# frozen_string_literal: false

require_relative 'game_session'
require_relative 'human_player'
require_relative 'computer_player'

# Class that handles the logic for the game
class Mastermind
  def start_game
    print_title_info
    rounds, starting_role = setup_game

    GameSession.new(rounds, starting_role).start
  end

  def setup_game
    puts 'Press any key to set up the game or press (X) to proceed with the default settings:'
    puts 'Default ~>= starting_role: code_breaker | rounds: 4 <=~'
    # Default values
    starting_role = 'B'
    rounds = 4

    return [rounds, starting_role] if gets.chomp == 'X'

    starting_role = choose_starting_role

    loop do
      puts 'Number of Rounds: '

      rounds = gets.chomp.to_i

      break if rounds.even?

      puts 'Error: Number of rounds must be even'
    end
    [rounds, starting_role]
  end

  private

  def choose_starting_role
    print 'Type \'M\' to be the Code Maker and \'B\' to be the Code Breaker: '

    starting_role = ''
    loop do
      starting_role = gets.chomp

      if %w[M B].include?(starting_role)
        puts "You are the #{starting_role == 'M' ? 'CODE MAKER' : 'CODE BREAKER'}"
        break
      end

      print 'Invalid role, try again: '
    end
    starting_role
  end

  def print_title_info
    puts 'Welcome to Mastermind'
    puts 'Colors:
      R (Red)
      O (Orange)
      Y (Yelow)
      G (Green)
      B (Blue)
      V (Violet)'
  end
end
