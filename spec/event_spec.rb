require 'spec_helper'
describe Event do
  it 'will validate the start time' do
    test_event = Event.create(description: 'Wolf', location: 'The Zoo', start_date: '2012/12/12', start_time: '12:00:00', end_date: '2014/03/04')
    Event.all.length.should eq 0
  end
  it 'will validate the start time' do
    test_event = Event.create(description: 'Wolf', location: 'The Zoo', start_date: '2015/03/12', start_time: '12:00:00', end_date: '2015/03/16')
    Event.all.length.should eq 1
  end
  it 'will validate the start time' do
    test_event = Event.create(description: 'Wolf', location: 'The Zoo', start_date: '2013/03/14', start_time: '12:00:00', end_date: '2013/06/12')
    Event.all.length.should eq 0
  end
  it 'will validate the start time' do
    test_event = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 15, 2015', start_time: '12:00:00', end_date: 'March 12, 2015')
    Event.all.length.should eq 0
  end

  describe ".sort_by_date" do
    it 'will list out the events by date order' do
      test_event1 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 13, 2015', start_time: '12:00:00', end_date: 'March 15, 2015')
      test_event2 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 14, 2015', start_time: '12:00:00', end_date: 'March 15, 2015')
      test_event3 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 12, 2015', start_time: '12:00:00', end_date: 'March 15, 2015')
      sorted_events = Event.sort_by_date
      sorted_events.should eq [test_event3, test_event1, test_event2]
    end
  end
  describe ".find_date" do
    it 'will find all events that occur on a given date' do
      test_event1 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 14, 2015', start_time: '12:00:00', end_date: 'March 15, 2015')
      test_event2 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 14, 2015', start_time: '12:00:00', end_date: 'March 15, 2015')
      test_event3 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 12, 2015', start_time: '12:00:00', end_date: 'March 15, 2015')
    found_dates = Event.find_date('March 14, 2015')
    found_dates.should eq [test_event1, test_event2]
    end
  end
  describe ".today_day" do
    it 'will find all events that occur today date' do
      test_event1 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 27, 2014', end_date: 'March 15, 2015')
      test_event2 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 14, 2015', end_date: 'March 15, 2015')
      test_event3 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 12, 2015', end_date: 'March 15, 2015')
    found_dates = Event.today_day
    found_dates.should eq [test_event1]
    end
  end
  describe ".this_week" do
    it 'will find all evets for a given week' do
      test_event1 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 27, 2014', end_date: 'March 15, 2015')
      test_event2 = Event.create(description: 'Beach', location: 'Desert', start_date: 'March 28, 2014', end_date: 'March 28, 2014')
      test_event3 = Event.create(description: 'Beached Whale', location: 'The Gym', start_date: 'March 12, 2015', end_date: 'March 15, 2015')
      found_dates = Event.this_week
      found_dates.should eq [test_event1, test_event2]
    end
  end
  describe ".this_month" do
    it 'will find all evets for a given month' do
      test_event1 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 27, 2014', end_date: 'March 15, 2015')
      test_event2 = Event.create(description: 'Beach', location: 'Desert', start_date: 'March 28, 2014', end_date: 'March 28, 2014')
      test_event3 = Event.create(description: 'Beached Whale', location: 'The Gym', start_date: 'March 12, 2015', end_date: 'March 15, 2015')
      found_dates = Event.this_month
      found_dates.should eq [test_event1, test_event2]
    end
  end
  describe ".next_date" do
    it 'will find all events for the next date' do
      test_event1 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 27, 2014', end_date: 'March 15, 2015')
      test_event2 = Event.create(description: 'Beach', location: 'Desert', start_date: 'March 28, 2014', end_date: 'March 28, 2014')
      test_event3 = Event.create(description: 'Beached Whale', location: 'The Gym', start_date: 'March 12, 2015', end_date: 'March 15, 2015')
      found_dates = Event.next_date(test_event1.start_date)
      found_dates.should eq [test_event2]
    end
  end

  describe ".next_date" do
    it 'will find all events for the next date' do
      test_event1 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 27, 2014', end_date: 'March 15, 2015')
      test_event2 = Event.create(description: 'Beach', location: 'Desert', start_date: 'March 28, 2014', end_date: 'March 28, 2014')
      test_event3 = Event.create(description: 'Beached Whale', location: 'The Gym', start_date: 'March 12, 2015', end_date: 'March 15, 2015')
      found_dates = Event.next_date(test_event2.start_date)
      found_dates.should eq []
    end
  end

  describe ".previous_date" do
    it 'will find all events for the previous day' do
      test_event1 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 27, 2014', end_date: 'March 27, 2014')
      test_event2 = Event.create(description: 'Beach', location: 'Desert', start_date: 'March 28, 2014', end_date: 'March 28, 2014')
      test_event3 = Event.create(description: 'Beached Whale', location: 'The Gym', start_date: 'March 12, 2015', end_date: 'March 15, 2015')
      found_dates = Event.previous_date(test_event2.start_date)
      found_dates.should eq [test_event1]
    end
  end

  describe ".next_week" do
    it 'will find all events for the next week' do
      test_event1 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 28, 2014', end_date: 'March 15, 2015')
      test_event2 = Event.create(description: 'Beach', location: 'Desert', start_date: 'April 3, 2014', end_date: 'April 28, 2014')
      test_event3 = Event.create(description: 'Beached Whale', location: 'The Gym', start_date: 'March 12, 2015', end_date: 'March 15, 2015')
      found_dates = Event.next_week(test_event1.start_date)
      found_dates.should eq [test_event2]
    end
  end

  describe ".previous_week" do
    it 'will find all events for the previous week' do
      test_event1 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 27, 2014', end_date: 'March 15, 2015')
      test_event2 = Event.create(description: 'Beach', location: 'Desert', start_date: 'April 4, 2014', end_date: 'April 28, 2014')
      test_event3 = Event.create(description: 'Beached Whale', location: 'The Gym', start_date: 'March 12, 2015', end_date: 'March 15, 2015')
      found_dates = Event.previous_week(test_event2.start_date)
      found_dates.should eq [test_event1]
    end
  end

    describe ".next_month" do
    it 'will find all events for the next month' do
      test_event1 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 28, 2014', end_date: 'March 15, 2015')
      test_event2 = Event.create(description: 'Beach', location: 'Desert', start_date: 'April 28, 2014', end_date: 'April 28, 2014')
      test_event3 = Event.create(description: 'Beached Whale', location: 'The Gym', start_date: 'March 12, 2015', end_date: 'March 15, 2015')
      found_dates = Event.next_month(test_event1.start_date)
      found_dates.should eq [test_event2]
    end
  end

  describe ".previous_month" do
    it 'will find all events for the previous month' do
      test_event1 = Event.create(description: 'Wolf', location: 'The Zoo', start_date: 'March 27, 2014', end_date: 'March 15, 2015')
      test_event2 = Event.create(description: 'Beach', location: 'Desert', start_date: 'April 28, 2014', end_date: 'April 28, 2014')
      test_event3 = Event.create(description: 'Beached Whale', location: 'The Gym', start_date: 'March 12, 2015', end_date: 'March 15, 2015')
      found_dates = Event.previous_month(test_event2.start_date)
      found_dates.should eq [test_event1]
    end
  end
end
