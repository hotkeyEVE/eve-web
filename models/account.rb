require 'json'

class Account < Sequel::Model(:accounts)

  def to_json
    JSON.generate({
      email:  email,
      serial: serial
    })
  end
end

