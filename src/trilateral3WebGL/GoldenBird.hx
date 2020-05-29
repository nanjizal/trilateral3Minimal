package trilateral3WebGL;
// Color pallettes
import pallette.QuickARGB;
import pallette.Gold;
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
import trilateral3WebGL.PathTests; // poly2trihxText

class GoldenBird {
    public function new( pen: Pen ){
        pen.currentColor = periniNavi;
        var sketch = new Sketch( pen, StyleSketch.Fine, StyleEndLine.both );
        sketch.width = 2;
        var scaleTranslateContext = new ScaleTranslateContext( sketch, 0, 0, 1.5, 1.5 );
        var p = new SvgPath( scaleTranslateContext );
        p.parse( bird_d );
        /*
    tess2;
    polyK;
    poly2tri;
        */
        triangulate( pen, sketch, tess2 );
    }
}