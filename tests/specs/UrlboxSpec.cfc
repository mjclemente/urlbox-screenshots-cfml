/**
* This tests the BDD functionality in TestBox. This is CF10+, Lucee4.5+
*/
component extends="testbox.system.BaseSpec"{

/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		urlbox = new models.urlbox( api_key = 'API_KEY', api_secret = 'API_SECRET' );
	}

/*********************************** BDD SUITES ***********************************/

	function run(){
		describe( "The urlbox component", function(){
      it("can generate unauthenticated urls", function(){
        var unauthenticated_urlbox = new models.urlbox( api_key = 'API_KEY' );
        var result = unauthenticated_urlbox.buildUrl( 'example.com' );
				expect( result ).toBeWithCase( 'https://api.urlbox.io/v1/API_KEY/png?url=example.com' );
			});
			it("defaults to a png format", function(){
        var result = urlbox.buildUrl( 'example.com' );
				expect( result ).toBeWithCase( 'https://api.urlbox.io/v1/API_KEY/b1b9b4362a5044ff18718d4d9a961044ed0cc815/png?url=example.com' );
			});
      it("generates a jpg format url correctly", function(){
        var options = {
          "format": 'jpg'
        };
        var result = urlbox.buildUrl( 'example.com', options );
				expect( result ).toBeWithCase( 'https://api.urlbox.io/v1/API_KEY/b1b9b4362a5044ff18718d4d9a961044ed0cc815/jpg?url=example.com' );
			});
      it("can handle the kitchen sink of options", function(){
        var uri = 'https://app_staging.example.com/misc/template_preview.php?dsfdsfsdf&acc=79&cb=ba86b4c1&regions=%5B%7B%22id%22%3A%22dsfds%22%2C%22data%22%3A%7B%22html%22%3A%22It%20works!%22%7D%2C%22type%22%3A%22html%22%7D%5D&state=published&tid=7&sig=a642316f7e0ac9d783c30ef30a89bed3204252000319a2789851bc3de65ea216';
        var options = [
          "delay": 5000,
          "selector": "##trynow",
          "full_page": true,
          "width": 1280,
          "height": 1024,
          "cookie": ['ckplns=1', 'foo=bar'],
          "user_agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 10_0 like Mac OS X) AppleWebKit/602.1.32 (KHTML, like Gecko) Version/10.0 Mobile/14A5261v Safari/602.1",
          "retina": true,
          "thumb_width": 400,
          "crop_width": 500,
          "ttl": 604800,
          "force": true,
          "headless": false,
          "wait_for": ".someel",
          "click": "##tab-specs-trigger",
          "hover": 'a[href="https://google.com"]',
          "bg_color": "##bbbddd",
          "highlight": "trump|inauguration",
          "highlightbg": "##11cc77",
          "highlightfg": "green",
          "hide_selector": ".modal-backdrop, ##email-roadblock-topographic-modal",
          "flash": true,
          "timeout": 40000,
          "s3_path": "/path/to/image with space",
          "use_s3": true
        ];
        var result = urlbox.buildUrl( uri, options );
				expect( result ).toBeWithCase( 'https://api.urlbox.io/v1/API_KEY/ab4e8b4856388c849a2c72862b4358c845f948dd/png?url=https%3A%2F%2Fapp_staging.example.com%2Fmisc%2Ftemplate_preview.php%3Fdsfdsfsdf%26acc%3D79%26cb%3Dba86b4c1%26regions%3D%255B%257B%2522id%2522%253A%2522dsfds%2522%252C%2522data%2522%253A%257B%2522html%2522%253A%2522It%2520works%21%2522%257D%252C%2522type%2522%253A%2522html%2522%257D%255D%26state%3Dpublished%26tid%3D7%26sig%3Da642316f7e0ac9d783c30ef30a89bed3204252000319a2789851bc3de65ea216&delay=5000&selector=%23trynow&full_page=true&width=1280&height=1024&cookie=ckplns%3D1&cookie=foo%3Dbar&user_agent=Mozilla%2F5.0+%28iPhone%3B+CPU+iPhone+OS+10_0+like+Mac+OS+X%29+AppleWebKit%2F602.1.32+%28KHTML%2C+like+Gecko%29+Version%2F10.0+Mobile%2F14A5261v+Safari%2F602.1&retina=true&thumb_width=400&crop_width=500&ttl=604800&force=true&headless=false&wait_for=.someel&click=%23tab-specs-trigger&hover=a%5Bhref%3D%22https%3A%2F%2Fgoogle.com%22%5D&bg_color=%23bbbddd&highlight=trump%7Cinauguration&highlightbg=%2311cc77&highlightfg=green&hide_selector=.modal-backdrop%2C+%23email-roadblock-topographic-modal&flash=true&timeout=40000&s3_path=%2Fpath%2Fto%2Fimage+with+space&use_s3=true' );
			});

      it("returns the proper base URL", function(){
        var result = urlbox.getBaseUrl();
				expect( result ).toBeWithCase( 'https://api.urlbox.io/v1/' );
			});

      it("returns the proper render URL", function(){
        var result = urlbox.getRenderUrl();
				expect( result ).toBeWithCase( 'https://api.urlbox.io/v1/render' );
			});

		});


	}

}
