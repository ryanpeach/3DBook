use <page.scad>;
use <./String/string.scad>;
include<.textdata>;
include<params.txt>;

// Calculate the locations of pages
function ploc (i) = [0,0,(len(pages)-i-1)*(pgwidth+pgspace)];
bookh = (pgwidth+pgspace)*len(pages);

// Create the binding
union() {
    if (!rings) {
        union() {
            if(titlep) {
                translate([-bindwidth, 0, -pgwidth*3]) {
                    cube([10,pgsize[1],(pgspace+pgwidth)*(len(pages)+3)]);
                }
                createTitle(titles);
            } else {
                translate([-bindwidth, 0, -pgwidth]) {
                    cube([10,pgsize[1],(pgspace+pgwidth)*(len(pages)+1)]);
                }
            }
            createall();
        }
    } else {
        loc1 = [lmargin/2,pgsize[1]/6*1,-bookh];
        loc2 = [lmargin/2,pgsize[1]/6*3,-bookh];
        loc3 = [lmargin/2,pgsize[1]/6*5,-bookh];
        ringsize = lmargin/4;
        difference() {
            group () {
                createall();
                echo(titles);
                if(titlep){createTitle(titles);}            
            }
            translate(loc1) {cylinder(bookh*3,ringsize,ringsize);}
            translate(loc2) {cylinder(bookh*3,ringsize,ringsize);}
            translate(loc3) {cylinder(bookh*3,ringsize,ringsize);}
        }
        rtot=5;
        translate([-rtot+ringsize/2,loc1[1],0]){
            sqrings(ringsize/2,rtot);
        }
        translate([-rtot+ringsize/2,loc2[1],0]){
            sqrings(ringsize/2,rtot);
        }
        translate([-rtot+ringsize/2,loc3[1],0]){
            sqrings(ringsize/2,rtot);
        }
        
    }
}

module createall() {
    // Create all pages and translate them
    for (p = [0:len(pages)-1]) {
        translate(ploc(p)) {
            page(pages[p],txtsz,pgsize,pgwidth,braille);
        }
        echo("Page ", p+1, " of ", len(pages));
    }
}

module createTitle(s) {
    // Center the text
    CHARMAX = pgsize[0]/txtsz;
    before = (CHARMAX-len(s))/2; echo(CHARMAX);
    out = s;
    
    echo(out);
    
    translate([0,0,bookh]) {
            page(["","",str(out)],txtsz,pgsize,pgwidth*3,braille);
    }
    translate([0,0,-pgwidth*3]) {
            page([""],txtsz,pgsize,pgwidth*3,braille);
    }
}

module sqrings(rin,rtot) {
    Hout = bookh+rin*2+(pgwidth+pgspace)*5;;
    Hin = Hout-rin*2;
    translate([-rin*2,-rin,-rin-(pgwidth+pgspace)*3]) {
        difference() {
            cube([rtot*2+rin*4,rin*2,Hout]);
            translate([rin,-rin,rin]) cube([rtot*2+rin*2,rin*4,Hin]);
        }
    }
}
    
module toroid(rin,rtot) {
    rotate([90,0,0]) {
        rotate_extrude()
        translate([rin*rtot,0,0])
        circle(r = rin);
    }
}
