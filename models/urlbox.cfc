/**
* urlbox-screenshots-cfml
* Copyright 2022  Matthew J. Clemente, John Berquist
* Licensed under MIT (https://mit-license.org)
*/
component singleton {

  public any function init(
      string api_key = '',
      string api_secret = '',
      string webhook_secret = '',
      string default_format = 'png'
  ) {

      structAppend( variables, arguments );

      //map sensitive args to env variables or java system props
      var secrets = {
        'api_key': 'URLBOX_API_KEY',
        'api_secret': 'URLBOX_API_SECRET',
        'webhook_secret': 'URLBOX_WEBHOOK_SECRET'
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
      option = lcase(option);
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

  public string function getBaseUrl() {
    return variables.baseUrl;
  }

  public string function getRenderUrl() {
    return variables.baseUrl & 'render';
  }

  public boolean function verifyWebhookSignature( required string payload, required string signature ) {
    // extract timestamp and token
    var timestamp = arguments.signature.listFirst(',').listLast('=');
    var token     = arguments.signature.listLast(',').listLast('=');

    var generated_input = timestamp & "." & arguments.payload;
    var generated_token = generateWebhookToken(generated_input);

    return generated_token == token;
  }

  private string function generateToken( required string input ){
    return lcase(hmac( arguments.input, variables.api_secret, 'HMACSHA256' ) );
  }

  private string function generateWebhookToken(required string input) {
    return lCase(hmac(arguments.input, variables.webhook_secret, "HMACSHA256"));
  }

}
