# frozen_string_literal: true

require './hangman'

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
