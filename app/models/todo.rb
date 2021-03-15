class Todo < ActiveRecord::Base

  def to_pleasant_string
    is_completed = completed ? "[x]" : "[ ]"
    return "#{id}. #{due_date.to_s(:short)} - #{todo_text} #{is_completed} "
  end

  def self.add_task(new_todo)
    Todo.create!(
      "todo_text": new_todo[:todo_text],
      "due_date": Date.today + new_todo[:due_in_days].to_i,
      "completed": false
    )
  end

  def self.mark_as_complete!(todo_id)
    todo = Todo.find(todo_id)
    todo.completed = true
    todo.save
    return todo
  end



end
