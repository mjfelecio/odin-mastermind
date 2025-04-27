# frozen_string_literal: false

class HumanPlayer
  COLORS = %w[R O Y G B V].freeze

  def secret_code
    secret_code = nil
    loop do
      print 'Enter your secret code: '

      secret_code = gets.chomp # Add a way to validate this later

      break if valid_code?(secret_code)

      puts 'Invalid secret code, try again: '
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
