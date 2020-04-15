class BuysController < ApplicationController

  before_action :set_item
  before_action :set_card

  require 'payjp'

  def new
  end

  def create
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    charge = Payjp::Charge.create(
    amount: @item.price,
    customer: @card.customer_id,
    currency: 'jpy'
    )
    if @item.save
      @item.update(state: 2)
      # @item.buyer_id = current_user.id
      redirect_to action: 'done'
    else
      flash[:alert] = '購入に失敗しました。'
      redirect_to action: "new"
    end
  end

  def done
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @card_information = customer.cards.retrieve(@card.card_id)

    # @prefecture = Prefecture.find(current_user.address.prefecture_id).name

    @item_buyer = Item.find(params[:item_id])
    # @item_buyer.update(buyer_id: current_user.id)
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

end
