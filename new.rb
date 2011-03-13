puts "==> Installing missing Gems"
%w{colored}.each do |component|
  unless Gem.available?(component)
    run "gem install #{component}"
    Gem.refresh
    Gem.activate(component)
  end
	require "#{component}"
end

puts "=================================".green
puts " Loading Fousa's Rails Templates ".green
puts "=================================".green

if @github = yes?("Do you want to push your app to a remote Gihub repo? (y/n)".red)
	@github_username  = ask "Enter your Github username: ".red
	@github_repo_name = ask "Enter your Github repository name: ".red
end

if @rvm = yes?("Do you want to use RVM? (y/n)".red)
	rvm_list         = `rvm list`.gsub(Regexp.new("\e\\[.?.?.?m"), '')
	rvm_current_ruby = rvm_list.match(/=> ([^ ]+)/)[1]
	@rvm_ruby        = ask "Enter the Ruby version you wish to use [#{rvm_current_ruby}]".red
	@rvm_ruby        = rvm_current_ruby if @rvm_ruby.blank?
	@rvm_gemset      = ask "Enter the RVM Gemset name you wish to use [#{@app_name}]:".red
	@rvm_gemset      = @app_name if @rvm_gemset.blank?
end

@jquery       = yes? "Do you want to use jQuery? (y/n)".red
@haml         = yes? "Do you want your views to be generated with haml? (y/n)".red
@rspec        = yes? "Do you want to use Rspec? (y/n)".red
@factory_girl = yes? "Do you want to use Factory Girl? (y/n)".red
@config_file  = yes? "Do you want to use a config.yml file? (y/n)".red
@capistrano   = yes? "Do you want to use Capistrano for deployment? (y/n)".red

puts "=================================".green
puts " START!                          ".green
puts "=================================".green

@partials        = File.join(File.dirname(__FILE__), 'partials')
@static_file_dir = File.join(File.dirname(__FILE__), 'static')

def copy_static_file(path)
  remove_file path
  file path, File.read(File.join(@static_file_dir, path))
end

apply "#{@partials}/_git.rb"
apply "#{@partials}/_application.rb"
apply "#{@partials}/_jquery.rb"
apply "#{@partials}/_rvm.rb"
apply "#{@partials}/_gems.rb"
apply "#{@partials}/_config.rb"
apply "#{@partials}/_haml.rb"
apply "#{@partials}/_rspec.rb"
apply "#{@partials}/_factory_girl.rb"
apply "#{@partials}/_capistrano.rb"

puts "=================================".green
puts " DONE!                           ".green
puts "=================================".green
