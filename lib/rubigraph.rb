require 'xmlrpc/client'
require 'pp'

#
# Ruby wrapper for Ubigraph.
#
# first, call Rubigraph.init
#
module Rubigraph
  VERSION = '0.1'

  class Vertex
    attr_reader :id

    def initialize(id = nil)
      if id
        @id = Rubigraph.server.call('ubigraph.new_vertex_w_id', id)
      else
        @id = Rubigraph.server.call('ubigraph.new_vertex')
      end
      raise 'Rubigraph::Vertex.initialize: cannot create vertex' if @id == -1
    end

    def remove
      if -1 == Rubigraph.server.call('ubigraph.remove_vertex', @id)
        raise "Rubigraph::Vertex#remove: cannot remove vertex #{@id}"
      end
    end

    def set_attribute(att, value)
      if -1 == Rubigraph.server.call('ubigraph.set_vertex_attribute', @id, att, value)
        raise "Rubigraph::Vertex##{att}=: cannot change #{att} #{@id}"
      end
    end

    def color=(color)
      set_attribute('color', color)
    end

    def colour=(color)
      self.color=(color)
    end

    def shape=(shape)
      set_attribute('shape', shape)
    end
      
    def shapedetail(detail)
      set_attribute('shapedetail', detail)
    end
  end # Vertex

  class Edge
    def initialize(from, to, id = nil)
      if id
        @id = Rubigraph.server.call('ubigraph.new_edge_w_id', id, from.id, to.id)
      else
        @id = Rubigraph.server.call('ubigraph.new_edge', from.id, to.id)
      end
      raise 'Rubigraph::Edge.initialize: cannot create edge' if @id == -1
    end

    def remove
      if -1 == Rubigraph.server.call('ubigraph.remove_edge', @id)
        raise "Rubigraph::Edge#remove: cannot remove edge #{@id}"
      end
    end
  end # Edge


  def self.init(host='127.0.0.1', port='20738')
    @server = XMLRPC::Client.new2("http://#{host}:#{port}/RPC2")
  end

  def self.clear
    @server.call('ubigraph.clear')
  end

  def self.server
    @server
  end
end # Rubigraph
