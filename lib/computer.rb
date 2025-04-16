class Computer
  attr_writer :role

  COLORS = %w[R O Y G B V].freeze

  def initialize
    @role = :code_maker
  end

  def generate_secret_code
    secret_code = ''
    4.times do
      secret_code << COLORS[rand(6)]
    end
    secret_code
  end

  def provide_feedback(secret_code, guess)
    feedback = []
    secret_code.split('').each_with_index do |color, idx|
      if guess[idx] == color && secret_code.include?(guess[idx])
        feedback << 'red'
        next
      end
      feedback << 'white' if secret_code.include?(guess[idx])
    end
    feedback.shuffle.inspect
  end
end
