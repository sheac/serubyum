require "serubyum/version"
require "serubyum/session"
require "serubyum/element"

module Serubyum
  def self.new_session
    return Session.new.connect
  end
end
