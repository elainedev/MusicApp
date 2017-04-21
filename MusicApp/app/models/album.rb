class Album < ApplicationRecord

  validates :band_id, :title, presence: true

  has_many :tracks,
  dependent: :destroy, # if this album is destroyed, so are all the tracks
  primary_key: :id,
  foreign_key: :album_id,
  class_name: :Track

  belongs_to :band,
  primary_key: :id,
  foreign_key: :band_id,
  class_name: :Band



end
