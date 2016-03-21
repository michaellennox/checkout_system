# Checkout System

A simple checkout system that calculates the cost of a basket and applies any special discounts or pricing rules which are required for that order.

## Installation Instructions

You will require [Ruby](https://www.ruby-lang.org/en/downloads/) installed to use this program.

Clone down from github, cd into the directory and install all dependencies. If you don't have bundler installed you will have to do so with `gem install bundle`.

```
$ git@github.com:michaellennox/checkout_system.git
$ cd checkout_system
$ bundle install
```

## Usage Instructions

The system can be run from a REPL such as irb or pry. To open irb enter `$ irb` while in the project root directory.

```ruby
$ irb

# First of all you will need to import checkout and item files from lib,
# This will import all the classes required to run the system
require_relative 'lib/checkout'
require_relative 'lib/item'

# You will also need to require any discounts you plan to use in your system,
# These are stored in lib/discounts
require_relative 'lib/discounts/item_discount'
require_relative 'lib/discounts/percent_discount'

# To build your catalog, create Item objects representing each item in the catalog,
# The item takes 3 arguments, the code as a string, the name as a string
# and the price as an integer in pennies
item_001 = Item.new('001', 'Lavender heart', 925)
item_002 = Item.new('002', 'Personalised cufflinks', 4500)
item_003 = Item.new('003', 'Kids T-shirt', 1995)

# Store these items in an array to be used by the system
products = [item_001, item_002, item_003]

# You will then need to build any promotional rules you need to apply,
# Two constructors are provided for your convenience, PercentDiscount and ItemDiscount

# To build a percentage discount initialize PercentDiscount with two arguments,
# The first is the percentage you want to discount the order by
# The second is the minimum value the order must meet to receive the discount in pennies

# For example, we want to apply a 10% discount to orders over £60 (6000p)
ten_percent_discount = PercentDiscount.new(10, 6000)

# To build a discount for ordering a certain number of items initialize ItemDiscount with three arguments,
# The first is the item code which the discount is applicable for
# The second is the minimum number of items required to qualify for a discount
# The third is the amount to be discounted from each item in pennies if it qualifies

# For example, here we want to apply a 75p discount on each Lavender Heart when you order 2 or more
lavender_heart_discount = ItemDiscount.new("001", 2, 75)

# You can then store these in an array to be injected into the system,
# Please note the order you arrange items in that array,
# The discounts run sequentially from start to end,
# So if you need to apply one discount before another make sure it is earlier

pricing_rules = [lavender_heart_discount, ten_percent_discount]

# To initialize the system pass pricing_rules and products as arguments
# pricing_rules is a standard argument, products is a keyword argument

checkout = Checkout.new(pricing_rules, products: products)

# You can then use your checkout to calculate the price of a basket
# The checkout has two methods,
# #scan => this takes the key code of the item as a string and adds it to your basket
# #total => this returns the cost of the current basket as a string in pounds

# For example here's a basket which takes advantage of both rules we built
checkout.scan '001'
checkout.scan '002'
checkout.scan '001'
checkout.scan '003'

price = checkout.total
price # => '£73.76'
```

## Future Improvements

* Right now products are being represented as an array of Items and then injected into the system. In a real system these would be held as a table in a database and accessed that way.
* Order is being represented by a Hash within Checkout. This could be extracted to an in memory datastore such as redis.

## Running Tests

To run the test suite, simply run rspec from the root directory.

```
$ rspec
```

## Brief

Our client is an online marketplace, here is a sample of some of the products available on our site:

Product code | Name | Price
-------------|------|------
001 | Lavender heart | £9.25
002 | Personalised cufflinks | £45.00
003 | Kids T-shirt | £19.95

Our marketing team want to offer promotions as an incentive for our customers to purchase these items.

* If you spend over £60, then you get 10% of your purchase
* If you buy 2 or more lavender hearts then the price drops to £8.50.

Our check-out can scan items in any order, and because our promotions will change, it needs to be
flexible regarding our promotional rules.

The interface to our checkout looks like this (shown in Ruby):

```ruby
co = Checkout.new(promotional_rules)
co.scan(item)
co.scan(item)
price = co.total
```

Implement a checkout system that fulfill’s these requirements.

Test data:

* Basket: 001,002,003
  Total price expected: £66.78
* Basket: 001,003,001
  Total price expected: £36.95
* Basket: 001,002,001,003
  Total price expected: £73.76
