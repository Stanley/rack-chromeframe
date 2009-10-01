
require 'rack/mock'
require 'lib/rack/chrome_frame'

def simple_html
  <<-HTML
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
      <head>
        <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
        <title>Hello World!</title>
      </head>
      <body>
        <div>
          Simple example
        </div>
      </body>
    </html>
  HTML
end

def chrome_frame_meta_tag
  '<meta http-equiv="X-UA-Compatible" content="chrome=1">'
end

def chrome_frame_installation_script(destination = nil)
  script = <<-HTML
    <div id="cf-placeholder"></div>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/chrome-frame/1/CFInstall.min.js"></script>
    <script>CFInstall.check({ node: "cf-placeholder" #{', destination: "' + destination + '" ' if destination}});</script>
  HTML
  script.gsub(/\n( )*/, '').lstrip
end