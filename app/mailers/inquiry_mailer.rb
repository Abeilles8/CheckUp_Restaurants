class InquiryMailer < ApplicationMailer
 
    def received_email(inquiry)
      @inquiry = inquiry
      mail(
        # 送信元アドレス
        from: "example@example.com",
        # 送信先アドレス
        to:  ENV["SEND_MAIL"],
        # 件名
        subject: "お問い合わせを承りました")
    end
end
