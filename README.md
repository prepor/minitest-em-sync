minitest-em-sync
================

A little helper for make tests of EM code are more readable.

So

```ruby
it "should perform successful GET" do
  EventMachine.run {
    http = EventMachine::HttpRequest.new('http://127.0.0.1:8090/').get
    http.errback { failed(http) }
    http.callback {
      http.response_header.status.must_equal 200
      http.response.must_match /Hello/
      EventMachine.stop
    }
  }
end
```

can be written as

```ruby
it "should perform successful GET" do
  http = EventMachine::HttpRequest.new('http://127.0.0.1:8090/').get
  sync http
  http.response_header.status.must_equal 200
  http.response.must_match /Hello/
end
```

Usage
-----

```ruby
gem "minitest-em-sync"
```

Just include Minitest::EMSync to your tests/specs:

```ruby
require 'minites/em_sync'
describe Minitest::EMSync do
  include Minitest::EMSync

  it "should start EM and wait result from deferrable" do
    d = EM::DefaultDeferrable.new
    EM.next_tick { d.succeed :foo }
    sync(d).must_equal :foo
  end
end
```

It raise exceptions passed to callbacks:

```ruby
it "should raise exception from callbacks" do
  d = EM::DefaultDeferrable.new
  EM.next_tick { d.fail RuntimeError.new("oh!") }
  proc { sync(d) }.must_raise RuntimeError
end
```
