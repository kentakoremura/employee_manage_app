# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# coding: utf-8

# 店舗登録
@store1 = Store.new(name:"新宿店")
@store1.save
@store2 = Store.new(name:"代々木店")
@store2.save
@store3 = Store.new(name:"原宿店")
@store3.save
@store4 = Store.new(name:"渋谷店")
@store4.save
@store5 = Store.new(name:"恵比寿店")
@store5.save
@store6 = Store.new(name:"目黒店")
@store6.save

(1..100).each do |no|
  if no.even?
    # 偶数
    @sex = "F"
    @birthday_year = 1995
    @join_year = 2016
    @stores = [@store3, @store4]
  else
    # 奇数
    @sex = "M"
    @birthday_year = 1985
    @join_year = 2010
    @stores = [@store1, @store2]
  end
  @employee = Employee.new(name: "スタッフ#{no}",
                           email: "staff#{no}@email.com",
                           password: "123456",
                           sex: @sex,
                           birthday: Date.new(@birthday_year, 5, 1),
                           joinday: Date.new(@join_year, 4, 1))
  @stores.each {|store|
    @employee.responsibles.build({store_id: store.id})
  }
  @employee.save
end
