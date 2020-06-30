class WelcomeController < ApplicationController
  def upload
    puts "file upload here"
    analysis(params[:file])
  end

  private
  def analysis(path)
    puts "file will be anlysis -> #{path}"
  end
end
