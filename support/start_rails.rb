require "bundler/setup"
require "fileutils"
require "rbconfig"
require_relative "server_port"

begin
  listener = TrainingServer.reserve_port
rescue TrainingServer::StartupError => error
  abort error.message
end

root = File.expand_path("../training_app", __dir__)
day = ENV.fetch("TRAINING_DAY")
FileUtils.mkdir_p(File.join(root, "public"))
if day.to_i >= 7
  require "tailwindcss/ruby"
  success = system(Tailwindcss::Ruby.executable.to_s,
    "-i", File.join(root, "app/tailwind.css"),
    "-o", File.join(root, "public/tailwind.css"), "--minify", chdir: root)
  abort "Tailwind compilation failed." unless success
end

require_relative "../training_app/config/environment"
require_relative "../training_app/db/prepare"
port = listener.addr[1]
bind = "tcp://127.0.0.1:#{port}"
puts "Day #{day}: http://localhost:#{port} (Ctrl+C to stop)"
$stdout.flush
# Pass the reserved socket through exec using Puma's inherited-listener support.
exec({ "PUMA_INHERIT_0" => "#{listener.fileno}:#{bind}" },
  RbConfig.ruby, Gem.bin_path("puma", "puma"), "-b", bind,
  File.join(root, "config.ru"), listener.fileno => listener)
