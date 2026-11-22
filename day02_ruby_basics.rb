# Run: ruby day02_ruby_basics.rb
puts "Grade Checker — passing score: 60"
print "Your name: "
name = $stdin.gets&.strip
exit if name.nil?
name = "Student" if name.empty?

loop do
  print "Enter a whole-number score (0–100), or q to quit: "
  input = $stdin.gets&.strip
  break if input.nil? || input.downcase == "q"

  score = Integer(input, exception: false)
  unless score && score.between?(0, 100)
    puts "Please enter a whole number from 0 to 100."
    next
  end

  grade = if score >= 90
    "Excellent"
  elsif score >= 60
    "Passed"
  else
    "Needs improvement"
  end
  puts "#{name}, your score is #{score}: #{grade}."
end
puts "Goodbye!"
