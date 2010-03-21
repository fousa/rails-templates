if yes?"Do you want to use git?"
  run "rm -rf .gitignore"
  file ".gitignore", <<-END
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
.DS_Store
  END

  git :init
  git :add => "."
  git :commit => "-a -m 'Initial commit'"

  if yes? "Do you have a remote repository on Github? (yes/no)"
    username        = ask "Enter your Github username:"
    repository_name = ask "Enter the name of your Github repository:"
    if !username.chop.empty? && !repository_name.chop.empty?
      git :remote => "add origin git@github.com:#{username}/#{repository_name}.git"
      git :push   => "origin master"
    else
      puts "WARNING: No push happened to a Github remote repository due to incomplete data"
    end
  end
end