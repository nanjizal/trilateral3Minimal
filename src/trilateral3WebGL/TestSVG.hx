package trilateral3WebGL;
// Color pallettes
import pallette.QuickARGB;
// SVG path parser
import justPath.*;
import justPath.transform.ScaleContext;
import justPath.transform.ScaleTranslateContext;
import justPath.transform.TranslationContext;
// Sketching
import trilateral3.drawing.StyleEndLine;
import trilateral3.drawing.Sketch;
import trilateral3.drawing.StyleSketch;
import trilateral3.drawing.Fill;
import trilateral3.drawing.Pen;
// SVG paths
import trilateral3WebGL.PathTests;

class TestSVG{
    public function new( pen: Pen ){
        pen.currentColor = Blue;
        cubicSVG( pen );
        pen.currentColor = Blue;
        quadSVG( pen );
    }
    function cubicSVG( pen: Pen ){
        var sketch = new Sketch( pen, StyleSketch.Fine, StyleEndLine.both );
        sketch.width = 20;
        // function to adjust color of curve along length
        sketch.colourFunction = function( colour: Int, x: Float, y: Float, x_: Float, y_: Float ):  Int {
            return Math.round( colour-1*x*y );
        }
        var translateContext = new TranslationContext( sketch, 50, 200 );
        var p = new SvgPath( translateContext );
        p.parse( cubictest_d );
    }
    function quadSVG( pen: Pen ){
        var sketch = new Sketch( pen, StyleSketch.Fine, StyleEndLine.both );
        sketch.width = 5;
        // function to adjust width of curve along length
        sketch.widthFunction = function( width: Float, x: Float, y: Float, x_: Float, y_: Float ): Float{
            return width+0.008*2;
        }
        var translateContext = new TranslationContext( sketch, -100, 300 );
        var p = new SvgPath( translateContext );
        p.parse( quadtest_d );
    }
}