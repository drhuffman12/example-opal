require 'opal'
Opal.append_path File.dirname(File.expand_path(`gem which opal-jquery`)).untaint

oj = Opal::Builder.build("opal-jquery")

File.write('opal-jquery.js', oj.to_s)


