# frozen_string_literal: false

require_relative './guessing_algorithm'

class ComputerPlayer
  VALID_CODES = %w[1 2 3 4 5 6].freeze

  def initialize
    @guesser = GuessingAlgoritm.new
  end

  def create_secret_code
    secret_code = ''
    4.times do
      secret_code << VALID_CODES[rand(6)]
    end
    puts '~> The computer has decided on a secret code <~'
    secret_code
  end

  def make_guess(feedback)
    @guesser.guess(feedback)
  end
end
