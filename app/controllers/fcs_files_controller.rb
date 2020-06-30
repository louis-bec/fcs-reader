class FcsFilesController < ApplicationController
  def index
    @fcs_files = FcsFile.all
  end

  def new
    @fcs_file = FcsFile.new
  end

  def create
    @fcs_file = FcsFile.new(fcs_params)

    if @fcs_file.after_save
      redirect_to fcs_file_path, notice: "uploaed"
    else
      render "new"
    end
  end

  def destroy
    @fcs_file = FcsFile.find(params[:id])
    @fcs_file.destory

    redirect_to fcs_file_path, notice: "deleted"
  end

  private
    def fcs_params
      params.require(:fcs_file).permit(:name, :attachment)
    end
end
