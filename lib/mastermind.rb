# frozen_string_literal: false

require_relative 'game_session'
require_relative 'human_player'
require_relative 'computer_player'

# Class that handles the logic for the game
class Mastermind
  def start_game
    print_title_info
    starting_role = choose_starting_role
    rounds = 12

    GameSession.new(rounds, starting_role).start
  end

  def setup
    # Code that handles setting up the game like:
    # - How many rounds the game should have
    # - What the player starting role should be
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
