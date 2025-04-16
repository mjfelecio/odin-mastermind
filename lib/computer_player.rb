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

  def provide_feedback(secret_code, guess)
    # TODO: Refactor this later
    feedback = []
    remaining_code = secret_code.chars

    # Check for any red pegs
    secret_code.split('').each_with_index do |color, idx|
      next unless guess[idx] == color

      feedback << 'red'
      remaining_code[idx] = nil
      next
    end

    # Check for any white pegs
    guess.chars.each do |color|
      next unless remaining_code.include?(color)

      feedback << 'white'
      guess_color_idx = remaining_code.find_index(color)
      remaining_code[guess_color_idx] = nil
    end

    feedback.shuffle.inspect
  end
end
