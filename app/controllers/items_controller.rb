class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user
        items = user.items
      else
        return render json: {error: 'user not found'}, status: :not_found
      end
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      item = user.items.find_by(id: params[:id])
      if item
        return render json: item, include: :user
      else
        return render json: {error: 'item not found'}, status: :not_found
      end
    else
      item = Item.find_by(id: params[:id])
      render json: item, include: :user
    end
  end

  def create
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      item = user.items.create(item_params)
      render json: item, status: :created
    end
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

end
