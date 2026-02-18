[![ImageBoss logo](https://img.imageboss.me/boss-images/width/180/emails/logo-2@2x.png)](https://imageboss.me)

# ImageBoss Helper for Ruby
[![CI](https://github.com/imageboss/imageboss-rb/actions/workflows/ci.yml/badge.svg)](https://github.com/imageboss/imageboss-rb/actions/workflows/ci.yml) [![Gem Version](https://badge.fury.io/rb/imageboss-rb.svg)](https://badge.fury.io/rb/imageboss-rb)

Official Gem for Generating ImageBoss URLs.
[https://imageboss.me/](https://imageboss.me/)

**Table of Contents**
- [ImageBoss Helper for Ruby](#imageboss-helper-for-ruby)
  - [Ruby compatibility](#ruby-compatibility)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Example `Image Resizing With Cover Operation`](#example-image-resizing-with-cover-operation)
    - [Example `Image Resizing With Height Operation`](#example-image-resizing-with-height-operation)
    - [Example `Image Resizing With Extra Options`](#example-image-resizing-with-extra-options)
    - [All operations and options for Image Resizing](#all-operations-and-options-for-image-resizing)
    - [Disabling URL generation](#disabling-url-generation)
    - [Signing your URLs](#signing-your-urls)

## Ruby compatibility

- **Required:** Ruby `>= 1.9.0` (see [gemspec](imageboss-rb.gemspec)).
- **Tested in CI:** Latest 2.x and 3.x (Ruby 2.7 and 3.4). Ruby 1.9 is no longer available on current CI runners (see [CI workflow](https://github.com/imageboss/imageboss-rb/actions)).

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
client = ImageBoss::Client.new(source: 'mywebsite')

image_url = client.path('/images/img01.jpg')
                  .operation(:cover, width: 100, height: 100)

#=> https://img.imageboss.me/mywebsite/cover/100x100/images/img01.jpg
```

### Example `Image Resizing With Height Operation`
```ruby
client = ImageBoss::Client.new(source: 'mywebsite')

image_url = client.path('/images/img01.jpg')
                  .operation(:height, height: 100)

#=> https://img.imageboss.me/mywebsite/height/100/images/img01.jpg
```

### Example `Image Resizing With Extra Options`
```ruby
client = ImageBoss::Client.new(source: 'mywebsite')

image_url = client.path('/images/img01.jpg')
                  .operation(:width, width: 100, options: { grayscale: true })

#=> https://img.imageboss.me/mywebsite/width/100/grayscale:true/images/img01.jpg
```

### Supported features (per [ImageBoss docs](https://imageboss.me/docs))

- **Operations:** `cover`, `width`, `height`, `cdn`
- **Cover modes:** `mode: :center`, `:north`, `:entropy`, `:attention`, `:face`, `:smart`, `:contain`, `:inside`, etc.
- **Options** (any doc option via `options: { ... }`): `grayscale`, `blur`, `animation`, `download`, `wmk-path`, `withoutEnlargement`, `ignoreAspectRatio`, `fp-x`, `fp-y`, `fp-z`, `face-index`, `fill-color`, `format:auto`, and all [filters](https://imageboss.me/docs/filters) (extract, privacy, sharpen, trim, gamma, linear, threshold).

### All operations and options for Image Resizing
Full reference: [Official Docs](https://imageboss.me/docs).

### Disabling URL generation
If you are coding on `test`, `development` environments and don't want to send any image to ImageBoss
you can always disable the URL generation and the client will just fallback to the original path provided.

```ruby
client = ImageBoss::Client.new(source: 'mywebsite', enabled: false)

image_url = client.path('/images/img01.jpg')
                  .operation(:width, width: 100, options: { grayscale: true })

#=> /images/img01.jpg
```
This will give you the ability to see your image without adding extra code to handle this situation.

### Signing your URLs
Read more: [Security (signed URLs)](https://imageboss.me/docs/security)

```ruby
client = ImageBoss::Client.new(source: 'mywebsite', secret: '<MY_SECRET>')

image_url = client.path('/images/img01.jpg')
                  .operation(:width, width: 100)

#=> https://img.imageboss.me/width/100/images/img01.jpg?bossToken=ff74a46c7228ee4262c39b8d501c488293c5be9d433bb9ca957f32c9c3d844ab
```
This will give you the ability to see your image without adding extra code to handle this situation.
