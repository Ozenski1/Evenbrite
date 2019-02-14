class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :welcome_send

  has_many :events
  has_many :attendances
  has_many :events, through: :attendances

  validates :first_name, presence: true
  validates :last_name, presence: true


  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

end