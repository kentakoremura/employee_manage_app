require 'rails_helper'

RSpec.describe Employee, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  it "必須項目に全てデータが設定されていれば有効な状態であること" do
    employee = Employee.new(name: "staff1",
                            email: "staff@email.com",
                            password: "123456",
                            sex: "M")
    expect(employee).to be_valid
  end
  it "名前が未設定ならば無効な状態であること" do
    employee = Employee.new(name: nil,
                            email: "staff@email.com",
                            password: "123456",
                            sex: "M")
    employee.valid?
    expect(employee.errors[:name]).to include("を入力してください")
  end
  it "名前が30文字を超えたならば無効な状態であること" do
    employee = Employee.new(name: "0123456789012345678901234567890",
                            email: "staff@email.com",
                            password: "123456",
                            sex: "M")
    employee.valid?
    expect(employee.errors[:name]).to include("は30文字以内で入力してください")
  end
  it "Eメールが未設定ならば無効な状態であること" do
    employee = Employee.new(name: "staff1",
                            email: nil,
                            password: "123456",
                            sex: "M")
    employee.valid?
    expect(employee.errors[:email]).to include("を入力してください")
  end
  it "Eメールが重複するならば無効な状態であること" do
    Employee.create(name: "staff1",
                    email: "staffemail.com",
                    password: "123456",
                    sex: "M")
    employee = Employee.new(name: "staff1",
                            email: "staffemail.com",
                            password: "123456",
                            sex: "M")
    employee.valid?
    expect(employee.errors[:email]).to include("は不正な値です")
  end
  it "Eメールのフォーマットが不正ならば無効な状態であること" do
    employee = Employee.new(name: "staff1",
                            email: "staffemail.com",
                            password: "123456",
                            sex: "M")
    employee.valid?
    expect(employee.errors[:email]).to include("は不正な値です")
  end
  it "パスワードが未設定ならば無効な状態であること" do
    employee = Employee.new(name: "staff1",
                            email: "staff@email.com",
                            password: nil,
                            sex: "M")
    employee.valid?
    expect(employee.errors[:password]).to include("を入力してください")
  end
  it "パスワードの文字数が６文字未満ならば無効な状態であること" do
    employee = Employee.new(name: "staff1",
                            email: "staff@email.com",
                            password: "1234",
                            sex: "M")
    employee.valid?
    expect(employee.errors[:password]).to include("は6文字以上で入力してください")
  end
  it "性別が未設定ならば無効な状態であること" do
    employee = Employee.new(name: "staff1",
                            email: "staff@email.com",
                            password: "123456",
                            sex: nil)
    employee.valid?
    expect(employee.errors[:sex]).to include("を入力してください")
  end
  it "性別が不正ならば無効な状態であること" do
    employee = Employee.new(name: "staff1",
                            email: "staff@email.com",
                            password: "123456",
                            sex: "S")
    employee.valid?
    expect(employee.errors[:sex]).to include("は一覧にありません")
  end
  it "生年月日が現在日付より未来ならば無効な状態であること" do
    employee = Employee.new(name: "staff1",
                            email: "staff@email.com",
                            password: "123456",
                            sex: "M",
                            birthday: "2030/12/01")
    employee.valid?
    expect(employee.errors[:birthday]).to include("は本日より以前を指定してください。")
  end
  it "入社日が現在日付より未来ならば無効な状態であること" do
    employee = Employee.new(name: "staff1",
                            email: "staff@email.com",
                            password: "123456",
                            sex: "M",
                            joinday: "2030/12/01")
    employee.valid?
    expect(employee.errors[:joinday]).to include("は本日より以前を指定してください。")
  end
  it "生年月日から年齢に正常に変換されること" do
    employee = Employee.new(name: "staff1",
                            email: "staff@email.com",
                            password: "123456",
                            sex: "M",
                            birthday: "1998/12/01")
    expect(employee.age).to eq (20)
  end
  it "入社日から勤続年数に正常に変換されること" do
    employee = Employee.new(name: "staff1",
                            email: "staff@email.com",
                            password: "123456",
                            sex: "M",
                            joinday: "1998/12/01")
    expect(employee.working).to eq (20)
  end
end
