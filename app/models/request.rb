class Request < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :status, inclusion: { in: %w(PENDING
                                         RUNNING
                                         COMPLETED
                                         FAILED
                                         ERROR) }

#  validates :status, on: :create,
#                     uniqueness: { scope: :user_id,
#                                   message: "There is another request for this user",
#                                   conditions: -> { where(status: ['PENDING',
#                                                                   'RUNNING',
#                                                                   'ERROR']) }
#
#  }

  validate :unique_status_within_collection, on: :create

  def unique_status_within_collection
    unique_statuses = ['PENDING', 'RUNNING', 'ERROR']
    if unique_statuses.include?(status) && Request.exists?(user: user, status: unique_statuses)
      errors.add(:status, "There is another request for this user")
    end
  end
end
