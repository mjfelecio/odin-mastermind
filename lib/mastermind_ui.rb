# frozen_string_literal: false

# Responsible for getting inputs and displaying outputs from the game
class MastermindUI
  def display_title_screen
    clear_screen
    display_welcome_message
    display_rules

    puts "\nPress any key to start the game..."
    gets
  end

  def display_game_end_screen(won)
    clear_screen
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
    clear_screen
    puts '-----------------------------------'
    puts '            Setup Game             '
    puts '-----------------------------------'
    puts 'Type (x) to proceed with default settings'
    puts 'Number of Rounds: 2 | Initial Role: Code Breaker'
    puts

    # Default settings
    input = gets.chomp.downcase
    if input == 'x'
      puts 'Using default settings!'
      sleep(1)
      return { num_of_rounds: 2, initial_role: :code_breaker }
    end

    initial_role = choose_initial_role
    num_of_rounds = choose_num_of_rounds

    puts
    role_display = initial_role == :code_maker ? 'CODE MAKER' : 'CODE BREAKER'
    puts "You are the #{role_display}"
    puts "Starting a game with #{num_of_rounds} rounds"
    sleep(1.5)

    { num_of_rounds: num_of_rounds, initial_role: initial_role }
  end

  def prompt_to_continue_playing
    clear_screen
    puts '-----------------------------------'
    puts '   Would you like to play again?   '
    puts '-----------------------------------'
    puts
    print "Press Enter to play again or 'q' to quit: "
    gets.chomp
  end

  def display_score(score)
    clear_screen
    puts '|-------------------------|'
    puts '|       Scoreboard        |'
    puts '|-------------------------|'
    puts '      Human      Computer   '
    puts "    #{center_text(score[:human], 9)}     #{center_text(score[:computer], 9)}"
    puts '|-------------------------|'

    # Show who's currently winning
    if score[:human] > score[:computer]
      puts '    Human is in the lead!    '
    elsif score[:computer] > score[:human]
      puts '   Computer is in the lead!   '
    else
      puts '    The game is tied!    '
    end

    puts
    puts 'Press any key to continue to next round...'
    gets
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
      print 'Choose your initial role (B for Code Breaker/M for Code Maker): '
      initial_role = gets.chomp.upcase

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
    puts '• OBJECTIVE: Earn the most points across all rounds.'
    puts '• GAMEPLAY: Players take turns as Code Maker and Code Breaker.'
    puts
    puts '  AS CODE MAKER:'
    puts '  - Create a secret code of 4 digits (1-6)'
    puts '  - Earn points based on how many guesses it takes'
    puts '    the Code Breaker to solve your code'
    puts '  - Maximum 12 points if your code remains uncracked'
    puts
    puts '  AS CODE BREAKER:'
    puts '  - Try to guess the secret code within 12 attempts'
    puts '  - After each guess, you\'ll receive feedback:'
    puts '    🔴 = Correct digit in correct position'
    puts '    ⚪ = Correct digit in wrong position'
    puts
    puts '• SCORING: Code Maker earns points equal to the'
    puts '  number of guesses used. If uncracked after 12'
    puts '  attempts, Code Maker earns maximum 12 points.'
    puts
    puts '• The roles swap after each round.'
    puts '• After all rounds, the player with most points wins!'
    puts
    puts 'Good luck and may the best mind win!'
    puts '-----------------------------------'
  end

  def clear_screen
    system('clear') || system('cls')
  rescue StandardError
    puts "\n" * 5
  end
end
