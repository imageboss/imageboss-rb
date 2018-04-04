# ImageBoss Helper for Ruby [![Build Status](https://travis-ci.org/imageboss/imageboss-rb.svg?branch=master)](https://travis-ci.org/imageboss/imageboss-rb)

Official Gem for generating ImageBoss URLs.
[https://imageboss.me/](https://imageboss.me/)

## Installation
Add this line to your application's Gemfile:
```
bundle add imageboss-rb
```

Or install it yourself as:

```
gem install imageboss-rb
```

## Usage
### Example `Image Resizing With Cover Operation`
```ruby
client = ImageBoss::Client.new('https://mywebsite.com')

image_url = client.path('/images/img01.jpg')
                  .operation(:cover, width: 100, height: 100)
#=> https://service.imageboss.me/cover/100x100/https://mywebsite.com/images/img01.jpg
```

### Example `Image Resizing With Height Operation`
```ruby
client = ImageBoss::Client.new('https://mywebsite.com')

image_url = client.path('/images/img01.jpg')
                  .operation(:height, height: 100)
#=> https://service.imageboss.me/height/100/https://mywebsite.com/images/img01.jpg
```

### Example `Image Resizing With Extra Options`
```ruby
client = ImageBoss::Client.new('https://mywebsite.com')

image_url = client.path('/images/img01.jpg')
                  .operation(:width, width: 100, options: { grayscale: true })
#=> https://service.imageboss.me/width/100/grayscale:trye/https://mywebsite.com/images/img01.jpg
```
### All operations and options for Image Resizing
It's all available on our [Official Docs](https://imageboss.me/docs).

## Tested on
Ruby
  - 2.5.1
  - 2.4.4
  - 2.3.7
  - 2.2.7
  - 2.1.10

jRuby
  - jruby-9.0.5.0

Rubinius
  - rbx-3.100
