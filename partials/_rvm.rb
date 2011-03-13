if @rvm
	puts "==> RVM Integrations".magenta

	puts "   --> Create gemset".magenta
	run "rvm #{@rvm_ruby} gemset create #{@rvm_gemset}"
	@rvm_exec = "rvm #{@rvm_ruby}@#{@rvm_gemset}"

	puts "   --> Create .rvmrc file".magenta
	file '.rvmrc', @rvm_exec
	run "rvm rvmrc trust #{@app_path}"
end

git :add => '.'
git :commit => "-aqm 'RVM integration'"
