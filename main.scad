use <page.scad>;
//include<.textdata>
include<params.txt>
// Define Content
pages = [["Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Cras pulvinar urna ex, aliquam dignissim massa blandit a."],["Curabitur pellentesque libero enim, in dignissim dolor faucibus sit amet.", "Nunc sit amet metus erat."], ["Curabitur placerat, urna vitae tristique condimentum, magna nisi auctor ligula, non elementum dolor felis id nulla.", "Sed aliquet rutrum fringilla. Nullam lectus tortor, dignissim lobortis suscipit in, elementum eu libero."],["Curabitur placerat, urna vitae tristique condimentum, magna nisi auctor ligula, non elementum dolor felis id nulla.", "Sed aliquet rutrum fringilla. Nullam lectus tortor, dignissim lobortis suscipit in, elementum eu libero."]];

// Calculate the locations of pages
function ploc (i) = [0,0,(len(pages)-i-1)*(pgwidth+pgspace)];

// Create the binding
translate([-bindwidth, 0, -pgwidth]) {
    cube([10,pgsize[1],(pgspace+pgwidth)*(len(pages)+1)]);
}

// Create all pages and translate them
for (p = [0:len(pages)-1]) {
    translate(ploc(p)) {
        page(pages[p],txtsz,pgsize,pgwidth);
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
