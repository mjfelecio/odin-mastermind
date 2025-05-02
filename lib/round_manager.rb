# frozen_string_literal: false

require_relative './feedback_processor'
require_relative './mastermind_ui'

# Handles a single round of a Mastermind Game
class RoundManager
  include FeedbackProcessor

  def initialize(code_maker, code_breaker)
    @secret_code = nil
    @code_maker = code_maker
    @code_breaker = code_breaker
    @code_maker_score = 12
    @ui = MastermindUI.new
  end

  def start
    create_secret_code
    handle_breaker_guessing
    @ui.display_round_result(@code_maker_score)
  end

  def fetch_result
    @code_maker_score
  end

  private

  def handle_breaker_guessing
    feedback = nil
    (1..12).each do |row_num|
      @code_breaker.instance_of?(HumanPlayer) && print("Attempt ##{row_num}: ")

      guess = @code_breaker.make_guess(feedback)
      feedback = process(@secret_code, guess)

      # Shuffles the feedback when displaying them
      puts "Feedback: #{feedback.chars.shuffle.join}"

      next unless solved?(guess)

      # The current row will be the score of the code maker
      @code_maker_score = row_num
      break
    end
  end

  def create_secret_code
    @secret_code = @code_maker.create_secret_code
  end

  def solved?(guess)
    guess == @secret_code
  end
end
