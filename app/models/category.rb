class Category < ApplicationRecord
  has_many :categories_posts, dependent: :destroy
  has_many :posts, through: :categories_posts

  validates :name, presence: true, uniqueness: { message: I18n
    .t('category.error.messages.already_exists') }
end
