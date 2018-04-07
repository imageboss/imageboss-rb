# ImageBoss Helper for Ruby
[![Build Status](https://travis-ci.org/imageboss/imageboss-rb.svg?branch=master)](https://travis-ci.org/imageboss/imageboss-rb) [![Gem Version](https://badge.fury.io/rb/imageboss-rb.svg)](https://badge.fury.io/rb/imageboss-rb)

Official Gem for generating ImageBoss URLs.
[https://imageboss.me/](https://imageboss.me/)

**Table of Contents**
- [ImageBoss Helper for Ruby](#imageboss-helper-for-ruby)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Example `Image Resizing With Cover Operation`](#example-image-resizing-with-cover-operation)
    - [Example `Image Resizing With Height Operation`](#example-image-resizing-with-height-operation)
    - [Example `Image Resizing With Extra Options`](#example-image-resizing-with-extra-options)
    - [All operations and options for Image Resizing](#all-operations-and-options-for-image-resizing)
    - [Disabling URL generation](#disabling-url-generation)
  - [Tested on](#tested-on)

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
client = ImageBoss::Client.new(domain: 'https://mywebsite.com')

image_url = client.path('/images/img01.jpg')
                  .operation(:cover, width: 100, height: 100)

#=> https://service.imageboss.me/cover/100x100/https://mywebsite.com/images/img01.jpg
```

### Example `Image Resizing With Height Operation`
```ruby
client = ImageBoss::Client.new(domain: 'https://mywebsite.com')

image_url = client.path('/images/img01.jpg')
                  .operation(:height, height: 100)

#=> https://service.imageboss.me/height/100/https://mywebsite.com/images/img01.jpg
```

### Example `Image Resizing With Extra Options`
```ruby
client = ImageBoss::Client.new(domain: 'https://mywebsite.com')

image_url = client.path('/images/img01.jpg')
                  .operation(:width, width: 100, options: { grayscale: true })

#=> https://service.imageboss.me/width/100/grayscale:true/https://mywebsite.com/images/img01.jpg
```
### All operations and options for Image Resizing
It's all available on our [Official Docs](https://imageboss.me/docs).

### Disabling URL generation
If you are coding on `test`, `development` environments and don't want to send any image to ImageBoss
you can always disable the URL generation and the client will just fallback to the original path provided.

```ruby
client = ImageBoss::Client.new(domain: 'https://mywebsite.com', disabled: true)

image_url = client.path('/images/img01.jpg')
                  .operation(:width, width: 100, options: { grayscale: true })

#=> /images/img01.jpg
```
This will give you the ability to see your image without adding extra code to handle this situation.

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
