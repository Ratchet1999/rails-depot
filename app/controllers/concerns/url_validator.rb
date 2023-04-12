class UrlValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value =~ IMAGE_URL_REGEX
        record.errors.add(attribute,
          (options[:message] || "is not an approriate Image URL format")
        )
      end
    end
  end