# Rack Middleware for Google Chrome Frame

Written by [Luigi Montanez](http://twitter.com/LuigiMontanez) of the [Sunlight Labs](http://sunlightlabs.com), a group of [civic hackers](http://www.slideshare.net/luigimontanez/civic-hacking). Copyright 2009.

[Google Chrome Frame](http://blog.chromium.org/2009/09/introducing-google-chrome-frame.html) is an open source plug-in that brings HTML5 and other open web technologies to Internet Explorer. See the [developer's guide](http://code.google.com/chrome/chromeframe/developers_guide.html) for more on implementation.

This middleware injects two snippets of code into every outgoing HTML response, which only affects Internet Explorer users.

At the bottom of the `<head>`, enable Chrome Frame if it's installed:
  
    <meta http-equiv="X-UA-Compatible" content="chrome=1">

At the bottom of the `<body>`, prompt the user to install Chrome Frame if it's not yet installed:

      <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/chrome-frame/1/CFInstall.min.js"></script>
      <div id="cf-placeholder"></div>
      <script>CFInstall.check({node: "cf-placeholder"});</script>

The user will be presented with a page overlay displaying the official [Chrome Frame installation page](http://www.google.com/chromeframe).

## Configuration

To use in your Rails app, place `chrome_frame.rb` in `lib/rack`.

Then in `environment.rb`:

    config.middleware.use "Rack::ChromeFrame"

Or in the `config.ru` rackup file of your Sinatra app:

    require 'chrome_frame'
    use Rack::ChromeFrame
    
That's all there is to it. Fire up your app, View Source on any page, and see the magic.


## Tests

To run the tests:

    gem install rack-test
    cd test
    ruby chrome_frame_test.rb

