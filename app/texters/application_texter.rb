class ApplicationTexter
  def self.with(params)
    self.new(params)
  end

  def initialize(params)
    @params = params
  end

  def text(to:, content:)
    [to].flatten.each do |phone_number|
      SMSSender.new(phone_number, content).deliver
    end
  end

  private

  attr_reader :params
end
