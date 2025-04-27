# frozen_string_literal: false

module FeedbackProcessor
  def process(secret_code, guess)
    feedback = []
    code_chars = secret_code.chars
    guess_chars = guess.chars

    # Check for red pins
    code_chars.each_with_index do |color, idx|
      next unless guess_chars[idx] == color

      feedback << '🔴'
      code_chars[idx] = nil
      guess_chars[idx] = nil
    end

    # Check for white pins
    guess.chars.each do |color|
      next unless code_chars.include?(color)

      feedback << '⚪'
      idx = code_chars.find_index(color)
      code_chars[idx] = nil
    end

    feedback.shuffle.join
  end
end
