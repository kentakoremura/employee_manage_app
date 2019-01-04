require 'rails_helper'

RSpec.describe "ログイン機能", type: :System do

  it "ログイン成功" do
    FactoryBot.create(:store01)
    FactoryBot.create(:store02)
    FactoryBot.create(:store03)
    FactoryBot.create(:store04)
    FactoryBot.create(:store05)
    FactoryBot.create(:store06)
    employee = FactoryBot.create :login_employee, :with_default_store
    visit '/login'
    fill_in "Eメール", with: employee.email
    fill_in "パスワード", with: "123456"
    click_button 'login'
    expect(page).to have_content('ログインしました')
  end

  it "ログイン失敗" do
    employee = Employee.create(name: "staff1",
                               email: "staff@email.com",
                               password: "123456",
                               sex: "M")
    visit '/login'
    fill_in "Eメール", with: "staff@email.com"
    fill_in "パスワード", with: "12345"
    click_button 'login'
    expect(page).to have_content('・メールアドレスまたはパスワードが間違っています')
  end

  it "ログアウト" do
    FactoryBot.create(:store01)
    FactoryBot.create(:store02)
    FactoryBot.create(:store03)
    FactoryBot.create(:store04)
    FactoryBot.create(:store05)
    FactoryBot.create(:store06)
    employee = FactoryBot.create :login_employee, :with_default_store
    visit '/login'
    fill_in "Eメール", with: employee.email
    fill_in "パスワード", with: "123456"
    click_button 'login'
    click_link 'sign out'
    expect(page).to have_content('ログアウトしました')
  end

  it "ログインせずに直リンク" do
    visit '/employee/index'
    expect(page).to have_content('ログインしてください')
  end
end
