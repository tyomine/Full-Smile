class Post < ApplicationRecord
  has_one_attached :image  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 500 }
  validates :image, presence: true
  
  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
      # 部分一致
      @post = Post.where("title LIKE?","%#{word}%")
  end
  
  def create_notification_by(current_user)
	    notification = current_user.active_notifications.new(
	      post_id: id,
	      visited_id: user_id,
	      action: "like"
	    )
	    # 自分の投稿に対するいいねの場合は、通知済みとする
	    if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
	    notification.save if notification.valid?
  end
  
  
end
