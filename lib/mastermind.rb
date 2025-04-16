# frozen_string_literal: false

# Class that handles the logic for the game
class Mastermind
  COLORS = %w[R O Y G B V].freeze

  def initialize
    @player_role = 'B' # Default role is to be the code breaker for now
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
    input_secret_code

    12.times do |i|
      row_num = i + 1
      guess = ''
      puts "Row ##{row_num} Guess:"
      guess = gets.chomp # Add a way to validate guess input
    end
  end

  private

  def input_secret_code
    if @player_role == 'B'
      @secret_code = generate_secret_code
    elsif @player_role == 'M'
      puts 'Your secret code must be 4 letters
            (Ex. RGBV or BYOG)
            Enter your secret code:'
      @secret_code = gets.chomp # Add a way to validate this later
    end
    puts "The secret code is: #{@secret_code}"
    puts "\n" * 10
  end

  def generate_secret_code
    secret_code = ''
    4.times do
      secret_code << COLORS[rand(6)]
    end
    secret_code
  end
end
