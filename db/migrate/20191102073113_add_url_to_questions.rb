class AddUrlToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :url, :string
  end
end
