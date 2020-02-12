# frozen_string_literal: true

require 'open-uri'

# GameController
class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @word = (params[:word] || '').upcase
    @letters = params[:letters]
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(attempt, grid)
    attempt.chars.all? do |letter|
      attempt.count(letter) <= grid.count(letter)
    end
  end

  def english_word?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word_serialized = open(url).read
    JSON.parse(word_serialized)["found"]
  end
end
