require 'pry'

require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def main
  system('clear')
  puts "             \e[34mMAIN MENU\e[0m       "
  puts "* * * * * * * * * * * * * * * * * *"
  puts "*       v: to view calendar       *"
  puts "*       a: to add an event!       *"
  puts "*       e: to edit an event       *"
  puts "*      d: to delete an event      *"
  puts "*      l: to list out events      *"
  puts "*            x: to exit           *"
  puts "* * * * * * * * * * * * * * * * * *"
  main_input = gets.chomp
  case main_input
  when 'a'
    add_event
  when 'e'
  edit_event
  when 'd'
    delete_event
  when 'l'
    list_event
  when 'v'
    view_calendar
  when 'x'
    puts 'Adiós'
    exit
  end
end

def view_calendar
  puts "t: to view today."
  puts "w: to view this week."
  puts "m: to view this month."
  puts "b: to go back to main menu."

  user_input = gets.chomp.downcase

  case user_input
  when 't'
    today_screen
  when 'w'
    week_screen
  when 'm'
    month_screen
  when 'b'
    main
  end
end

def today_screen
  puts "Today's Events:"
  puts "---------------"
  Event.today_day.each do |event|
    puts "\t{event.description} | #{event.location} | #{event.start_date}, #{event.start_time} - #{event.end_date}, #{event.end_time}"
  end
  date = Date.today
  day_choice_menu(date)
end

def next_day(date)
  puts "#{date} Events:"
  puts "---------------"
  Event.next_date(date).each do |event|
    puts "\t{event.description} | #{event.location} | #{event.start_date}, #{event.start_time} - #{event.end_date}, #{event.end_time}"
  end
  date = date + 1
  day_choice_menu(date)
end

def previous_day(date)
  puts "#{date} Events:"
  puts "---------------"
  Event.previous_date(date).each do |event|
    puts "\t{event.description} | #{event.location} | #{event.start_date}, #{event.start_time} - #{event.end_date}, #{event.end_time}"
  end
  date = date - 1
  day_choice_menu(date)
end

def day_choice_menu(date)
  puts "p: previous day's events"
  puts "n: next day's events"
  puts "b: go back"
  user_input = gets.chomp.downcase
  case user_input
  when 'p'
    previous_day(date)
  when 'n'
    next_day(date)
  when 'b'
    view_calendar
  end
  main
end

def week_screen
  puts "This Week's Events:"
  puts "-------------------"
    Event.this_week.each do |event|
      puts "{event.description} | #{event.location} | #{event.start_date}, #{event.start_time} - #{event.end_date}, #{event.end_time}"
    end
  date = Date.today
  week_choice_menu(date)
end

def next_week(date)
  puts "#{date} Events:"
  puts "---------------"
  Event.next_week(date).each do |event|
    puts "\t{event.description} | #{event.location} | #{event.start_date}, #{event.start_time} - #{event.end_date}, #{event.end_time}"
  end
  date = date + 1.week
  week_choice_menu(date)
end

def previous_week(date)
  puts "#{date} Events:"
  puts "---------------"
  Event.previous_week(date).each do |event|
    puts "\t{event.description} | #{event.location} | #{event.start_date}, #{event.start_time} - #{event.end_date}, #{event.end_time}"
  end
  date = date - 1.week
  week_choice_menu(date)
end

def week_choice_menu(date)
  puts "p: previous week's events"
  puts "n: next week's events"
  puts "b: go back"
  user_input = gets.chomp.downcase
  case user_input
  when 'p'
    previous_week(date)
  when 'n'
    next_week(date)
  when 'b'
    view_calendar
  end
  main
end

def month_screen
  puts "This Month's Events:"
  puts "-------------------"
  Event.this_month.each do |event|
    puts "{event.description} | #{event.location} | #{event.start_date}, #{event.start_time} - #{event.end_date}, #{event.end_time}"
  end
  date = Date.today
  month_choice_menu(date)
end

def next_month(date)
  puts "#{date} Events:"
  puts "---------------"
  Event.next_month(date).each do |event|
    puts "\t{event.description} | #{event.location} | #{event.start_date}, #{event.start_time} - #{event.end_date}, #{event.end_time}"
  end
  date = date + 1.month
  month_choice_menu(date)
end

def previous_month(date)
  puts "#{date} Events:"
  puts "---------------"
  Event.previous_month(date).each do |event|
    puts "\t{event.description} | #{event.location} | #{event.start_date}, #{event.start_time} - #{event.end_date}, #{event.end_time}"
  end
  date = date - 1.month
  month_choice_menu(date)
end

def month_choice_menu(date)
  puts "p: previous month's events"
  puts "n: next month's events"
  puts "b: go back"
  user_input = gets.chomp.downcase
  case user_input
  when 'p'
    previous_month(date)
  when 'n'
    next_month(date)
  when 'b'
    view_calendar
  end
  main
end

def add_event
  puts "Enter Event Name:"
  name_input = gets.chomp.upcase
  puts "Dondé:"
  location_input = gets.chomp.upcase
  puts "Enter #{name_input} Start Date:"
  start_date = gets.chomp
  puts "Enter #{name_input} Start Time:"
  start_input = gets.chomp
  puts "Enter #{name_input} End Date:"
  end_date = gets.chomp
  puts "Enter #{name_input} End Time:"
  end_input = gets.chomp

  new_event = Event.create(:description => name_input, :location => location_input, :start_date => start_date, :start_time => start_input, :end_date => end_date, :end_time => end_input)

  if new_event.valid?
    puts "#{name_input} Added!"
  else
    puts "Not a valid entry."
    new_event.errors.full_messages.each { |message| puts message }
  end
  main
end

def delete_event
  puts "Which event do you no longer want to partake in?"
  delete_input = gets.chomp.upcase
  delete = Event.find_by(:description => delete_input)
  if delete != nil
    delete.destroy
    puts "#{delete_input} is now destroyed ლ(ಠ益ಠლ)"
  else
    puts "not an event...try again."
    delete_event
  end
  main
end

def edit_event
  puts "Which event do you want to edit?"
  edit_input = gets.chomp.upcase
  edit = Event.find_by(:description => edit_input)
  puts "Enter Number to Change:"
  puts "\t1. Description"
  puts "\t2. Location"
  puts "\t3. Start Date"
  puts "\t4. Start Time"
  puts "\t5. End Date"
  puts "\t6. End Time"
  change_input = gets.chomp.to_i
  change_hash = {1 => :description, 2 => :location, 4 => :start_time, 3 => :start_date, 5 => :end_date, 6 => :end_time}
  puts "What do you want to change it to?"
  update_input = gets.chomp.upcase
  new_event = edit.update(change_hash[change_input] => update_input)

  if new_event
    puts "Upate Accepted ┏(-_-)┛┗(-_-﻿ )┓┗(-_-)┛┏(-_-)┓"
  else
    puts "Not a valid update. (ノಠ益ಠ)ノ彡"
    edit.errors.full_messages.each { |message| puts message }
    edit_event
  end
  main
end

def list_event
  Event.sort_by_date.each do |event|
    puts "#{event.description} | #{event.location} | #{event.start_date}, #{event.start_time} - #{event.end_date}, #{event.end_time}"
  end
  sleep(90)
  main
end

main

