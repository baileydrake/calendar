require 'pry'

require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def main
  puts "a: to add an event"
  puts "e: to edit an event"
  puts "d: to delete an event"
  puts "l: to list out events"
  puts "x: to exit"
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
  when 'x'
    puts 'Adiós'
  end
end

def add_event
  puts "Enter Event Name:"
  name_input = gets.chomp.upcase
  puts "Dondé:"
  location_input = gets.chomp.upcase
  puts "Enter #{name_input} Start Date & Time:"
  start_input = gets.chomp
  puts "Enter #{name_input} End Date & Time:"
  end_input = gets.chomp
  new_event = Event.create(:description => name_input, :location => location_input, :start_time => start_input, :end_time => end_input)
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
  puts "Enter Number to Change: 1.Description 2.Location 3.Start Date 4.End Date"
  change_input = gets.chomp.to_i
  change_hash = {1 => :description, 2 => :location, 3 => :start_time, 4 => :end_time}
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
  puts Event.sort_by_date
end
main

