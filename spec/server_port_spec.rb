require "stringio"
require_relative "../support/server_port"

RSpec.describe TrainingServer do
  it "reserves an available port instead of just checking it" do
    listener = described_class.reserve_port(port: nil, output: StringIO.new)
    expect(listener.addr[3]).to eq("127.0.0.1")
    expect { TCPServer.new("127.0.0.1", listener.addr[1]) }.to raise_error(Errno::EADDRINUSE)
  ensure
    listener&.close
  end

  it "automatically skips port 3000 when another server is listening" do
    occupied = begin
      TCPServer.new("127.0.0.1", 3000)
    rescue Errno::EADDRINUSE
      nil # An existing server already provides the conflict for this test.
    end
    output = StringIO.new
    listener = described_class.reserve_port(port: nil, output: output)
    expect(listener.addr[1]).not_to eq(3000)
    expect(output.string).to include("busy", listener.addr[1].to_s)
  ensure
    listener&.close
    occupied&.close
  end

  it "explains an occupied explicit port without moving to another port" do
    occupied = TCPServer.new("127.0.0.1", 0)
    expect { described_class.reserve_port(port: occupied.addr[1].to_s) }
      .to raise_error(TrainingServer::StartupError, /already in use.*without PORT/)
  ensure
    occupied&.close
  end

  it "rejects invalid port settings before starting Rails" do
    ["", "abc", "3000oops", "-1", "0", "1023", "65536"].each do |port|
      expect { described_class.reserve_port(port: port) }
        .to raise_error(TrainingServer::StartupError, /whole number/)
    end
  end
end
