# frozen_string_literal: false

require_relative 'game_session'
require_relative 'human_player'
require_relative 'computer_player'
require_relative 'mastermind_ui'

# Class that handles the logic for the game
class Mastermind
  def initialize
    @ui = MastermindUI.new
    @game_session = GameSession.new
  end

  def start_game
    @ui.display_start_messages
    setup_game

    @game_session.start
    display_result(@game_session.fetch_winner)
  end

  def display_result(winner)
    puts 'You lost the game!' if winner == :computer
    puts 'You won the game!' if winner == :human
  end

  private

  def setup_game
    setup_options = @ui.prompt_for_game_setup
    @game_session.num_of_rounds = setup_options[:num_of_rounds]
    @game_session.initial_role = setup_options[:initial_role]
  end

  def print_title_info
    puts 'Welcome to Mastermind'
    puts 'Colors:
      R (Red)
      O (Orange)
      Y (Yelow)
      G (Green)
      B (Blue)
      V (Violet)'
  end
end
