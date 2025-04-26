# frozen_string_literal: false

require_relative './feedback_processor'

class HumanPlayer
  attr_accessor :role

  COLORS = %w[R O Y G B V].freeze

  def secret_code
    puts 'Your secret code must be 4 letters (Ex. RGBV or BYOG)'
    print 'Enter your secret code: '
    secret_code = nil
    loop do
      secret_code = gets.chomp # Add a way to validate this later

      break if valid_code?(secret_code)

      print 'Invalid secret code, try again: '
    end
    secret_code
  end

  def guess
    guess = ''
    loop do
      guess = gets.chomp

      break if guess.length == 4 && guess.chars.all? { |c| COLORS.include?(c) }

      print 'Invalid input, try again: '
    end
    guess
  end

  def valid_code?(code)
    code.length == 4 && code.chars.all? { |c| COLORS.include?(c) }
  end
end
