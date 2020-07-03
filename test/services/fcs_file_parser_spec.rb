require('./app/services/fcs_file_parser')

RSpec.describe FcsFileParser do
    describe "fcs file parser" do
        it "get file name based on given file path" do
            parser = FcsFileParser.new
            puts parser.open "/parser/open_this_file.fcs"
            expect(parser.name).to eq('open_this_file.fcs')
        end
    end
end