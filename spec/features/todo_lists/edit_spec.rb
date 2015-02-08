require "spec_helper"

describe 'Editing todo lists' do

  let!(:todo_list) {TodoList.create(title: 'Grocery list', description: 'description Grocery list')}

  def update_todo_list(option={})
      option[:title] ||= "My todo list"
      option[:description] ||= "My description list"

      todo_list = option[:todo_list]

      visit "/todo_lists"

      within "#todo_list_#{todo_list.id}" do
        click_link 'Edit'
      end

      fill_in "Title", with: option[:title]
      fill_in "Description", with: option[:description]
      click_button "Update Todo list"
  end

  it 'updates a todo list success with correct information' do
    update_todo_list todo_list: todo_list,
                     title: 'New title',
                     description: 'New Description'

    todo_list.reload

    expect(page).to have_content('Todo list was successfully updated.')
    expect(todo_list.title).to eq('New title')
    expect(todo_list.description).to eq('New Description')

  end


end
