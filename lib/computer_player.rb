# frozen_string_literal: false

class ComputerPlayer
  VALID_CODES = %w[1 2 3 4 5 6].freeze

  def secret_code
    secret_code = ''
    4.times do
      secret_code << VALID_CODES[rand(6)]
    end
    puts '~> The computer has decided on a secret code <~'
    secret_code
  end

  def guess
    guess = ''
    4.times do
      guess << VALID_CODES[rand(6)]
    end
    sleep(1)
    puts guess
    guess
  end
end
