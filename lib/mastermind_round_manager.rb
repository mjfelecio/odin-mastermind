class MastermindRoundManager
  def initialize(code_breaker, secret_code)
    @secret_code = secret_code
    @code_breaker = code_breaker
    @code_maker_score = 12
    @num_of_attempts = 12
  end

  def start
    handle_breaker_guessing
  end

  def fetch_result
    @code_maker_score
  end

  private

  def handle_breaker_guessing
    (1..@num_of_attempts).each do |row_num|
      print "Row ##{row_num} Guess: "

      guess = fetch_guess

      if solved?(guess)
        # The current row will be the score of the code maker
        @code_maker_score = row_num
        break
      end

      puts "Feedback: #{FeedbackProcessor.process(@secret_code, guess)}"
    end
  end

  def fetch_guess
    @code_breaker.guess
  end

  def solved?(guess)
    guess == @secret_code
  end
end
