# Serubyum

## Selenium + Ruby = Se-Ruby-ummmmmm...

## Usage

Start with a Session, and `go` to the URL you need to test:

```ruby
session = Serubyum.NewSession.go("www.google.com")
```

From here, you can grab the title from the page:

```ruby
# not fetched yet...
session.title
# => nil

title = session.fetch_title
# => "Google"

# fetched!
session.title
# => "Google"
```

Or you can grab an element from the page:

```ruby
element = session.get_element( using: "css selector", value: "input#lst-ib.gsfi" )
```

## Coming Soon!

Click on an element!
```ruby
element.click()
```
