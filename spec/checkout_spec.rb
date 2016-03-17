require_relative '../lib/checkout'

describe Checkout do
  it { is_expected.to respond_to :scan }
end
