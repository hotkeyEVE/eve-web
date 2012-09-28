require 'securerandom'

class SerialNumber
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def self.generate
    new SecureRandom.uuid
  end
end

