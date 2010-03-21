run "rm public/index.html"

if yes? "Do you want to use a config.yml file?"
  initializer "load_config.rb", %q{CONFIG = File.open("#{Rails.root}/config/config.yml") { |file| YAML::load(file) }}
  file "config/config.yml"
end

if yes? "Do you want to use jQuery?"
  run "rm public/javascripts/controls.js"
  run "rm public/javascripts/dragdrop.js"
  run "rm public/javascripts/effects.js"
  run "rm public/javascripts/prototype.js"

  inside "public/javascripts" do
    run "curl -L http://code.jquery.com/jquery-1.4.1.min.js > jquery-1.4.1.min.js"
  end
end