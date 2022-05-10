class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

    # 今日
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  # 前日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
   #今週
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  # 前週
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }

  #ユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べる
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(name: content)
    elsif method == 'forward'
      Book.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('name LIKE ?', '%' + content)
    elsif method == 'partial'
      Book.where('name LIKE ?', '%' + content + '%')
    end
  end
end
