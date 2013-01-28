spec = Gem::Specification.new do |s|
  s.name = 'minitest-em-sync'
  s.version = '0.1.0'
  s.date = '2013-01-28'
  s.summary = 'Less-callbacks helper for EventMachine and minitestn'
  s.email = "ceo@prepor.ru"
  s.homepage = "http://github.com/prepor/em-postgres"
  s.description = 'Less-callbacks helper for EventMachine and minitestn'
  s.has_rdoc = false
  s.authors = ["Andrew Rudenko"]
  s.add_dependency('eventmachine', '>= 0.12')

  # = MANIFEST =
  s.files = %w[
    Gemfile
    Gemfile.lock
    Rakefile
    lib/minitest/em_sync.rb
    minitest-em-sync.gemspec
    spec/minitest/em_sync_spec.rb
    spec/spec_helper.rb
  ]
  # = MANIFEST =
end
