require "rails_helper"

RSpec.describe User, type: :model do
  before do
    @user = User.new attributes_for(:user)
  end

  subject { @user }

  it { should respond_to :email }
  it { should respond_to :first_name }
  it { should respond_to :last_name }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :cpf }
  it { should respond_to :nickname }
  it { should respond_to :bio }
  it { should respond_to :company }
  it { should respond_to :gender }
  it { should respond_to :schooling }
  it { should respond_to :birth_date }
  it { should respond_to :marital_status }
  it { should respond_to :father }
  it { should respond_to :mother }
  it { should respond_to :consignor_organ }
  it { should respond_to :place_of_birth }
  it { should respond_to :special_needs }
  it { should respond_to :occupation }
  it { should respond_to :rg }
  it { should respond_to :address }
  it { should respond_to :geography_state_id }
  it { should respond_to :neighborhood }
  it { should respond_to :zip_code }
  it { should respond_to :complement }

  it { expect(@user).to be_valid }

  context 'user need certificate' do
    before { @user.need_certificate = true }

    describe "when first_name is not present" do
      before { @user.first_name = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when last_name is not present' do
      before { @user.last_name = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when cpf is not present' do
      before { @user.cpf = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when rg is not present' do
      before { @user.rg = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when consignor_organ is not present' do
      before { @user.consignor_organ = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when company is not present' do
      before { @user.company = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when phone is not present' do
      before { @user.phone = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when celphone is not present' do
      before { @user.celphone = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when schooling is not present' do
      before { @user.schooling = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when birth_date is not present' do
      before { @user.birth_date = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when gender is not present' do
      before { @user.gender = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when marital_status is not present' do
      before { @user.marital_status = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when place_of_birth is not present' do
      before { @user.place_of_birth = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when mother is not present' do
      before { @user.mother = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when address is not present' do
      before { @user.address = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when neighborhood is not present' do
      before { @user.neighborhood = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when geography_state_id is not present' do
      before { @user.geography_state_id = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when zip_code is not present' do
      before { @user.zip_code = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when special_needs is not present' do
      before { @user.special_needs = '' }
      it { expect(@user).not_to be_valid }
    end
  end

  context "user don't need certificate" do
    before { @user.need_certificate = false }

    describe 'when email is not present' do
      before { @user.email = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when password is not present' do
      before { @user.password = '' }
      it { expect(@user).not_to be_valid }
    end

    describe 'when password_confirmation is not present' do
      before { @user.password_confirmation = '' }
      it { expect(@user).not_to be_valid }
    end
  end

  describe "when authentication_token was generated" do
    before { @user.save }
    it { expect(@user.authentication_token).not_to eq(nil) }
  end
end
