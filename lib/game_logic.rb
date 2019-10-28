# frozen_string_literal: true

# classes:

# Game
# Could include a class variable with games played
# Method / call to class to display the board (instead of puts on line 18)
# Method to instatiate the game / start game method
# Method to create a new player takes as a parameter the player name variable
# Method that includes the loop
# Method for quitting game
# ---???Method check_choice
# Method choice_valid?
# Method house_empty?
# Method update_board
# Method winner
# Optional methods to check rows, columns and diagonals

# Method restart

class Game
  @@game_counter = 0
  TURNS = 9
  def initialize
    @board = { a1: "\s", a2: "\s", a3: "\s", b1: "\s", b2: "\s", b3: "\s", c1: "\s", c2: "\s", c3: "\s" }
    @turn_counter = 1
    @@game_counter += 1
  end

  def create_player(name)
    Player.new(name)
  end

  def display_board
    "    1  2  3\n a [#{@board[:a1]}][#{@board[:a2]}][#{@board[:a3]}]\n b [#{@board[:b1]}][#{@board[:b2]}][#{@board[:b3]}]\n c [#{@board[:c1]}][#{@board[:c2]}][#{@board[:c3]}]\n"
  end

  def start_game
    while @turn_counter < TURNS
      puts '???????'
      @turn_counter += 1
    end
  end

  def board_values
    @board.values.join()
  end

  def choice_checker(input)
    return 'INVALID CHOICE' unless choice_valid?(input)

    return 'INVALID HOUSE' unless house_empty?(input)

    return true if choice_valid?(input) && house_empty?(input)
  end

  def choice_valid?(input)
    !@board[input].nil?
  end

  def house_empty?(input)
    return false if @board[input].match(/[OX]/)

    true
  end

  def update_board(input, player)
    puts "\n\n#{player.player_char}\n\n"
    @board[input] = player.player_char
    @board
  end

  def quit_game?(input)
    return true if input == :quit

    false
  end

  def winner(vals)
    return 'P1' if row_winner(vals, 'O')
    return 'P2' if row_winner(vals, 'X')
    return 'P1' if column_winner(vals, 'O')
    return 'P2' if column_winner(vals, 'X')
    return 'P1' if diagonal_winner(vals, 'O')
    return 'P2' if diagonal_winner(vals, 'X')
  end

  def row_winner(values, choice)
    if values[0..2] == "#{choice}#{choice}#{choice}" || values[3..5] == "#{choice}#{choice}#{choice}" || values[6..8] == "#{choice}#{choice}#{choice}"
      true
    else
      false
    end
  end

  def column_winner(values, choice)
    return true if values.match(/#{choice}..#{choice}..#{choice}/)
  end

  def diagonal_winner(values, choice)
    true if values.match(/#{choice}...#{choice}...#{choice}/) || values.match(/..#{choice}.#{choice}.#{choice}../)
  end

  def board_values
    @board.values.join
  end
end

class Player
  @@player_number = 0
  def initialize(name)
    @name = name
    @@player_number += 1
    @player_character = @@player_number
  end

  def player_char
    if @player_character.odd?
      'O'
    else
      'X'
    end
  end
end
