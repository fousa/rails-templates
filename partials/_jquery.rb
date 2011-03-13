if @jquery
	puts "==> jQuery integration".magenta

	puts "   --> Remove Prototype files".magenta
	inside "public/javascripts" do
		remove_file "controls.js"
		remove_file "dragdrop.js"
		remove_file "effects.js"
		remove_file "prototype.js"
		remove_file "rails.js"
	end

	puts "   --> Downloading".magenta
	["jquery-1.5.1.min", "rails", "modernizr-1.7.min"].each do |name|
		copy_static_file "public/javascripts/#{name}.js"
	end

	puts "   --> Add to default javascript files".magenta
	inject_into_file 'config/application.rb', :before => "  end\nend" do
  <<-RUBY

    # Add jQuery to defaults
    config.action_view.javascript_expansions[:defaults] = %w(jquery-1.5.1.min rails, modernizr-1.7.min)
  RUBY
	end
	
	git :add => '.'
	git :commit => "-aqm 'jQuery integration'"
end
