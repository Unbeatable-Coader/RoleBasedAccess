class User < ApplicationRecord
  enum usertype: [:employee, :manager, :admin]

  has_secure_password

  has_many :tasks
  has_many :managed_tasks, class_name: 'Task', foreign_key: 'manager_id'


  has_many :admin, dependent: :destroy
  has_many :manager, dependent: :destroy
  has_many :employee, dependent: :destroy



end
