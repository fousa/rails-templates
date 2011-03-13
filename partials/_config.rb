if @config_file
	puts "==> Create config file".magenta

	file 'config/config.yml', <<-RUBY.gsub(/^ {2}/, '')
  # Application wide config file
RUBY

	file "config/initializers/config.rb", <<-RUBY.gsub(/^ {2}/, '')
	CONFIG = YAML.load(File.read(Rails.root.join('config', 'config.yml')))
RUBY

	git :add => '.'
	git :commit => "-aqm 'Add config file'"
end
