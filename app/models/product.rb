class Product < ApplicationRecord
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates_presence_of     :title, :description, :image_url, :price
  validates_numericality_of :price, greater_than_or_equal_to: 0.01
  validates_uniqueness_of   :title
  validates :image_url, format: {with: %r{\.(gif|jpg|png)\Z}i, message: "must be a URL for GIF, JPG or PNG image."}


  private
      # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
