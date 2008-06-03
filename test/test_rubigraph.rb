require 'test/unit'
require 'lib/rubigraph'

Rubigraph.init

class RubigraphTest < Test::Unit::TestCase
  def test_clear
    Rubigraph.clear
  end

  def test_vertex
    v = Rubigraph::Vertex.new
    v.set_attribute('size', '2.0')
    v.remove
  end

  def test_edge
    v1 = Rubigraph::Vertex.new
    v2 = Rubigraph::Vertex.new
    e  = Rubigraph::Edge.new(v1, v2)
    e.label = 'edge'
    e.remove
  end

  def test_many
    vs = []
    100.times do |i|
      v = Rubigraph::Vertex.new
      v.color = sprintf("#%02d%02d%02d", i, i, i)
      vs.push v
    end

    100.times do |i|
      e = Rubigraph::Edge.new(vs[i], vs[(i+1)%100])
    end
  end
end
