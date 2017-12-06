# -*- encoding: utf-8 -*-
# stub: just-datetime-picker 0.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "just-datetime-picker".freeze
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Marcin Lewandowski".freeze, "doabit".freeze, "Samuel Vega Caballero".freeze]
  s.date = "2016-02-10"
  s.description = "Gem that just creates date/time picker in Active Admin forms".freeze
  s.email = ["marcin@saepia.net".freeze]
  s.homepage = "https://github.com/saepia/just-datetime-picker".freeze
  s.rubygems_version = "2.6.13".freeze
  s.summary = "Gem that just creates date/time picker in Active Admin forms".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<formtastic>.freeze, [">= 2.0.0"])
      s.add_runtime_dependency(%q<activeadmin>.freeze, [">= 0.4.4"])
    else
      s.add_dependency(%q<formtastic>.freeze, [">= 2.0.0"])
      s.add_dependency(%q<activeadmin>.freeze, [">= 0.4.4"])
    end
  else
    s.add_dependency(%q<formtastic>.freeze, [">= 2.0.0"])
    s.add_dependency(%q<activeadmin>.freeze, [">= 0.4.4"])
  end
end
