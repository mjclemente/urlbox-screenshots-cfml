/**
* This tests the BDD functionality in TestBox. This is CF10+, Lucee4.5+
*/
component extends="testbox.system.BaseSpec"{

/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		urlbox = new models.urlbox( api_key = 'example_key', api_secret = 'top_secret' );
	}

/*********************************** BDD SUITES ***********************************/

	function run(){
		describe( "The urlbox component", function(){
			it("is just so wonderful", function(){
        var options = {
          "url": "bbc.co.uk",
          "width": 1024,
          "height": 768,
          "delay": 1000
        };
        debug( urlbox.buildUrl( 'https://www.classaction.org', options ) );
				expect( 1 ).toBe( 1 );
			});

		});


	}

}
