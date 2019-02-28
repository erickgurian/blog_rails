class Post < ApplicationRecord
  belongs_to :user
  validates :title, :body, presence: true

  def formated_data
    created_at.strftime("%d/%m/%Y")
  end

  def author?(current_user)
    user == current_user
  end
end
