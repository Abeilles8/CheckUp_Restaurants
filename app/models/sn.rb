class Sn < ApplicationRecord
  # 外部キーのnilを許可(認証登録時use_idが存在しないため)
  belongs_to :user, optional: true
end
