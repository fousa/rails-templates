if @factory_girl
	puts "==> Factory Girl integration".magenta

	puts "   --> Remove fixtures".magenta
	remove_dir 'test/fixtures'

	puts "   --> Generate forgery"
	run "rails generate forgery"

	puts "   --> Add factories file"
	if @rspec
		file "spec/factories.rb", <<-RUBY
# Factory.define :user do |user|
#  user.email { Forgery(:internet).email_address }
# end
		RUBY
	else
		file "test/factories.rb", <<-RUBY
# Factory.define :user do |user|
#  user.email { Forgery(:internet).email_address }
# end
		RUBY
	end

	puts "   --> Add to generators".magenta
	if @haml || @rspec
		inject_into_file 'config/application.rb', :after => "config.generators do |generator|" do
	<<-RUBY

			generator.fixture_replacement :factory_girl
	RUBY
		end
	else
		inject_into_file 'config/application.rb', :before => "  end\nend" do
  <<-RUBY

		config.generators do |generator|
			generator.fixture_replacement :factory_girl
		end
  RUBY
		end
	end

	puts "   --> Configure"
	if @rspec
		inject_into_file 'spec/spec_helper.rb', :after => "require 'rspec/rails'" do
	<<-RUBY
require "factory_girl"
Factory.find_definitions
require "email_spec"
	RUBY
		end

		inject_into_file 'spec/spec_helper.rb', :after => "RSpec.configure do |config|" do
	<<-RUBY
	config.before(:each) do
		DatabaseCleaner.strategy = :truncation
		DatabaseCleaner.clean
	end
	RUBY
		end
	else
		inject_into_file 'test/test_helper.rb', :after => "require 'rails/test_help'" do
	<<-RUBY
require "factory_girl"
Factory.find_definitions
require "email_spec"
	RUBY
		end

		inject_into_file 'test/test_helper.rb', :after => "class ActiveSupport::TestCase" do
	<<-RUBY

	def setup
		DatabaseCleaner.strategy = :truncation
		DatabaseCleaner.clean
	end
	RUBY
		end
	end
end
