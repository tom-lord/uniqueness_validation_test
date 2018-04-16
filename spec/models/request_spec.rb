require 'rails_helper'
RSpec.describe Request do
  let(:user) { User.create! }
  it 'cannot a new pending request if user allredy has another RUNNING task' do
    described_class.create!(user: user, status: 'RUNNING')

    expect { described_class.create!(user: user) }.to raise_error(ActiveRecord::RecordInvalid, 
                                                                  /There is another request for this user/)
  end
end
