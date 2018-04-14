#include<sys/time.h>
#include<stdio.h>
#include<math.h>

//////////////////////////////////////
int pack_hex(int hex3, int hex2, int hex1, int hex0)
{
	return ((hex3 << 24) | (hex2 << 16) | (hex1 << 8) | hex0);
}
//////////////////////////////////////
int hex_to_7segment(int hex)
{
	switch(hex) {
	case 0 :
		return 0b11000000;
	case 1 :
		return 0b11111001;
	case 2 :
		return 0b10100100;
	case 3 :
		return 0b10110000;
	case 4 :
		return 0b10011001;
	case 5 :
		return 0b10010010;
	case 6 :
		return 0b10000010;
	case 7 :
		return 0b11111000;
	case 8 :
		return 0b10000000;
	case 9 :
		return 0b10010000;
	default :
		return 0b11111111;
}
return(0);
}
///////////////////////////////////////////


// test multiplication program
int main(void) {
	volatile int * led = (int *) 0xFF200040; // red LED address
	volatile int * hex3_hex0 = (int *) 0xFF200020; // 7-segment 0 to 3 address
	volatile int * hex5_hex4 = (int *) 0xFF200010; // 7-segment 4 to 5 address
	volatile int * switchptr = (int *) 0xFF200030; // SW slider switch address
	volatile int * pushbutton_ptr = (int *) 0xFF200040 	// pushbutton address
	int switch_value;
	int state_machine_status = 0;

	int a = 0;
	int b = 0;

	while(1) {
		while(*(pushbutton_ptr) == 0) {
			// wait for pushbutton press, setting LEDs according to switches
			switch_value = *(switchptr);
			*(led) = switch_value;
		}

		if (state_machine_status == 0) {
			a = *(switchptr);	// read status of switches
			
			state_machine_status = 1;
		} else if (state_machine_status == 1) {
			b = *(switchptr);	// read status of switches
			int c = a * b;

			*(hex3_hex0) = pack_hex(hex_to_7segment((0x00F000 & c) / (pow(2.0, 12.0))), hex_to_7segment((0x000F00 & c) / (pow(2.0, 8.0))), 
				hex_to_7segment((0x0000F0 & c) / (pow(2.0, 4.0))), hex_to_7segment(0x00000F & c));
			*(hex5_hex4) = pack_hex(0,0,hex_to_7segment((0xF00000 & c) / (pow(2.0, 20.0))), hex_to_7segment((0x0F0000 & c) / (pow(2.0, 16.0))));
			
			state_machine_status = 2;
		} else if (state_machine_status == 2) {
			a = 0;	// clear registers
			b = 0;

			// set 7-segment displays to 0
			*(hex3_hex0) = pack_hex(hex_to_7segment(0), hex_to_7segment(0), hex_to_7segment(0), hex_to_7segment(0));
			*(hex5_hex4) = pack_hex(0,0,hex_to_7segment(0), hex_to_7segment(0));
			state_machine_status = 0;
		}
	}
}
