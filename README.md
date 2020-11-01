# Seo Optimizer

Seo Optimizer provides a set of helpers which guide you in SEO improvements.

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

#### Sitemap.yml, robots.txt

There is a generator and a task to create needed files that will be read by search engines robots.

**1** - Setup (it add a new config variable in `application.rb`)

```bash
$ rails g seo_optimizer:setups
```    
**2** - Replace the default value of product_url in `application.rb`  

```ruby
config.sitemap_config_variable = {}
config.sitemap_config_variable[:production_url] = 'https://YOUR-PRODUCTION-URL.com'
```

**3** - Generate robots files (this will create sitemap.yml, robots.txt routes/actions/views)

```bash
$ rails g seo_optimizer:robots_files
```

**4** - Edit sitemap generate task `lib/tasks/sitemap/generate.rake` to add your customs routes like resources CRUD 
    routes etc, check the section below for more informations or check sitemap_generator 
    doc (https://github.com/kjvarga/sitemap_generator).

**5** - Generate the sitemap.xml
```bash
$ rails sitemap:generate
```
**Existing routes will be generated in sitemap by default.**

Then you can check these urls: 

robots.txt file: http://localhost:3000/robots.txt  
sitemap.xml file: http://localhost:3000/sitemap.xml  

_________________

#### Model routes with slug:

To add seo_slug field to a model, you can use the generator as shown below.

**1** - Syntax:
`rails g seo_optimizer:my_model field_1 field_2 3 4 5...`

    $ rails generate seo_optimizer:user first_name last_name other_field
    
**2** - Migrate

    $ rails db:migrate    
    
**3** - Override `to_param` method in your model to change your models links pattern

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


**4** - So, in your `UsersController`:

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

**5** - You can update the sitemap task to add every routes with slugs in it.

- In `SitemapGenerator::Sitemap.create` block

```ruby
SitemapGenerator::Sitemap.create do
  ...
  User.select(:seo_slug, :updated_at).each do |slug|
    add user_path(slug), lastmod: slug.updated_at, priority: 0.8
  end
end
```

- Then don't forget to `$ rails sitemap:generate`.

______________

#### Error pages (404, 500):
 
**1** - Generate error pages view, actions and routes.
```bash
$ rails g seo_optimizer:errors_pages
```

**2** - You can customize pages in `app/views/errors/`

**3** - Edit `config/environment/develoment.rb` if you want to test it in dev environment.

⛔️ DO NOT COMMIT ⛔️

```ruby
config.consider_all_requests_local = true
# to 
config.consider_all_requests_local = false 
```
_________________
 
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/seo_optimizer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/seo_optimizer/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SeoOptimizer project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/seo_optimizer/blob/master/CODE_OF_CONDUCT.md).
