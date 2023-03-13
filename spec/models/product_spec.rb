require 'rails_helper'

# validates :name, presence: true
# validates :price, presence: true
# validates :quantity, presence: true
# validates :category, presence: true


RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'passes validation' do
      category = Category.new(name: 'test')
      product = Product.new(name: 'test product', price: 500, quantity: 5, category: category)
      expect(product).to be_valid
      
    end

    it 'requires a name' do
      category = Category.new(name: 'test')
      product = Product.new(name: nil, price: 500, quantity: 5, category: category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages_for(:name)).to include("Name can't be blank")
    end

    it 'requires a price' do
      category = Category.new(name: 'test')
      product = Product.new(name: 'test product', quantity: 5, category: category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages_for(:price)).to include("Price can't be blank")
    end

    it 'requires a quantity' do
      category = Category.new(name: 'test')
      product = Product.new(name: 'test product', price: 500, quantity: nil, category: category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages_for(:quantity)).to include("Quantity can't be blank")
    end

    it 'requires a category' do
      category = nil
      product = Product.new(name: 'test product', price: 500, quantity: 5, category: category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages_for(:category)).to include("Category can't be blank")
    end


  end

end
