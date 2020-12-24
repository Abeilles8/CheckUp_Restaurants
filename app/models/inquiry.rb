class Inquiry < ApplicationRecord
  
  attr_accessor :name, :email, :title, :message
  
  validates :title, :presence => {:message => 'タイトルを入力してください'}
  validates :name, :presence => {:message => '名前を入力してください'}
  validates :email, :presence => {:message => 'メールアドレスを入力してください'}
  
end