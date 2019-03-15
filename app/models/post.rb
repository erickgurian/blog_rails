class Post < ApplicationRecord
  belongs_to :user
  has_many :categories_posts, dependent: :destroy
  has_many :categories, through: :categories_posts
  validates :title, :body, presence: true

  def formated_data
    created_at.strftime('%d/%m/%Y')
  end

  def author?(current_user)
    user == current_user
  end

  def read_more?
    body.size >= 320
  end

  def initial_body
    read_more? ? body.at(0...320) : body
  end
end
