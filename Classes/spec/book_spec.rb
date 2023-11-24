require_relative '../book'
require 'date'

describe Book do
  let(:publisher) { 'Example Publisher' }
  let(:cover_state) { 'Good' }

  describe '#initialize' do
    it 'creates a Book instance with default values' do
      book = Book.new(publisher, cover_state)
      expect(book.id).to be_a(Integer)
      expect(book.publish_date).to eq(Date.today)
      expect(book.publisher).to eq(publisher)
      expect(book.cover_state).to eq(cover_state)
    end

    it 'creates a Book instance with specified values' do
      custom_date = Date.new(2022, 1, 1)
      book = Book.new(publisher, cover_state, custom_date)
      expect(book.id).to be_a(Integer)
      expect(book.publish_date).to eq(custom_date)
      expect(book.publisher).to eq(publisher)
      expect(book.cover_state).to eq(cover_state)
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if super class allows archiving' do
      allow_any_instance_of(Item).to receive(:can_be_archived?).and_return(true)
      book = Book.new(publisher, 'Bad')
      expect(book.can_be_archived?).to be true
    end

    it 'returns true if cover state is bad' do
      book = Book.new(publisher, 'Bad')
      expect(book.can_be_archived?).to be true
    end

    it 'returns false if super class and cover state do not allow archiving' do
      allow_any_instance_of(Item).to receive(:can_be_archived?).and_return(false)
      book = Book.new(publisher, 'Good')
      expect(book.can_be_archived?).to be false
    end
  end

  describe '#to_json' do
    it 'returns a hash with book details in JSON format' do
      book = Book.new(publisher, cover_state)
      json_data = book.to_json
      expect(json_data).to include(:id, :publisher, :cover_state, :publish_date)
    end
  end
end
