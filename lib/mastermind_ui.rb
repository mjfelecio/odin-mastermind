# frozen_string_literal: false

# Responsible for getting inputs and displaying outputs from the game
class MastermindUI
  def display_title_screen
    display_welcome_message
    display_rules

    puts 'Press any letter to continue...'
    gets
  end

  def prompt_for_game_setup
    puts '-----------------------------------'
    puts '            Setup Game             '
    puts '-----------------------------------'
    puts 'Type (x) to proceed with default settings'
    puts 'Number of Rounds: 2 | Initial Role: Code Breaker'

    # Default settings
    return { num_of_rounds: 2, initial_role: :code_breaker } if gets.chomp == 'x'

    initial_role = choose_initial_role
    num_of_rounds = choose_num_of_rounds
    puts "You are the #{initial_role == :code_maker ? 'CODE MAKER' : 'CODE BREAKER'}"

    { num_of_rounds: num_of_rounds, initial_role: initial_role }
  end

  def display_score(score)
    puts '|-----------------------|'
    puts '|      Scoreboard       |'
    puts '|-----------------------|'
    puts '    Human     Computer   '
    puts "  #{center_text(score[:human], 9)}   #{center_text(score[:computer], 9)}"
  end

  private

  def center_text(text, width)
    text = text.to_s
    total_padding = [width - text.length, 0].max
    left_padding = total_padding / 2
    right_padding = total_padding - left_padding
    ' ' * left_padding + text + ' ' * right_padding
  end

  # === User input functions ===

  def choose_num_of_rounds
    loop do
      print 'Number of Rounds: '

      num_of_rounds = gets.chomp.to_i

      return num_of_rounds if num_of_rounds.even? && num_of_rounds >= 2

      puts 'Number of rounds must be even and at least 2'
    end
  end

  def choose_initial_role
    loop do
      print 'Choose your initial role (B/M): '
      initial_role = gets.chomp

      if %w[M B].include?(initial_role)
        role_as_sym = initial_role == 'B' ? :code_breaker : :code_maker
        return role_as_sym
      end

      puts 'Invalid role, try again'
    end
  end

  # === UI functions ===

  def display_welcome_message
    puts '==================================='
    puts '        Welcome to Mastermind!     '
    puts '==================================='
  end

  def display_rules
    puts '-----------------------------------'
    puts '            Game Rules             '
    puts '-----------------------------------'
    puts '- You must guess the secret code.'
    puts '- The code is made of 4 colors.'
    puts '- Colors may repeat.'
    puts "- After each guess, you'll get hints:"
    puts '  - A 🔴 hint for correct color and position.'
    puts '  - A ⚪ hint for correct color but wrong position.'
    puts '- You have 12 turns to crack the code!'
    puts 'Good luck!'
    puts '-----------------------------------'
  end
end
