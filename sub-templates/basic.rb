run "rm public/index.html"

file "public/stylesheets/master.css"

inside "public/javascripts" do
  run "curl -L http://html5shiv.googlecode.com/svn/trunk/html5.js > html5.js"
end

if yes? "Do you want to use a config.yml file?"
  initializer "load_config.rb", %q{CONFIG = File.open("#{Rails.root}/config/config.yml") { |file| YAML::load(file) }}
  file "config/config.yml"
end

haml = yes? "Do you want your views to be generated with haml?"
if haml
  gem "haml"
  run "haml --rails ."
end

if yes? "Do you want to use jQuery?"
  run "rm public/javascripts/controls.js"
  run "rm public/javascripts/dragdrop.js"
  run "rm public/javascripts/effects.js"
  run "rm public/javascripts/prototype.js"
  run "rm public/javascripts/rails.js"

  inside "public/javascripts" do
    run "curl -L http://code.jquery.com/jquery-1.4.1.min.js > jquery-1.4.1.min.js"
    run "curl -L http://github.com/rails/jquery-ujs/raw/master/src/rails.js > jquery-rails.js"
  end

  if haml
    file "app/views/layouts/application.html.haml", %q{
!!!
%html{ :lang => "en" }
  %head
    %meta{ :charset => "utf-8" }
    %title= h(yield(:title) || "Untitled")
    = stylesheet_link_tag "master"
    = javascript_include_tag "jquery-1.4.1.min", "jquery-rails", "application"
    /[if IE]
      = javascript_include_tag "html5"
    = csrf_meta_tag
  %body
    %h1 This is the generated layout
    = yield
    }
  else
    file "app/views/layouts/application.html.erb", %q{
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title><%= h(yield(:title) || "Untitled") %></title>
    <%= stylesheet_link_tag "master" %>
    <%= javascript_include_tag "jquery-1.4.1.min", "jquery-rails", "application" %>
    <!--[if IE]>
      <%= javascript_include_tag "html5" %>
    <![endif]-->
    <%= csrf_meta_tag %>
  </head>
  <body>
    <h1>This is the generated layout</h1>
    <%= yield %>
  </body>
</html>
    }
  end
else
  if haml
    file "app/views/layouts/application.html.haml", %q{
!!!
%html{ :lang => "en" }
  %head
    %meta{ :charset => "utf-8" }
    %title= h(yield(:title) || "Untitled")
    = stylesheet_link_tag "master"
    = javascript_include_tag :defaults
    /[if IE]
      = javascript_include_tag "html5"
    = csrf_meta_tag
  %body
    %h1 This is the generated layout
    = yield
    }
  else
    file "app/views/layouts/application.html.erb", %q{
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title><%= h(yield(:title) || "Untitled") %></title>
    <%= stylesheet_link_tag "master" %>
    <%= javascript_include_tag :defaults %>
    <!--[if IE]>
      <%= javascript_include_tag "html5" %>
    <![endif]-->
    <%= csrf_meta_tag %>
  </head>
  <body>
    <h1>This is the generated layout</h1>
    <%= yield %>
  </body>
</html>
    }
  end
end