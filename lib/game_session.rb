# frozen_string_literal: false

require_relative 'human_player'
require_relative 'computer_player'

class GameSession
  def initialize(num_of_rounds, starting_role)
    @num_of_rounds = num_of_rounds
    @human = HumanPlayer.new
    @computer = ComputerPlayer.new
    setup_player_roles(starting_role)
    @curr_round = 1
    @scores = {
      human: 0,
      computer: 0
    }
  end

  def start
    is_solved = false
    @num_of_rounds.times do
      input_secret_code
      rows_used = 12

      (1..12).each do |row_num|
        print "Row ##{row_num} Guess: "
        guess = get_breaker_guess

        if solved?(guess)
          is_solved = true
          rows_used = row_num
          break
        end

        provide_feedback(guess)
      end

      handle_scores(rows_used)
      handle_win_lose(is_solved)
      handle_switching_rounds
    end
  end

  def fetch_winner
    return :computer if @scores[:computer] > @scores[:human]

    :human
  end

  private

  def handle_scores(rows_used)
    if @human.role == :code_breaker
      @scores[:computer] += rows_used
    elsif @human.role == :code_maker
      @scores[:human] += rows_used
    end

    display_scores
  end

  def display_scores
    puts 'Score Board:'
    puts "You: #{@scores[:human]} | Computer: #{@scores[:computer]}"
  end

  def handle_switching_rounds
    puts "Round #{@curr_round} over, swapping roles..."
    swap_roles
    puts "You are now the #{@human.role == :code_maker ? 'CODE MAKER' : 'CODE BREAKER'}"
    @curr_round += 1
  end

  def swap_roles
    if @human.role == :code_breaker
      @human.role = :code_maker
      @computer.role = :code_breaker
    elsif @human.role == :code_maker
      @human.role = :code_breaker
      @computer.role = :code_maker
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

  def handle_win_lose(is_solved)
    human_solved_it = is_solved && @human.role == :code_breaker
    computer_did_not_solve_it = !is_solved && @human.role == :code_maker
    if human_solved_it || computer_did_not_solve_it
      winning_sequence
    else
      losing_sequence
    end
  end

  def losing_sequence
    puts 'Womp womp. You lost to a computer lmao'
  end

  def winning_sequence
    puts 'Congratulations! You won this round!~'
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
