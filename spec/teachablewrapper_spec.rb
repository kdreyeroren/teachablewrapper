require_relative 'spec_helper'

EMAIL = "weoriueoiru@abc.com"
PASSWORD = "password"

describe Teachablewrapper do
  it 'has a version number' do
    expect(Teachablewrapper::VERSION).not_to be nil
  end

  describe ".register" do

    it 'registers a user' do
      new_user = TeachableMockAPI.register(EMAIL, PASSWORD, PASSWORD)
      expect(new_user).to include("id", "email", "tokens")
    end

  end

  describe ".get_users" do

    it 'returns a user' do
      user = TeachableMockAPI.register(EMAIL, PASSWORD, PASSWORD)
      expect(user).to include("id", "email", "tokens")
    end

  end

end
