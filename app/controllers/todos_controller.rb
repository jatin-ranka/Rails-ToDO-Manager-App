class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    # render plain: Todo.order(:id).map {|todo| todo.to_pleasant_string}.join("\n")
    render "index"
  end

  def show
    id = params[:id].to_i
    todo = Todo.find(id)
    render plain: todo.to_pleasant_string
  end

  def create
    new_todo = {
      :todo_text => params[:todo_text],
      :due_date => params[:due_date]
    }
    puts new_todo
    todo = Todo.add_task(new_todo)
    redirect_to todos_path
  end

  def update
    id = params[:id]
    completed = params[:completed]

    todo = Todo.find(id)
    todo.completed = completed
    todo.save

    redirect_to todos_path
  end

  def destroy
    id = params[:id]
    del = Todo.delete_todo(id)

    redirect_to todos_path
  end
end
