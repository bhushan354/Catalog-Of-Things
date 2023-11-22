require 'date'

class Item
  attr_accessor :genre, :source, :label, :publish_date
  attr_reader :id, :archived, :author

  def initialize(id = Random.rand(1..1000), publish_date = Date.today, archived: false)
    raise ArgumentError, 'publish_date must be a Date' unless publish_date.is_a?(Date)

    @id = id
    @archived = archived
    @publish_date = publish_date
    @genre = nil
    @author = nil
    @source = nil
    @label = nil
  end

  def can_be_archived?
    current_date = Date.today
    @publish_date && (@publish_date < (current_date << 10))
  end

  def move_to_archive
    @archived = can_be_archived?
    @archived
  end

  def author=(author)
    @author = author
    author.items.push(self) unless author.items.include?(self)
  end
end
