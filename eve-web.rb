%w[sinatra sequel slim json active_support/inflector].each { |lib|  require lib }


# CONFIG
##############################################

Sequel.connect ENV["DATABASE_URL"]

# load models after connection was established
%w[serial_number kagi_response account shortcut].each { |model| require "./models/#{model}" }


# WEB
##############################################

get "/" do
  @title = "Get Started"
  slim :index
end

get "/shortcuts" do
  @title     = "Online DB"
  @shortcuts = Shortcut.where(:AppName => Shortcut::STANDARD_APPS).order(:AppName).to_a.group_by(&:AppName)

  slim :shortcuts
end

get "/:site" do |site|
  @title = ActiveSupport::Inflector.titleize(site)
  slim site.to_sym
end


# API
##############################################
post "/lcg" do
  begin
    if params.fetch("ACG:Flags", "").include?("Test=1")
      accounts = [Account.example]
    else
      accounts = Account.generate(params)
    end

    KagiResponse.success(accounts)
  rescue Sequel::InvalidValue
    KagiResponse.failed("Incomplete request. Did you submit an email?")
  end
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

