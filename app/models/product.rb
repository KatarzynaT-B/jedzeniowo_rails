class Product < ActiveRecord::Base
  before_save :count_calories

  belongs_to :user
  has_many :ingredients, dependent: :destroy
  default_scope -> { order('product_name ASC') }

  validates :user,            presence:     true
  validates :product_name,    presence:     true,
                              uniqueness:   { scope: :user_id }
  validates :product_protein, presence:     true,
                              numericality: true
  validates :product_fat,     presence:     true,
                              numericality: true
  validates :product_carbs,   presence:     true,
                              numericality: true
  validate  :sum_of_values

  def protein_kcal
    (4 * self.product_protein.to_f).round
  end

  def fat_kcal
    (9 * self.product_fat.to_f).round
  end

  def carbs_kcal
    (4 * self.product_carbs.to_f).round
  end

  def count_calories
    self.product_calories = (self.protein_kcal + self.fat_kcal + self.carbs_kcal).to_i
  end

  def sum_of_values
    sum = self.product_protein.to_f.round + self.product_fat.to_f.round + self.product_carbs.to_f.round
    if sum > 100
      errors.add(:product_protein, (I18n.t('activerecord.errors.models.product.attributes.product_protein.sum_of_values')))
      errors.add(:product_carbs, (I18n.t('activerecord.errors.models.product.attributes.product_fat.sum_of_values')))
      errors.add(:product_fat, (I18n.t('activerecord.errors.models.product.attributes.product_carbs.sum_of_values')))
    end
  end
end
