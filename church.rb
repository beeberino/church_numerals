module Church
  extend self

  def encode(_num)
    raise ArgumentError.new('not a whole number') unless _num.to_i >= 0
    ->(_proc) { ->(x) { recursively_apply(_num.to_i, x, _proc) } }
  end

  def decode(_proc)
    raise ArgumentError.new('not a proc') unless _proc === Proc
    _proc.call(-> x { x + 1 }).call(0)
  end

  def recursively_apply(_num, x, _proc)
    return x if _num.zero?
    _proc.call(recursively_apply(_num - 1, x, _proc))
  end
end
