class Post < ApplicationRecord
  validates :title, :body,
            presence: { message: 'Todos os campos são obrigatórios' }
end
