# -*- encoding: utf-8 -*-
# stub: pdfkit 0.8.2 ruby lib

Gem::Specification.new do |s|
  s.name = "pdfkit".freeze
  s.version = "0.8.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jared Pace".freeze, "Relevance".freeze]
  s.date = "2015-08-26"
  s.description = "Uses wkhtmltopdf to create PDFs using HTML".freeze
  s.email = ["jared@codewordstudios.com".freeze]
  s.homepage = "https://github.com/pdfkit/pdfkit".freeze
  s.rubyforge_project = "pdfkit".freeze
  s.rubygems_version = "2.6.13".freeze
  s.summary = "HTML+CSS -> PDF".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<activesupport>.freeze, [">= 3.0.8"])
      s.add_development_dependency(%q<mocha>.freeze, [">= 0.9.10"])
      s.add_development_dependency(%q<rack-test>.freeze, [">= 0.5.6"])
      s.add_development_dependency(%q<i18n>.freeze, ["~> 0.6.11"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 0.9.2"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 4.0.1"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 3.0.8"])
      s.add_dependency(%q<mocha>.freeze, [">= 0.9.10"])
      s.add_dependency(%q<rack-test>.freeze, [">= 0.5.6"])
      s.add_dependency(%q<i18n>.freeze, ["~> 0.6.11"])
      s.add_dependency(%q<rake>.freeze, ["~> 0.9.2"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 4.0.1"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 3.0.8"])
    s.add_dependency(%q<mocha>.freeze, [">= 0.9.10"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0.5.6"])
    s.add_dependency(%q<i18n>.freeze, ["~> 0.6.11"])
    s.add_dependency(%q<rake>.freeze, ["~> 0.9.2"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 4.0.1"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
  end
end