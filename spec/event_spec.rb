require 'spec_helper'
describe Event do
  it 'will validate the start time' do
    test_event = Event.create(description: 'Wolf', location: 'The Zoo', start_time: '02/12/14', end_time: '03/13/14')
    test_event.valid? should eq nil
  end
end
