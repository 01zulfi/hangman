# frozen_string_literal: true

# for all the display methods
module Display
  def puts_initial_prompt
    system('clear')
    puts 'Welcome to Hangman!'
    puts "You'll have a total of 6 (six) guesses to get the word..."
  end

  def puts_mode_selection
    puts ''
    puts 'Enter a number from the following:'
    puts '[1] New Game'
    puts '[2] Load Game'
    puts ''
  end

  def puts_file_selection(files_list)
    puts ''
    puts 'Select game to load:'

    files_list.each_with_index do |file_name, index|
      puts "[#{index}]  #{file_name}"
    end

    puts ''
  end

  def puts_guess_your_letter_prompt
    puts "Make your guess (or type 'save' to save the game): "
  end

  def puts_character_already_used
    puts "You've already guessed this character, make a new guess:"
  end

  def puts_invalid_guess
    puts 'Invalid, guess again:'
  end

  def puts_game_state(word, correct, incorrect)
    puts ''

    word_to_display = word.split('').map do |char|
      correct.include?(char) ? char : '_'
    end.join

    total_lives = 6

    puts word_to_display
    puts ''
    puts "Letters guessed: #{(correct + incorrect).join(', ')}"
    puts "Lives Left: #{total_lives - incorrect.length}"
    puts ''
  end

  def puts_correct_move(move)
    puts ''
    puts "#{move} is correct! You're getting closer to the word."
    puts ''
  end

  def puts_incorrect_move(move)
    puts ''
    puts "#{move} is a wrong guess!"
    puts ''
  end

  def puts_out_of_lives
    puts 'Out of lives!'
  end

  def puts_final_result(did_win, word)
    puts ''
    puts "The correct word was #{word}."
    puts did_win ? 'You guesed it right, congratulations!' : 'You could not get it.'
    puts ''
  end

  def puts_game_saved
    puts ''
    puts 'Game was saved, you can load it later.'
    puts ''
  end

  def puts_game_loaded
    puts ''
    puts 'Game is successfully loaded, continue playing:'
    puts ''
  end

  def puts_filename_input_prompt
    puts ''
    puts 'Enter a name to save the game:'
    puts ''
  end
end
