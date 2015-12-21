use<./braille/Braille.scad>

module page (lines, txtsz, pgsize, pgwidth, braille) {
    // Create Text

    function loc (i) = [0,pgsize[1]-txtsz*i,pgwidth/2];

    for(n = [0:len(lines)-1]) {
        //linear_extrude(height = pgwidth/2) {
        //    square(pgsize);
        //}
        translate(loc(n)){
            linear_extrude(height = pgwidth/2) {
                if (!braille) {
                    text(lines[n],size=txtsz, valign="top");
                }
                if (braille) {
                    rotate([90,0,0]) braille_str(lines[n], len(lines[n]));
                }
            }
        }
    }
}
