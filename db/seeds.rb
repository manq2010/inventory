require 'update_sale_total'

# Create Users
admin = User.create(name: "admin")
user = User.create(name: "test")

# Create Items 1 to 3
item_1 = Item.create(
  name: "4-in-1 toilet",
  buying_price: 180.51,
  selling_price: 140.21,
  item_quantity: 15,
  category: "Toilets"
  )

Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/WhatsApp-Image-2021-03-24-at-15.37.25-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg", item: item_1)
Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/CHILLERS-26-1024x728-1-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg", item: item_1)

item_2 = Item.create(
  name: "2-in-1 toilet",
  buying_price: 270.51,
  selling_price: 220.21,
  item_quantity: 15,
  category: "Toilets"
  )

Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/WhatsApp-Image-2021-03-24-at-15.37.25-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg", item: item_2)
Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/CHILLERS-26-1024x728-1-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg", item: item_2)

item_3 = Item.create(
    name: "7-in-1 toilet",
    buying_price: 350.51,
    selling_price: 270.21,
    item_quantity: 13,
    category: "Toilets"
    )

Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/WhatsApp-Image-2021-03-24-at-15.37.25-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg", item: item_3)
Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/CHILLERS-26-1024x728-1-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg", item: item_3)

# Create Sales 1 to 3
sale_1 = Sale.create(
    name: "Chillers",
    user: admin
)

sale_2 = Sale.create(
    name: "Wheels",
    user: admin
)

sale_3 = Sale.create(
    name: "Chillers on Wheels",
    user: user
)

# Add 2 Items to Sales 1
sale_1.items << item_1
sale_1.items << item_2
item_sale_1 = ItemsSale.find_by(sale_id: sale_1.id, item_id: item_1.id)
item_sale_1.update(quantity: 5, price: item_1.selling_price)
item_sale_2 = ItemsSale.find_by(sale_id: sale_1.id, item_id: item_2.id)
item_sale_2.update(quantity: 1, price: item_2.selling_price)
update_sale_total(sale_1)

# Add 1 Item to Sales 2
sale_2.items << item_3
item_sale_3 = ItemsSale.find_by(sale_id: sale_2.id, item_id: item_3.id)
item_sale_3.update(quantity: 7, price: item_3.selling_price)
update_sale_total(sale_2)

# Add 2 Items to Sales 3
sale_3.items << item_1
sale_3.items << item_2
item_sale_4 = ItemsSale.find_by(sale_id: sale_3.id, item_id: item_1.id)
item_sale_4.update(quantity: 10, price: item_1.selling_price)
item_sale_5 = ItemsSale.find_by(sale_id: sale_3.id, item_id: item_2.id)
item_sale_5.update(quantity: 1, price: item_2.selling_price)
update_sale_total(sale_3)
