#!/usr/bin/env ruby
require 'net/https'
require 'uri'

url = 'http://data.fixer.io/api/latest'
uri = URI(url)

Net::HTTP.start(uri.host, uri.port,
    :use_ssl => uri.scheme == 'https', 
    :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

    request = Net::HTTP::Get.new uri.request_uri
    response = http.request request
    puts response.body
end
