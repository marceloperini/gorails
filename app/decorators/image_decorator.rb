class ImageDecorator < Draper::Decorator
  delegate_all

  def album_image
    object.try(:asset).present? ? object.asset.thumb.url : ''
  end
end