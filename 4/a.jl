using Statistics
using DelimitedFiles

large_number_mark = 10000

function read_bingo_input(filename) 
    random_numbers = []
    bingo_boards = []
    f=open(filename ) do file
        random_numbers = parse.(Int, split(readline(file), ","));

        bingo_boards_2d = readdlm(file, Int)
        number_of_boards = Int(size(bingo_boards_2d, 1) / 5)
        println("NUMBER OF BOARDS ", number_of_boards)
        bingo_boards = reshape(bingo_boards_2d', (5,5,number_of_boards))
        close(file)

    end
    random_numbers, bingo_boards
end

function mark_number(bingo_boards, number)
    bingo_boards + (bingo_boards.==number)*large_number_mark
end

function sum_board_if_bingo(bingo_boards)
    score = -1
    bingo_dim1 = sum(sum(bingo_boards, dims=1).>5*large_number_mark, dims=2)
    bingo_dim2 = sum(sum(bingo_boards, dims=2).>5*large_number_mark, dims=1)

    bingo_on_boards_dim1 = findall(bingo_dim1.==true)
    bingo_on_boards_dim2 = findall(bingo_dim2.==true)

    println("SIZE1 ", size(bingo_on_boards_dim1))
    println("SIZE2   ", size(bingo_on_boards_dim2))
    if size(bingo_on_boards_dim1, 1)>0
        board = bingo_on_boards_dim1[1][3]
        winning_board = bingo_boards[:,:,board]'
        global score = sum((winning_board.<large_number_mark).*winning_board)
    end

    if size(bingo_on_boards_dim2, 1)>0
        board = bingo_on_boards_dim2[1][3]
        winning_board = bingo_boards[:,:,board]'
        global score = sum((winning_board.<large_number_mark).*winning_board)
    end

    score
end

(random_numbers, bingo_boards) = read_bingo_input("input")
println(random_numbers)
display(bingo_boards)

number_count = 0
for number in random_numbers
    global number_count += 1
    global bingo_boards = mark_number(bingo_boards, number)

    println("NUMBER ", number_count, ": ", number)

    score = sum_board_if_bingo(bingo_boards)
    
    if (score>=0) 
        println(score*number)
        exit()
    end
    
end