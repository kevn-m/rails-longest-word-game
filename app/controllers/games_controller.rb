require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    # array = ('a'..'z').to_a
    # @grid = array.sample(10)
    @grid = %w(a p p l e y h e l l o)
  end

  def score
    new
    @answer = params[:input]
    @answer_array = @answer.split("")
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    uri = URI.open(url).read
    @dictionary = JSON.parse(uri)
    # check if the word exists in the dictionary
    # if yes, check if the letters used match those in the grid
    # if no, spit error out "Letter used not in the grid"
    # otherwise, Say congrats!
    if @dictionary['found']
      @answer_array.each do |letter|
        if @grid.include?(letter)
          @result = "Congratulations #{@answer} is a valid word"
          # @grid.delete_at(@grid.index(letter))
        else
          @result = "Sorry #{@answer} cannot be built out of #{@grid}"
        end
      end
    else
      @result = "Sorry, #{@answer} is not a valid word"
    end
  end
end
# Need Help
# It works if the randomly generated grid is static
