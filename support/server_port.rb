require "socket"

module TrainingServer
  class StartupError < StandardError; end

  def self.reserve_port(port: ENV["PORT"], output: $stdout)
    if port
      number = Integer(port, 10, exception: false)
      unless number && number.between?(1024, 65_535)
        raise StartupError, "PORT must be a whole number from 1024 to 65535."
      end
      begin
        return TCPServer.new("127.0.0.1", number)
      rescue Errno::EADDRINUSE
        raise StartupError, "Port #{number} is already in use. Run without PORT to choose an available port automatically."
      end
    end

    # Keep the socket open until Puma inherits it, so another app cannot take it.
    (3000..3010).each do |number|
      begin
        listener = TCPServer.new("127.0.0.1", number)
      rescue Errno::EADDRINUSE
        next
      end
      output.puts "Port 3000 is busy; using port #{number}." if number != 3000
      return listener
    end

    listener = TCPServer.new("127.0.0.1", 0)
    output.puts "Ports 3000–3010 are busy; using port #{listener.addr[1]}."
    listener
  rescue Errno::EACCES, Errno::EPERM
    raise StartupError, "Cannot open a local server port. Check your system's permissions."
  end
end
