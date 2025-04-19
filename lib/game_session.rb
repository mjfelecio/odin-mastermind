# frozen_string_literal: false

require_relative 'human_player'
require_relative 'computer_player'

class GameSession
  def initialize(rounds, starting_role)
    @num_of_rounds = rounds
    @human = HumanPlayer.new
    @computer = ComputerPlayer.new
    setup_player_roles(starting_role)
  end

  def start
    input_secret_code
    rounds = 12

    rounds.times do |i|
      row_num = i + 1
      print "Row ##{row_num} Guess: "
      guess = get_breaker_guess
      break if solved?(guess)

      provide_feedback(guess)
    end
  end

  def input_secret_code
    if @human.role == :code_breaker
      @secret_code = @computer.generate_secret_code
    elsif @human.role == :code_maker
      @secret_code = @human.prompt_for_secret_code
    end
    puts "The secret code is: #{@secret_code}"
    puts "\n" * 20
  end

  def provide_feedback(guess)
    feedback = []
    feedback = @computer.provide_feedback(@secret_code, guess) if @human.role == :code_breaker
    feedback = @human.provide_feedback(@secret_code, guess) if @human.role == :code_maker
    puts "Feedback: #{feedback}"
  end

  def solved?(guess)
    guess == @secret_code
  end

  def get_breaker_guess
    # TODO: Add better validation messages
    # TODO: Add a way to get the computer guess
    guess = ''
    guess = @computer.guess if @human.role == :code_maker
    guess = @human.guess if @human.role == :code_breaker
    guess
  end

  def setup_player_roles(selected_role)
    if selected_role == 'M'
      @human.role = :code_maker
      @computer.role = :code_breaker
    elsif selected_role == 'B'
      @human.role = :code_breaker
      @computer.role = :code_maker
    end
  end
end
