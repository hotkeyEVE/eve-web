%w[sinatra sequel slim].each { |lib|  require lib }



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

