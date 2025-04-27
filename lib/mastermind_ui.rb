# frozen_string_literal: false

# Responsible for getting inputs and displaying outputs from the game
class MastermindUI
  def display_title_screen
    display_welcome_message
    display_rules

    puts 'Press any letter to continue...'
    gets
  end

  def display_game_end_screen(won)
    puts '==================================='
    case won
    when true
      puts '🏆 YOU ARE THE WINNER!! 🏆'
      puts
      puts 'You dominated the battlefield of wits and cracked more codes!'
      puts 'A true Mastermind! Your logical prowess reigns supreme!'
      puts
      puts 'Thank you for playing!'
    when false
      puts '💻 COMPUTER WINS! 💻'
      puts
      puts 'The machine outsmarted the human this time...'
      puts 'But every defeat plants the seed for a greater comeback.'
      puts 'Sharpen your mind and challenge again!'
      puts
      puts 'Thank you for playing!'
    when :tie
      puts "🤝 IT'S A DRAW! 🤝"
      puts
      puts 'What a tense and thrilling battle!'
      puts 'Neither side could claim absolute victory today.'
      puts 'Perhaps destiny awaits in a future rematch?'
      puts
      puts 'Thank you for playing!'
    else
      puts '⚠️ Unexpected end of game.'
    end
    puts '==================================='
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

  def prompt_to_continue_playing
    puts '-----------------------------------'
    puts '   Would you like to play again?   '
    puts '-----------------------------------'
    print "Enter to play again or 'q' to quit: "
    gets.chomp
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
    puts '- The code is made of 4 numbers from 1-6.'
    puts '- Numbers may repeat.'
    puts "- After each guess, you'll get hints:"
    puts '  - A 🔴 hint for correct number and position.'
    puts '  - A ⚪ hint for correct number but wrong position.'
    puts '- You have 12 turns to crack the code!'
    puts
    puts '- After each round, the roles will swap!'
    puts '- One round you will be the code breaker, the next the code maker.'
    puts '- The player with the most total points after all rounds wins!'
    puts
    puts 'Good luck!'
    puts '-----------------------------------'
  end
end
