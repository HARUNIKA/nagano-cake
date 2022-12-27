class Public::CartItemsController < ApplicationController
 
 private
def cart_item_params
  params.require(:cart_item).permit(:item_id, :amount)
end
