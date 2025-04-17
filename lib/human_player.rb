class HumanPlayer
  attr_accessor :role

  COLORS = %w[R O Y G B V].freeze

  def prompt_for_secret_code
    puts 'Your secret code must be 4 letters (Ex. RGBV or BYOG)'
    puts 'Enter your secret code: '
    secret_code = nil
    loop do
      secret_code = gets.chomp # Add a way to validate this later

      break if valid_code?(secret_code)

      print 'Invalid secret code, try again: '
    end
    secret_code
  end

  def guess
    guess = ''
    loop do
      guess = gets.chomp

      break if guess.length == 4 && guess.chars.all? { |c| COLORS.include?(c) }

      print 'Invalid input, try again: '
    end
    guess
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

  def valid_code?(code)
    code.length == 4 && code.chars.all? { |c| COLORS.include?(c) }
  end
end
