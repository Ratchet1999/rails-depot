Active Record Validations

## [ Validations Overview](https://guides.rubyonrails.org/active_record_validations.html#validations-overview)

Here's an example of a very simple validation:

```ruby
class Person < ApplicationRecord
  validates :name, presence: true
end
```
