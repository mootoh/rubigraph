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
      @id = id ?
        Rubigraph.server.call('ubigraph.new_vertex_w_id', id) :
        Rubigraph.server.call('ubigraph.new_vertex')
      raise 'Rubigraph::Vertex.initialize: cannot create vertex' if @id == -1
    end

    def remove
      if -1 == Rubigraph.server.call('ubigraph.remove_vertex', @id)
        raise "Rubigraph::Vertex#remove: cannot remove vertex #{@id}"
      end
    end

    def set_attribute(att, value)
      if -1 == Rubigraph.server.call('ubigraph.set_vertex_attribute', @id, att, value.to_s)
        raise "Rubigraph::Vertex##{att}=: cannot change #{att} #{@id}"
      end
    end

    def set_attributes(attrs)
      attrs.each do |k, v|
        if -1 == Rubigraph.server.call('ubigraph.set_vertex_attribute', @id, k, v.to_s)
          raise "Rubigraph::Vertex##{k}=: cannot change #{v} #{@id}"
        end
      end
    end

    def color=(c)
      set_attribute('color', c)
    end

    def colour=(c)
      self.color=(c)
    end

    def shape=(s)
      set_attribute('shape', s)
    end
      
    def shapedetail=(d)
      set_attribute('shapedetail', d)
    end

    def label=(l)
      set_attribute('label', l)
    end

    def labelpos=(p)
      set_attribute('labelpos', p)
    end

    def size=(s)
      set_attribute('size', s)
    end

    def fontcolor=(c)
      set_attribute('fontcolor', c)
    end

    def fontfamily=(f)
      # TODO: should assert 'Helvetica' | 'Times Roman'
      set_attribute('fontfamily', f)
    end

    def fontsize=(s)
      # TODO: should assert 10, 12, 18. 24
      set_attribute('fontsize', s)
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

    def set_attribute(att, value)
      if -1 == Rubigraph.server.call('ubigraph.set_edge_attribute', @id, att, value.to_s)
        raise "Rubigraph::edge##{att}=: cannot change #{att} #{@id}"
      end
    end

    def set_attributes(attrs)
      attrs.each do |k, v|
        if -1 == Rubigraph.server.call('ubigraph.set_edge_attribute', @id, k, v.to_s)
          raise "Rubigraph::edge##{k}=: cannot change #{v} #{@id}"
        end
      end
    end

    def color=(c)
      set_attribute('color', c)
    end

    def colour=(c)
      self.color=(c)
    end

    def label=(l)
      set_attribute('label', l)
    end

    def labelpos=(p)
      set_attribute('labelpos', p)
    end

    def fontcolor=(c)
      set_attribute('fontcolor', c)
    end

    def fontfamily=(f)
      # TODO: should assert 'Helvetica' | 'Times Roman'
      set_attribute('fontfamily', f)
    end

    def fontsize=(s)
      # TODO: should assert 10, 12, 18. 24
      set_attribute('fontsize', s)
    end

    def strength=(s)
      set_attribute('strength', s)
    end

    def orientationweight=(o)
      set_attribute('orientationweight', o)
    end

    def width=(w)
      set_attribute('width', w)
    end

    def arrow=(a)
      set_attribute('arrow', a)
    end

    def showstrain=(s)
      set_attribute('showstrain', s)
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
