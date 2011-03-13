puts "==> Gems".magenta

puts "  --> Initialize Gemfile".magenta
gem "haml"       if @haml
gem "haml-rails" if @haml

gem "capistrano"     if @capistrano
gem "capistrano-ext" if @capistrano

gem "hoptoad_notifier"
gem "capfire"

if @rspec && @factory_girl
	append_file 'Gemfile' do
  <<-RUBY

group :development, :test do
	gem "rspec-rails"
	gem "factory_girl_rails"
	gem "forgery"
	gem "email_spec"
end
  RUBY
	end
else
	if @rspec 
		append_file 'Gemfile' do
  <<-RUBY

group :development, :test do
	gem "rspec-rails"
	gem "database_cleaner"
end
  RUBY
		end
	end

	if @factory_girl
		append_file 'Gemfile' do
  <<-RUBY

group :development, :test do
	gem "factory_girl_rails"
	gem "database_cleaner"
end
  RUBY
		end
	end
end

puts "   --> Install gems".magenta
run "gem install bundler"
run "bundle install"

git :add => '.'
git :commit => "-aqm 'Installed gems'"
