import("page.scad");

content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras pulvinar urna ex, aliquam dignissim massa blandit a. Curabitur pellentesque libero enim, in dignissim dolor faucibus sit amet. Nunc sit amet metus erat. Curabitur placerat, urna vitae tristique condimentum, magna nisi auctor ligula, non elementum dolor felis id nulla. Sed aliquet rutrum fringilla. Nullam lectus tortor, dignissim lobortis suscipit in, elementum eu libero. Phasellus eget nunc quam. Maecenas consequat ullamcorper dapibus. Etiam ultricies accumsan iaculis. Morbi at risus et sem tempor malesuada. Integer eget congue urna. Pellentesque a nunc vel lectus lobortis posuere. Vestibulum at leo ac diam egestas consectetur. \n\n\t Sed quis auctor neque. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sed risus et felis molestie fermentum eget in eros. Vivamus sodales pellentesque molestie. Pellentesque velit ligula, varius vitae ex tempus, convallis ullamcorper ante. Vivamus erat arcu, ultrices at nisi sit amet, interdum pellentesque nisi. In dictum neque est, quis euismod dui scelerisque sit amet. Nulla luctus cursus ante ut lacinia.\n\n\t Aenean eu blandit purus. Praesent quis sapien lectus. Fusce vulputate ullamcorper lacus vitae blandit. Etiam euismod libero neque, nec ultrices purus aliquet vitae. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent et commodo eros. Quisque euismod ipsum eget ex finibus, eu maximus mi euismod. Nunc ac egestas odio.";
sz = 3.4; //mm

txtsz = 3.4; //mm
pgspace = .2; //mm
pgwidth = .4; //mm

pages = [content]; //in the future this will work for multiple pages

// Create all pages and translate them
pgnum = 0;
for (p = pages) {
    translate([0,0,(len(pages)-pgnum)*(pgwidth+pgspace)]) {
        // Create the positive material
        union() {
            linear_extrude(height = pgwidth/2) {
                square(pgsize);
            }
            translate([0,0,pgwidth/2]) {
                page(content,txtsz,pgsize,pgwidth);
            }
        }

        // Create the filler material
        difference() {
            translate([0,0,pgwidth/2]) {
                linear_extrude(height = pgwidth/2+pgspace) {
                    square(pgsize);
                }
                translate([0,0,pgwidth/2]) {
                    page(content,txtsz,pgsize,pgwidth);
                }
            }
        }
    }
    pgnum = pgnum + 1;
}
