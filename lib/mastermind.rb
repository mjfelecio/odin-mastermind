# frozen_string_literal: false

require_relative 'game_session'
require_relative 'human_player'
require_relative 'computer_player'

# Class that handles the logic for the game
class Mastermind
  def start_game
    print_title_info
    rounds, starting_role = setup_game

    game_session = GameSession.new(rounds, starting_role)
    game_session.start
    display_result(game_session.fetch_winner)
  end

  def display_result(winner)
    puts 'You lost the game!' if winner == :computer
    puts 'You won the game!' if winner == :human
  end

  private

  def setup_game
    puts 'Press any key to set up the game or press (X) to proceed with the default settings:'
    puts 'Default ~>= starting_role: code_breaker | rounds: 4 <=~'
    # Default values
    starting_role = 'B'
    rounds = 4

    return [rounds, starting_role] if gets.chomp == 'X'

    starting_role = choose_starting_role
    rounds = choose_num_of_rounds
    puts "You are the #{starting_role == 'M' ? 'CODE MAKER' : 'CODE BREAKER'}"

    [rounds, starting_role]
  end

  def choose_num_of_rounds
    loop do
      print 'Number of Rounds: '

      rounds = gets.chomp.to_i

      return rounds if rounds.even? && rounds >= 2

      puts 'Error: Number of rounds must be even and at least 2'
    end
  end

  def choose_starting_role
    print 'Type \'M\' to be the Code Maker and \'B\' to be the Code Breaker: '

    loop do
      starting_role = gets.chomp

      return starting_role if %w[M B].include?(starting_role)

      print 'Invalid role, try again: '
    end
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
