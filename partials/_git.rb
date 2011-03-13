puts "==> Git integration".magenta

puts "   --> Configure .gitignore".magenta
remove_file '.gitignore'
file '.gitignore', <<-CODE.gsub(/^ {2}/, '')
  .DS_Store
  mkmf.log
  log
  coverage
  rdoc
  .bundle
  tmp
  db/*.sqlite3
  config/database.yml
  public/stylesheets/compiled/*
  public/system/*
	*.swp
	*.swo
CODE

if @github
	if !@github_username.chop.empty? && !@github_repo_name.chop.empty?
		puts "   --> Set up Github repository".magenta
		git :remote => "add origin git@github.com:#{@github_username}/#{@github_repo_name}.git"
	else
		puts "   --> WARNING: Github remote is not set due to incomplete information.".orange
	end
end

git :init
git :add => "."
git :commit => "-aqm 'Initial Rails application'"
