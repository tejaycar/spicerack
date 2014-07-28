require 'pp'

ruby_block 'print spicerack debug attributes' do
  block do
    node[:spicerack][:debug][:attributes].each do |attr|
      pp attr.join('.')
      pp node.debug_value(*attr)
    end
  end
end

