# Run: ruby day03_enumerable_and_debugging.rb [student name] [--debug]
students = [
  { name: "Ana", score: 95 },
  { name: "Ben", score: 58 },
  { name: "Carlo", score: 76 },
  { name: "Dina", score: 60 }
]

passing = students.select { |student| student[:score] >= 60 }
report = passing.map { |student| "#{student[:name].upcase}: #{student[:score]} (passed)" }
total = students.reduce(0) { |sum, student| sum + student[:score] }
average = students.empty? ? 0.0 : total.fdiv(students.length)

puts "Passing students:", report
puts format("Class average: %.2f", average)
query = ARGV.reject { |arg| arg == "--debug" }.join(" ")
unless query.empty?
  match = students.find { |student| student[:name].casecmp?(query) }
  puts(match ? "Found #{match[:name]}: #{match[:score]}" : "No student named #{query}.")
end
if ARGV.include?("--debug")
  warn "DEBUG selected records: #{passing.inspect}"
  warn "DEBUG total=#{total}, count=#{students.length}"
  warn "Integer division truncates the average: #{total / students.length}; fdiv preserves decimals."
end
