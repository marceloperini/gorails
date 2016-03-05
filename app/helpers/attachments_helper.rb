module AttachmentsHelper

  def show_by_file_type(attachment, type)
    case File.extname(type)
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
  end
end