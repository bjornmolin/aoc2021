import Pkg; Pkg.add("InvertedIndices")

using Statistics
using DelimitedFiles
using InvertedIndices

large_number_mark = 10000

function read_bingo_input(filename) 
    random_numbers = []
    bingo_boards = []
    f=open(filename ) do file
        random_numbers = parse.(Int, split(readline(file), ","));

        bingo_boards_2d = readdlm(file, Int)
        number_of_boards = Int(size(bingo_boards_2d, 1) / 5)
        bingo_boards = reshape(bingo_boards_2d', (5,5,number_of_boards))
        close(file)

    end
    random_numbers, bingo_boards
end

function mark_number(bingo_boards, number)
    bingo_boards + (bingo_boards.==number)*large_number_mark
end

function boards_with_bingo(bingo_boards)
    bingo_dim1 = sum(sum(bingo_boards, dims=1).>5*large_number_mark, dims=2)
    bingo_dim2 = sum(sum(bingo_boards, dims=2).>5*large_number_mark, dims=1)

    bingo_on_boards_dim1 = findall(bingo_dim1.==true)
    bingo_on_boards_dim2 = findall(bingo_dim2.==true)

    bingoboards1 = map(coordinate -> coordinate[3], bingo_on_boards_dim1)
    bingoboards2 = map(coordinate -> coordinate[3], bingo_on_boards_dim2)
    bingo = sort(union(bingoboards1,bingoboards2), rev=true)

    bingo_boards_left = bingo_boards
    bingo_on_board = -1
    score_on_board = -1
    for boardNo in bingo
        bingo_boards_left = bingo_boards_left[:,:,Not(boardNo)]
        bingo_on_board = boardNo
        score_on_board = score_board(bingo_boards, bingo_on_board)
    end

    (bingo_boards_left, bingo_on_board, score_on_board)
end


function score_board(bingo_boards, board_index)
    score = -1

    winning_board = bingo_boards[:,:,board_index]'
    score = sum((winning_board.<large_number_mark).*winning_board)
    score
end

(random_numbers, bingo_boards) = read_bingo_input("input")

number_count = 0
for number in random_numbers
    global number_count += 1
    global bingo_boards = mark_number(bingo_boards, number)

    println("NUMBER ", number_count, ": ", number)

    (bingo_boards_left, bingo_on_board, score_on_board) = boards_with_bingo(bingo_boards)
    
    if bingo_on_board > 0
        println("SCORE on board with bingo: ", score_on_board*number)
    end
    global bingo_boards = bingo_boards_left

    println("Boards left: ", size(bingo_boards_left, 3))
    if size(bingo_boards_left, 3) == 0
        exit()
    end
end