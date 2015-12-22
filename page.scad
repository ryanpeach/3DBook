use<./Braille/braille.scad>
include<textdata.txt>;
include<params.txt>;

$fn = 50;

// Create a page
page(pages[0],txtsz,pgsize,pgwidth,true);

module page (lines, txtsz, pgsize, pgwidth, braille) {
    // Create Text

    function loc (i) = [0,pgsize[1]-txtsz*i,pgwidth/2];

    for(n = [0:len(lines)-1]) {
        union() {
        cube([pgsize[0],pgsize[1],pgwidth/2]);
        translate(loc(n)){
            if (!braille) {
                linear_extrude(height = pgwidth/2) {
                    text(lines[n],size=txtsz, valign="top");
                }
            } else {
                rotate([0,0,-90]) braille_str(lines[n], len(lines[n]), pgwidth, txtsz);
            }
        }
    }
    }
}
