# frozen_string_literal: false

class GuessingAlgoritm
  include FeedbackProcessor

  def initialize
    @all_secret_code_combinations = generate_all_codes
  end

  def guess
  end

  def generate_all_codes
    (1111..6666).to_a.select { |num| num.to_s.chars.all? { |c| c.to_i.between?(1, 6) } }
  end

  def filter_valid_codes(codes, prev_guess, feedback)
    # Filter the codes that would give the same feedback if they WERE the secret code
    codes.select { |code| process(code, prev_guess) == feedback }
  end

  def find_worst_feedback(guess, possible_codes)
    # Compares the guess to the each of the possible secret codes
    # to see the worst possible outcome for that guess.
    # (This is so that even if we take the worst possible feedback
    # we still guarantee that it is the best choice)
    feedbacks = possible_codes.map { |code| process(code, guess) }
    groups = feedbacks.group_by { |fb| fb }
    groups.values.map(&:size).max
  end
end
