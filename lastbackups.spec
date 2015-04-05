# -*- encoding: utf-8 -*-
# Diskspace specification file
# Created with sur-0.2
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Lastbackups"
  s.version     = "0.1"
  s.tags        = [ "backup" ]
  s.files       = [ "lastbackups.rb" ]
  s.icons       = [ "lastbackups.xbm" ]

  # Sublet description
  s.description = "Duration of different backups"
  s.notes       = <<NOTES
"Shows the duration between last backup and current date for different backups like weekly or monthly backups. Source under http://github.com/DSIW/sublet-lastbackups. Please contribute."
NOTES

  # Sublet authors
  s.authors     = [ "DSIW" ]
  s.contact     = "dsiw@dsiw-it.de"
  s.date        = "Thu Aug 13 17:29 CET 2014"

  # Sublet config
  s.config = [
    {
      :name        => "interval",
      :type        => "integer",
      :description => "Update interval in seconds.",
      :def_value   => "3600"
    },
    {
      :name        => "info_color",
      :type        => "String",
      :description => "Color code of info color which will be used if counter is greater than zero.",
      :def_value   => "#FF2525"
    },
    {
      :name        => "important_color",
      :type        => "String",
      :description => "Color code of important color which will be used if counter is greater than color_border.",
      :def_value   => "#FF2525"
    },
    {
      :name        => "color_border",
      :type        => "integer",
      :description => "",
      :def_value   => "1"
    },
    {
      :name        => "separator",
      :type        => "String",
      :description => "Separator between each backup interval.",
      :def_value   => "-"
    },
    {
      :name        => "update_file",
      :type        => "String",
      :description => "This file contains the backup interval information. One line has the following structure: backup_interval_name;last_backup_date.",
      :def_value   => "~/.lastbackups"
    },
    {
      :name        => "backup_intervals",
      :type        => "Array",
      :description => "Active backup intervals. Choose between yearly, monthly, weekly, daily and hourly",
      :def_value   => "%i[yearly monthly weekly daily]"
    }
  ]
end
