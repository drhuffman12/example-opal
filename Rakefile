require 'opal'

desc "Build our app to build.js"
task :build do
  Opal.append_path "app"
  File.binwrite "www/conway.js", Opal::Builder.build("conway").to_s
end