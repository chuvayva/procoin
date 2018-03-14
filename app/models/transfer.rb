class Transfer < ApplicationRecord

  belongs_to :user
  belongs_to :target, class_name: 'User'

  enumerize :status, in: %i[pending completed failed error], default: :pending, scope: true, predicates: true
end
