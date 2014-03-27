class Event < ActiveRecord::Base
  validate :start_time_valid, :end_time_valid

  def start_time_valid
    if start_time.present? && start_time < Date.today
      errors.add(:start_time, "start time can't be in the past")
    end
  end

  def end_time_valid
    if end_time.present? && end_time < start_time
      errors.add(:end_time, "you can't end before you start. try again.")
    end
  end

  def self.sort_by_date
    sorted_events = []
    events = Event.order(:start_time)
    events.each do |event|
      sorted_events << "#{event.description} | #{event.location} | #{event.start_time} #{event.end_time}"
    end
    sorted_events
  end
end
