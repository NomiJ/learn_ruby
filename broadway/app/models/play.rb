class Play < ApplicationRecord
    has_attached_file :play_img, styles: { :play_index => "100x100>", :play_show => "500x500>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :play_img, content_type: /\Aimage\/.*\z/  
    validates :title, presence: true, length: { minimum: 5}
    validates :description, presence: true
    validates :director, presence: true
    belongs_to :user   
    belongs_to :category
    has_many :reviews
end
