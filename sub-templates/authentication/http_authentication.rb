run "rm app/controllers/application_controller.rb"

file "app/controllers/application_controller.rb", %q{
class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all

  def authenticate
    authenticate_or_request_with_http_basic do |user, password|
      user == "login" && password == "secret"
    end
  end

end
}

puts "NOTICE: You should now add \"before_filter :authenticate\" to every controller you wish to protect!"