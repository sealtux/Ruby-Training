require "socket"
require "open3"
require "net/http"
require "timeout"
require "tmpdir"
require "fileutils"
require "rbconfig"

RSpec.describe "Rails launcher" do
  it "serves Day 9 on another port when port 3000 is occupied" do
    occupied = begin
      TCPServer.new("127.0.0.1", 3000)
    rescue Errno::EADDRINUSE
      nil
    end
    directory = Dir.mktmpdir("ojt-startup-")
    root = File.expand_path("..", __dir__)
    input, output, process = Open3.popen2e(
      { "PORT" => nil, "RAILS_ENV" => "test", "TRAINING_DATABASE" => File.join(directory, "test.sqlite3") },
      RbConfig.ruby, File.join(root, "day09_forms_and_authentication.rb"), chdir: root)
    input.close
    lines = []
    Timeout.timeout(20) do
      loop do
        line = output.gets
        raise "Server exited:\n#{lines.join}" unless line
        lines << line
        break if line.include?("Use Ctrl-C to stop")
      end
    end
    address = lines.join.match(%r{Day 9: http://localhost:(\d+)})
    expect(address).not_to be_nil
    port = address[1].to_i
    expect(port).not_to eq(3000)
    http = Net::HTTP.new("127.0.0.1", port, nil)
    http.open_timeout = 3
    http.read_timeout = 5
    response = http.get("/login")
    expect(response.code).to eq("200")
    expect(response.body).to include("Welcome back.")
  ensure
    if process&.alive?
      Process.kill("INT", process.pid)
      unless process.join(5)
        Process.kill("TERM", process.pid)
        process.join(5)
      end
    end
    output&.close
    occupied&.close
    FileUtils.remove_entry(directory) if directory
  end
end
