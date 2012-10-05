require 'spec_helper'

describe Harbour::Port do
  it '#open? returns false if port is not open' do
    Harbour::Port.new(8080).open?.should be_false
  end

  it '#open? returns true if port is open' do
    # currently to pass manually start a server on port 3000
    Harbour::Port.new(3000).open?.should be_true
  end
end
