MY RAILS TEMPLATES
==================

Ruby on Rails has a nice feature where you can generate a new rails project with a template.

My templates are based on the newest version of Rails at the moment: Rails 3

At the moment my templates handles:

- jQuery
- git
- git push to Github
- HAML 
- configuration file
- factory girl
- rspec
- capistrano
- rvm
- cleanup

Every option can be chosen, so for example you can leave out capistrano if you don't like it... Weird, but okay!

And here is how you generate a new rails app with my template:

    git clone git://github.com/fousa/rails-templates.git /tmp/fousa-rails-templates
    rails new_app -m /tmp/fousa-rails-templates/new.rb

And next just answer the questions!
