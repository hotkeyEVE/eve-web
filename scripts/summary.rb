require 'sequel'

DB = Sequel.connect(ENV["DATABASE_URL"])

require './models/account'


licences          = Account.count
unused_licences   = Account.where(mac_addresses: nil).count
used_licences     = [licences - unused_licences, 1].max

licenced_machines = Account.all.map(&:mac_addresses).compact.map { |a| a.split(",") }.flatten.count

puts <<-TEXT
LICENCE SUMMARY
---------------

Number of Licences:              #{licences}
Number of used Licences:         #{used_licences}
Registered machines per Licence: #{(licenced_machines / used_licences).round(2)}
TEXT

