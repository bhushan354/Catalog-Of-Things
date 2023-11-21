class Item
  attr_accessor :id, :author, :source, :label, :publish_date, :archived

  def initialize(publish_date)
    @id = generate_id
    @author = nil
    @source = nil
    @label = nil
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?
    years_difference > 10
  end

  def move_to_archive
    result = can_be_archived?
    if result
      @archived = true
      puts 'Item archived successfully.'
    else
      puts 'Item cannot be archived.'
    end
    result
  end

  private

  def generate_id
    Random.rand(1..1000)
  end

  def years_difference
    current_year - @publish_date.year
  end

  def current_year
    Time.new.year
  end
end
