# frozen_string_literal: true

require('./app/services/fcs_file_parser')

RSpec.describe FcsFileParser do
  it 'will cal FCSParse to parse the fcs file' do
    # arrange
    expect(FCSParse).to  receive(:process_file).with('/parser/open_this_file.fcs')
    # act
    parser = FcsFileParser.new
    parser.open('/parser/open_this_file.fcs')
  end

  context 'when parse succfully' do
    before do
      # arrange
      allow(FCSParse).to receive(:process_file) do
        'this is a test fcs file'
      end
    end

    it 'return the fcs file content' do
      # act
      parser = FcsFileParser.new
      file_content = parser.open '/parser/open_this_file.fcs'
      # assert
      expect(parser.name).to eq('open_this_file.fcs')
      expect(file_content).to eq('this is a test fcs file')
    end
  end

  context 'when parse failed' do
    before do
      # arrange
      allow(FCSParse).to receive(:process_file).and_raise('Unexpect error')
    end

    it 'throw the error message when failed to parse' do
      # act
      parser = FcsFileParser.new
      parser.open '/parser/open_this_file.fcs'
      expect(0).to eq(1)
    rescue StandardError => e
      # assert
      expect(e.message).to eq('Unexpect error')
    end
  end
end
