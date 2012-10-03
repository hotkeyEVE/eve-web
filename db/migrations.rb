require 'sequel'

DB = Sequel.connect(ENV["DATABASE_URL"])

# accounts table
DB.drop_table :accounts
DB.create_table :accounts do
  primary_key :id

  String :email, size: 100, null: false
  String :serial, size: 50, null: false
  String :mac_addresses, size: 150

  index [:email, :serial], unique: true
end

