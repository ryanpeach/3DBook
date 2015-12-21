/*
Braille Module
http://creativecommons.org/licenses/by/3.0/
*/


// mm sizes from http://dots.physics.orst.edu/gs_layout.html
radius = 0.25;
spacing = 2.5;
distance = 3.75 + spacing;

plate_height = 10;
plate_thickness = 2;

$fn = 10;



module letter(bitmap) {
	row_size = 2;
	col_size = 3;
	bitmap_size = row_size * col_size;
	
	function loc_x(loc) = floor(loc / row_size) * spacing + spacing;
	function loc_y(loc) = loc % row_size * spacing  + (distance-spacing)/2;

	for (loc = [0:bitmap_size - 1]) {
		if (bitmap[loc] != 0) {
			union() {
				translate(v = [loc_x(loc), loc_y(loc), 0]) {
					sphere(radius = radius* bitmap[loc], center = true);
				}
			}
		}
	}
}


module braille_char(char) {
	if (char == "A" || char == "a") {
		letter([
			1,0,
			0,0,
			0,0
		]);
	} else if (char == "B" || char == "b") {
		letter([
			1,0,
			1,0,
			0,0
		]);
	} else if (char == "C" || char == "c") {
		letter([
			1,1,
			0,0,
			0,0
		]);
	} else if (char == "D" || char == "d") {
		letter([
			1,1,
			0,1,
			0,0
		]);
	} else if (char == "E" || char == "e") {
		letter([
			1,0,
			0,1,
			0,0
		]);
	} else if (char == "F" || char == "f") {
		letter([
			1,1,
			1,0,
			0,0
		]);
	} else if (char == "G" || char == "g") {
		letter([
			1,1,
			1,1,
			0,0
		]);
	} else if (char == "H" || char == "h") {
		letter([
			1,0,
			1,1,
			0,0
		]);
	} else if (char == "I" || char == "i") {
		letter([
			0,1,
			1,0,
			0,0
		]);
	} else if (char == "J" || char == "j") {
		letter([
			0,1,
			1,1,
			0,0
		]);
	} else if (char == "K" || char == "k") {
		letter([
			1,0,
			0,0,
			1,0
		]);
	} else if (char == "L" || char == "l") {
		letter([
			1,0,
			1,0,
			1,0
		]);
	} else if (char == "M" || char == "m") {
		letter([
			1,1,
			0,0,
			1,0
		]);
	} else if (char == "N" || char == "n") {
		letter([
			1,1,
			0,1,
			1,0
		]);
	} else if (char == "O" || char == "o") {
		letter([
			1,0,
			0,1,
			1,0
		]);
	} else if (char == "P" || char == "p") {
		letter([
			1,1,
			1,0,
			1,0
		]);
	} else if (char == "Q" || char == "q") {
		letter([
			1,1,
			1,1,
			1,0
		]);
	} else if (char == "R" || char == "r") {
		letter([
			1,0,
			1,1,
			1,0
		]);
	} else if (char == "S" || char == "s") {
		letter([
			0,1,
			1,0,
			1,0
		]);
	} else if (char == "T" || char == "t") {
		letter([
			0,1,
			1,1,
			1,0
		]);
	} else if (char == "U" || char == "u") {
		letter([
			1,0,
			0,0,
			1,1
		]);
	} else if (char == "V" || char == "v") {
		letter([
			1,0,
			1,1,
			1,0
		]);
	} else if (char == "W" || char == "w") {
		letter([
			0,1,
			1,1,
			0,1
		]);
	} else if (char == "X" || char == "x") {
		letter([
			1,1,
			0,0,
			1,1
		]);
	} else if (char == "Y" || char == "y") {
		letter([
			1,1,
			0,1,
			1,1
		]);
	} else if (char == "Z" || char == "z") {
		letter([
			1,0,
			0,1,
			1,1
		]);
	} else {
		echo("Invalid Character: ", char);
	}

}

module braille_str(chars, char_count) {
	echo(str("Total Width: ", distance * char_count, "mm"));
	union() {
		for (count = [0:char_count-1]) {
			translate(v = [0, count * distance, plate_thickness]) {
				braille_char(chars[count]);
			}
		}
		translate(v = [0, -distance/2, 0]) {
			color([0,0,1]) {
				cube(size = [plate_height, distance * (char_count+1), plate_thickness]);
			}
		}
	}
}






chars = ["C", "A", "R", "P", "E", " ", "D", "I", "E", "M" ];
char_count = 10;

union()
{
	rotate([0,90,0]) braille_str(chars, char_count);
	// uncomment next line to have a small "foot" added for better adhesion to the print platform or raft
	//translate([-19,20,-plate_height]) cube(size = [20,5,2]);
}