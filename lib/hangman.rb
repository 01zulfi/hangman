# frozen_string_literal: true

require 'json'
require_relative './serialize'
require_relative './file_operations'
require_relative './display'

# hangman class
class Hangman
  include Serialize
  include FileOperations
  include Display

  def initialize(word, correct = [], incorrect = [])
    @original_word = word
    @word = word.split('').uniq
    @correct = correct
    @incorrect = incorrect
    @saved = false
  end

  def start
    game_loop
    game_won = saved?
    return puts_game_saved if @saved

    puts_out_of_lives if hanged?
    puts_final_result(game_won, @original_word)
  end

  private

  def game_loop
    until game_end?
      puts_game_state(@original_word, @correct, @incorrect)
      move = player_input
      if move == 'save'
        save_game_to_file
        break
      else
        @word.include?(move) ? correct_move(move) : incorrect_move(move)
      end
    end
  end

  def save_game_to_file
    save_game(to_json({ word: @original_word, correct: @correct, incorrect: @incorrect }))
    @saved = true
  end

  def correct_move(move)
    @correct.push(move).uniq!

    puts_correct_move(move)
  end

  def incorrect_move(move)
    @incorrect.push(move).uniq!

    puts_incorrect_move(move)
  end

  def player_input
    puts_guess_your_letter_prompt
    input = ''
    input = gets.chomp until valid_input(input)
    input.downcase
  end

  # rubocop:disable Metrics/
  def valid_input(input)
    return true if input == 'save'

    puts_character_already_used if already_used?(input)
    puts_invalid_guess if (!correct_length?(input) || !only_alphabets?(input)) && input != ''

    correct_length?(input) && only_alphabets?(input) && !already_used?(input)
  end
  # rubocop:enable Metrics/

  def correct_length?(input)
    input.length == 1
  end

  def already_used?(input)
    @correct.include?(input) || @incorrect.include?(input)
  end

  def only_alphabets?(input)
    input.match?(/\A[a-zA-Z'-]*\z/)
  end

  def game_end?
    hanged? || saved?
  end

  def hanged?
    total_lives = 6
    @incorrect.length == total_lives
  end

  def saved?
    @correct.length == @word.length
  end
end
