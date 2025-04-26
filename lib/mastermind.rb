# frozen_string_literal: false

require_relative 'human_player'
require_relative 'computer_player'
require_relative 'mastermind_ui'
require_relative 'mastermind_round_manager'

# Class that handles the logic for the game
class Mastermind
  def initialize
    @ui = MastermindUI.new
    @human = HumanPlayer.new
    @computer = ComputerPlayer.new
    @code_breaker = ''
    @code_maker = ''
    @game_options = {}
    @scores = {
      human: 0,
      computer: 0
    }
  end

  def start_game
    @ui.display_start_messages
    setup_game

    # Runs for however many rounds were set by the player
    (1..@game_options[:num_of_rounds]).each do
      @secret_code = create_secret_code
      round = MastermindRoundManager.new(@code_breaker, @secret_code)
      round.start
      track_scores(round.fetch_result)
    end
  end

  # def display_result(winner)
  #   puts 'You lost the game!' if winner == :computer
  #   puts 'You won the game!' if winner == :human
  # end

  private

  def create_secret_code
    @code_maker.secret_code
  end

  def track_scores(score)
    code_maker = @code_breaker == @human ? :computer : :human
    @scores[code_maker] += score
  end

  def swap_player_role
    @code_maker, @code_breaker = @code_breaker, @code_maker
  end

  def setup_game
    player_preferences = @ui.prompt_for_game_setup
    @game_options[:num_of_rounds] = player_preferences[:num_of_rounds]
    @game_options[:initial_role] = player_preferences[:initial_role]
    set_up_roles
  end

  def set_up_roles
    human_role = @game_options[:initial_role]
    if human_role == :code_breaker
      @code_breaker = @human
      @code_maker = @computer
    else
      @code_breaker = @computer
      @code_maker = @human
    end
    p "Breaker #{@code_breaker}"
    p "Maker #{@code_maker}"
  end
end
