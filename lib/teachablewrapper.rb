require_relative "teachablewrapper/version"

require 'net/http'
require 'json'
require 'uri'

class TeachableMockAPI

  API_URL = "https://fast-bayou-75985.herokuapp.com/"

  # Registers a user for the first time. Returns the user object as a hash.

  def self.register(email, password, password_confirmation)

    address = API_URL + "users.json"

    uri = URI.parse(address)

    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Post.new(uri.request_uri)

    request.add_field 'Accept', 'application/json'
    request.add_field 'Content-Type', 'application/json'

    user = {email: email, password: password, password_confirmation: password_confirmation}

    request.body = {user: user}.to_json

    response = http.request(request)

    if response.code == "201"
      return JSON.parse(response.body)
    else
      raise "Error: response code " + response.code + ". Should be 201."
    end

  end

  # Authenticates a user. Returns the user token.

  def self.authenticate(email, password)

    address = API_URL + "users/sign_in.json"

    uri = URI.parse(address)

    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Post.new(uri.request_uri)

    request.add_field 'Accept', 'application/json'
    request.add_field 'Content-Type', 'application/json'

    user = {email: email, password: password}

    request.body = {user: user}.to_json

    response = http.request(request)

    if response.code == "201"
      result = JSON.parse(response.body)
      token = result['tokens']
      return token
    else
      raise "Error: response code " + response.code + ". Should be 201."
    end

  end

  # Shows user information. Returns user object as a hash.

  def self.get_users(email, token)

    address = API_URL + "api/users/current_user/edit.json?user_email=" + email + "&user_token=" + token

    uri = URI.parse(address)

    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Get.new(uri.request_uri)

    request.add_field 'Content-Type', 'application/json'

    response = http.request(request)

    if response.code == "200"
      return JSON.parse(response.body)
    else
      raise "Error: response code " + response.code + ". Should be 200."
    end

  end

  # Create a new order. Returns the user token.

  def self.make_order(email, token, total, total_quantity, special_instructions)

    address = API_URL + "api/orders.json?user_email=" + email + "&user_token=" + token

    uri = URI.parse(address)

    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Post.new(uri.request_uri)

    request.add_field 'Accept', 'application/json'
    request.add_field 'Content-Type', 'application/json'

    order = {total: total, total_quantity: total_quantity, email: email, special_instructions: special_instructions}

    request.body = {order: order}.to_json

    response = http.request(request)

    if response.code == "200"
      result = JSON.parse(response.body)
      token = result['tokens']
      return token
    else
      raise "Error: response code " + response.code + ". Should be 201."
    end

  end

  # Shows an order. Returns the order object as a hash.

  def self.get_order(email, token)

    address = API_URL + "api/orders.json?user_email=" + email + "&user_token=" + token

    uri = URI.parse(address)

    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Get.new(uri.request_uri)

    request.add_field 'Content-Type', 'application/json'

    response = http.request(request)

    if response.code == "200"
      return JSON.parse(response.body)
    else
      raise "Error: response code " + response.code + ". Should be 200."
    end

  end

  # Deletes an order.

  def self.delete_order(email, token, order)

    order_id = order[0]["id"].to_s

    address = API_URL + "api/orders/" + order_id + ".json?user_email=" + email + "&user_token=" + token

    uri = URI.parse(address)

    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Delete.new(uri.request_uri)

    request.add_field 'Accept', 'application/json'
    request.add_field 'Content-Type', 'application/json'

    response = http.request(request)

    unless response.code == "204"
      raise "Error: response code " + response.code + ". Should be 200."
    end

  end

end

# Some test code. Email address will only register once; if you want to run it again, use a new email address.

email = "teddybear@abc.com"
password = "password"

begin
TeachableMockAPI::register(email, password, password)
rescue # Assume it failed because the user existed; let's move on.
end
token =  TeachableMockAPI::authenticate(email, password)
TeachableMockAPI::get_users(email, token)
TeachableMockAPI::make_order(email, token, "3.00", "3", "special instructions foo bar")
order = TeachableMockAPI::get_order(email, token)
TeachableMockAPI::delete_order(email, token, order)
