require 'sequel'

DB = Sequel.connect(ENV["DATABASE_URL"])

# Create accounts table
DB.create_table :accounts do
  primary_key :id

  String :email, size: 100
  String :serial, size: 50
  String :mac_id, size: 50

  index :serial, unique: true
end

