# frozen_string_literal: true

require 'json'

# hangman class
class Hangman
  def initialize(word, correct = [], incorrect = [])
    @original_word = word
    @word = word.split('').uniq
    @correct = correct
    @incorrect = incorrect
  end

  def start
    p @word
    until game_end?
      move = player_input
      if move == 'save'
        save_game
        break
      elsif @word.include?(move)
        @correct << move
        @correct.uniq!
      else
        @incorrect << move
        @incorrect.uniq!
      end
      p "correct #{@correct}"
      p "incorrect #{@incorrect}"
    end
  end

  private

  def save_game
    json_string = JSON.generate({ word: @original_word, correct: @correct, incorrect: @incorrect })
    p json_string
  end

  def player_input
    input = ''
    input = gets.chomp until valid_input(input)
    input
  end

  def valid_input(input)
    return true if input == 'save'

    correct_length = input.length == 1
    already_used = @correct.include?(input) || @incorrect.include?(input)
    only_alphabets = input.match?(/\A[a-zA-Z'-]*\z/)

    correct_length && only_alphabets && !already_used
  end

  def game_end?
    hanged? || saved?
  end

  def hanged?
    @incorrect.length == 6
  end

  def saved?
    @correct.length == @word.length
  end
end
