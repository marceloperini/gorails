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
    requested_file = sanitize(params[:pagina])
    if payload =~ /.html.erb$/
      File.exist?(Pathname.new(Rails.root + "app/views/paginas/#{requested_file}.html.erb"))
    else
      raise "Unknown file format requested"
    end
end
