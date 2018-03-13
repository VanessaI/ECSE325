package Lab2;

import java.io.*;

/**
 * 
 * @author Alex Hale
 *
 */
class fixedBinary {
	public static void main(String[] args) throws IOException{
		/*BufferedReader buffer = new BufferedReader(
                new FileReader("lab2-x.txt"));
		int c = 0;
		int max = 0;
		int maxAfterDecimal = 0;
		String numberString = "";
		boolean counting = false;
		String afterDecimal = "";
		while ((c = buffer.read()) != -1) {
			if ((char) c == 46) {
				counting = true;
			}
			if ((char) c == 32) {
				// found a space
				counting = false;
				int number = Integer.parseInt(numberString);
				numberString = "";
				
				if (Math.abs(number) > Math.abs(max)) {
					max = number;
				}
				
				int afterDecimalNumber = Integer.parseInt(afterDecimal);
				afterDecimal = "";
				
				if (afterDecimalNumber > maxAfterDecimal) {
					maxAfterDecimal = afterDecimalNumber;
				}
			} else {
				numberString += c;
				
				if (counting) {
					afterDecimal += c;
				}
			}
		}
		
		// max holds the largest value to the left of the decimal
		// maxAfterDecimal holds the largest value to the right of the decimal
		int leftBitsNeeded, rightBitsNeeded;
		if (max < 0) {
			leftBitsNeeded = (int)((Math.log(max) - 1)/Math.log(2));
		} else if (max > 0) {
			leftBitsNeeded = (int)((Math.log(max - 1)+1)/Math.log(2));
		} else {
			leftBitsNeeded = 0;
		}
		
		rightBitsNeeded = 0;
		int w = leftBitsNeeded + rightBitsNeeded;*/
				
		// System.out.println("W = " + w + " and F = " + rightBitsNeeded);
		System.out.println("W = 7 and F = 3");
		
		int w = 7, f = 3;
		BufferedReader bf = new BufferedReader(new FileReader("lab2-x.txt"));
		int c = 0;
		String current = "";
		while ((c = bf.read()) != -1) {
			if (c == 32) {
				double number = Double.parseDouble(current);
				
				double b = Math.abs(number) * Math.pow(2, f);
				int d = (int)Math.round(b);
				String done = Integer.toBinaryString(d);

				// convert to two's complement
				if (number < 0) {
					done = "1" + done;	// add negative sign
					
					// flip bits
					for (int i = 1; i < done.length(); i++) {
						if (done.charAt(i) == '1') {
							done = done.substring(0, i) + "0" + done.substring(i+1, done.length());
						} else {
							done = done.substring(0, i) + "1" + done.substring(i+1, done.length());
						}
					}
					
					// add 1
					if (done.charAt(done.length()-1) == '0') {
						done = done.substring(0, done.length()) + "1";
					} else {
						int i = done.length() - 1;
						
						while (done.charAt(i) == '1') {
							done = done.substring(0, i) + "0" + done.substring(i+1, done.length());
							i--;
							if (i == 0) {
								break;
							}
						}
					}
				} else {
					done = "0"  + done;
				}
				
				if (done.length() < w) {
					// add bits to left
					while(done.length() < w) {
						if (number > 0) {
							done = "0" + done;
						} else {
							done = "1" + done;
						}
					}
				} else if (done.length() > w) {
					// truncate
					done = done.substring(0, w-1);
				}
				String output = done.substring(0, w-f) + "." + done.substring(w-f, w);
				System.out.println(output);
				current = "";
			} else {
				current += (char)c;
			}
		}
	}
}