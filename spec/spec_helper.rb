ENV['BUNDLE_GEMFILE'] = File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup'

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'

require 'minitest/em_sync'

MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new
