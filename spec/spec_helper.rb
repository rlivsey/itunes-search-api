$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'webmock/rspec'
require 'itunes-search-api'

RSpec.configure do |config|
  config.include(WebMock)
end

# helper to find a fixture
def fixture(name)
  File.open(File.expand_path(File.dirname(__FILE__) + "/fixtures/#{name}"))
end
