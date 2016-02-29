class PaginasController < ApplicationController
    def show
      if pagina_valida?
        render template: "paginas/#{params[:pagina]}"
      else
        render file: "public/404.html", status: :not_found
      end
    end

    private
    def pagina_valida?
      File.exist?(Pathname.new(Rails.root + "app/views/paginas/#{params[:pagina]}.html.erb"))
    end
end
