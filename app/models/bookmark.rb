class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :movie_id, uniqueness: { scope: :list_id, message: "déjà ajouté à cette liste" }
  validates :comment, length: { minimum: 6, message: "doit avoir au moins 6 caractères" }
end
