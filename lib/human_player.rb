# frozen_string_literal: false

class HumanPlayer
  VALID_CODES = %w[1 2 3 4 5 6].freeze

  def create_secret_code
    loop do
      print 'Enter your secret code: '
      secret_code = gets.chomp

      return secret_code if valid_code?(secret_code)

      puts 'Invalid code! Must be 4 digits, each between 1-6.'
    end
  end

  def make_guess(feedback)
    loop do
      guess = gets.chomp

      return guess if valid_code?(guess)

      puts 'Invalid guess! Must be 4 digits, each between 1-6.'
    end
  end

  private

  def valid_code?(code)
    code.length == 4 && code.chars.all? { |c| VALID_CODES.include?(c) }
  end
end
