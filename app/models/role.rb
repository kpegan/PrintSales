class Role < ActiveRecord::Base
  has_many :users
  has_and_belongs_to_many :permissions

  validates_presence_of     :name
  validates_uniqueness_of   :name
end
