# frozen_string_literal: true

require_relative './hangman'
require_relative './file_operations'
require_relative './serialize'

# main class
class Main
  include FileOperations
  include Serialize

  def start
    if game_mode == '1'
      Hangman.new(random_word_from_dictionary).start
    else
      file = select_file
      data = from_json(read_saved_game(file))
      puts data

      Hangman.new(data['word'], data['correct'], data['incorrect']).start
    end
  end

  private

  def select_file
    puts 'select file'
    list_saved_games.each_with_index do |file_name, index|
      puts "#{index} - #{file_name}"
    end

    file_number = -1
    file_number = gets.chomp.to_i until valid_file_selection(file_number, list_saved_games.length)
    list_saved_games[file_number]
  end

  def valid_file_selection(file_number, total_files)
    file_number.between?(0, total_files)
  end

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
