# app/finders/base_finder.rb
class BaseFinder
  def self.method_missing(name, *args, &block)
    new(model.all).send(name, *args, &block)
  end

  def self.model(klass = nil)
    if klass
      @model = klass
    else
      @model
    end
  end

  def initialize(scope)
    @scope = scope
  end

  def paginate(page)
    scope.page page
  end

  private

  attr_reader :scope

  def new(*args)
    self.class.new(*args)
  end
end