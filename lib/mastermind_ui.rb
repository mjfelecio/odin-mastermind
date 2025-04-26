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
    return { num_of_rounds: 4, initial_role: :code_breaker } if gets.chomp == 'X'

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

      puts 'Error: Number of rounds must be even and at least 2'
    end
  end

  def choose_initial_role
    print 'Choose your role (B/M): '

    loop do
      initial_role = gets.chomp

      if %w[M B].include?(initial_role)
        role_as_sym = initial_role == 'B' ? :code_breaker : :code_maker
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
