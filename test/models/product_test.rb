require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
 test 'product attrs must not be empty' do
   product = Product.new
   assert(product.invalid?)
   assert(product.errors[:title].any?)
   assert(product.errors[:description].any?)
   assert(product.errors[:image_url].any?)
   assert(product.errors[:price].any?)
 end
  test 'product price must be positive' do
    product = Product.new(title:"My Book Title", description:'hhhh',image_url:'7aga.png')
    product.price = -1
    assert(product.invalid?)
    assert_equal(["must be greater than or equal to 0.01"],product.errors[:price])
    product.price = 0
    assert(product.invalid?)
    assert_equal(["must be greater than or equal to 0.01"],product.errors[:price])
    product.price = 1
    assert(product.valid?)
  end
def new_product(img_url)
  Product.new(title: "My Book Title", description: "yyy", price: 1, image_url: img_url)
end
  test "image url ends with good values" do
    ok = %w{fred.jpg bla.Jpg FRED.JPG FRED.png FRED.PNG FRED.GIF http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |img_url|
      assert( new_product(img_url).valid?,"#{img_url} should be valid")
    end
    bad.each do |img_url|
      assert(new_product(img_url).invalid?,"#{img_url} should be invalid")
    end
  end
  test 'product not valid without unique title ' do
    product = Product.new(title: products(:ruby).title,
                          description:'kfjfas;lj',price:9.0,
                          image_url:'bla.gif')
    assert product.invalid?
    assert_equal(['has already been taken'],product.errors[:title])
  end
end
