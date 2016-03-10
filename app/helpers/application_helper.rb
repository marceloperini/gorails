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
end