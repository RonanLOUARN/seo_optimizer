# SeoOptimizer

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/seo_optimizer`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'seo_optimizer'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install seo_optimizer

## Usage

##### Model routes with slug:

To add seo_slug field to a model, you can use the generator as shown below.

Syntax:
*rails g seo_optimizer:my_model field_1 field_2 3 4 5...*

    $ rails generate seo_optimizer:user first_name last_name other_field
    
Then

    $ rails db:migrate    
    
You can override `to_param` method in your model to change your models links pattern

````ruby
class User < ApplicationRecord
  ...
  
  def to_param
    seo_slug
  end
end
````

And then `<%= link_to 'Show', User.first %>` will generate a link that follow the new seo pattern

`/users/USERID-FIELD-FIELD-FIELD`


`/users/1-field_one-field_two-other_field`


So, in your `UsersController`:

```ruby
class UsersController < ApplicationController
  before_action :set_user, only: :show
  
  def show; end

  private

  def set_user
    # we find users by seo_slug field 
    @user = User.find_by(seo_slug: params[:id])
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/seo_optimizer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/seo_optimizer/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SeoOptimizer project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/seo_optimizer/blob/master/CODE_OF_CONDUCT.md).
