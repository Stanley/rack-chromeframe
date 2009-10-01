require File.dirname(__FILE__) + '/helper'

describe "Rack::ChromeFrame" do

  before do
    @app = lambda { |env| [200, {'Content-Type' => 'text/html'}, simple_html] }
    @request = Rack::MockRequest.new(Rack::ChromeFrame.new(@app, {:minimum => 8.0}))
  end

  shared_examples_for "nothing happens" do
    it "should change nothing" do
      @response.body.should eql(simple_html)
    end
  end

  context "not IE:" do
    before do
      @response = @request.get('/')
    end

    it_should_behave_like "nothing happens"
  end

  context "IE:" do

    context "chromeframe installed" do
      before do
        @response = @request.get('/', {'HTTP_USER_AGENT' => 'MSIE 6.0; chromeframe' })
      end

      it "should add meta tag"  do
        @response.body.should include(chrome_frame_meta_tag)
      end
    end

    context "chromeframe not installed" do

      context "but satisfactory IE version installed" do
        before do
          @response = @request.get('/', {'HTTP_USER_AGENT' => 'MSIE 8.0' })
        end

        it_should_behave_like "nothing happens"
      end

      context "but not satisfactory IE version installed" do
        before do
          @response = @request.get('/', {'HTTP_USER_AGENT' => 'MSIE 7.0' })
        end

        it "should suggest chromeframe installation" do
          @response.body.gsub(/\n( )*/, '').should include(chrome_frame_installation_script)
        end
      end
    end
  end
end