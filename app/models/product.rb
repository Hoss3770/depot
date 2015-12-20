class Product < ActiveRecord::Base
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  #validations
  validates :title,:description,:image_url, presence: true
  validates :title, uniqueness: true
  validates :image_url, allow_blank:true, format:
      { with: %r{\.(png|jpg|gif)\Z}i,
        message: "must be a URL for GIF, JPG or PNG image."}
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :description, length: {minimum: 10 }

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base,'Line Items present')
      return false
      end
    end

  def self.latest
    self.order(:updated_at).last
  end
end
