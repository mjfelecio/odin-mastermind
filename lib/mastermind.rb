# frozen_string_literal: false

require_relative 'human_player'
require_relative 'computer_player'
require_relative 'mastermind_ui'
require_relative 'round_manager'

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
    @ui.display_title_screen
    setup_game

    loop do
      start_session
      @ui.display_game_end_screen(won?)
      exit if @ui.prompt_to_continue_playing == 'q'
    end
  end

  private

  def start_session
    # Runs for however many rounds were set by the player
    (1..@game_options[:num_of_rounds]).each do
      @secret_code = create_secret_code
      round = RoundManager.new(@code_breaker, @secret_code)
      round.start
      track_scores(round.fetch_result)
      @ui.display_score(@scores)
      swap_player_role
    end
  end

  def create_secret_code
    @code_maker.secret_code
  end

  def won?
    return :tie if @scores[:human] == @scores[:computer]

    @scores[:human] > @scores[:computer]
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
  end
end
