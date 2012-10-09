require 'sequel'

DB = Sequel.connect(ENV["DATABASE_URL"])
DB.run "TRUNCATE menu_bar_shortcuts"

File.read('./db/dumps/menu_bar_shortcuts.sql').each_line do |line|
  next if line.empty?
  DB.run line
end

