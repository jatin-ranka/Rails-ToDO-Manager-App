class Todo < ActiveRecord::Base
  belongs_to :user

  def to_pleasant_string
    is_completed = completed ? "[x]" : "[ ]"
    return "#{id}. #{due_date.to_s(:short)} - #{todo_text} #{is_completed} "
  end

  def self.of_user(user)
    Todo.all.where(user_id: user.id)
  end

  def self.delete_todo(todo_id)
    Todo.delete(todo_id)
  end

  def self.due_today
    Todo.where("due_date = ? ",  Date.today)
  end

  def self.due_later
    Todo.where("due_date > ? ",  Date.today)
  end

  def self.over_due
    Todo.where("due_date < ? ", Date.today)
  end

  def show_due_date?
    return due_date != Date.today
  end

end
