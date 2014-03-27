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
    Event.where(:start_date => Date.today)

  end

  def self.this_week
    Event.where(:start_date => Date.today.at_beginning_of_week..Date.today.at_end_of_week)
  end

  def self.this_month
    Event.where(:start_date => Date.today.at_beginning_of_month..Date.today.at_end_of_month)
  end

  def self.next_date(date)
    Event.where(:start_date => date + 1)
  end

  def self.previous_date(date)
    Event.where(:start_date => date - 1)
  end

  def self.next_week(week)
    Event.where(:start_date => week.next_week.at_beginning_of_week..week.next_week.at_end_of_week)
  end

  def self.previous_week(week)
    Event.where(:start_date => week.prev_week.at_beginning_of_week..week.prev_week.at_end_of_week)
  end

  def self.next_month(month)
    Event.where(:start_date => month.at_beginning_of_month.next_month..month.at_end_of_month.next_month)
  end

  def self.previous_month(month)
    Event.where(:start_date => month.at_beginning_of_month.prev_month..month.at_end_of_month.prev_month)
  end
end
