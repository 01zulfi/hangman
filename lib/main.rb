# frozen_string_literal: true

# hangman class
class Hangman
  def initialize(word, correct = [], incorrect = [])
    @word = word.split('').uniq
    @correct = correct
    @incorrect = incorrect
  end

  def start
    p @word
    until game_end?
      move = player_input
      if @word.include?(move)
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

# main class
class Main
  def start
    if game_mode == '1'
      Hangman.new(random_word_from_dictionary).start
    else
      Hangman.new('scrumptious', %w[s p], %w[z x l]).start
    end
  end

  private

  def game_mode
    puts '1. new game'
    puts '2. load game'

    mode = ''
    mode = gets.chomp until valid_mode(mode)
    mode
  end

  def valid_mode(mode)
    %w[1 2].include?(mode)
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
end

Main.new.start
