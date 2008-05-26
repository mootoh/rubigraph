Gem::Specification.new do |s|
  s.name = %q{rubigraph}
  s.version = "0.0.1"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["mootoh"]
  s.date = %q{2008-05-27}
  s.description = %q{a Ruby wrap for Ubigraph (http://www.ubietylab.net/ubigraph).  see http://www.ubietylab.net/ubigraph/content/Docs/index.html to get complete description about API.}
  s.email = %q{mootoh@gmail.com}
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "lib/rubigraph.rb", "test/test_rubigraph.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://rubyforge.org/projects/rubigraph}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rubigraph}
  s.rubygems_version = %q{1.0.1}
  s.summary = %q{a Ruby wrap for Ubigraph (http://www.ubietylab.net/ubigraph)}
  s.test_files = ["test/test_rubigraph.rb"]

  s.add_dependency(%q<hoe>, [">= 1.5.3"])
end
