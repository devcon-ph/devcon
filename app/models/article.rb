# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  content      :text
#  author_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  slug         :string(255)
#  summary      :text
#  thumbnail    :string(255)
#  published    :boolean          default(FALSE)
#  published_at :datetime
#

include ActionView::Helpers::SanitizeHelper

class Article < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :tags
  has_many :comments, :as => :commentable

  validates :title, :presence => true
  validates :content, :presence => true
  validates :author_id, :presence => true
  validates_presence_of :slug
  validates_uniqueness_of :slug

  default_scope -> { order('articles.created_at DESC') }

  before_validation :generate_slug, :generate_summary

  mount_uploader :thumbnail, ThumbnailUploader
  mount_uploader :opengraph_image, OpengraphUploader

  def generate_slug
    self.slug ||= title.to_slug.normalize.to_s
  end

  def generate_summary
    if self.summary.blank?
      self.summary = strip_tags(content)
    end
  end

  def to_param
    slug
  end

end
