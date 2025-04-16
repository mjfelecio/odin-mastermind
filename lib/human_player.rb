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

  def provide_feedback(secret_code, guess)
    feedback = []
    puts 'Provide feedback on the guess made by the computer: '
    secret_code.split('').each_with_index do |color, idx|
      if guess[idx] == color && secret_code.include?(guess[idx])
        feedback << 'red'
        next
      end
      feedback << 'white' if secret_code.include?(guess[idx])
    end
    feedback.shuffle.inspect
  end

  def valid_code?(code)
    code.length == 4 && code.chars.all? { |c| COLORS.include?(c) }
  end
end
