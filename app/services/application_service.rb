class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end
  def  call
    raise NotImplementedError
  end

  def initialize(*args, &block)
    @args = args
  end
end
