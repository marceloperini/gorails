module ApplicationHelper

  def show_by_file_type(attachment)
    if attachment.present?
      case File.extname(attachment.file.filename)
      when ".doc" 
        link_to attachment.file.filename, attachment.url
      when ".docx"
        link_to attachment.file.filename, attachment.url
      when ".pdf"
        link_to attachment.file.filename, attachment.url
      when ".txt"
        link_to attachment.file.filename, attachment.url
      else
        image_tag attachment.thumb.url
      end
    else
      "Nenhum arquivo cadastrado."
    end
  end
  
   def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
   end

  def flash_error_color(name)
    case name
      when 'success' then '#27ae60'
      when 'error' then '#ae5757'
      when 'alert'  then '#edc613 '
      when 'notice'  then '#27ae60'
      else name
    end
  end


  def flash_message_title(name)
    case name
      when 'success' then 'Sucesso'
      when 'error' then 'Atenção'
      when 'alert'  then 'Atenção '
      when 'notice'  then 'Atenção'
      else name
    end
  end



end

