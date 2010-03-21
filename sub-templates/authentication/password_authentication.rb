file "app/models/user.rb", %q{class User

include ActiveModel::Validations

validates :password, :inclusion => { :in => ["secret"] }

attr_accessor :id,
              :password

def initialize(options={})
  [:password].each do |field|
    class << self
      self
    end.module_eval{attr_accessor field}
    self.send("#{field}=", options[field.to_sym])
  end
end

def new_record?
  true
end

d
}

file "app/controllers/sessions_controller.rb", %q{class SessionsController < ApplicationController

before_filter :authenticate, :except => [ :new, :create ]

def new
  @user        = User.new
end

def create
  @user = User.new(params[:user])

  if @user.valid?
    session[:logged_in]  = true
    if session[:previous_page]
      previous_uri = session[:previous_page]
      session[:previous_page] = nil

      redirect_to previous_uri, :notice => "You are now logged in to this website"
    else
      redirect_to root_path, :notice => "You are now logged in to this website"
    end
  else
    redirect_to login_path, :alert => "You entered the wrong password"
  end
end

def destroy
  reset_session

  redirect_to login_path, :notice => "You are now logged off from this website"
end

d
}

run "rm app/controllers/application_controller.rb"
file "app/controllers/application_controller.rb", %q{class ApplicationController < ActionController::Base

helper :all
helper_method :admin?

protect_from_forgery

private

  def admin?
    session[:logged_in]
  end

  def authenticate
    redirect_to login_url, :alert => "Not authenticated, please login" unless admin?
  end

  def set_previous_url
    session[:previous_page] = request.request_uri
  end

d
}

file "app/views/sessions/new.html.erb", %q{<h2>Please log in to this website.</h2>

 if flash[:alert] -%>
<p style="color: red;"><%= flash[:alert] %></p>
 end -%>

 form_for @user, :url => sessions_path do |form| -%>
<p>
  <%= form.label :password %>
  <br />
  <%= form.password_field :password %>
</p>

<p>
  <%= form.submit "Login" %>
</p>

 end -%>
}

file "app/views/sessions/index.html.erb", %q{<h2>You are authenticated.</h2>
 if flash[:notice] -%>
<p style="color: green;"><%= flash[:notice] %></p>
 end -%>

><%= link_to "logoff", logoff_path %></p>
}

route "resources :sessions"
route "root :to => \"sessions#index\""
route "match \"login\"  => \"sessions#new\", :as => :login"
route "match \"logoff\" => \"sessions#destroy\", :as => :logoff"

puts "NOTICE: You should now add \"before_filter :authenticate\" to every controller you wish to protect!"
puts "NOTICE: You should now add \"before_filter :set_previous_url\" to every controller you wish to be redirected to after login!"