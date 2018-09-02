# frozen_string_literal: true

class HangpersonGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # Get a word from remote "random word" service

  # def initialize()
  # end

  def initialize(new_word)
    @word = new_word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end

  def word_with_guesses
    @word.gsub(/[^ #{@guesses}]/, '-')
  end

  def guess(input)
    
    if input.nil? || !/[^A-Za-z]/.match(input).nil? || input == ''
      raise ArgumentError, 'Not a valid letter'
    end

    input = input.downcase

    return false if (@guesses.include? input) || (@wrong_guesses.include? input)

    if @word.include? input
      @guesses += input
      return true
    else
      @wrong_guesses += input
      return true
    end
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if word_with_guesses == @word
    :play
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start do |http|
      return http.post(uri, '').body
    end
  end
end
