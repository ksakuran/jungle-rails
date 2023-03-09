class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['USER_NAME'], password: ENV['PASSWORD']
  def show
    @products_count = Product.all.order(created_at: :desc).count
    @category_count = Category.all.order(created_at: :desc).count
  end
end
