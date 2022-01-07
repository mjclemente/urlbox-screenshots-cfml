# urlbox-screenshots

Quickly generate screenshots using the urlbox.io screenshot as a service API.

This project follows the example of the official Urlbox [node](https://github.com/urlbox/urlbox-screenshots-node) and [php](https://github.com/urlbox-io/urlbox-screenshots-php) repositories and  *generates the Urlbox urls, but does not actually make the request for the screenshot*.

Signup at [Urlbox.io](https://urlbox.io) to get your API key and secret.

## Installation

You can install this project with [CommandBox](https://commandbox.ortusbooks.com/):

```bash
box install urlbox-screenshots
```

Alternatively, you can copy the `models/urlbox.cfc` file into your project.

## Example

```cfc
// Get your API key and secret from urlbox.io
urlbox = new models.urlbox(YOUR_API_KEY, YOUR_API_SECRET);

// See all urlbox screenshot options at urlbox.io/docs
url = 'github.com';
options = {
  thumb_width: 600,
  format: 'jpg',
  quality: 80
}

imgUrl = urlbox.buildUrl( url, options );
// https://api.urlbox.io/v1/YOUR_API_KEY/TOKEN/jpg?url=github.com&quality=80&thumb_width=600
```

Now stick that url in an img tag to render the screenshot!

![Urlbox Screenshot of github.com](https://api.urlbox.io/v1/ca482d7e-9417-4569-90fe-80f7c5e1c781/5a9a56f05cf1229bd8f2edf4a0e6c218ccea1bb7/jpeg?url=github.com&thumb_width=600&quality=80)

Available options can be found here: urlbox.io/docs
