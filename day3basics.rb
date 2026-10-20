
friends = ['sharon','leo', 'leila']

friends.each{|friend| puts "hello " + friend}

friends.each do |friend|
    puts "Hello #{friend}"
end

my_hash = {"one"=>1, "two" =>2}

my_hash.each {|key, value| puts "Current number is #{key} the value is #{value}"}

puts friends.select{|friend| friend != 'leila' }

numbers = [1,2,3,4,5]
numbers.push(numbers.reduce{|sum,number| sum+number})

puts numbers

friendly = ["arthur","john","jane"]
friendly.each { |friend| puts friend.upcase }
print friendly


#Predicate Enumerable Methods

froends = ["jack","jordan","jollibee"]

variables = froends.select{|friend| friend != "jordan"}
puts variables.include?("jordan")

numbers = 