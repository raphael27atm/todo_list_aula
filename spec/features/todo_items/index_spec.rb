require "spec_helper"

describe 'Display todo item' do
  let!(:todo_list){TodoList.create(title: 'Title Grocery list', description: 'Description grocery list')}

  def visit_todo_list(list)
    visit '/todo_lists'
    within "#todo_list_#{list.id}" do
      click_link 'List items'
    end
  end

  it 'display title todo list' do
    visit_todo_list(todo_list)
    within('h1') do
      expect(page).to have_content(todo_list.title)
    end
  end

  it "diplay no items when a todo list is empty" do
    visit_todo_list(todo_list)
    expect(page.all('ul.todo_items li').size).to eq(0)
  end

  it "display item content when todo list has item" do
    todo_list.todo_items.create(content: 'milk')
    todo_list.todo_items.create(content: 'my eggs')

    visit_todo_list(todo_list)

    expect(page.all('ul.todo_items li').size).to eq(2)

    within 'ul.todo_items' do
      expect(page).to have_content('milk')
      expect(page).to have_content('my eggs')
    end
  end

end
