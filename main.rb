#!/usr/bin/env ruby
require 'net/https'
require 'inifile'
require 'json'
require 'uri'

access_key = String.new

if (File.file?('config.ini'))
    config = IniFile.load('config.ini')
    access_key = config['global']['access_key']
end

url = 'http://data.fixer.io/api/latest?access_key=' + access_key
uri = URI(url)

Net::HTTP.start(uri.host, uri.port,
    :use_ssl => uri.scheme == 'https', 
    :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

    request = Net::HTTP::Get.new uri.request_uri
    response = http.request request
    json = JSON.parse(response.body)
    value = Float json['rates']['GBP']
    value = 1.0 / value

    puts "1.00 GBP = #{value} EUR"
    puts "Date: #{Time.now.strftime("%Y-%m-%d")}"
end

