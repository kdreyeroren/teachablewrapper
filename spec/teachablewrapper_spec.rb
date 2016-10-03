require_relative 'spec_helper'

describe Teachablewrapper do
  it 'has a version number' do
    expect(Teachablewrapper::VERSION).not_to be nil
  end

  it 'has an object called teachablewrapper::users' do
    expect(Teachablewrapper::User).to exist
  end
end
