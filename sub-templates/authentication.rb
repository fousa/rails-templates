if @authentication_type == "http"
  apply "http://github.com/fousa/rails-templates/raw/master/sub-templates/authentication/http_authentication.rb"
elsif @authentication_type == "password"
  apply "http://github.com/fousa/rails-templates/raw/master/sub-templates/authentication/password_authentication.rb"
else
  puts "WARNING: NO authentication applied"
end