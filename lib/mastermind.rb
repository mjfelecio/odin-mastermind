# frozen_string_literal: false

require_relative 'computer_player'

# Class that handles the logic for the game
class Mastermind
  COLORS = %w[R O Y G B V].freeze

  def initialize
    @player_role = 'B' # Default role is to be the code breaker for now
    @computer = ComputerPlayer.new
  end

  def start_game
    print_title_info
    prompt_player_role
    input_secret_code

    12.times do |i|
      row_num = i + 1
      print "Row ##{row_num} Guess:"
      guess = get_breaker_guess
      break if solved?(guess)

      provide_feedback(guess)
    end
  end

  private

  def input_secret_code
    if @player_role == :code_breaker
      @secret_code = @computer.generate_secret_code
    elsif @player_role == :code_maker
      puts 'Your secret code must be 4 letters (Ex. RGBV or BYOG)'
      puts 'Enter your secret code: '
      @secret_code = gets.chomp # Add a way to validate this later
    end
    puts "The secret code is: #{@secret_code}"
    # puts "\n" * 10
  end

  def provide_feedback(guess)
    feedback = []
    feedback = @computer.provide_feedback(@secret_code, guess) if @player_role == 'B'
    # Add a way to get user feedback here
    puts "Feedback: #{feedback}"
  end

  def solved?(guess)
    guess == @secret_code
  end

  def get_breaker_guess
    # TODO: Add better validation messages
    # TODO: Add a way to get the computer guess
    guess = ''
    loop do
      guess = gets.chomp

      break if guess.length == 4 && guess.chars.all? { |c| COLORS.include?(c) }

      print 'Invalid input, try again: '
    end
    guess
  end

  def prompt_player_role
    print 'Type \'M\' to be the Code Maker and \'B\' to be the Code Breaker: '

    loop do
      selected_role = gets.chomp

      if %w[M B].include?(selected_role)
        setup_player_roles(selected_role)
        puts "You are the #{selected_role == 'M' ? 'CODE MAKER' : 'CODE BREAKER'}"
        break
      end

      print 'Invalid role, try again: '
    end
  end

  def setup_player_roles(selected_role)
    if selected_role == 'M'
      @player_role = :code_maker
      @computer.role = :code_breaker
    elsif selected_role == 'B'
      @player_role = :code_breaker
      @computer.role = :code_maker
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
