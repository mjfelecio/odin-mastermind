# frozen_string_literal: false

class FeedbackProcessor
  def self.process(secret_code, guess)
    new(secret_code, guess).process
  end

  def initialize(secret_code, guess)
    @secret_code = secret_code
    @guess = guess
    @feedback = []
  end

  def process
    check_red_pegs
    check_white_pegs

    @feedback.shuffle
  end

  private

  def check_red_pegs
    code_chars = @secret_code.chars
    guess_chars = @guess.chars

    code_chars.each_with_index do |color, idx|
      next unless guess_chars[idx] == color

      @feedback << 'red'
      code_chars[idx] = nil
      guess_chars[idx] = nil
    end

    @secret_code = code_chars.compact.join
    @guess = guess_chars.compact.join
  end

  def check_white_pegs
    code_chars = @secret_code.chars

    @guess.chars.each do |color|
      next unless code_chars.include?(color)

      @feedback << 'white'
      idx = code_chars.find_index(color)
      code_chars[idx] = nil
    end
    @secret_code = code_chars.compact.join
  end
end
