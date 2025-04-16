# frozen_string_literal: false

require_relative 'computer'

# Class that handles the logic for the game
class Mastermind
  COLORS = %w[R O Y G B V].freeze

  def initialize
    @player_role = 'B' # Default role is to be the code breaker for now
    @computer = Computer.new
  end

  def start_game
    puts 'Welcome to Mastermind'
    puts 'Colors:
      R (Red)
      O (Orange)
      Y (Yelow)
      G (Green)
      B (Blue)
      V (Violet)'
    puts 'Type \'M\' to be the Code Maker and \'B\' to be the Code Breaker: '
    @player_role = 'B' # Add a way to get input later, for now, the player is the breaker
    @computer.role = @player_role == 'B' ? :code_maker : :code_breaker
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
    if @player_role == 'B'
      @secret_code = @computer.generate_secret_code
    elsif @player_role == 'M'
      puts 'Your secret code must be 4 letters
            (Ex. RGBV or BYOG)
            Enter your secret code:'
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
end
