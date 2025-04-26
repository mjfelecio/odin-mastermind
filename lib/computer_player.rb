# frozen_string_literal: false

class ComputerPlayer
  COLORS = %w[R O Y G B V].freeze

  def secret_code
    secret_code = ''
    4.times do
      secret_code << COLORS[rand(6)]
    end
    secret_code
  end

  def guess
    guess = ''
    4.times do
      guess << COLORS[rand(6)]
    end
    sleep(1)
    puts guess
    guess
  end
end
