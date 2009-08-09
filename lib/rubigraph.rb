require 'xmlrpc/client'
require 'pp'
require 'thread'

#
# Ruby wrapper for Ubigraph.
#
# Call Rubigraph.init at first.
#
module Rubigraph
  VERSION = '0.2.0'

  class Vertex
    attr_reader :id

    def initialize(id = Rubigraph.genid)
      @id = id
      Rubigraph.call('ubigraph.new_vertex_w_id', id)
    end

    def remove
      Rubigraph.call('ubigraph.remove_vertex', @id)
    end

    def set_attribute(att, value)
      Rubigraph.call('ubigraph.set_vertex_attribute', @id, att, value.to_s)
    end

    def set_attributes(attrs)
      attrs.each do |k, v|
        Rubigraph.call('ubigraph.set_vertex_attribute', @id, k, v.to_s)
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

  # Edge between Vertexes
  class Edge
    # create an Edge.
    # from, to should be Vertex.
    def initialize(from, to, id = Rubigraph.genid)
      @id = id
      Rubigraph.call('ubigraph.new_edge_w_id', id, from.id, to.id)
    end

    def remove
      Rubigraph.call('ubigraph.remove_edge', @id)
    end

    def set_attribute(att, value)
      Rubigraph.call('ubigraph.set_edge_attribute', @id, att, value.to_s)
    end

    def set_attributes(attrs)
      attrs.each do |k, v|
        Rubigraph.call('ubigraph.set_edge_attribute', @id, k, v.to_s)
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


  # initialize XML-RPC client
  def self.init(host='127.0.0.1', port='20738',ttl=1)
    @server = XMLRPC::Client.new2("http://#{host}:#{port}/RPC2")
    @mutex  = Mutex.new
    @pool   = Array.new
    @num    = -1 * (1 << 31) - 1 # XMLPRC i4's minimum
    @flusher = Thread.start(ttl) do |ttl|
      while true do
        sleep ttl
        flush!
      end
    end
    at_exit { flush! }
  end

  # clear all vertex, edges
  def self.clear
    call('ubigraph.clear')
    flush!
  end

  def self.flush!
    @mutex.synchronize {
      @server.multicall(*@pool)
      @pool.clear
    }
  end

  def self.genid
    @mutex.synchronize {
      @num += 1
    }
    @num
  end

  def self.call(*argv)
    @mutex.synchronize {
      @pool.push argv
    }
    flush! if @pool.size >= 256
  end
end # Rubigraph
