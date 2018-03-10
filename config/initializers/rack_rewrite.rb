if ENV['RACK_ENV'] == 'production'
  Powder::Application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
    r301 %r{.*}, 'https://www.a-date.jp$&', :if => Proc.new {|rack_env|
      rack_env['SERVER_NAME'] == 'limitless-shelf-32995.herokuapp.com'
    }
  end
end