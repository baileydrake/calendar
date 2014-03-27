require 'spec_helper'
describe Event do
  it 'will validate the start time' do
    test_event = Event.create(description: 'Wolf', location: 'The Zoo', start_time: '2012/12/12', end_time: '2014/03/04')
    Event.all.length.should eq 0
  end
  it 'will validate the start time' do
    test_event = Event.create(description: 'Wolf', location: 'The Zoo', start_time: '03/15/2015', end_time: '03/16/2015')
    Event.all.length.should eq 1
  end
  it 'will validate the start time' do
    test_event = Event.create(description: 'Wolf', location: 'The Zoo', start_time: 'March 15, 2015', end_time: 'March 12, 2015')
    Event.all.length.should eq 0
  end

  describe "#sort_by_date" do
    it 'will list out the events by date order' do
      test_event1 = Event.create(description: 'Wolf', location: 'The Zoo', start_time: 'March 13, 2015', end_time: 'March 15, 2015')
      test_event2 = Event.create(description: 'Wolf', location: 'The Zoo', start_time: 'March 14, 2015', end_time: 'March 15, 2015')
      test_event3 = Event.create(description: 'Wolf', location: 'The Zoo', start_time: 'March 12, 2015', end_time: 'March 15, 2015')
      sorted_events = Event.sort_by_date
      sorted_events.should eq ["Wolf | The Zoo | 2015-03-12 00:00:00 UTC 2015-03-15 00:00:00 UTC", "Wolf | The Zoo | 2015-03-13 00:00:00 UTC 2015-03-15 00:00:00 UTC", "Wolf | The Zoo | 2015-03-14 00:00:00 UTC 2015-03-15 00:00:00 UTC"]
    end
  end
end
