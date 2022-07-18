# frozen_string_literal: true

# hangman class
class Hangman
  def initialize
    @word = random_word_from_dictionary.split('').uniq
    @guessed = false
    @correct = []
    @incorrect = []
  end

  def start
    until game_end?
      move = player_input
      if @word.include?(move)
        @correct << move
        @correct.uniq!
      else
        @incorrect << move
        @incorrect.uniq!
      end
    end
  end

  private

  def player_input
    character = ''
    character = gets.chomp until valid_character_input(character)
    character
  end

  def valid_character_input(input)
    correct_length = input.length == 1
    already_used = @correct.include?(input) || @incorrect.include?(input)
    only_alphabets = input.match?(/\A[a-zA-Z'-]*\z/)

    correct_length && only_alphabets && !already_used
  end

  def random_word_from_dictionary
    dictionary = []
    file = File.read('dictionary.txt')
    file.each_line do |line|
      word = line.strip
      dictionary << word if word.length.between?(5, 12)
    end
    dictionary.sample
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

Hangman.new.start
