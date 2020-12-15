# Preview all emails at http://localhost:3000/rails/mailers/inquiry_mailer
class InquiryMailerPreview < ActionMailer::Preview
  
  def inquiry
    inquiry = Inquiry.new(title: "不具合", name: "太郎", message: "エラーが出ています。")
    
    InquiryMailer.received_email(inquiry)
  end
  
end
