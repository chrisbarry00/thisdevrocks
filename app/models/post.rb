class Post < ApplicationRecord
    # Automatically generate a slug from the title before saving
    before_save :generate_slug, if: -> { title.present? && slug.blank? }

    validates :title, presence: true
    validates :content, presence: true

    # Slug generation from title
    def generate_slug
      self.slug = title.parameterize
    end
end
