class Tictacthrow
    def initialize()
        @winner = {[1,2,3] => 0 ,[4,5,6] => 0, [7,8,9] => 0 , [1,4,7]=>0,
        [2,5,8]=>0, [3,6,9]=>0, [1,5,9]=>0, [3,5,7]=>0}

        @player1_inputs = []

        @player2_inputs = []

    end 

    def player1(input1)

        @player1_inputs.push(input1)

    end

    def player2(input2)

        @player1_inputs.push(input2)

    end

    def returner()
    
    
        return 0
    end
    
    def rulemessage()

    end
end



command = Tictacthrow.new

win =1
i=0 
matrix = 0
game = 0

loop do 
    if game% 2  == 0
        while true 
            if i%2 == 0   
                puts "Pick from 1 to 9 player1 (X)"
                matrix = gets.chomp()
                command.player1(matrix)
                    

            elsif
                puts "Pick from 1 to 9 player1 (0)"
                matrix = gets.chomp()
                command.player1(matrix)
            
            else
                puts "Again"
            end

            i +=1


        end

    else

       while true 
            if i%2 == 0   
                puts "Pick from 1 to 9 player1 (X)"
                matrix = gets.chomp()
                command.player1(matrix)
                    

            elsif
                puts "Pick from 1 to 9 player1 (0)"
                matrix = gets.chomp()
                command.player1(matrix)
           

            

            else
                puts "Again"
            end
            i +=1

        end
    end
    game+=1
end