require 'rails_helper'

RSpec.describe "社員登録機能", type: :System do
  # 共通処理 ログイン
  before do
    FactoryBot.create(:store01)
    FactoryBot.create(:store02)
    FactoryBot.create(:store03)
    FactoryBot.create(:store04)
    FactoryBot.create(:store05)
    FactoryBot.create(:store06)
    @employee = FactoryBot.create :login_employee, :with_default_store
    visit '/login'
    fill_in 'Eメール', with: @employee.email
    fill_in 'パスワード', with: '123456'
    click_button 'login'
  end

  describe "新規登録" do

    it "画面表示" do
      click_link '新規作成'
      expect(page).to have_content('新規作成')
    end

    it "新規登録 成功" do
      click_link '新規作成'
      fill_in '名前', with: 'staff2'
      fill_in 'Eメール', with: 'staff2@email.com'
      fill_in 'パスワード', with: '123456'
      choose 'employee_sex_m'
      check "employee_store_ids_1"
      check "employee_store_ids_2"
      click_button '登録'
      expect(page).to have_content('新規作成しました')
    end

    it "新規登録 失敗" do
      click_link '新規作成'
      fill_in 'Eメール', with: 'staff2@email.com'
      fill_in 'パスワード', with: '123456'
      choose 'employee_sex_m'
      check "employee_store_ids_1"
      check "employee_store_ids_2"
      click_button '登録'
      expect(page).to have_content('名前を入力してください')
    end
  end

  describe "変更登録" do

    it "画面表示" do
      click_link '編集'
      expect(page).to have_content('編集')
    end

    it "変更登録 成功" do
      click_link '編集'
      fill_in '名前', with: 'staff_update'
      fill_in 'Eメール', with: 'staff_update@email.com'
      fill_in 'パスワード', with: '123456'
      click_button '変更'
      expect(page).to have_content('変更しました')
    end

    it "変更登録 失敗" do
      click_link '編集'
      fill_in '名前', with: ''
      click_button '変更'
      expect(page).to have_content('名前を入力してください')
    end
  end

  it "削除" do
    click_link '削除'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content('削除しました')
  end

  describe "検索" do

    before do
      FactoryBot.create :employee, :male, :with_default_store
      FactoryBot.create :employee, :female, :with_default_store
    end

    it "名前で絞り込み" do
      click_link '一覧'
      fill_in '名前', with: 'searchStaff1'
      click_button '検索'
      expect(page).to have_content('1件の社員が表示されています')
    end

    it "性別で絞り込み" do
      click_link '一覧'
      choose 'q_sex_eq_m'
      click_button '検索'
      expect(page).to have_content('2件の社員が表示されています')
    end

    it "全件検索" do
      click_link '一覧'
      click_button '検索'
      expect(page).to have_content('3件の社員が表示されています')
    end
  end
end
