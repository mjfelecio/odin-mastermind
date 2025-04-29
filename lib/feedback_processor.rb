# frozen_string_literal: false

module FeedbackProcessor
  def process(secret_code, guess)
    @feedback = []
    @code_chars = secret_code.to_s.chars
    @guess_chars = guess.to_s.chars

    check_red_pins
    check_white_pins

    @feedback.join
  end

  def check_red_pins
    @code_chars.each_with_index do |color, idx|
      next unless @guess_chars[idx] == color

      @feedback << '🔴'
      @code_chars[idx] = nil
      @guess_chars[idx] = nil
    end
  end

  def check_white_pins
    @guess_chars.each do |color|
      next if color.nil?
      next unless @code_chars.include?(color)

      @feedback << '⚪'
      code_idx = @guess_chars.find_index(color)
      @code_chars[code_idx] = nil
      @guess_chars[code_idx] = nil
    end
  end
end
