# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application


# このメソッドを追加
if ENV['RACK_ENV'] == 'production'
  use Rack::Rewrite do
    r301 %r{.*}, 'http://a-date.jp$&', :if => Proc.new {|rack_env|
      rack_env['SERVER_NAME'] != 'a-date.jp'
    }
  end
end
require './app.rb'
run Sinatra::Application