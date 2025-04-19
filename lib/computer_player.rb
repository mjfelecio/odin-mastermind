# frozen_string_literal: false

require_relative './feedback_processor'

class ComputerPlayer
  attr_accessor :role

  COLORS = %w[R O Y G B V].freeze

  def generate_secret_code
    secret_code = ''
    4.times do
      secret_code << COLORS[rand(6)]
    end
    secret_code
  end

  def guess
    guess = ''
    4.times do
      guess << COLORS[rand(6)]
    end
    sleep(1)
    puts guess
    guess
  end

  def provide_feedback(secret_code, guess)
    FeedbackProcessor.process(secret_code, guess)
  end
end
