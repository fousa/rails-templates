if @haml
	puts "==> Haml integration".magenta

	puts "   --> Install".magenta
  run "haml --rails ."

	puts "   --> Add to generators".magenta
	inject_into_file 'config/application.rb', :before => "  end\nend" do
  <<-RUBY

		config.generators do |generator|
			generator.template_engine :haml
		end
  RUBY
	end
end
