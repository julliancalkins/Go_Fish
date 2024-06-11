# frozen_string_literal: true

require_relative 'deck'

# Represents the game of Go Fish
class Game
  attr_reader :players, :current_player
  attr_accessor :winner, :last_turn_opponent, :last_turn_card_taken, :last_turn_books

  MIN_PLAYERS = 2
  STARTING_HAND = 5

  def initialize(players)
    @players = players
    @winner = nil
    @current_player = players.first
    @last_turn_opponent = nil
    @last_turn_card_taken = nil
    @last_turn_books = []
  end

  def start
    deck.shuffle
    players.each do |player|
      STARTING_HAND.times { player.hand << deck.deal }
    end
  end

  def validate_rank(rank)
    exists = current_player.hand.any? { |card| card.rank == rank }
    rank if exists
  end

  def validate_opponent(position)
    return nil if position.empty?

    index = position.to_i - 1
    return nil if index.negative? || index >= players.size

    players[index]
  end

  def deck
    @deck ||= Deck.new
  end
end
