class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  before_save :add_frame

  belongs_to :user, foreign_key: "user_id", class_name: "User"
  has_many :empathies
  has_one_attached :image
  attr_accessor :composed_image_path

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 4000 }
  validates :image, presence: true

  enum status: { published: 0, draft: 1 }

  def empathize_by?(user)
    empathies.where(user_id: user.id).exists?
  end

  private

  def add_frame
    if image.present?
      # 投稿画像のパス
      input_path = image.path
      # 額縁画像のパス
      frame_path = 'app/assets/images/額縁.png'
      # 投稿画像を読み込む
      image = MiniMagick::Image.open(input_path)
      # 額縁画像を読み込む
      frame = MiniMagick::Image.open(frame_path)
      # 投稿画像と額縁画像を合成する
      result = image.composite(frame) do |c|
        c.compose "Over"
      end
      # 合成した画像を保存する
      output_path = Rails.root.join("public/uploads/post/image/#{Time.now.to_i}.png").to_s
      result.write(output_path)
      self.compose_image = output_path # 合成した画像のパスをインスタンス変数に保存
      self.composed_image_path = output_path.to_s
    end
  end
end