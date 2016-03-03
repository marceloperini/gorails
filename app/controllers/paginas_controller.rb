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
        requested_file =  ActionController::Base.helpers.sanitize(params[:pagina])
        
        if File.exist?(Pathname.new(Rails.root + "app/views/paginas/#{requested_file}.html.erb"))
          true
        else
          raise "Unknown file format requested"
        end
      end
end
