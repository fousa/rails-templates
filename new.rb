@authentication_type = ask("What do you want to use as authentication mechanism?\n\n- http (HTTP basic authentication)\n- password (Single password authentication)\n\nYour choice:")

@config_file         = yes? "Do you want to use a config.yml file?"
@jquery              = yes? "Do you want to use jQuery?"
@haml                = yes? "Do you want your views to be generated with haml?"

if @git = yes?("Do you want to use git?")
  if @github = yes?("Do you have a remote repository on Github? (yes/no)")
    @username        = ask("Enter your Github username:")
    @repository_name = ask("Enter the name of your Github repository:")
  end
end


apply "http://github.com/fousa/rails-templates/raw/master/sub-templates/basic.rb"
apply "http://github.com/fousa/rails-templates/raw/master/sub-templates/git.rb"
apply "http://github.com/fousa/rails-templates/raw/master/sub-templates/authentication.rb"