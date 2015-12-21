module page (content, txtsz, pgsize, pgwidth) {
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

    // Create Text
    n = 0;
    for(t = lines) {
        translate([0,pgsize[0]-txtsz*n,pgwidth/2]){
            linear_extrude(height = pgwidth/2) {
                text(text = t, size = txtsz);
            }
        }
        n = n + 1;
    }
}
