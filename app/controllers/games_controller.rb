require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = ("A".."Z").to_a
    @letters = 10.times.map { alphabet.sample }
  end

  def score
    @word = params[:word]
    @grid = params[:grid].split
    if attempt_match_grid?(@word, @grid) == false
      @message = "Sorry but #{@word} can't be built out of #{@grid.join(", ")}"
    elsif english_word?(@word) == false
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
    else
      @message = "Congratulations! #{@word} is a valid English word!"
    end
  end

  private

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    word["found"]
  end

  def attempt_match_grid?(attempt, grid)
    attempt.upcase.chars.all? do |char|
      grid.delete_at(grid.index(char)) if grid.include?(char)
    end
  end
end
