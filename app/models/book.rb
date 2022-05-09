class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}


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
