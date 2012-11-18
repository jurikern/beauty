class Profile < ActiveRecord::Base
  attr_accessible :name, :logo, :link, :gender

  belongs_to :user
end
