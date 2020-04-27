# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Dir.glob("app/assets/images/*.jpg").each do |path|
    img_path = path.split("/")
    file_name = img_path.last
    User.create(name: file_name.split(".").first, url: file_name, rating: 1500)
end