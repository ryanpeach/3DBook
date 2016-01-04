/*
Braille Module
http://creativecommons.org/licenses/by/3.0/
*/

module letter(bitmap,pgwidth,txtsz) {
    spacing = txtsz/3;
    distance = spacing*3;
	row_size = 2;
	col_size = 3;
	bitmap_size = row_size * col_size;
	
	function loc_x(loc) = floor(loc / row_size) * spacing + spacing;
	function loc_y(loc) = loc % row_size * spacing  + (distance-spacing)/2;

	for (loc = [0:bitmap_size - 1]) {
		if (bitmap[loc] != 0) {
			union() {
				translate(v = [loc_x(loc), loc_y(loc), -pgwidth/2]) {
					sphere(r=pgwidth/1.35, center = true); //I don't understand why sphere radius seems to be bigger than other meaurements, but regardless I have shrunk them a bit
				}
			}
		}
	}
}


module braille_char(char,pgwidth,txtsz) {
	if (char == "A" || char == "a" || char == "1") {
		letter([
			1,0,
			0,0,
			0,0
		],pgwidth,txtsz);
	} else if (char == "B" || char == "b" || char == "2") {
		letter([
			1,0,
			1,0,
			0,0
		],pgwidth,txtsz);
	} else if (char == "C" || char == "c" || char == "3") {
		letter([
			1,1,
			0,0,
			0,0
		],pgwidth,txtsz);
	} else if (char == "D" || char == "d" || char == "4") {
		letter([
			1,1,
			0,1,
			0,0
		],pgwidth,txtsz);
	} else if (char == "E" || char == "e" || char == "5") {
		letter([
			1,0,
			0,1,
			0,0
		],pgwidth,txtsz);
	} else if (char == "F" || char == "f" || char == "6") {
		letter([
			1,1,
			1,0,
			0,0
		],pgwidth,txtsz);
	} else if (char == "G" || char == "g" || char == "7") {
		letter([
			1,1,
			1,1,
			0,0
		],pgwidth,txtsz);
	} else if (char == "H" || char == "h" || char == "8") {
		letter([
			1,0,
			1,1,
			0,0
		],pgwidth,txtsz);
	} else if (char == "I" || char == "i" || char == "9") {
		letter([
			0,1,
			1,0,
			0,0
		],pgwidth,txtsz);
	} else if (char == "J" || char == "j") {
		letter([
			0,1,
			1,1,
			0,0
		],pgwidth,txtsz);
	} else if (char == "K" || char == "k") {
		letter([
			1,0,
			0,0,
			1,0
		],pgwidth,txtsz);
	} else if (char == "L" || char == "l") {
		letter([
			1,0,
			1,0,
			1,0
		],pgwidth,txtsz);
	} else if (char == "M" || char == "m") {
		letter([
			1,1,
			0,0,
			1,0
		],pgwidth,txtsz);
	} else if (char == "N" || char == "n") {
		letter([
			1,1,
			0,1,
			1,0
		],pgwidth,txtsz);
	} else if (char == "O" || char == "o") {
		letter([
			1,0,
			0,1,
			1,0
		],pgwidth,txtsz);
	} else if (char == "P" || char == "p") {
		letter([
			1,1,
			1,0,
			1,0
		],pgwidth,txtsz);
	} else if (char == "Q" || char == "q") {
		letter([
			1,1,
			1,1,
			1,0
		],pgwidth,txtsz);
	} else if (char == "R" || char == "r") {
		letter([
			1,0,
			1,1,
			1,0
		],pgwidth,txtsz);
	} else if (char == "S" || char == "s") {
		letter([
			0,1,
			1,0,
			1,0
		],pgwidth,txtsz);
	} else if (char == "T" || char == "t") {
		letter([
			0,1,
			1,1,
			1,0
		],pgwidth,txtsz);
	} else if (char == "U" || char == "u") {
		letter([
			1,0,
			0,0,
			1,1
		],pgwidth,txtsz);
	} else if (char == "V" || char == "v") {
		letter([
			1,0,
			1,1,
			1,0
		],pgwidth,txtsz);
	} else if (char == "W" || char == "w") {
		letter([
			0,1,
			1,1,
			0,1
		],pgwidth,txtsz);
	} else if (char == "X" || char == "x") {
		letter([
			1,1,
			0,0,
			1,1
		],pgwidth,txtsz);
	} else if (char == "Y" || char == "y") {
		letter([
			1,1,
			0,1,
			1,1
		],pgwidth,txtsz);
	} else if (char == "Z" || char == "z") {
		letter([
			1,0,
			0,1,
			1,1
		],pgwidth,txtsz);
	} else {
		echo("Invalid Character: ", char);
	}

}

module braille_str(chars, pagewidth, txtsz) {
    spacing = txtsz/3;
    distance = spacing*3;
    char_count = len(chars);
	echo(str("Total Width: ", distance * char_count, "mm"));
    for (count = [0:char_count-1]) {
		translate(v = [0, count * distance, pagewidth/2]) {
			braille_char(chars[count],pagewidth,txtsz);
		}
	}
}

chars = "abcdefghijklmnopqrstuvwxyz";

union()
{
	rotate([0,90,0]) braille_str(chars,1.5,6);
	// uncomment next line to have a small "foot" added for better adhesion to the print platform or raft
	//translate([-19,20,-plate_height]) cube(size = [20,5,2]);
}