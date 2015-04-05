# Lastbackups sublet file
# Created with sur-0.2

require "time"

configure :lastbackups do |s|
  s.icon     = Subtlext::Icon.new("lastbackups.xbm")

  s.info_color = s.config[:info_color] || "#C53535" # blue
  s.important_color = s.config[:important_color] || "#FF2525" # red
  s.normal_color = Subtlext::Subtle.colors[:sublets_fg]
  s.color_border = s.config[:color_border] || 1

  s.interval        = s.config[:interval] || 3600
  s.separator       = s.config[:separator] || "–"
  s.update_file      = s.config[:update_file] || "#{ENV['HOME']}/.lastbackups"
  s.backup_intervals = s.config[:backup_intervals] || %i[yearly monthly weekly daily]
end

helper do |s|
  FACTORS_BY_INTERVAL = {
    yearly:  60*60*24*365,
    monthly: 60*60*24*28,
    weekly:  60*60*24*7,
    daily:   60*60*24,
    hourly:  60*60
  }
  OLD_YEAR = 1990
  NEVER_EXECUTED_COUNT = -1

  def to_color(string_or_symbol)
    case string_or_symbol
    when String, Symbol then Subtlext::Color.new(string_or_symbol)
    else string_or_symbol
    end
  end

  def colorize(string, color)
    [to_color(color), string, to_color(normal_color)].join
  end

  def color_of_count(count)
    if count.abs >= color_border
      important_color
    elsif count > 0
      info_color
    else
      normal_color
    end
  end

  def printable_counts(infos)
    min_length = 2

    infos.map do |interval, count|
      if count == -1
        printed_count = "-" * min_length
      else
        printed_count = count.to_s.rjust(min_length, '0')
      end
      printed_count = printed_count + interval[0]
      colorize(printed_count, color_of_count(count))
    end
  end

  def duration_from(last_date, interval)
    last_time = Time.parse(last_date)

    return NEVER_EXECUTED_COUNT if last_time.year == OLD_YEAR

    duration = (Time.now - last_time).to_i # seconds
    factor = FACTORS_BY_INTERVAL[interval.to_sym]
    duration / factor
  end

  def update
    # Fill hash with keys. Each key has value -1.
    infos = backup_intervals.reduce({}) { |hash, key| hash.merge({key => NEVER_EXECUTED_COUNT}) }

    File.open(update_file, "r") do |file|
      file.each_line do |line|
        interval, last_date = line.chomp.split(';')
        duration = duration_from(last_date, interval)
        infos[interval.to_sym] = duration.to_i if infos.has_key?(interval.to_sym)
      end
    end

    min, max = infos.values.minmax
    if min == NEVER_EXECUTED_COUNT
      icon_count = color_border # colorizing in red
    else
      icon_count = max
    end

    colorized_icon = colorize(icon, color_of_count(icon_count))
    counts = printable_counts(infos).join(separator)
    self.data = "#{colorized_icon}#{counts}"
  end
end

on :run do |s|
  begin
    update
  rescue => err # Sanitize to prevent unloading
    s.data = "LASTBACKUPS"
  end
end
