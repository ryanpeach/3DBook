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

module braille_char(ch, pgwidth, txtsz) {
	if (ch == "A" || ch == "a" || ch == "1") {
		letter([
			1,0,
			0,0,
			0,0
		],pgwidth,txtsz);
	} else if (ch == "B" || ch == "b" || ch == "2") {
		letter([
			1,0,
			1,0,
			0,0
		],pgwidth,txtsz);
	} else if (ch == "C" || ch == "c" || ch == "3") {
		letter([
			1,1,
			0,0,
			0,0
		],pgwidth,txtsz);
	} else if (ch == "D" || ch == "d" || ch == "4") {
		letter([
			1,1,
			0,1,
			0,0
		],pgwidth,txtsz);
	} else if (ch == "E" || ch == "e" || ch == "5") {
		letter([
			1,0,
			0,1,
			0,0
		],pgwidth,txtsz);
	} else if (ch == "F" || ch == "f" || ch == "6") {
		letter([
			1,1,
			1,0,
			0,0
		],pgwidth,txtsz);
	} else if (ch == "G" || ch == "g" || ch == "7") {
		letter([
			1,1,
			1,1,
			0,0
		],pgwidth,txtsz);
	} else if (ch == "H" || ch == "h" || ch == "8") {
		letter([
			1,0,
			1,1,
			0,0
		],pgwidth,txtsz);
	} else if (ch == "I" || ch == "i" || ch == "9") {
		letter([
			0,1,
			1,0,
			0,0
		],pgwidth,txtsz);
	} else if (ch == "J" || ch == "j") {
		letter([
			0,1,
			1,1,
			0,0
		],pgwidth,txtsz);
	} else if (ch == "K" || ch == "k") {
		letter([
			1,0,
			0,0,
			1,0
		],pgwidth,txtsz);
	} else if (ch == "L" || ch == "l") {
		letter([
			1,0,
			1,0,
			1,0
		],pgwidth,txtsz);
	} else if (ch == "M" || ch == "m") {
		letter([
			1,1,
			0,0,
			1,0
		],pgwidth,txtsz);
	} else if (ch == "N" || ch == "n") {
		letter([
			1,1,
			0,1,
			1,0
		],pgwidth,txtsz);
	} else if (ch == "O" || ch == "o") {
		letter([
			1,0,
			0,1,
			1,0
		],pgwidth,txtsz);
	} else if (ch == "P" || ch == "p") {
		letter([
			1,1,
			1,0,
			1,0
		],pgwidth,txtsz);
	} else if (ch == "Q" || ch == "q") {
		letter([
			1,1,
			1,1,
			1,0
		],pgwidth,txtsz);
	} else if (ch == "R" || ch == "r") {
		letter([
			1,0,
			1,1,
			1,0
		],pgwidth,txtsz);
	} else if (ch == "S" || ch == "s") {
		letter([
			0,1,
			1,0,
			1,0
		],pgwidth,txtsz);
	} else if (ch == "T" || ch == "t") {
		letter([
			0,1,
			1,1,
			1,0
		],pgwidth,txtsz);
	} else if (ch == "U" || ch == "u") {
		letter([
			1,0,
			0,0,
			1,1
		],pgwidth,txtsz);
	} else if (ch == "V" || ch == "v") {
		letter([
			1,0,
			1,1,
			1,0
		],pgwidth,txtsz);
	} else if (ch == "W" || ch == "w") {
		letter([
			0,1,
			1,1,
			0,1
		],pgwidth,txtsz);
	} else if (ch == "X" || ch == "x") {
		letter([
			1,1,
			0,0,
			1,1
		],pgwidth,txtsz);
	} else if (ch == "Y" || ch == "y") {
		letter([
			1,1,
			0,1,
			1,1
		],pgwidth,txtsz);
	} else if (ch == "Z" || ch == "z") {
		letter([
			1,0,
			0,1,
			1,1
		],pgwidth,txtsz);
	} else {
		echo("Invalid Character: ", ch);
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