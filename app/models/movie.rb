class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :lists, through: :bookmarks

  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true

  before_destroy :ensure_not_referenced

  private

  def ensure_not_referenced
    if bookmarks.exists?
      errors.add(:base, 'Ce film est référencé dans des signets et ne peut pas être supprimé.')
      throw :abort
    end
  end
end
