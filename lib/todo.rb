require_relative 'assignment_helper'
require 'csv'

class Todo
  include AssignmentHelper

  def initialize(file_name)
    @file_name = file_name #Don't touch this line or var
    # You will need to read from your CSV here and assign them to the @todos variable. make sure headers are set to true
    @todos = CSV.read(@file_name, {headers: true})
    # @completed
  end

  def start
    loop do
      system('clear')

      puts "---- TODO.rb ----"
      view_todos

      puts
      puts "What would you like to do?"
      puts "1) Exit 2) Add Todo 3) Mark Todo As Complete 4) Edit Todo"
      print " > "
      action = get_input.to_i
      case action
      when 1 then exit
      when 2 then add_todo
      when 3 then mark_todo
      when 4 then edit_todo
      else
        puts "\a"
        puts "Not a valid choice"
      end
    end
  end

  def view_todos
    puts "Unfinished"
    @todos.each_with_index do |todo, index|
      if todo[1] == "no"
        puts "#{index + 1}) #{todo["name"]}"
      end
    end
    puts "Completed"
    @todos.each_with_index do |todo, index|
      if todo[1] == "yes"
        puts "#{index + 1}) #{todo["name"]}"
      end
    end
  end

  def add_todo
    puts "Name of Todo > "
    todo = get_input
    @todos << [todo, "no"]
  end

  def mark_todo
    puts "Which todo have you finished?"
    @todos[get_input.to_i - 1][1] = "yes"
  end

  def edit_todo_number
    puts "Which todo would you like to edit?"
    get_input
  end

  def edit_todo
    edited = edit_todo_number
    puts "Please enter the new ##{edited} todo: "
    @todos[edited.to_i - 1][0] = get_input
  end

  def todos
    @todos
  end

  private # Don't edit the below methods, but use them to get player input and to save the csv file
  def get_input
    STDIN.gets.chomp
  end

  def save!
    File.write(@file_name, @todos.to_csv)
  end
end
