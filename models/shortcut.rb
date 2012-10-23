class Shortcut < Sequel::Model(:menu_bar_shortcuts)
  STANDARD_APPS = %w[
    Preview Finder Reminders Terminal Xcode Mail
    Console Chrome App\ Store System\ Preferences
    Activity\ Monitor Skype Text Calendar Base MacVim
    Pages Disk\ Utility Reminders VP-UML Safari GitX
  ]
end

