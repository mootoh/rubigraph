# Rubigraph

A Ruby wrapper for dynamic visualization library, [Ubigraph](http://www.ubietylab.net/ubigraph).
It provides a shortcut to plot, draw a graph (by calling XML-RPC internally).

See the [Ubigraph API site](http://www.ubietylab.net/ubigraph/content/Docs/index.html) to get complete description about API.

## Example
Make sure Ubigraph serverr is started before using this library.

    require 'rubigraph'
    Rubigraph.init

    v1  = Vertex.new
    v2  = Vertex.new
    e12 = Edge.new(v1, v2)
    
    v1.color  = '#003366'
    v2.shape  = 'sphere'
    e12.label = 'edge between 1 and 2'

## Install

Rubigraph is included in the official [Ubigraph](http://www.ubietylab.net/ubigraph) package. Download Ubigraph and install it.

If you ever want it with your modifications, simply type:

    % gem install rubigraph

## License

The MIT License

    Copyright (c) 2008 mootoh
    
    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    'Software'), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:
    
    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
