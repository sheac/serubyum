require 'serubyum/selenium_server'

module Serubyum
  class Element
    attr_accessor :id, :session

    def initialize(id=nil, session=nil)
      self.id = id
      self.session = session
    end

    def type_into(str)
      # TODO
    end

    def get_text()
      # TODO
    end

    def click()
      # TODO
    end
  end
end