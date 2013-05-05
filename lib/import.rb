require 'csv'

puts "importing from #{ARGV[0]}"
csv = CSV.parse(File.open(ARGV[0]), headers: true)
for row in csv
  year = row["YEAR1"].to_i
  month = Date::MONTHNAMES.index(row["MONTH_"])
  day = row["DAY1"].to_i
  hour, min, sec = row["HR_MIN_SEC"].split("_").map(&:to_i)
  taken = Time.utc(year, month, day, hour, min, sec)
  Image.create!(filename: row["SLIDE"], full_url: row["FULL_SLIDE"], thumb_url: row["THUMBNAIL_"], geo_area: row["GEO_AREA"], pre: row["PRE_POST"].downcase=="pre", storm: row["STORM"], latitude: row["LATITUDE"], longitude: row["LONGITUDE"], taken_at: taken)
end
