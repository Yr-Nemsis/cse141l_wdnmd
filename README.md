# CSE 141L Microprocessor
## Team: WDNMD
Notes for walkthrough:
1. The top level file is ```top_leve.sv``` and all other ```.sv``` files are named as their functionality. 
2. For more specific details of how each module works, please go to the file and check out the comment. 
3. For the purpose of a quick test, please go to the ```Milestone2 TestBench``` folder within the ```Testbench``` folder and it is recommended to look through mach_code_comment.txt to see what the instructions are actually doing since the testbench relies on these files. (The format is following the ARM/MIPS standard)
4. To test all 3 programs, please download all the files under the folder ```assembler``` which end with "_mach.txt" and change the file name to be read in the ```Instr_ROM.sv``` file to the corresponding test name. If you want to understand how each program actually works, it's suggested to take a look at the file ending with "_assem.txt" since all the comments and assembly codes are in it and definitely more human readable. 
5. The only speical implementations we have are
   - The program is done when the pc reaches 250 lines, which is hardwired to only work under these 3 programs.
   - The xor instruction can be used to do both xor reduction and normal xor. 
   - The beq instruction is based on a PC lookup table, which can only be used to work on the 3 programs. To make it work on other program, remember to change the jumping distance in ```PC_LUT.sv``` under ```design``` folder. 
6. All tests passed. All program work.
<br/>
<div style="text-align:center">
That's it, Thanks for reading !
</div>
