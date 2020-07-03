class FcsFileParser
  def initialize
    @file_name
    @file_header
  end

  def name
    @file_name
  end

  def header
    @file_header
  end

  def open(path)
    @file_name = File.basename(path)
    @file_header = nil
    begin
      FCSParse.process_file(path)
    rescue StandardError => e
      e.message
    end
  end
end
