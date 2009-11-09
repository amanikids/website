# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack-canonical-host}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tyler Hunt"]
  s.date = %q{2009-11-04}
  s.description = %q{Rack middleware for defining a canonical host name. It will redirect all requests to non-canonical hosts to the canonical host.}
  s.email = %q{tyler@tylerhunt.com}
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = [".document", ".gitignore", "LICENSE", "README.rdoc", "Rakefile", "VERSION", "lib/rack-canonical-host.rb"]
  s.homepage = %q{http://github.com/tylerhunt/rack-canonical-host}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Rack middleware for defining a canonical host name.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
