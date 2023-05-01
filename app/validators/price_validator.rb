class PriceValidator < ActiveModel::Validator
  def validate(record)
    unless record.price > record.discount_price
      record.errors.add :price, "Discount Price Can't be greater than Original Price!"
    end
  end
end

