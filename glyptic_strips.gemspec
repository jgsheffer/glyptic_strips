Gem::Specification.new do |s|
  s.name        = 'glyptic-strips'
  s.version     = '0.0.1'
  s.date        = '2017-03-13'
  s.summary     = "Gif Creating Library"
  s.description = 
  "Glyptic Gifs - A gem which assists in the creation of gifs for cucumber projects
  "
  s.authors     = ["Jared Sheffer"]
  s.email       = 'magus.chef@gmail.com'
  s.files       = ["lib/glyptic_strips.rb"]
  s.add_runtime_dependency "mini_magick",
    ["= 4.6.1"]
  s.add_runtime_dependency 'cucumber', '~> 2.0', '>= 2.0.0'
  s.homepage    =
    'http://rubygems.org/gems/glyptic_gifs'
  s.license       = 'MIT'
end