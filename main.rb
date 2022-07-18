# frozen_string_literal: true

def random_word_from_dictionary
  dictionary = []
  file = File.read('dictionary.txt')
  file.each_line do |line|
    line.strip!
    dictionary << line if line.length.between?(5, 12)
  end
  dictionary.sample
end
