require 'rails_helper'

RSpec.describe Store, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  it "必須項目に全てデータが設定されていれば有効な状態であること" do
    store = Store.new(name: "東京")
    expect(store).to be_valid
  end
  it "名前が未設定ならば無効な状態であること" do
    store = Store.new(name: nil)
    store.valid?
    expect(store.errors[:name]).to include("を入力してください")
  end
end
