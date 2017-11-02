namespace :dev do

  desc "Setup Development"
  task setup: :environment do

    puts "Executando o setup para desenvolvimento"

    puts "Apagando o BD...#{%x(rails db:drop)}"
    puts "Criando o BD...#{%x(rails db:create)}"
    puts %x(rails db:migrate)
    puts %x(rails dev:generate_itens)
    puts %x(rails dev:generate_users)
    puts %x(rails dev:generate_events)
    puts %x(rails dev:generate_posts)
    puts %x(rails dev:generate_socials)

    puts "Setup completado"
  end


  desc "Cria Itens do Game"
  task generate_itens: :environment do
    puts "Cadastrando Itens..."
    10.times do
      Gamification::ItemGroup.create!(
          key: 'human_man',
          name: FFaker::Product.product
      )
    end
    puts "Cadastrando Usuário Adminstrador..."
  end

  desc "Cria Usuários do Sistema"
  task generate_users: :environment do
    puts "Cadastrando Usuário Adminstrador..."

    User.create!(
        nickname: FFaker::Internet.user_name,
        father: FFaker::NameBR.name,
        mother: FFaker::NameBR.name,
        consignor_organ: "AAA",
        place_of_birth: FFaker::AddressBR.country,
        special_needs: FFaker::Skill.tech_skills,
        occupation: FFaker::JobBR.title,
        address: FFaker::AddressBR.full_address,
        uf: FFaker::AddressBR.state_abbr,
        neighborhood: FFaker::AddressBR.neighborhood,
        zip_code: FFaker::AddressBR.zip_code,
        complement: FFaker::AddressBR.secondary_address,
        cpf: FFaker::IdentificationBR.cpf,
        rg: FFaker::IdentificationBR.rg,
        marital_status: FFaker::AddressBR.state,
        birth_date: FFaker::Time.datetime,
        schooling: FFaker::Education.degree,
        celphone: FFaker::PhoneNumberBR.mobile_phone_number,
        job_title: FFaker::JobBR.title,
        phone: FFaker::PhoneNumberBR.phone_number,
        gender: FFaker::Gender.random,
        company: FFaker::Company.name,
        bio: FFaker::Lorem.phrase,
        first_name: FFaker::NameBR.first_name,
        last_name: FFaker::NameBR.last_name,
        email: 'admin@admin.com',
        password: '12345678',
        password_confirmation: '12345678',
        need_certificate: FFaker::Boolean.random
    )

    user_admin = User.last
    user_admin.add_role :admin

    puts "Usuário Adminstrador cadastrado!"

    puts "Cadastrando Usuários comuns..."
    10.times do
      User.create!(
          nickname: FFaker::Internet.user_name,
          father: FFaker::NameBR.name,
          mother: FFaker::NameBR.name,
          consignor_organ: "AAA",
          place_of_birth: FFaker::AddressBR.country,
          special_needs: FFaker::Skill.tech_skills,
          occupation: FFaker::JobBR.title,
          address: FFaker::AddressBR.full_address,
          uf: FFaker::AddressBR.state_abbr,
          neighborhood: FFaker::AddressBR.neighborhood,
          zip_code: FFaker::AddressBR.zip_code,
          complement: FFaker::AddressBR.secondary_address,
          cpf: FFaker::IdentificationBR.cpf,
          rg: FFaker::IdentificationBR.rg,
          marital_status: FFaker::AddressBR.state,
          birth_date: FFaker::Time.datetime,
          schooling: FFaker::Education.degree,
          celphone: FFaker::PhoneNumberBR.mobile_phone_number,
          phone: FFaker::PhoneNumberBR.phone_number,
          job_title: FFaker::JobBR.title,
          gender: FFaker::Gender.random,
          company: FFaker::Company.name,
          bio: FFaker::Lorem.phrase,
          first_name: FFaker::NameBR.first_name,
          last_name: FFaker::NameBR.last_name,
          email: FFaker::Internet.email,
          password: '12345678',
          password_confirmation: '12345678',
          need_certificate: FFaker::Boolean.random
      )
    end

    puts "Usuários Comuns cadastrados!"
  end


  desc "Cria Eventos no Sistema"
  task generate_events: :environment do
    puts "Cadastrando Eventos..."

    5.times do
      start_at = FFaker::Time.datetime
      end_at = start_at + FFaker::Time.datetime
      Event.create!(
          name: FFaker::Conference.name,
          description: FFaker::Lorem.phrases,
          start_at: start_at,
          local: FFaker::AddressBR.full_address,
          participants_limit: Random.rand(10..1000),
          end_at: end_at,
          status: "OK"
      )
    end

    puts "Eventos cadastrados!"
  end

  desc "Cria Postagens no Sistema"
  task generate_posts: :environment do
    puts "Cadastrando Postagem..."

    15.times do
      Blog::Post.create!(
          title: FFaker::Book.title,
          teaser: FFaker::HipsterIpsum.phrase,
          body: FFaker::HipsterIpsum.paragraph,
          draft: FFaker::Boolean.random,
          published_at: FFaker::Time.datetime,
          user_id: User.all.sample.id,
          custom_url: FFaker::Internet.http_url,
          access_count: Random.rand(100..1000000)
      )
    end

    puts "Postagens cadastradas!"
  end


  desc "Cria Redes Sociais no Sistema"
  task generate_socials: :environment do
    puts "Cadastrando Redes Sociais..."

    %w(facebook google+ twitter instagram linkedin snapshat youtube github reddit twitch stackoverflow discord).each do |rede|
      SocialNetworkType.create!(
          name_social_media: rede
      )
    end

    puts "Redes Sociais cadastradas!"
  end

end