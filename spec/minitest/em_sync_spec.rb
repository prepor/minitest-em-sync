require 'spec_helper'

describe Minitest::EMSync do
  include Minitest::EMSync

  it "should start EM and wait result from deferrable" do
    d = EM::DefaultDeferrable.new
    EM.next_tick { d.succeed :foo }
    sync(d).must_equal :foo
  end

  it "should raise exception from callbacks" do
    d = EM::DefaultDeferrable.new
    EM.next_tick { d.fail RuntimeError.new("oh!") }
    proc { sync(d) }.must_raise RuntimeError
  end
end
