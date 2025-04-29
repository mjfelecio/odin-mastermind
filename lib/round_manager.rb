# frozen_string_literal: false

require_relative './feedback_processor'

class RoundManager
  include FeedbackProcessor
  def initialize(code_breaker, secret_code)
    @secret_code = secret_code
    @code_breaker = code_breaker
    @code_maker_score = 12
    @num_of_attempts = 12
    @prev_feedback = :first_guess
  end

  def start
    handle_breaker_guessing
  end

  def fetch_result
    @code_maker_score
  end

  private

  def handle_breaker_guessing
    (1..@num_of_attempts).each do |row_num|
      print "Row ##{row_num} Guess: "

      guess = fetch_guess(@prev_feedback)

      if solved?(guess)
        # The current row will be the score of the code maker
        @code_maker_score = row_num
        break
      end

      feedback = process(@secret_code, guess)
      @prev_feedback = feedback
      puts "Feedback: #{feedback}"
    end
  end

  def fetch_guess(feedback)
    @code_breaker.guess(feedback)
  end

  def solved?(guess)
    guess == @secret_code
  end
end
