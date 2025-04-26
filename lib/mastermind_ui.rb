# frozen_string_literal: false

# Responsible for getting inputs and displaying outputs from the game
class MastermindUI
  def display_start_messages
    display_welcome_message
    display_game_rules
  end

  def prompt_for_game_setup
    puts '~===> Game Setup <===~'
    puts 'Type (X) to proceed with default settings'

    # Default settings
    return { num_of_rounds: 4, starting_role: 'B' } if gets.chomp == 'X'

    starting_role = choose_starting_role
    num_of_rounds = choose_num_of_rounds
    puts "You are the #{starting_role == 'M' ? 'CODE MAKER' : 'CODE BREAKER'}"

    { num_of_rounds: num_of_rounds, starting_role: starting_role }
  end

  private

  # === User input functions ===

  def choose_num_of_rounds
    loop do
      print 'Number of Rounds: '

      num_of_rounds = gets.chomp.to_i

      return num_of_rounds if num_of_rounds.even? && num_of_rounds >= 2

      puts 'Error: Number of rounds must be even and at least 2'
    end
  end

  def choose_starting_role
    print 'Choose your role (B/M): '

    loop do
      starting_role = gets.chomp

      if %w[M B].include?(starting_role)
        role_as_sym = starting_role == 'B' ? :code_breaker : :code_maker

        return role_as_sym
      end

      print 'Invalid role, try again: '
    end
  end

  # === UI functions ===

  def display_welcome_message
    puts 'Welcome to Mastermind Game'
  end

  def display_game_rules
    puts 'Placeholder for game rules'
  end
end
