require('./app/services/fcs_file_parser')

describe FcsFileParser do
  it 'will cal FCSParse to parse the fcs file' do
    expect(FCSParse).to  receive(:process_file).with('/parser/open_this_file.fcs')

    parser = FcsFileParser.new
    parser.open('/parser/open_this_file.fcs')
  end

  context 'when parse succfully' do
    before do
      allow(FCSParse).to receive(:process_file) do
        'this is a test fcs file'
      end
    end

    it 'return the fcs file content' do
      parser = FcsFileParser.new
      file_content = parser.open '/parser/open_this_file.fcs'
      expect(parser.name).to eq('open_this_file.fcs')
      expect(file_content).to eq('this is a test fcs file')
    end
  end

  context 'when parse failed' do
    before do
        allow(FCSParse).to receive(:process_file).and_raise("Unexpect error")
    end

    it 'throw the error message when failed to parse' do
      
      parser = FcsFileParser.new
      begin
        file_content = parser.open '/parser/open_this_file.fcs'
        expect(0).to eq(1) 
      rescue StandardError => e
        expect(e.message).to eq('Unexpect error')
      end
    end
  end
end
