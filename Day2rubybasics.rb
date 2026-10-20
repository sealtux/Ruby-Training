puts"Welcome the ATM How much money would you like to withdraw?"
numarray = []

loop do 
    puts "can You enter your pin"
    x = gets 
    numarray.push(x)
    puts x
    if numarray.length == 5
        break
    end
   
end
