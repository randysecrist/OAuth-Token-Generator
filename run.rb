CONSUMER_KEYS = {
  twitter: {
    key: '',
    secret: ''
  },
  facebook: {
    key: '',
    secret: ''
  },
  linkedin: {
    key: '',
    secret: ''
  },
  github: {
    key: '',
    secret: ''
  },
  mhealth: {
    key: '',
    secret: ''
  }
}

require 'sinatra'
require 'omniauth'
require 'omniauth-twitter'
require 'omniauth-facebook'
require 'omniauth-linkedin'
require 'omniauth-github'
require 'omniauth-mhealth'

use Rack::Session::Cookie

# insecure but handy for testing
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

use OmniAuth::Builder do
  provider :twitter, CONSUMER_KEYS[:twitter][:key], CONSUMER_KEYS[:twitter][:secret]
  provider :facebook, CONSUMER_KEYS[:facebook][:key], CONSUMER_KEYS[:facebook][:secret]
  provider :linkedin, CONSUMER_KEYS[:linkedin][:key], CONSUMER_KEYS[:linkedin][:secret]
  provider :github, CONSUMER_KEYS[:github][:key], CONSUMER_KEYS[:github][:secret]
  provider( :mhealth, CONSUMER_KEYS[:mhealth][:key], CONSUMER_KEYS[:mhealth][:secret],
    {:client_options => {:ssl => {verify: false}}
 )
end

get '/' do
  CONSUMER_KEYS.map do |name, consumer|
    "<a href='/auth/#{name}'>#{name}</a>"
  end.join("\n")
end

get '/auth/:name/callback' do
  content_type 'application/json'
  auth = request.env['omniauth.auth']
  auth.to_json
end
