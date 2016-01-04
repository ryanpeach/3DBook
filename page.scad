use<./Braille/braille.scad>
include<.textdata>;
include<params.txt>;

// Create a page
page(pages[0],txtsz,pgsize,pgwidth,braille);

module page (lines, txtsz, pgsize, pgwidth, braille) {
    // Create Text

    function loc (i) = [lmargin,pgsize[1]-(txtsz*(i+.5)),pgwidth/2];

    cube([pgsize[0],pgsize[1],pgwidth/2]);
    color([0,0,0,1]) {
    for(n = [0:len(lines)-1]) {
        translate(loc(n)){
            if (!braille) {
                linear_extrude(height = pgwidth/2) {
                    text(lines[n], size=txtsz, valign="top");
                }
            } else {
                rotate([0,0,-90]) braille_str(lines[n], pgwidth, txtsz);
            }
        }
    }
    }
}
