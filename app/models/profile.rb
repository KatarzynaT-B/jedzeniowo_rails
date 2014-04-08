class Profile < ActiveRecord::Base
  before_save :calculate_bmr_total, :calculate_protein_need, :calculate_fat_need, :calculate_carbs_need
  belongs_to :user

  validates :user,            presence: true
  validates :name,            presence: true,
                              uniqueness: true
  validates :age,             presence: true,
                              numericality: true
  validates :gender,          presence: true
  validates :weight,          presence: true,
                              numericality: true
  validates :height,          presence: true,
                              numericality: true
  validates :activity_level,  presence: true

  def activity_factor
    male = {1 => 1.3, 2 => 1.5, 3 => 1.7, 4 => 1.9, 5 => 2.0, 6 => 2.2}
    female = {1 => 1.3, 2 => 1.5, 3 => 1.6, 4 => 1.7, 5 => 1.9, 6 => 2.0}

    gender == 1 ? female[activity_level] : male[activity_level]
  end

  # Calculation based on body weight and level of activity
  def bmr_1
    24 * weight * activity_factor
  end

  # Calculation based on MD Mifflin and ST St Jeor equation
  def bmr_2
    modifier = gender == 1 ? -161 : 5
    9.99 * weight + 6.25 * height - 4.92 * age + modifier
  end

  # Calculation based od body weight, age and level of activity
  def bmr_3
    if (10..17).include?(age)
      (13.4 * weight + 692 + 50) * activity_factor
    elsif (18..29).include?(age)
      (14.8 * weight + 487+ 60) * activity_factor
    else
      (8.3 * weight + 846 + 50) * activity_factor
    end
  end

  def calculate_bmr_total
    self.calories_need = ((bmr_1 + bmr_2 + bmr_3) / 3).round(2)
  end

  def calculate_protein_need
    female = {1 => 1.0, 2 => 1.1, 3 => 1.2, 4 => 1.3, 5 => 1.5, 6 => 1.8}
    male = {1 => 1.2, 2 => 1.3, 3 => 1.4, 4 => 1.5, 5 => 1.7, 6 => 2.0}

    factor = gender == 1 ? female[activity_level] : male[activity_level]

    self.protein_need = (weight * factor + (0.3 * calories_need / 4) / 2).round(2)
  end

  def calculate_fat_need
    self.fat_need = (0.32 * calories_need / 9).round(2)
  end

  def calculate_carbs_need
    self.carbs_need = ((calories_need - (protein_need * 4 + fat_need * 9)) / 4).round(2)
  end
end
