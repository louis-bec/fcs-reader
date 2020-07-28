# frozen_string_literal: true

class EntriesController < ApplicationController
  def index
    render json: Entry.all
  end

  def show
    render json: Entry.find(params[:id])
  end

  def create
    entry = Entry.create! params
    render json: entry
  end

  def update
    entry = Entry.find(params[:id])
    entry.update_attributes!(params[:entry])
    render json: entry
  end

  def destroy
    render json: Entry.destroy(params[:id])
  end
end
