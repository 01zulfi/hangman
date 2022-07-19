# frozen_string_literal: true

# module for file operations
module FileOperations
  SAVED_GAMES_DIR_NAME = 'saved_games'

  def save_game(contents)
    Dir.mkdir(SAVED_GAMES_DIR_NAME) unless Dir.exist?(SAVED_GAMES_DIR_NAME)

    filename = "#{SAVED_GAMES_DIR_NAME}/#{filename_input}.json"

    File.open(filename, 'w') { |file| file.write(contents) }
  end

  def read_saved_game(filename)
    File.read("#{SAVED_GAMES_DIR_NAME}/#{filename}")
  end

  def list_saved_games
    Dir.children(SAVED_GAMES_DIR_NAME)
  end

  def filename_input
    filename = ''
    filename = gets.chomp until filename.length > 1
    filename
  end
end
