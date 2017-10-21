# -*- encoding: utf-8 -*-
# stub: go_gamification 0.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "go_gamification".freeze
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jo\u00E3o Carlos Ottobboni".freeze]
  s.date = "2017-10-21"
  s.description = "go_gamification engine".freeze
  s.email = ["jcottobboni@gmail.com".freeze]
  s.homepage = "http://www.gorails.com.br".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.13".freeze
  s.summary = "go_gamification engine".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<draper>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rails>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<pg>.freeze, [">= 0"])
    else
      s.add_dependency(%q<draper>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, [">= 0"])
      s.add_dependency(%q<pg>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<draper>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 0"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
  end
end
