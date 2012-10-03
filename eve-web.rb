%w[sinatra sequel slim json].each { |lib|  require lib }


# CONFIG
##############################################

Sequel.connect ENV["DATABASE_URL"]

# load models after connection was established
%w[serial_number account].each { |model| require "./models/#{model}" }


# APP
##############################################

get "/" do
  slim :index
end

get "/request" do
  serial  = SerialNumber.generate
  account = Account.create(serial: serial.number)

  account.to_json
end

post "/verify" do
  begin
    Account.verify JSON.parse(request.body.read.to_s)
    200
  rescue JSON::ParserError
    [400, "Malformed request / JSON can't be parsed"]
  rescue Account::Unknown, Account::EmptyMac => e
    [406, e.message]
  rescue Account::LicenceLimit => e
    [403, e.message]
  end
end

