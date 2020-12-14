class InquiryMailer < ApplicationMailer
  
  def send_mail(inquiry)
    @inquiry = inquiry
    mail(
      # 送信元メール
      from: 'system@example.com',
      # メールの送信先アドレス
      to: 'manager@example.com',
      # メールの件名
      subject: 'お問い合わせ通知'
      )
  end
end
