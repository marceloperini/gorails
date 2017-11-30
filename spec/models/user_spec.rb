require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new email: 'foo@bar.com', first_name: 'Foo', last_name: 'Bar',
                     password: '12345678', password_confirmation: '12345678',
                     cpf: '503.887.476-25', nickname: 'foo', bio: 'Foobar Foobar',
                     company: 'Foobar', gender: 'F', job_title: 'Foo Bar',
                     phone: '22222222', celphone: '2222222', schooling: 'Foo',
                     birth_date: Date.today, marital_status: 'S',
                     father: 'Foother', mother: 'Bather', consignor_organ: 'SSP',
                     place_of_birth: 'Foo City', special_needs: 'Foo',
                     occupation: 'Foo', rg: '222222', address: 'Foo',
                     geography_state_id: 'GO', neighborhood: 'Foo',
                     zip_code: '44444444', complement: 'Foobar'
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

  describe 'when authentication_token was generated' do
    before { @user.save }
    it { expect(@user.authentication_token).not_to eq(nil) }
  end
end
