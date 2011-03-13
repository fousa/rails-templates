if @rspec
	puts "==> Rspec integration".magenta

	puts "   --> Remove test unit".magenta
	remove_dir 'test'

	puts "   --> Add to generators".magenta
	run "rails generate rspec:install"
	
	if @haml
		inject_into_file 'config/application.rb', :after => "config.generators do |generator|" do
	<<-RUBY

			generator.test_framework   :rspec, :fixture => true, :views => false
			generator.integration_tool :rspec, :fixture => true, :views => true
	RUBY
		end
	else
		inject_into_file 'config/application.rb', :before => "  end\nend" do
  <<-RUBY

		config.generators do |generator|
			generator.test_framework   :rspec, :fixture => true, :views => false
			generator.integration_tool :rspec, :fixture => true, :views => true
		end
  RUBY
		end
	end
end

