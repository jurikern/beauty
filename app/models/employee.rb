class Employee < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  attr_accessible :role, :company_id

  validates :company_id, presence: true

  scope :allowed, where(allowed: true)

  def allow!
    self.allowed = true
    save!
  end

  def ban!
    self.allowed = false
    save!
  end

  def splitted_role
    return self.role.split(',').map(&:strip) if self.role.present?
    []
  end
end
