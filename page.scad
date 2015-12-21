module page (content, txtsz, pgsize, pgwidth, pgnum, totalpages) {
    // Splice Content into lines
    length = len(content);
    c = 0; start = 0;
    CMAX = 100;

    lines = []
    while(c < length) {
        start = c;
        if(c+CMAX <= length) {
            // Move to nearest space.
            while(content[c+CMAX]!=' ') {
                c++;
            }
        }
        line = content[start:c];
        lines = concat(lines,line);
    }

    union() {
        // Elevate all to the proper page number.
        translate([0,0,(totalpages-pgnum)*pgwidth]) {
            // Create Page
            linear_extrude(height = pgwidth/2) {
                square(pgsize);
            }

            // Create Text
            n = 0;
            for(t = lines) {
                translate([0,279-sz*n,pgwidth/2]){
                    linear_extrude(height = pgwidth/2) {
                        text(text = t, size = txtsz);
                    }
                }
                n = n + 1;
            }
        }
    }
}
