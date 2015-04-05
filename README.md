# Sublet lastbackups

Shows the duration between last backup and current date for different backup intervals like weekly or monthly.

## Requirements

* Ruby
* [subtle](http://subtle.subforge.org/)
* `~/.lastbackups`

## Installation

Run `sur install lastbackups`.

or

```
sur build lastbackups.spec
sur install lastbackups-0.1.sublet
```

## Usage

Your subtle config file could be:
```ruby
screen 1 do
  bottom [:separator, :diskspace, :separator]
end

# ...

sublet :lastbackups do
  interval 60*30 # 30 minutes
  separator " "
  important_color "#FE4B35"
  color_border 25
  backup_intervals [:weekly, :monthly]
end
```

## Output

```
+ 00w 00m
```

Content of `~/.lastbackups`:
```
yearly;1990-01-01T00:00:00
monthly;1990-01-01T00:00:00
weekly;1990-01-01T00:00:00
daily;1990-01-01T00:00:00
hourly;1990-01-01T00:00:00
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT
