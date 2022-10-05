//Part A code
/*Author - Wing Hoy. Last edited on Feb 26, 2021 */
/*-----------------DO NOT MODIFY--------*/
.global Welcomeprompt
.global printf
.global cr
.extern value
.extern getstring

.text
Welcomeprompt:
/*-----------------Students write their subroutine here--------------------*/
/* Nikhil Nayyar 1614962 */
/* Joshua Gan 1573981 */
mov r6, r14 // store the return adr
mov r5, #1 // counter for reading in each entry
.equ storage, 0x20001000
ldr r7, = storage // storage location

// print the welcome message followed by new line
bl cr
bl printf
ldr r0, = Welcome
bl printf
bl cr
b getEntry

getEntry:
// print the entry message and read in number of entries
ldr r0, = Entry
bl printf
bl cr
bl getstring
mov r4, r0
bl value
bl cr
// compare number of entries to see if there is an error
cmp r4, #3
blo dispError
cmp r4, #10
bhi dispError
// if valid entry then go to read in values
push {r4}
b getValue
dispError:
// print the error message and go back to read in num of entries
ldr r0, = Error
bl printf
bl cr
b getEntry
// print message to enter value then read them in
getValue:
ldr r0, = num
bl printf
bl cr
bl getstring
mov r4, r0 // get the entry
bl value
bl cr

cmp r4, #0 // check if >= 0
blt dispError2
str r4, [r7] // store the value at mem loc.
// check if 2nd last value
pop {r4}
sub r3, r4, #1
push {r4}
cmp r5, r3
beq getLastVal
// increase counter and memory location
add r7, #0x4
add r5, #1
b getValue
getLastVal:
ldr r0, = numLast
bl printf
bl cr
bl getstring
mov r4, r0 // get the entry
bl value
bl cr
cmp r4, #0 // check if >= 0
blt dispError3
add r7, #0x4
str r4, [r7] // store the value at mem loc.
b End // go to end
dispError2:
// print the error message and go back to read in value
ldr r0, = Error
bl printf
bl cr
b getValue
dispError3:
// print the error message and go back to read in last value
ldr r0, = Error
bl printf
bl cr
b getLastVal
End:
// store return adr in LR
mov r14, r6
bx lr

// Store the message strings
.data
Welcome:
.string "Welcome to Bubble Sort Program"
Entry:
.string "Enter the number of entries (min of 3, max of 10)"
num:
.string "Enter a number (greater then or equal to 0)"
numLast:
.string "Enter the last number (greater then or equal to 0)"
Error:
.string "Enter a valid number"
/*--------------------------------------*/



//Part B code

/*Author - Wing Hoy. Last edited on Feb 26, 2021 */
/*-----------------DO NOT MODIFY--------*/
.global Sort
.global printf
.global cr
.extern value
.extern getstring

.text
Sort:
/*-----------------Students write their subroutine here--------------------*/
/* Nikhil Nayyar 1614962 */
/* Joshua Gan 1573981 */
mov r6, r14 // store the return adr
POP {r4} // get the number of entries
push {r4} // push the number of entries
mov r5, #0 // counter for swapping
mov r3, #0 // counter for array index

.equ storage, 0x20001000

// go start at loop
b loop

loop:
// check r3 to see if we are at the last element
sub r1, r4, #2 // maybe 2 maybe 1
cmp r3, r1
// if we reached last element check if we fully sorted
bhi check
// if not at last element continue sorting next 2 elements
beq sort
blo sort

check:
cmp r5, #0 // compare swap counter to check at 0 (all values were sorted)
beq End
// reset counters and go back to begining of array
mov r5, #0
mov r3, #0
ldr r0, = storage // go back to 20001000

b loop // continue looping

sort:
// get two elements from array at storage location
ldr r1, [r0]
ldr r2, [r0, #4]
// compare to see if they need to switch places
cmp r2, r1
blo swap // if value2-value1 is negative then val1 is higher so swap
beq noswap
bhi noswap

// swap values
swap:
str r2, [r0] // store value2 in the lower index
add r0, #4 // increase address to next element
str r1, [r0] // store value1 in the higher index

add r5, #1 // swap counter
add r3, #1 // increase index counter

b loop// continue looping

// if no swap add 4 to r0 to compare the next values
noswap:
add r0, #4 // increase address to next element
add r3, #1 // increase index counter
b loop // continue looping

End:
// store return adr in LR
mov r14, r6
bx lr


.data
/*--------------------------------------*/



//Part C code


/*Author - Wing Hoy. Last edited on Feb 26, 2021 */
/*-----------------DO NOT MODIFY--------*/
.global Display
.global printf
.global cr
.extern value
.extern getstring
/* Nikhil Nayyar 1614962 */
/* Joshua Gan 1573981 */
.text
Display:
/*-----------------Students write their subroutine here--------------------*/
mov r6, #0 /* initialize a counter */
mov r7, r14 // store the return adr

ldr r0, =numEntryMsg/* prints "The number of entries was */
bl printf	

pop {r4}  /* The number of entries */
mov r0, r4 // move entries into r0 to print
bl value
bl cr

pop {r5} // get the storage location

ldr r0, =sortedMsg/* prints "Sorted from smallest to biggest the numbers are: */
bl printf
bl cr

REPEAT:
cmp r6, r4 /* Checks if the counter is equal to the last entry, if so End*/
BEQ END

ldr r0, [r5] // get the val from mem loc.
bl value
bl cr
add r6, #1
add r5, #4

B REPEAT

END:
ldr r0, =endMsg/* prints "Program Ended" */
bl printf
bl cr

mov r14, r7
bx lr

.data
/*--------------------------------------*/
numEntryMsg:
.string "The number of entries was "
sortedMsg:
.string "Sorted from smallest to biggest, the numbers are: "
endMsg:
.string "Program Ended"
