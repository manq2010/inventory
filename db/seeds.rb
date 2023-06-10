require 'update_sale_total'

puts "Seeding database..."

# Admin user
# ----------
ADMIN_FIRST_NAME = "Mancoba"
ADMIN_LAST_NAME = "Sihlongonyane"
ADMIN_EMAIL = "admin@inventory.com"
ADMIN_PHONE = "0123456789"
ADMIN_ROLE = "admin"

admin_user = lambda do
user = User.find_or_initialize_by(
    first_name: ADMIN_FIRST_NAME,
    last_name: ADMIN_LAST_NAME,
    email: ADMIN_EMAIL,
    phone: ADMIN_PHONE
)
    unless user.persisted?
        user.update!(role: ADMIN_ROLE)
    end
    puts "Added/updated admin user."
end

# Owner user
# ----------
OWNER_FIRST_NAME = "James"
OWNER_LAST_NAME = "Bond"
OWNER_EMAIL = "owner@inventory.com"
OWNER_PHONE = "0123456789"
OWNER_ROLE = "owner"

owner_user = lambda do
user = User.find_or_initialize_by(
    first_name: OWNER_FIRST_NAME,
    last_name: OWNER_LAST_NAME,
    email: OWNER_EMAIL,
    phone: OWNER_PHONE
)
    unless user.persisted?
        user.update!(role: OWNER_ROLE)
    end
    puts "Added/updated owner user."
end

# Developer user
# ----------
DEVELOPER_FIRST_NAME = "James"
DEVELOPER_LAST_NAME = "Bond"
DEVELOPER_EMAIL = "developer@inventory.com"
DEVELOPER_PHONE = "0123456789"
DEVELOPER_ROLE = "developer"

developer_user = lambda do
user = User.find_or_initialize_by(
    first_name: DEVELOPER_FIRST_NAME,
    last_name: DEVELOPER_LAST_NAME,
    email: DEVELOPER_EMAIL,
    phone: DEVELOPER_PHONE
)
    unless user.persisted?
        user.update!(role: DEVELOPER_ROLE)
    end
    puts "Added/updated developer user."
end

ActiveRecord::Base.transaction do
    admin_user.call
    owner_user.call
    developer_user.call
end

# Admin user
# ----------
# user = User.create(
# first_name: "James",
# last_name: "Bond",
# email: "jamaes2020@g.com",
# phone: "0123456789"
# )
# User.create(
# first_name: "Juice",
# last_name: "Orange",
# email: "juice2030@g.com",
# phone: "0123456789"
# )
# User.create(
# first_name: "Change",
# last_name: "Nations",
# email: "change2040@g.com",
# phone: "0123456789"
# )

# # Create Items 1 to 3
# item_1 = Item.create(
#   name: "Portable Flush Toilet",
#   buying_price: 180.51,
#   selling_price: 140.21,
#   item_quantity: 15,
#   category: "Toilets"
#   )

# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/Lato-4-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpg", item: item_1)
# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/WhatsApp-Image-2023-04-07-at-18.42.12-q4pew0150u5furh51adsw7o3ujaxurfmctx17tsmpo.jpeg", item: item_1)
# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/IMG-20200421-WA0023-q1kviyhx6ht1wtcj08jlvplcryo51iuen3e0ndmhh8.jpg", item: item_1)

# item_2 = Item.create(
#   name: "Construction None Flush Toilet",
#   buying_price: 270.51,
#   selling_price: 220.21,
#   item_quantity: 25,
#   category: "Toilets"
#   )

# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/Lato-2160-%C3%97-2160-px-1-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpg", item: item_2)
# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/CHILLERS-26-1024x728-1-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg", item: item_2)
# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/WhatsApp-Image-2023-04-07-at-18.42.12-q4pew0150u5furh51adsw7o3ujaxurfmctx17tsmpo.jpeg", item: item_2)

# item_3 = Item.create(
#     name: "2-in-1 toilet",
#     buying_price: 350.51,
#     selling_price: 270.21,
#     item_quantity: 18,
#     category: "Toilets"
#     )

# Image.create(url: " https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/CHILLERS-26-1024x728-1-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg", item: item_3)
# Image.create(url: "https://scontent.fjnb2-1.fna.fbcdn.net/v/t39.30808-6/298683589_10221891685504838_4756938879621764060_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=8bfeb9&_nc_eui2=AeFSw8ieAXdUJOf4AHbWW_yxBqCQ9qK5WYQGoJD2orlZhKaSHMQB2PUyh838XCRzKcaFe8-jstgp5HVd7pd3GPhV&_nc_ohc=wUGTvFa-E6sAX8lWp45&_nc_pt=5&_nc_zt=23&_nc_ht=scontent.fjnb2-1.fna&oh=00_AfCPAi_eXcFu_xbx9sV2c8pctGNNTFMMOIC0tH2b-e2ygQ&oe=64568A12", item: item_3)
# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/IMG-20200421-WA0023-q1kviyhx6ht1wtcj08jlvplcryo51iuen3e0ndmhh8.jpg", item: item_3)


