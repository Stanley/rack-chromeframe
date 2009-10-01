# Rack Middleware for Google Chrome Frame

Written by [Luigi Montanez](http://twitter.com/LuigiMontanez) of the [Sunlight Labs](http://sunlightlabs.com), a group of [civic hackers](http://www.slideshare.net/luigimontanez/civic-hacking). Updated by Stanley. Copyright 2009.

[Google Chrome Frame](http://blog.chromium.org/2009/09/introducing-google-chrome-frame.html) is an open source plug-in that brings HTML5 and other open web technologies to Internet Explorer. See the [developer's guide](http://code.google.com/chrome/chromeframe/developers_guide.html) for more on implementation.

This middleware injects snippets of code into every outgoing HTML response, which only affects Internet Explorer users.

At the beginning of the `<head>`, enable Chrome Frame if it's installed:
  
    <meta http-equiv="X-UA-Compatible" content="chrome=1">

Rendres new page to prompt the user to install Chrome Frame (only when it's not yet installed) with following body section:

      <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/chrome-frame/1/CFInstall.min.js"></script>
      <div id="cf-placeholder"></div>
      <script>CFInstall.check({node: "cf-placeholder"});</script>

The user will be presented with a blank page displaying the official [Chrome Frame installation page](http://www.google.com/chromeframe).

## Configuration

To use in your Rails app, place `lib/rack/chrome_frame.rb` in `lib/rack`.

Then in `environment.rb`:

    config.middleware.use "Rack::ChromeFrame"

Or in the `config.ru` (`config/rack.rb`) rackup file of your Sinatra (Merb) app:

    require 'chrome_frame'
    use Rack::ChromeFrame
    
That's all there is to it. Fire up your app, View Source on any page, and see the magic.

## Options

You can customize middleware behavior by passing some optional parameters:

    use Rack::ChromeFrame, {:minimum => 8.0} will prompt only users with older IE version than 8.0

    use Rack::ChromeFrame, {:destination => "http://www.github.com"} will pass this option to CFInstall.check() JS method

## Tests

To run the tests:

    cd spec
    spec chrome_frame_spec.rb

