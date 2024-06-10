class String
  def to_boolean = ActiveRecord::Type::Boolean.new.cast(self)
  def to_float = to_s.gsub('.', '').gsub(',', '.').to_f
end

class NilClass
  def to_boolean = false
  def to_float = nil
end

class TrueClass
  def to_boolean = true
  def to_i = 1
end

class FalseClass
  def to_boolean = false
  def to_i = 0
end

class Integer
  delegate :to_boolean, :to_float, to: :to_s
end

class Float
  delegate :to_boolean, to: :to_i

  def to_float = self
end

class BigDecimal
  delegate :to_boolean, :to_float, to: :to_f
end

class Symbol
  def to_a = [self]
end
