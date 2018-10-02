require_relative '../config/environment'


CSV.foreach("csv/lebron_stats.csv") do |row|
  # use row here...
  binding.pry
end

binding.pry

puts "HELLO WORLD"
