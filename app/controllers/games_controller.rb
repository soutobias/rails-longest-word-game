require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample(1)[0].upcase }
    @time = DateTime.now
  end

  def score
    @word = params[:word].upcase
    start_time = params[:time].to_datetime
    end_time = DateTime.now
    grid = params[:letters].split('')
    @grid = grid.join(', ')
    @result = {
      time: (end_time - start_time).to_f * 100000,
      score: 0,
      message: 0
    }
    attempt1 = @word.split('')
    attempt1.each_with_index do |attempt1_letter, idx_a|
      grid.each_with_index do |grid_letter, idx_g|
        if attempt1_letter == grid_letter
          grid[idx_g] = "0"
          attempt1[idx_a] = "0"
          break
        end
      end
    end
    value = ""
    attempt1.size.times { value += "0" }
    if attempt1.join('') != value
      @result[:message] = 1
    else
      url = "https://wagon-dictionary.herokuapp.com/" + @word
      word_serialized = open(url).read
      word = JSON.parse(word_serialized)
      if word['found'] == false
        @result[:message] = 2
      else
        @result[:score] = (word['length'].to_i / @result[:time])
      end
    end
  end
end
