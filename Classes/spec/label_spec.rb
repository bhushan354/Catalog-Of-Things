require_relative '../label'
require_relative '../label_service'

describe Label do
  let(:title) { 'Example Label' }
  let(:color) { 'Blue' }

  describe '#initialize' do
    it 'creates a Label instance with the given title and color' do
      label = Label.new(title, color)
      expect(label.title).to eq(title)
      expect(label.color).to eq(color)
      expect(label.items).to be_empty
    end
  end

  describe '#add_item' do
    it 'adds an item to the label and sets the label for the item' do
      label = Label.new(title, color)
      item = Item.new('Example Item')
      label.add_item(item)
      expect(label.items).to include(item)
      expect(item.label).to eq(label)
    end
  end

  describe '#to_json' do
    it 'returns a hash with label details in JSON format' do
      label = Label.new(title, color)
      json_data = label.to_json
      expect(json_data).to include(:id, :title, :color, :items)
    end
  end
end

describe LabelService do
  let(:label_service) { LabelService.new }

  describe '#initialize' do
    it 'creates a LabelService instance with an empty array of labels' do
      allow(File).to receive(:exist?).and_return(false)  # Stub file existence check
      label_service = LabelService.new
      expect(label_service.labels).to be_empty
    end
  end
end
