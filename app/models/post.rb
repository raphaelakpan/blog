class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_ordered_taggable # Alias for acts_as_taggable_on :tags
end
