use <page.scad>;
use <./String/string.scad>
//include<.textdata>
include<params.txt>
// Define Content
pages = [["Lorem ipsum dolor sit amet, consectetur adipiscing elit."]];

// Calculate the locations of pages
function ploc (i) = [0,0,(len(pages)-i-1)*(pgwidth+pgspace)];

// Create the binding
translate([-bindwidth, 0, -pgwidth]) {
    cube([10,pgsize[1],(pgspace+pgwidth)*(len(pages)+1)]);
}

// Create all pages and translate them
for (p = [0:len(pages)-1]) {
    translate(ploc(p)) {
        page(pages[p],txtsz,pgsize,pgwidth,true);
    }

    // Create the filler material
    /*difference() {
        translate([0,0,pgwidth/2]) {
            linear_extrude(height = pgwidth/2+pgspace) {
                square(pgsize);
            }
            translate([0,0,pgwidth/2]) {
                page(content,txtsz,pgsize,pgwidth);
            }
        }
    }*/
}
