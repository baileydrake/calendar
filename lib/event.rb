class Event < ActiveRecord::Base
  validate :start_time_valid, :end_time_valid

  def start_time_valid
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "start date can't be in the past")
    end
  end

  def end_time_valid
    if end_date.present? && end_date < start_date
      errors.add(:end_date, "you can't end before you start. try again.")
    end
  end

  def self.sort_by_date
    sorted_events = []
    events = Event.order(:start_date)
    events.each do |event|
      sorted_events << event
    end
    sorted_events
  end

  def self.find_date(user_date)
    Event.where(:start_date => user_date)
  end

  def self.today_day
    found_events = []
    events = Event.where(:start_date => Date.today)
    events.each do |event|
      found_events << event
    end
    found_events
  end

  def self.this_week
    week_events = []
    Event.all.each do |event|
      if event.start_date != nil
        if event.start_date.cweek == Date.today.cweek
          week_events << event
        end
      end
    end
    week_events
  end

  def self.this_month
    month_events = []
    Event.all.each do |event|
      if event.start_date !=nil
        if (event.start_date.mon && event.start_date.cwyear) == (Date.today.mon && Date.today.cwyear)
          month_events << event
        end
      end
    end
    month_events
  end
end
