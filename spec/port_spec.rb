require 'spec_helper'

describe Harbour::Port do
  let(:port) { 3000 }

  it '#open? returns false if port is not open' do
    Harbour::Port.new(8080).open?.should be_false
  end

  it '#open? returns true if port is open' do
    with_server(port) do
      Harbour::Port.new(3000).open?.should be_true
    end
  end

  it '#pid returns process pid' do
    with_server(port) do
      Harbour::Port.new(port).pid.should_not be_nil
    end
  end

  it '#term! terminates process listening on port' do
    with_server(port) do
      Harbour::Port.new(3000).term!
      port_open?(port).should be_false
    end
  end

  it '#kill! terminates process listening on port' do
    with_server(port) do
      Harbour::Port.new(3000).kill!
      port_open?(port).should be_false
    end
  end
end
