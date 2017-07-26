class Post < ApplicationRecord
    belongs_to :user

    has_attached_file :image, styles: { large: "540x540>", medium: "320x320", thumb: "100x100#" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    validates :title, presence: true, length: {minimum: 4, maximum: 24}
    validates :image, presence: true


    has_many :comments, dependent: :destroy

end
