require 'date'

class Item
  attr_accessor :publish_date
  attr_reader :id, :archived, :author, :genre, :source, :label

  def initialize(id = Random.rand(1..1000), publish_date = Date.today)
    raise ArgumentError, 'publish_date must be a Date' unless publish_date.is_a?(Date)

    @id = id
    @archived = false
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
    associate_with_items(author)
  end

  def genre=(genre)
    @genre = genre
    associate_with_items(genre)
  end

  def source=(source)
    @source = source
    associate_with_items(source)
  end

  def label=(label)
    @label = label
    associate_with_items(label)
  end

  private

  def associate_with_items(association)
    association.items << self unless association.items.include?(self)
  end
end
