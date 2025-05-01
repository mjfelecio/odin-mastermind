# frozen_string_literal: false

require_relative './feedback_processor'

# Handles a single round of a Mastermind Game
class RoundManager
  include FeedbackProcessor

  def initialize(code_maker, code_breaker)
    @secret_code = nil
    @code_maker = code_maker
    @code_breaker = code_breaker
    @code_maker_score = 12
    @feedback = nil
  end

  def start
    create_secret_code
    handle_breaker_guessing
  end

  def fetch_result
    @code_maker_score
  end

  private

  def handle_breaker_guessing
    (1..12).each do |row_num|
      print "Row ##{row_num} Guess: "

      puts guess = @code_breaker.make_guess(@feedback)

      if solved?(guess)
        # The current row will be the score of the code maker
        @code_maker_score = row_num
        break
      end

      @feedback = process(@secret_code, guess)
      puts "Feedback: #{@feedback}"
    end
  end

  def create_secret_code
    @secret_code = @code_maker.create_secret_code
  end

  def solved?(guess)
    guess == @secret_code
  end
end
