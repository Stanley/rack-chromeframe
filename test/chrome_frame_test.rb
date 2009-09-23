require 'rubygems'
require 'rack/test'
require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + '/../chrome_frame')

# To run this test, you need to have rack-test gem installed: sudo gem install rack-test

class ChromeFrameTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    hello_world_app =  lambda {|env| [200, {'Content-Type' =>  'text/html', 'Content-Length' => '66'}, Rack::Response.new(["<html><head></head><body><form></form>Hello World!</body></html>"]) ] }
    app = Rack::ChromeFrame.new(hello_world_app)
  end
  
  def test_normal_request_should_go_through
    get '/'
    assert_equal 200, last_response.status
    assert_not_equal '', last_response.body
  end
  
  def test_add_to_head
    header "User-Agent", "MSIE"
    get '/'
    assert_equal 200, last_response.status
    
    head = <<-HEAD
      <meta http-equiv="X-UA-Compatible" content="chrome=1">
    HEAD
    
    assert last_response.body.index(head)    
  end
  
  def test_add_to_body
    header "User-Agent", "MSIE"
    get '/'
    assert_equal 200, last_response.status
    
    bod = <<-BOD
      <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/chrome-frame/1/CFInstall.min.js"></script>
      <div id="cf-placeholder"></div>
      <script>CFInstall.check({node: "cf-placeholder"});</script>
    BOD
    
    assert last_response.body.index(bod)
  end
  
end
