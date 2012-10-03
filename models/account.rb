class Account < Sequel::Model(:accounts)
  LICENCE_LIMIT = (ENV["LICENCE_LIMIT"] || 3).to_i

  EXAMPLE_EMAIL  = "example@example.com"
  EXAMPLE_SERIAL = "11111111-1111-1111-1111-111111111111"

  class Unknown < StandardError; end
  class EmptyMac < StandardError; end
  class LicenceLimit < StandardError; end

  def to_kagi(status = "GOOD", message = "")
    <<-TEXT
      Content-type: text/text

      kagiRemotePostStatus=#{status}, message="#{message}"

      userName=#{email}, regNumber=#{serial}
    TEXT
  end

  def self.generate(params)
    email = params["ACG:PurchaserEmail"]
    email = nil if email.empty?

    account = (first(email: email) || new(email: email, serial: SerialNumber.generate.number))

    account.save unless account.exists?
    account
  end

  def self.example
    new(email: EXAMPLE_EMAIL, serial: EXAMPLE_SERIAL)
  end

  def self.verify(params)
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

