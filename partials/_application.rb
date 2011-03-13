puts "==> Set up basic application".magenta

puts "   --> No timestamped migrations".magenta
inject_into_file 'config/application.rb', :before => "  end\nend" do
  <<-RUBY

    # Turn off timestamped migrations
    config.active_record.timestamped_migrations = false
  RUBY
end

puts "   --> Cleanup Rails project".magenta
remove_file "README"

inside "public" do
	remove_file "index.html"
	remove_file "favicon.ico"
	remove_file "robots.txt"
	remove_file "index.html"
	remove_file "images/rails.png"
end

inside "doc" do
	remove_file "README_FOR_APP"
end

git :commit => "-aqm 'Cleanup application'"
