# frozen_string_literal: false

class GuessingAlgoritm
  include FeedbackProcessor

  def initialize
    @all_secret_code_combinations = generate_all_codes
    @valid_codes = @all_secret_code_combinations.dup
    @previous_guess = '1122'
  end

  def guess(feedback)
    return '1122' if feedback == :first_guess

    @valid_codes = filter_valid_codes(@valid_codes, @previous_guess, feedback)

    # Score all the possible codes
    scores = @all_secret_code_combinations.map do |possible_guess|
      find_worst_feedback(possible_guess, @valid_codes)
    end

    # Gets lowest score (meaning it narrows down the secret code better because it has less possibilities)
    min_score = scores.min
    candidates = @all_secret_code_combinations.select.with_index { |_, i| scores[i] == min_score }

    # Filters the candidates to only those that are considered as valid codes using intersection
    valid_candidates = candidates & @valid_codes

    # If the candidate isn't in the valid codes, just use the candidates
    # from all possible secret codes, and then find the lowest number in it as the guess
    guess = (valid_candidates.empty? ? candidates : valid_candidates).min
    @previous_guess = guess
    guess
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
