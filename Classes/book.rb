require_relative 'item'
require 'date'

class Book < Item
  attr_accessor :publisher, :cover_state, :can_be_archived

  def initialize(publisher, cover_state, publish_date = Date.today, id: Random.rand(1..1000))
    @publisher = publisher
    @cover_state = cover_state
    publish_date_parse = publish_date ? Date.parse(publish_date.to_s) : Date.today
    super(id, publish_date_parse)
  end  

  def can_be_archived?
    super || cover_state.downcase == 'bad'
  end

  def to_json(*_args)
    {
      id: Random.rand(1..100),
      publisher: @publisher,
      cover_state: @cover_state,
      publish_date: @publish_date
    }
  end
end
