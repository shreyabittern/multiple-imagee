class Post < ApplicationRecord
belongs_to :user
has_many :post_attachments
     accepts_nested_attributes_for :post_attachments
end
