require 'rubygems'
require 'dboard'
require 'sinatra'
require 'rack/ssl'

ENV['RACK_ENV'] ||= 'development'

helpers do
  def development?
    ENV['RACK_ENV'] == 'development'
  end

  def authorized?
    return true if development? || !ENV["API_USER"]
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials &&
    @auth.credentials == [ ENV['API_USER'], ENV['API_PASSWORD'] ]
  end
end

use Rack::SSL unless development?
set :public, "public"

get "/sources" do
  Dboard::Api.get(params)
end

post "/sources/:type" do
  if authorized?
    Dboard::Api.update(params)
  end
end

get "/" do
  erb File.read('assets/index.html.erb')
end

[ 'jquery.js', 'dashboard.js' ].each do |file|
  get "/#{file}" do
    send_file File.join(settings.public, file)
  end
end
