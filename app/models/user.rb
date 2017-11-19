class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w( admin sales_rep )

  validates :role, inclusion: { in: ROLES, allow_blank: true }

  scope :admins, -> { where(role: ROLES) }

  def is_admin?
    self.role == 'admin'
  end

  def is_sales_rep?
    self.role == 'sales_rep'
  end

  protected
  def password_required?
    !persisted? || password.present? || password_confirmation.present?
  end
end
