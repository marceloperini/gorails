require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it { is_expected.to respond_to :email }
  it { is_expected.to respond_to :first_name }
  it { is_expected.to respond_to :last_name }
  it { is_expected.to respond_to :password }
  it { is_expected.to respond_to :password_confirmation }
  it { is_expected.to respond_to :cpf }
  it { is_expected.to respond_to :nickname }
  it { is_expected.to respond_to :bio }
  it { is_expected.to respond_to :company }
  it { is_expected.to respond_to :gender }
  it { is_expected.to respond_to :schooling }
  it { is_expected.to respond_to :birth_date }
  it { is_expected.to respond_to :marital_status }
  it { is_expected.to respond_to :father }
  it { is_expected.to respond_to :mother }
  it { is_expected.to respond_to :consignor_organ }
  it { is_expected.to respond_to :place_of_birth }
  it { is_expected.to respond_to :special_needs }
  it { is_expected.to respond_to :occupation }
  it { is_expected.to respond_to :rg }
  it { is_expected.to respond_to :address }
  it { is_expected.to respond_to :geography_state_id }
  it { is_expected.to respond_to :neighborhood }
  it { is_expected.to respond_to :zip_code }
  it { is_expected.to respond_to :complement }

  it { is_expected.to be_valid }

  it { is_expected.to have_many(:attachments) }
  it { is_expected.to have_many(:winners) }
  it { is_expected.to have_many(:registrations) }
  it { is_expected.to have_many(:social_networks) }
  it { is_expected.to have_many(:rewards) }

  context "user need certificate" do
    before { user.need_certificate = true }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_presence_of(:rg) }
    it { is_expected.to validate_presence_of(:consignor_organ) }
    it { is_expected.to validate_presence_of(:company) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:celphone) }
    it { is_expected.to validate_presence_of(:schooling) }
    it { is_expected.to validate_presence_of(:birth_date) }
    it { is_expected.to validate_presence_of(:gender) }
    it { is_expected.to validate_presence_of(:marital_status) }
    it { is_expected.to validate_presence_of(:place_of_birth) }
    it { is_expected.to validate_presence_of(:mother) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:neighborhood) }
    it { is_expected.to validate_presence_of(:geography_state_id) }
    it { is_expected.to validate_presence_of(:zip_code) }
    it { is_expected.to validate_presence_of(:special_needs) }
  end

  context "user don't need certificate" do
    before { user.need_certificate = false }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe "when cpf already are taken" do
    before do
      user_with_same_cpf = user.dup
      user_with_same_cpf.cpf = user.cpf
      user_with_same_cpf.save
    end

    it { is_expected.not_to be_valid }
  end

  describe "when cpf are an invalid format" do
    let(:invalid_cpfs) { %w(a2222 2.2.2.2 11111111 633.534.212-22) }

    it "user is not valid" do
      invalid_cpfs.each do |cpf|
        user.cpf = cpf

        expect(user).not_to be_valid
      end
    end
  end

  describe "when user are saved" do
    before { user.save }

    it "generate an authentication_token" do
      expect(user.authentication_token).not_to eq(nil)
    end
  end

  describe "#name" do
    context "when first_name and last_name are present" do
      before do
        user.first_name = "Foo"
        user.last_name = "Bar"
      end

      it "returns ':first_name :last_name'" do
        expect(user.name).to eq("Foo Bar")
      end
    end

    context "when first_name and last_name are empty" do
      before do
        user.first_name = nil
        user.last_name = nil
      end

      it "returns blank" do
        expect(user.name).to eq("")
      end
    end

    context "when only first_name are empty" do
      before { user.first_name = nil }

      it "returns only :last_name" do
        expect(user.name).to eq(user.last_name)
      end
    end

    context "when only last_name are empty" do
      before { user.last_name = nil }

      it "returns only :first_name" do
        expect(user.name).to eq(user.first_name)
      end
    end
  end

  describe "#has_valid_cpf?" do
    context "when cpf are invalid" do
      let(:invalid_cpfs) { %w(a2222 2.2.2.2 11111111 633.534.212-22) }

      it "returns false" do
        invalid_cpfs.each do |cpf|
          user.cpf = cpf

          expect(user.has_valid_cpf?).to eq(false)
        end
      end
    end

    context "when cpf are valid" do
      let(:valid_cpfs) { %w(671.228.448-11 211.531.122-13 731.691.226-06 245.568.131-90) }

      it "returns true" do
        valid_cpfs.each do |cpf|
          user.cpf = cpf

          expect(user.has_valid_cpf?).to eq(true)
        end
      end
    end
  end

  describe "#need_updated_account?" do
    context "when :cpf, :first_name and :last_name aren't nil" do
      before do
        user.cpf = "671.228.448-11"
        user.first_name = "Foo"
        user.last_name = "Bar"
      end

      it { expect(user.need_updated_account?).to eq(false) }
    end

    context "when :cpf or :first_name or :last_name are nil" do
      before do
        user.cpf = nil
        user.first_name = nil
        user.last_name = nil
      end

      it { expect(user.need_updated_account?).to eq(true) }
    end
  end

  describe "#full_name" do
    context "when :first_name are blank" do
      before { user.first_name = " " }

      it { expect(user.full_name).to eq(" " + user.nickname) }
    end

    context "when :last_name are blank" do
      before { user.last_name = " " }

      it { expect(user.full_name).to eq(" " + user.nickname) }
    end

    context "when :first_name and :last_name" do
      before do
        user.first_name = "Foo"
        user.last_name = "Bar"
      end

      it { expect(user.full_name).to eq(" Foo Bar") }
    end
  end

  describe "#event_name" do
    context "when :first_name are blank" do
      before { user.first_name = " " }

      it { expect(user.event_name).to eq(" " + user.nickname) }
    end

    context "when :first_name aren't blank" do
      before { user.first_name = "Foo" }

      it { expect(user.event_name).to eq(" " + user.first_name) }
    end
  end

  describe "#data_completed" do
    context "when all attributes are present" do
      it { expect(user.data_completed).to eq(true) }
    end

    context "when one or more attributes aren't present" do
      before { user.rg = nil }

      it { expect(user.data_completed).to eq(false) }
    end
  end

  describe "#admin?" do
    context "when user have admin role" do
      before { user.add_role(:admin) }

      it { expect(user.admin?).to eq(true) }
    end

    context "when user haven't admin role" do
      it { expect(user.admin?).to eq(false) }
    end
  end
end
