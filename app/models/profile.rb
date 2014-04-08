class Profile < ActiveRecord::Base
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

  def count_activity_factor

  end

end
