require 'date'

class Item
  attr_accessor :genre, :author, :source, :label, :publish_date
  attr_reader :id, :archived

  def initialize(id = Random.rand(1..1000), publish_date = DateTime.now, archived: false)
    @id = id
    @archived = archived
    @publish_date = publish_date
    @genre = nil
    @author = nil
    @source = nil
    @label = nil
  end

  def can_be_archived?
    @publish_date && (@publish_date > (Date.today - (365 * 10)))
  end

  def move_to_archive
    @archived = true unless can_be_archived?
  end
end
