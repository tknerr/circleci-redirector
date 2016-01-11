ENV['RACK_ENV'] = 'test'

require './app.rb'
require 'rspec'
require 'rack/test'

describe 'CircleCI Redirector' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context 'index view' do
    it 'shows the basic usage' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to match('Basic Usage')
    end
  end

  context '/api/v1' do
    it 'preserves query parameters when redirecting'

    context 'new endpoints' do
      it 'redirects to build details'
      it 'redirects to test results'
      it 'redirects to build artifacts'
      it 'redirects to a specific build artifact'
    end

    context 'existing endpoints' do
      it 'redirects everything else as-is'
    end
  end
end
