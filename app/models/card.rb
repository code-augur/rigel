class Card < ApplicationRecord
  scope :by_sha_id, -> (id) { where("data->>'id' = '#{id}'") }
end
