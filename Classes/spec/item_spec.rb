require 'date'
require_relative '../item'

RSpec.describe Item do
  describe '#initialize' do
    it 'raises an error if publish_date is not a Date' do
      expect { Item.new(nil, 'invalid') }.to raise_error(ArgumentError)
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if the item can be archived' do
      item = Item.new(nil, Date.today - (365 * 11))
      expect(item.can_be_archived?).to be true
    end

    it 'returns false if the item cannot be archived' do
      item = Item.new(nil, Date.today)
      expect(item.can_be_archived?).to be false
    end
  end

  describe '#move_to_archive' do
    it 'archives the item if it can be archived' do
      item = Item.new(nil, Date.today - (365 * 11))
      item.move_to_archive
      expect(item.archived).to be true
    end

    it 'does not archive the item if it cannot be archived' do
      item = Item.new(nil, Date.today)
      item.move_to_archive
      expect(item.archived).to be false
    end
  end
end
