class Employee < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  attr_accessible :role, :company_id

  validates :company_id, presence: true

  scope :allowed, where(allowed: true)

  def splitted_role
    return self.role.split(',').map(&:strip) if self.role.present?
    []
  end
end
