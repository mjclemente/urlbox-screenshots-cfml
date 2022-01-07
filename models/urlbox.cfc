/**
* urlbox-screenshots-cfml
* Copyright 2022  Matthew J. Clemente, John Berquist
* Licensed under MIT (https://mit-license.org)
*/
component singleton {

  public any function init(
      string api_key = '',
      string api_secret = '',
      string default_format = 'png'
  ) {

      structAppend( variables, arguments );

      //map sensitive args to env variables or java system props
      var secrets = {
        'api_key': 'URLBOX_API_KEY',
        'api_secret': 'URLBOX_API_SECRET'
      };
      var system = createObject( 'java', 'java.lang.System' );

      for ( var key in secrets ) {
          //arguments are top priority
          if ( variables[ key ].len() ) {
              continue;
          }

          //check environment variables
          var envValue = system.getenv( secrets[ key ] );
          if ( !isNull( envValue ) && envValue.len() ) {
              variables[ key ] = envValue;
              continue;
          }

          //check java system properties
          var propValue = system.getProperty( secrets[ key ] );
          if ( !isNull( propValue ) && propValue.len() ) {
              variables[ key ] = propValue;
          }
      }

      variables.baseUrl = 'https://api.urlbox.io/v1/';

      return this;
  }

  public string function buildUrl( required string url, struct options = {} ){
    var encodedUrl = encodeForURL( arguments.url );
    var queryParams = ["url=#encodedUrl#"];

    var format = options?.format ?: variables.default_format;
    arguments.options.delete('format');

    for ( var option in arguments.options ){
      if( isArray(arguments.options[option]) ){
        for( var el in arguments.options[option] ){
          queryParams.append("#option#=#encodeForURL(el)#");
        }
      } else {
        queryParams.append("#option#=#encodeForURL(arguments.options[option])#");
      }
    }
    var queryString = queryParams.toList("&");

    if( len( variables.api_secret ) ){
      // // https://api.urlbox.io/v1/api-key/auth-token/format?options
      var token = generateToken( queryString, variables.api_secret );
      return "#variables.baseUrl##variables.api_key#/#token#/#format#?#queryString#";
    } else {
      return "#variables.baseUrl##variables.api_key#/#format#?#queryString#";
    }
  }

  private string function generateToken( required string input ){
    return lcase(hmac( arguments.input, variables.api_secret, 'HMACSHA1' ) );
  }

}
