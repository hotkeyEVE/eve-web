require 'sequel'

DB = Sequel.connect(ENV["DATABASE_URL"])

# accounts table
DB.drop_table(:accounts) rescue PG::Error
DB.create_table :accounts do
  primary_key :id

  String :email, size: 100, null: false
  String :serial, size: 50, null: false
  String :mac_addresses, size: 150

  index [:email, :serial], unique: true
end

DB.drop_table(:menu_bar_shortcuts) rescue PG::Error
DB.create_table :menu_bar_shortcuts do
  String "AppName"
  String "AppVersion"
  String "Language"
  String "HasShortcut"
  String "ShortcutString"
  String "TitleAttribute"
  String "RoleAttribute"
  String "SubroleAttribute"
  String "RoleDescriptionAttribute"
  String "DescriptionAttribute"
  String "ValueAttribute"
  String "HelpAttribute"
  String "SelectStatement"
  String "ParentTitleAttribute"
  String "ParentRoleAttribute"
  String "ParentDescriptionAttribute"

  Integer "disabled"
end

