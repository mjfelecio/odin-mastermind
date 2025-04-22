# frozen_string_literal: false

# Responsible for getting inputs and displaying outputs from the game
class MastermindUI
  def display_start_messages
    display_welcome_message
    display_game_rules
  end

  private

  def display_welcome_message
    puts 'Welcome to Mastermind Game'
  end

  def display_game_rules
    puts 'Placeholder for game rules'
  end
end
