# frozen_string_literal: true

require_relative './hangman'
require_relative './file_operations'
require_relative './serialize'
require_relative './display'

# main class
class Main
  include FileOperations
  include Serialize
  include Display

  def start
    puts_initial_prompt
    if game_mode == '1'
      Hangman.new(random_word_from_dictionary).start
    else
      filename = select_filename
      data = from_json(read_saved_game(filename))

      puts_game_loaded

      Hangman.new(data['word'], data['correct'], data['incorrect']).start
    end
  end

  private

  def select_filename
    puts_file_selection(list_saved_games)

    file_number = ''
    file_number = gets.chomp until valid_file_selection(file_number, list_saved_games.length)
    list_saved_games[file_number.to_i]
  end

  def valid_file_selection(file_number, total_files)
    return false if file_number.empty?

    file_number.to_i.between?(0, total_files) && file_number.scan(/\D/).empty?
  end

  def game_mode
    puts_mode_selection

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