# item_4 = Item.create(
#     name: "4-in-1 toilet",
#     buying_price: 350.51,
#     selling_price: 270.21,
#     item_quantity: 20,
#     category: "Toilets"
#     )

# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/WhatsApp-Image-2021-03-24-at-15.37.25-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg", item: item_4)
# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/WhatsApp-Image-2023-04-07-at-18.42.13-q4pew1wtei80hzeeqb7217711b1oa5n313806dpud8.jpeg", item: item_4)

# item_5 = Item.create(
#     name: "Septic Tank Maintenance",
#     buying_price: 350.51,
#     selling_price: 270.21,
#     item_quantity: 5,
#     category: "Maintenance"
#     )

# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/WhatsApp-Image-2023-04-07-at-18.42.13-q4pew1wtei80hzeeqb7217711b1oa5n313806dpud8.jpeg", item: item_5)
# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/CHILLERS-26-1024x728-1-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg", item: item_5)

# item_6 = Item.create(
#     name: "Mobile Cold Room",
#     buying_price: 350.51,
#     selling_price: 270.21,
#     item_quantity: 14,
#     category: "Cold Room"
#     )

# Image.create(url: "https://s.kwikweb.co.za/swift/photos/Mobile%20cold%20room%202.jpg", item: item_6)
# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/CHILLERS-26-1024x728-1-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg", item: item_6)
# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/CHILLERS-26-1024x728-1-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg", item: item_6)

# item_7 = Item.create(
#     name: "Hand Wash Station",
#     buying_price: 350.51,
#     selling_price: 270.21,
#     item_quantity: 13,
#     category: "Toilets"
#     )

# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/IMG-20200421-WA0023-q1kviyhx6ht1wtcj08jlvplcryo51iuen3e0ndmhh8.jpg", item: item_7)
# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/WhatsApp-Image-2023-04-07-at-18.42.11-q4pevtg9ozwflhqp3pjewrbvou7dcvphzxcmuw2dx8.jpeg", item: item_7)
# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/WhatsApp-Image-2023-04-07-at-18.42.12-q4pew0150u5furh51adsw7o3ujaxurfmctx17tsmpo.jpeg", item: item_7)
# Image.create(url: "https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/WhatsApp-Image-2023-04-07-at-18.42.11-q4pevtg9ozwflhqp3pjewrbvou7dcvphzxcmuw2dx8.jpeg", item: item_7)

# # Create Sales 1 to 3
# sale_1 = Sale.create(
#     name: "Chillers",
#     user: admin
# )

# sale_2 = Sale.create(
#     name: "Wheels",
#     user: admin
# )

# sale_3 = Sale.create(
#     name: "Chillers on Wheels",
#     user: user
# )

# Sale.create(
#     name: "Chillers on Fridge",
#     user: user
# )

# Sale.create(
#     name: "Sandton Spares",
#     user: user
# )

# Sale.create(
#     name: "Midrand Spares",
#     user: user
# )

# Sale.create(
#     name: "Centurion Town",
#     user: user
# )

# Sale.create(
#     name: "CJC Spares",
#     user: user
# )

# Sale.create(
#     name: "Real Data link",
#     user: user
# )

# # Add 2 Items to Sales 1
# sale_1.items << item_1
# sale_1.items << item_2
# item_sale_1 = ItemsSale.find_by(sale_id: sale_1.id, item_id: item_1.id)
# item_sale_1.update(quantity: 5, price: item_1.selling_price)
# item_sale_2 = ItemsSale.find_by(sale_id: sale_1.id, item_id: item_2.id)
# item_sale_2.update(quantity: 1, price: item_2.selling_price)
# update_sale_total(sale_1)

# # Add 1 Item to Sales 2
# sale_2.items << item_3
# item_sale_3 = ItemsSale.find_by(sale_id: sale_2.id, item_id: item_3.id)
# item_sale_3.update(quantity: 7, price: item_3.selling_price)
# update_sale_total(sale_2)

# # Add 2 Items to Sales 3
# sale_3.items << item_1
# sale_3.items << item_2
# item_sale_4 = ItemsSale.find_by(sale_id: sale_3.id, item_id: item_1.id)
# item_sale_4.update(quantity: 10, price: item_1.selling_price)
# item_sale_5 = ItemsSale.find_by(sale_id: sale_3.id, item_id: item_2.id)
# item_sale_5.update(quantity: 1, price: item_2.selling_price)
# update_sale_total(sale_3)

