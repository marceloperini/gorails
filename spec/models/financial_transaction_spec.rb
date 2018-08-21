# == Schema Information
#
# Table name: financial_transactions
#
#  id                 :bigint(8)        not null, primary key
#  object             :string
#  origin             :string
#  transaction_type   :string(1)
#  value              :decimal(13, 2)
#  user_id            :bigint(8)
#  payment_date       :datetime
#  payment_method     :string
#  consolidated       :boolean          default(FALSE), not null
#  consolidation_date :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_financial_transactions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require "rails_helper"

RSpec.describe FinancialTransaction, type: :model do
  subject(:financial_transaction) { build(:financial_transaction) }

  it { is_expected.to respond_to(:object) }
  it { is_expected.to respond_to(:origin) }
  it { is_expected.to respond_to(:transaction_type) }
  it { is_expected.to respond_to(:value) }
  it { is_expected.to respond_to(:payment_date) }
  it { is_expected.to respond_to(:payment_method) }
  it { is_expected.to respond_to(:consolidated) }
  it { is_expected.to respond_to(:consolidation_date) }

  it { is_expected.to be_valid }

  it { is_expected.to have_many(:attachments) }

  it { is_expected.to belong_to(:user) }

  describe ".income" do
    before do
      create_list(:financial_transaction, 2, transaction_type: "I", consolidated: true, value: 1)
      create_list(:financial_transaction, 2, transaction_type: "I", consolidated: false, value: 3)
    end

    context "when passes true to param" do
      it "should returns the sum of consolidated incoming value" do
        expect(FinancialTransaction.income(true)).to eq(2)
      end
    end

    context "when passes false to param" do
      it "should returns the sum of unconsolidated incoming value" do
        expect(FinancialTransaction.income(false)).to eq(6)
      end
    end
  end

  describe ".outcome" do
    before do
      create_list(:financial_transaction, 2, transaction_type: "O", consolidated: true, value: 1)
      create_list(:financial_transaction, 2, transaction_type: "O", consolidated: false, value: 3)
    end

    context "when passes true to param" do
      it "should returns the sum of consolidated outcoming value" do
        expect(FinancialTransaction.outcome(true)).to eq(2)
      end
    end

    context "when passes false to param" do
      it "should returns the sum of unconsolidated outcoming value" do
        expect(FinancialTransaction.outcome(false)).to eq(6)
      end
    end
  end

  describe ".balance" do
    before do
      create_list(:financial_transaction, 3, transaction_type: "I", consolidated: true, value: 1)
      create_list(:financial_transaction, 2, transaction_type: "O", consolidated: true, value: 1)
    end

    it "should returns the value of (.income - .outcome)" do
      expect(FinancialTransaction.balance).to eq(1)
    end
  end

  describe ".balance_after_consolidated" do
    before do
      create_list(:financial_transaction, 3, transaction_type: "I", consolidated: true, value: 1)
      create_list(:financial_transaction, 2, transaction_type: "I", consolidated: false, value: 1)

      create_list(:financial_transaction, 1, transaction_type: "O", consolidated: true, value: 1)
      create_list(:financial_transaction, 1, transaction_type: "O", consolidated: false, value: 1)
    end

    it "should returns the balance of consolided and unconsolidated values" do
      expect(FinancialTransaction.balance_after_consolidated).to eq(3)
    end
  end

  describe "#user_name" do
    context "when user are present" do
      let(:user) { create(:user) }

      before { financial_transaction.user = user }

      it "should be the correct user name" do
        expect(financial_transaction.user_name).to eq(user.decorate.name)
      end
    end

    context "when user aren't present" do
      before { financial_transaction.user = nil }

      it { expect(financial_transaction.user_name).to be_nil }
    end
  end
end
