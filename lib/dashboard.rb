require 'rubygems'
require 'dboard'
require 'sinatra'

set :public, "public"

require File.expand_path(File.join(File.dirname(__FILE__), 'ci_status'))

get "/sources" do
  Dboard::Api.get(params)
end

post "/sources/:type" do
  Dboard::Api.update(params)
end

get "/" do
  erb File.read('assets/index.html.erb')
end

[ 'jquery.js', 'dashboard.js' ].each do |file|
  get "/#{file}" do
    send_file File.join(settings.public, file)
  end
end
