authentication_type = ask("What do you want to use as authentication mechanism?\n\n- http (HTTP basic authentication)\n- password (Single password authentication)\n\nYour choice:")
if authentication_type == "http"
  apply "http://github.com/fousa/rails-templates/raw/master/sub-templates/authentication/http_authentication.rb"
elsif authentication_type == "password"
  puts "WARNING: Single password authentication not yet implemented"
else
  puts "WARNING: NO authentication needed"
end