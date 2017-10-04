class EventDecorator < Draper::Decorator
  delegate_all



  def get_event_cover_image
    if self.albums.first
      self.albums.first.images.first.asset.medium.url
    else
      asset_path "bg-red.jpg"
    end
  end

end