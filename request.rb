require 'net/http'
require 'uri'

class Request
  def initialize(uri, user, pass)
    @uri = URI.parse(uri)
    @user = user
    @pass = pass
  end

  def get
    @request = Net::HTTP::Get.new(@uri)
    auth_and_send_request
  end

  def delete
    @request = Net::HTTP::Delete.new(@uri)
    auth_and_send_request
  end

  private

  def auth_and_send_request
    @request.basic_auth(@user, @pass)
    response = Net::HTTP.start(@uri.hostname, @uri.port, use_ssl: @uri.scheme == "https") { |http|  http.request(@request) }
  end
end
