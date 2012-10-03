class Account < Sequel::Model(:accounts)

  class Unknown < StandardError; end
  class EmptyMac < StandardError; end
  class LicenceLimit < StandardError; end

  def to_json
    JSON.generate({
      email:  email,
      serial: serial
    })
  end

  def self.verify(params)
    account = first(email: params["email"], serial: params["serial"])
    raise Unknown.new("Email and / or Serial doesn't exist") unless account

    mac = params.fetch("mac", "")
    raise EmptyMac.new("No Mac address specified") if mac.empty?

    registered_macs = (account.mac_addresses || "").split(",")
    return if registered_macs.include?(mac)

    raise LicenceLimit.new("Too many licences") if registered_macs.size > 2

    registered_macs << mac
    account.mac_addresses = registered_macs.join(",")
    account.save
  end
end

