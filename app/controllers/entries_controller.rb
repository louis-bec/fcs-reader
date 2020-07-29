# frozen_string_literal: true

class EntriesController < ApplicationController
  def index
    render json: Entry.all
  end

  def show
    render json: Entry.find(params[:id])
  end

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      render json: @entry
    else
      raise 'can not save entry'
    end
  rescue StandardError => e
    puts e.message
    render json: { message: e.message }, status: 500
  end

  def update
    entry = Entry.find(entry_params[:id])
    entry.update!(winner: entry_params[:winner])
    render json: entry
  end

  def destroy
    render json: Entry.destroy(params[:id])
  end

  private

  def entry_params
    params.require(:entry).permit(:id, :name, :winner)
  end
end
