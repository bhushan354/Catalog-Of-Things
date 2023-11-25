require 'date'
require_relative '../game'

RSpec.describe Game do
  let(:current_date) { Date.new(2023, 1, 1) }

  it 'creates a game instance with valid parameters' do
    game = Game.new(
      last_played_at: Date.new(2022, 12, 31),
      multiplayer: true,
      publish_date: Date.new(2022, 12, 30)
    )

    expect(game).to be_an_instance_of(Game)
  end

  it 'raises an error if multiplayer is not a Boolean' do
    expect { Game.new(last_played_at: Date.new(2022, 12, 31), multiplayer: 'invalid') }.to raise_error(ArgumentError)
  end

  it 'returns true for can_be_archived? if conditions are met' do
    game = Game.new(
      last_played_at: current_date - (365 * 3),
      multiplayer: true,
      publish_date: current_date - 365
    )

    expect(game.can_be_archived?).to be true
  end

  it 'returns false for can_be_archived? if last_played_at is nil' do
    game = Game.new(last_played_at: nil, multiplayer: true)

    expect(game.can_be_archived?).to be false
  end

  it 'returns true for can_be_archived? if last_played_at is not older than 2 years' do
    game = Game.new(
      last_played_at: current_date - 365,
      multiplayer: true,
      publish_date: current_date - 365
    )

    expect(game.can_be_archived?).to be true
  end
end
