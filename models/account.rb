class Account < Sequel::Model(:accounts)
  LICENCE_LIMIT = (ENV["LICENCE_LIMIT"] || 3).to_i

  EXAMPLE_EMAIL  = "example@example.com"
  EXAMPLE_SERIAL = "11111111-1111-1111-1111-111111111111"

  class Unknown < StandardError; end
  class EmptyMac < StandardError; end
  class LicenceLimit < StandardError; end

  class << self
    def generate(params)
      email = params["ACG:PurchaserEmail"]
      email = nil if email.empty?

      accounts = where(email: email).to_a
      return accounts unless accounts.empty?

      quantity = params["ACG:QuantityOrdered"].to_i
      quantity = [1, quantity].max

      quantity.times do
        accounts << create(email: email, serial: SerialNumber.generate.number)
      end
      accounts
    end

    def example
      new(email: EXAMPLE_EMAIL, serial: EXAMPLE_SERIAL)
    end

    def verify(params)
      account = first(email: params["email"], serial: params["serial"])
      raise Unknown.new("Email and / or Serial doesn't exist") unless account

      mac = params.fetch("mac", "")
      raise EmptyMac.new("No Mac address specified") if mac.empty?

      registered_macs = (account.mac_addresses || "").split(",")
      return if registered_macs.include?(mac)

      raise LicenceLimit.new("Too many licences") if registered_macs.size >= LICENCE_LIMIT

      registered_macs << mac
      account.mac_addresses = registered_macs.join(",")
      account.save
    end
  end
end

