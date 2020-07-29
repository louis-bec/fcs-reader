# frozen_string_literal: true

class Entry < ApplicationRecord
  validates :name, uniqueness: true
end
