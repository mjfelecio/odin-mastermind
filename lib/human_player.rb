# frozen_string_literal: false

class HumanPlayer
  VALID_CODES = %w[1 2 3 4 5 6].freeze

  def secret_code
    secret_code = nil
    loop do
      print 'Enter your secret code: '

      secret_code = gets.chomp

      break if valid_code?(secret_code)

      puts 'Invalid secret code, try again.'
    end
    secret_code
  end

  def guess(feedback)
    guess = ''
    loop do
      guess = gets.chomp

      break if valid_code?(guess)

      print 'Invalid guess, try again: '
    end
    guess
  end

  def valid_code?(code)
    code.length == 4 && code.chars.all? { |c| VALID_CODES.include?(c) }
  end
end
