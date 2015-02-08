class TodoItemsController < ApplicationController

  before_filter :set_todo_list

  def index
  end

  def new
    @todo_item = @todo_list.todo_items.new
  end

  def create
    @todo_item = @todo_list.todo_items.build(todo_item_params)
    if @todo_item.save
      flash[:success] = 'Add todo list item'
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = 'I Have problem'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end

end
