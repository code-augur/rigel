class Series < ApplicationRecord
  scope :by_code, -> (code) { where("data->>'code' = ?", code) }
end
