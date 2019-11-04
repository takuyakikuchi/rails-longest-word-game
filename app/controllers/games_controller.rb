require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').sample }
  end

  def score
    word = params[:word]
    if included?(word.upcase, @letters)
      if english_word?(params[:word]
        @result = 'Congratulations! #{word} is a valid English word!'
      else
        @result = 'Sorry but #{word} does not seem to be a valid English word...'
      end
    else
      @result = 'Sorry but #{word} cannot be built out of #{@letters.split("-")}'
    end
  end

  private

  def included?(attempt, grid)
    attempt.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
  end

  def english_word?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word_serialized = open(url).read
    JSON.parse(word_serialized)["found"]
  end
end

