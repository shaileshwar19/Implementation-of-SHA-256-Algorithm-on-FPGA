# Implementation-of-SHA-256-Algorithm-on-FPGA
 Design and implementation of a high-performance Cryptographic Processor
Steps Involved:
 1.	 Padding and Parsing: First Module in SHA-256 is Padding and Parser Module. This module includes the extra data after the original data has stopped to make total data for SHA-256 ‘s next modules a 1_Block ( 512bits Block) and then the Parser in this module stores all of this data after adding a 64-bit chunk which represents the the Size of the Input data. This module also issues the “padding_done” to signal the other modules that padding and parsing has been done.

2.	Scheduling: Message Scheduler In message scheduler we implement the 0-15 iterations for 32bit ‘w’ words which is all the 1_Block data from padding (32*16=512 bits). After 16 ‘w’ words we perform iterations from already received 16 words to create further 48 ‘w’ words.

3.	Iterative Processing : In iterative processing we create 8 registers each 32bit a, b, c, d, e, f, g, h with initial values equal to 8 intermediate initial values H0 = 32’h6a09e H1 = 32’hbb67ae H2 = 32’b3c6ef H3 = 32’ha54ff53a H4 = 32’h510e527f H5 = 32’h9b05688c H6 = 32’h1f83d9ab H7 = 32’h5be0cd

4.	Message Digest : In message digest we perform addition of Initial values of “H” and values of 8 iteration registers for 1_Block. After addition we concatenate values of 8 ‘H’ each 32bit giving the out of 256 bits Hash

5.	Top Module : As we followed top-down approach , here we are instantiating all the modules for generation of hash.

REFERENCES
Primary Source (Journal Article):
1.	Scholten, M., et al. (2020). "A Standalone FPGA-Based Miner for Lyra2REv2 Cryptocurrencies." IEEE Transactions on Emerging Topics in Computing.
Available at: https://ieeexplore.ieee.org/document/9007025
Additional References:
2.	National Institute of Standards and Technology (NIST). (2001). "Secure Hash Standard (SHS) – FIPS PUB 180-4."
Available at: https://csrc.nist.gov/publications
3.	Koç, Ç. K. (1995). "High-Speed RSA Implementation." RSA Laboratories.
Available at: https://www.rsa.com
4.	Bernstein, D. J. (2005). "Understanding Cryptography: A Textbook for Students and Practitioners." Springer.
5.	Kaps, J. P., & Gaubatz, G. (2006). "FPGA Implementation of Cryptographic Hash Functions SHA-256 and SHA-512."
Proceedings of the International Conference on Field Programmable Logic and Applications (FPL), IEEE.
6.	Xilinx Inc. (2021). "Artix-7 FPGA Data Sheet: DC and AC Switching Characteristics."
Available at: https://www.xilinx.com
7.	Tiri, K., & Verbauwhede, I. (2005). "A VLSI Design Flow for Secure Side-Channel Attack Resistant ICs."
Proceedings of Design, Automation & Test in Europe (DATE), IEEE.
8.	Menezes, A., van Oorschot, P., & Vanstone, S. (1996). "Handbook of Applied Cryptography." CRC Press.

*********THE END********

Contact : B.SHAILESHWAR GOUD, Email: shaileshwarbhoomagouni@gmail.com
