module Public::NotificationsHelper
  
  def notification_form(notification)
    # 通知を送ったユーザーを取得
    @visitor = notification.visitor
    # コメントの内容を通知に表示
    @comment = nil
    @visitor_comment = notification.comment_id
    
    # notification.actionが[follow]か[like]か[comment]なのかで処理を変える
    case notification.action
      when "follow"
        # aタグで通知を作成したユーザーshowのリンクを作成する
        tag.a(notification.visitor.name, href: user_path(@visitor)) + "があなたをフォローしました"
      when "like"
        tag.a(notification.visitor.name, href: user_path(@visitor)) + "が" + tag.a("あなたの投稿", href: review_path(notification.review_id)) + "にいいねしました"
      when "comment" then
        # コメントの内容と投稿のタイトルを取得
        @comment = ReviewComment.find_by(id: @visitor_comment)
        @comment_content = @comment.content
        @review_name = @comment.review.name
        tag.a(@visitor.name, href: user_path(@visitor)) + "が" + tag.a("#{@review_name}", href: review_path(notification.review_id)) + "にコメントしました"
    end
  end
  
end
