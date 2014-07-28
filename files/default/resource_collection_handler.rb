# lib/chef-handler-collection.rb
#
# Author: Simple Finance <ops@simple.com>
# Copyright 2013 Simple Finance Technology Corporation.
# Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Chef handler to print resource and notification collections; particularly
# useful for debugging recipes.

require 'rubygems'
require 'chef'
require 'chef/handler'

class ChefCollection < Chef::Handler
  attr_reader :resources, :immediate, :delayed, :always

  def initialize(options = defaults)
    @resources = options[:resources]
    @immediate = options[:immediate]
    @delayed = options[:delayed]
    @always = options[:always]
  end

  def defaults
    return {
      :resources => true,
      :immediate => true,
      :delayed => true,
      :always => true
    }
  end

  def log_message
    Chef::Log.info("\n==================== ChefCollection Report =====================\n\n")
    if @resources
      Chef::Log.info(resources_list.join("\n--- "))
    elsif @immediate
      Chef::Log.info(immediate_list.join("\n--- "))
    elsif @delayed
      Chef::Log.info(delayed_list.join("\n--- "))
    else
      return "No parameters enabled; skipping ChefCollection Report"
    end
  end

  def resources_list
    list = run_status.all_resources.collect do |res|
      "#{res.resource_name}[#{res.name}]"
    end
    list.unshift("\n** Resource List **\n\n")
  end

  def immediate_list
    list = run_context.immediate_notification_collection.collect do |notif, vals|
      "#{notif} =>\n  #{vals.join("\n  ")}\n"
    end
    list.unshift("\n** Immediate Notifications List **\n\n#{list}")
  end

  def delayed_list
    list = run_context.delayed_notification_collection.collect do |notif, vals|
      "#{notif} =>\n  #{vals.join("\n  ")}"
    end
    list.unshift("\n** Delayed Notifications List **\n\n#{list}")
  end

  def report
    `echo 'I ran' > /tmp/test`
    log_message
  end
end