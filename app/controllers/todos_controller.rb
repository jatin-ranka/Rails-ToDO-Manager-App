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
    render plain: todo.to_pleasant_string
  end

  def update
    id = params[:id]
    updated_todo = Todo.mark_as_complete!(id)
    render plain: updated_todo.to_pleasant_string
  end
end
