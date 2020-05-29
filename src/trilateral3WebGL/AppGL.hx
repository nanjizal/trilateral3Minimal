package trilateral3WebGL;

import kitGL.glWeb.Texture;
import kitGL.glWeb.Shaders;
import kitGL.glWeb.HelpGL;
import kitGL.glWeb.AnimateTimer;
import kitGL.glWeb.BufferGL;
import kitGL.glWeb.DivertTrace;

import trilateral3.Trilateral;
import trilateral3.drawing.Pen;
import trilateral3.geom.FlatColorTriangles;
import trilateral3.drawing.DrawAbstract;
import trilateral3.drawing.ColorAbstract;
import trilateral3.matrix.MatrixDozen;

import js.html.webgl.RenderingContext;
import js.html.webgl.Program;
import geom.matrix.Matrix4x3;
import geom.matrix.Matrix1x4;

function main(){ 
    var divertTrace = new DivertTrace();
    new AppGL( 600, 600 );
}

class AppGL{
    public var mainTexture: Texture;
    public var gl: RenderingContext;
    public var program: Program;
    public var noVertices: Int;
    public var pen: Pen;
    var first: Bool = true;
    static final largeEnough    = 2000000;
    var colorTriangles          = new FlatColorTriangles( largeEnough );
    public
    function new( width: Int, height: Int ){
        trace('AppGL started');
        mainTexture = new Texture();
        mainTexture.create( width, height, true );
        gl = mainTexture.gl;
        setup();
    }
    public inline
    function setup(){
        program = programSetup( gl, vertexString0, fragmentString0 );
        createPen();
        new GoldenBird( pen );
        new TestSVG( pen );
        noVertices = Std.int( colorTriangles.size*3 );
        interleaveXYZ_RGBA( gl
                          , program
                          , colorTriangles.toArray()
                          , 'vertexPosition', 'vertexColor' );
        first = false;
        setAnimate();
    }
    public inline
    function render(){
        if( first == true ) return; // don't draw till setup
        clearAll( gl, mainTexture.width, mainTexture.height );
        gl.useProgram( program );
        gl.drawArrays( RenderingContext.TRIANGLES, 0, noVertices );
    }
    inline
    function setAnimate(){
        AnimateTimer.create();
        AnimateTimer.onFrame = function( v: Int ) render();
    }
    function createPen() {
       var t = colorTriangles;
       @:privateAccess
       var drawAbstract: DrawAbstract = {     triangle:       t.triangle
                                            , transform:      t.transform
                                            , transformRange: t.transformRange
                                            , getTriangle3D:  t.getTriangle3D
                                            , next:           t.next
                                            , hasNext:        t.hasNext
                                            , get_pos:        t.get_pos
                                            , set_pos:        t.set_pos
                                            , get_size:       t.get_size
                                            , set_size:       t.set_size
                                            };
       @:privateAccess
       var colorAbstract: ColorAbstract = {   cornerColors:   t.cornerColors
                                            , colorTriangles: t.colorTriangles
                                            , getTriInt:      t.getTriInt
                                            , get_pos:        t.get_pos
                                            , set_pos:        t.set_pos
                                            , get_size:       t.get_size
                                            , set_size:       t.set_size
                                            };
        pen = new Pen( drawAbstract , colorAbstract );
        Trilateral.transformMatrix = cast scaleToGL();
    }
    function scaleToGL():Matrix4x3{
        var scale = 1/(mainTexture.width);
        var v = new Matrix1x4( { x: scale, y: -scale, z: scale, w: 1. } );
        var m: Matrix4x3 = Matrix4x3.unit;
        return ( Matrix4x3.unit.translateXYZ( -1., 1., 0. ) ).scaleByVector( v );
    }
}