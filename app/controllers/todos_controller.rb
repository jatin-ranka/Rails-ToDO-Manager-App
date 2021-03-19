class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @todos = Todo.of_user(current_user)
    render "index"
  end

  def show
    id = params[:id].to_i
    todo = Todo.find(id)
    render plain: todo.to_pleasant_string
  end

  def create
    new_todo = Todo.new(
      "todo_text": params[:todo_text],
      "due_date": params[:due_date],
      "completed": false,
      "user_id": current_user.id
    )

    if new_todo.save
      redirect_to todos_path
    else
      flash[:error] = new_todo.errors.full_messages.join(", ")
      redirect_to todos_path
    end
  end

  def update
    id = params[:id]
    completed = params[:completed]

    todo = Todo.of_user(current_user).find(id)
    todo.completed = completed
    todo.save

    redirect_to todos_path
  end

  def destroy
    id = params[:id]
    del = Todo.of_user(current_user).delete_todo(id)

    redirect_to todos_path
  end
end
