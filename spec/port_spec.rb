require 'spec_helper'

describe Harbour::Port do
  let(:port) { 3000 }

  it '#open? returns false if port is not open' do
    Harbour::Port.new(8080).open?.should be_false
  end

  it '#open? returns true if port is open' do
    with_server(port) do
      Harbour::Port.new(port).open?.should be_true
    end
  end

  it '#pid returns process pid' do
    with_server(port) do
      Harbour::Port.new(port).pid.should_not be_nil
    end
  end

  describe '#term!' do
    pending 'terminates process listening on port' do
      # Webrick does not die on TERM
      with_server(port) do
        Harbour::Port.new(port).term!
        port_open?(port).should be_false
      end
    end

    it 'raises if port fails to close' do
      # this is fragile, Webrick does not die on TERM, but may do in the future
      with_server(port) do
        expect { Harbour::Port.new(port).term! }.to raise_error(Harbour::Port::PortFailedToClose)
      end
    end

    it 'trys to kill process if term fails' do
      # this is fragile, Webrick does not die on TERM, but may do in the future
      with_server(port) do
        Harbour::Port.new(port, :try_kill => true).term!
        port_open?(port).should be_false
      end
    end
  end

  it '#kill! terminates process listening on port' do
    with_server(port) do
      Harbour::Port.new(port).kill!
      port_open?(port).should be_false
    end
  end
end
