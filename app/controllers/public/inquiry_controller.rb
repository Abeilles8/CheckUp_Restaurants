class Public::InquiryController < ApplicationController
  
  def index
    # 入力画面
    @inquiry = Inquiry.new
    render :action => "index"
  end
  
  def confirm
    # 入力値のチェック
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :title, :message))
    if @inquiry.valid?
      # 確認画面
      render :action => "confirm"
    else
      # 入力画面
      render :action => "index"
    end
  end
  
  def thanks
    # メール送信
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :title, :email, :message))
    InquiryMailer.received_email(@inquiry).deliver
    
    # 完了画面
    render :action => "thanks"
  end
end
