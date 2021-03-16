class Todo < ActiveRecord::Base

  def to_pleasant_string
    is_completed = completed ? "[x]" : "[ ]"
    return "#{id}. #{due_date.to_s(:short)} - #{todo_text} #{is_completed} "
  end

  def self.add_task(new_todo)
    Todo.create!(
      "todo_text": new_todo[:todo_text],
      "due_date": new_todo[:due_date],
      "completed": false
    )
  end

  def self.delete_todo(todo_id)
    Todo.delete(todo_id)
  end

  def due_today?
    due_date == Date.today
  end

end
