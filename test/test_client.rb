require File.dirname(__FILE__) + '/test_helper'

class TestClient < Test::Unit::TestCase
  
  def test_creates_client
    client = ApnServer::Client.new('cert.pem', 'gateway.sandbox.push.apple.com', 2196)
    assert_equal 'cert.pem', client.pem
    assert_equal 'gateway.sandbox.push.apple.com', client.host
    assert_equal 2196, client.port
  end
end
