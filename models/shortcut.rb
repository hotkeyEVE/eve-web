class Shortcut < Sequel::Model(:menu_bar_shortcuts)
  STANDARD_APPS = %w[
    Preview Finder Reminders Terminal Xcode Mail
    Console Chrome App\ Store System\ Preferences
    Activity\ Monitor
  ]
end

