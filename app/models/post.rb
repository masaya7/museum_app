class Post < ApplicationRecord
  #require 'open-uri'
  require 'aws-sdk-s3'
  mount_uploader :image, ImageUploader
  before_save :add_frame

  belongs_to :user, foreign_key: "user_id", class_name: "User"
  has_many :empathies
  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 4000 }
  validates :image, presence: true

  enum status: { published: 0, draft: 1 }

  def empathize_by?(user)
    empathies.where(user_id: user.id).exists?
  end

  private

  def add_frame
    return unless image.present?

    # 投稿画像のパス
    input_path = image.url
    # 額縁画像のパス
    s3 = Aws::S3::Resource.new(region: 'ap-northeast-1')
    obj = s3.bucket('museum1-app').object('uploads/frame.png')
    url = obj.presigned_url(:get)
    Rails.logger.info "frame___path"
    # 投稿画像を読み込む
    image = MiniMagick::Image.open(input_path)
    image.resize "210x280!"
    Rails.logger.info "image open"
    # 額縁画像を読み込む
    frame = MiniMagick::Image.open(url)
    frame.resize "210x280!"
    Rails.logger.info "frame open"
    # 投稿画像と額縁画像を合成する
    result = image.composite(frame) do |c|
      c.compose "Over"
    end
    Rails.logger.info "compose___ok"
    # 合成した画像を保存する
    output_filename = "#{Time.now.to_i}.png"
    output_path = Rails.root.join("public", "uploads", "post", "image", output_filename)
    result.write(output_path)
    self.compose_image = "/uploads/post/image/#{output_filename}"
    Rails.logger.info "outpath__ok"
  end
end

#https://museum1-app.s3.ap-northeast-1.amazonaws.com/uploads/frame.png?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEPP%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaDmFwLW5vcnRoZWFzdC0xIkcwRQIgSQNRQKxLZjHrnnXR%2FAdYcyOpIqGIX5QMPJ%2BfNMUXl9kCIQCeVkJC9vHuDuYPeMcbR%2B2jz9qo%2BMxck6xTdHM9v2mhpirxAgjM%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAAaDDI5NDMzMDUxMDE4MiIMZe0FJia4%2Bh1IQ4OFKsUCDDUlfTuejTBg4YFl9ZXAdJ4eU6wD3wllZonoW9JlUWJib4yvpGb6pzDFB4%2FsWUfP%2FPpj10GP%2FwA1V2rcr1CRNnm24JvGASnXQ%2BtvojOPKjWZqcNMTNZSg98V9qV5kqa%2FHXCiy0LW6nmj3OBn02TVFE5CvlZSfiSTYo1WL%2BSSy%2F26uem8uy3rzhlUxPPKp39WXB3frnlHFquqS51DAtUX9HP2N6GWX9VmV70AMmiO57q1V%2FZvC2wb4aTNUXaUlC2u5a6uJUOk5J3V4zvQXnoD8Hrpcj2ezzmbz1yT8I8DqL%2FmjvuUZaGtnCoEexLj4ciHoFh5CBEByz7Q711%2FpugujN6UbV5YLxzLXnmJ98UWetFr1TlhcMBpTfUvhKfSe%2BdjHgJmiisy5zbKDf2Ke9plRulk19P9C1YHCY%2FThU1I1fGzSry4dDCY3%2FSnBjqzAkEkAaHsvMPWxIYNzFnFRz1xao3EGoisflX2RUvCojSsKcKgbmqtHsDrk27qERiQWrddDP3rMvvrBkjpHiIys14tarwAs7ZOyagkovgMIEV9S7atmf5kGjJFibirdDslHEbOq753cJXfPZ67JZUKjA6IFzeIulPT8SRQswzZamqC6iAhZ%2BrAD1HRERpqDUg8FbB5iXplVvqnzOfG7yaRSYdSM5Tt53DBemruNKS56qr8S0MLw2iFN9Pii%2F7yhWYvfsx5IGERU2Nuj6vE3SBr%2FAY2Ptlgycu6juwxnxMSl8KNEBVi8kOzLSlhnHbe3B5lXRTCmZFio6vsGmUXZyMLP4jbzlWIkjeMcQOxFIIOK0wVIQvRyYD4q8GGjJ1ve2JPRjbeLvg32Izg%2BONFd3mUKn53Le4%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230910T091738Z&X-Amz-SignedHeaders=host&X-Amz-Expires=600&X-Amz-Credential=ASIAUJB3XFNTHADO4RSB%2F20230910%2Fap-northeast-1%2Fs3%2Faws4_request&X-Amz-Signature=d6ccec15f95d17aee37e68fae6450be61ad289a568167c1cb1de1961a30d7412