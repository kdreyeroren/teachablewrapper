require 'net/http'
require 'json'
require 'uri'

#API_URL = "https://fast-bayou-75985.herokuapp.com/"



host = "https://fast-bayou-75985.herokuapp.com/"

register_addr = host + "users.json"

uri = URI.parse(register_addr)

http = Net::HTTP.new(uri.host)
request = Net::HTTP::Post.new(uri.request_uri)
user = {email: "a@b.com", password: "password", password_confirmation: "password"}

request.body = user.to_json

response = http.request(request)

puts response.code
#
# if response.code == "200"
#   result = JSON.parse(response.body)
#
#   result.each do |doc|
#     puts doc["id"] #reference properties like this
#     puts doc # this is the result in object form
#     puts ""
#     puts ""
#   end
# else
#   puts "ERROR!!!"
# end

# module Teachablewrapper
#   class User
#   end
# end
