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
    secret_code
  end

  def make_guess(feedback)
    display_computer_thinking
    guess = @guesser.guess(feedback)
    display_computer_guess(guess)
    guess
  end

  private

  def display_computer_thinking
    print 'Computer is analyzing the feedback'
    3.times do
      print '.'
      sleep(0.5)
    end
    puts
  end

  def display_computer_guess(guess)
    puts "Computer guesses: #{guess}"
    sleep(1)
  end
end
