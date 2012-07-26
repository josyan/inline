# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{deep_cloneable}
  s.version = "1.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Reinier de Lange"]
  s.date = %q{2011-06-14}
  s.description = %q{Extends the functionality of ActiveRecord::Base#clone to perform a deep clone that includes user specified associations. }
  s.email = %q{r.j.delange@nedforce.nl}
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = [".document", "LICENSE", "README.rdoc", "Rakefile", "VERSION", "deep_cloneable.gemspec", "init.rb", "lib/deep_cloneable.rb", "test/database.yml", "test/schema.rb", "test/test_deep_cloneable.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/moiristo/deep_cloneable}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{This gem gives every ActiveRecord::Base object the possibility to do a deep clone.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
