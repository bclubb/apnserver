module ApnServer
  class Client
    
    attr_accessor :certificate, :key, :host, :port, :password
    
    def initialize(certificate, key, host = 'gateway.push.apple.com', port = 2195, pass = nil)
      @certificate, @key, @host, @port = certificate, key, host, port
      @password = pass
    end
    
    def connect!
      raise "The path to your pem file is not set." unless self.key
      raise "The path to your pem file does not exist!" unless File.exist?(self.key)
      
      @context      = OpenSSL::SSL::SSLContext.new
      @context.cert = OpenSSL::X509::Certificate.new(File.read(self.certificate))
      @context.key  = OpenSSL::PKey::RSA.new(File.read(self.key), self.password)
      
      @sock         = TCPSocket.new(self.host, self.port)
      @ssl          = OpenSSL::SSL::SSLSocket.new(@sock, @context)
      @ssl.connect
      
      return @sock, @ssl
    end
    
    def disconnect!
      @ssl.close
      @sock.close
    end
    
    def write(bytes)
      @ssl.write(bytes)
    end
    
    def connected?
      @ssl
    end
    
  end
end