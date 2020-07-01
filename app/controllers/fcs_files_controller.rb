class FcsFilesController < ApplicationController
  def index
    @fcs_files = FcsFile.all
  end

  def new
    @fcs_file = FcsFile.new
  end

  def create
    @fcs_file = FcsFile.new(fcs_params)

    saved_file = @fcs_file.save
    if saved_file
      redirect_to fcs_files_path, notice: "uploaed"
    else
      render "new"
    end
  end

  def show
    @fcs_file = FcsFile.find(params[:id])
  end

  def destroy
    @fcs_file = FcsFile.find(params[:id])
    @fcs_file.destroy
    redirect_to fcs_files_path, notice: "deleted"
  end

  private
    def fcs_params
      params.require(:fcs_file).permit(:name, :attachment)
    end
end
