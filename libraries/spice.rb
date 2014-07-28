#
# Cookbook Name:: spicerack
# Library:: spice
# Author:: Tejay Cardon <tejay.cardon@gmail.com>
#
# Copyright 2014 Tejay Cardon
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Cardontec
  module Spicerack
    def spice(attributes, component = :default)
      component = component.to_sym

      fetch_spice(attributes, component) || fetch_spice(attributes, :default)
    end

    # Simple Blend
    # Simple Blend will fetch the spices indicated by `attributes` for each component in
    # `components`.  These will all be deep merged on one another.  When elements of the
    # hash cannot be merged (due to incompatible types), then the components listed first
    # in the `components` array will take precedent.
    def simple_blend(attributes, components)
      return nil if components.length == 0
      return spice(attributes, components.first) if components.length == 1

      stuff_to_merge = []

      components.each do |component|
        stuff_to_merge << spice(attributes, component)
      end

      merged = stuff_to_merge.shift

      stuff_to_merge.each do |next_part|
        merged = Chef::Mixin::DeepMerge.merge(merged, next_part)
      end

      merged
    end

    def fetch_spice(attributes, component)
      branch = node['spicerack']
      attributes.each do |next_element|
        if branch.has_key? next_element
          branch = branch[next_element]
        else
          return nil
        end
      end
      branch
    end
  end
end
