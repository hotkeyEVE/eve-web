require 'sequel'

DB = Sequel.connect(ENV["DATABASE_URL"])

# accounts table
DB.drop_table :accounts
DB.create_table :accounts do
  primary_key :id

  String :email, size: 100
  String :serial, size: 50
  String :mac_addresses, size: 150

  index :serial, unique: true
end

