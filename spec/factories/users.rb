FactoryBot.define do
  factory :user do
    email { 'admin@teste.com' }
    password { 'segredo' }
  end
end
