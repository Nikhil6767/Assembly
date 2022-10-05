/*Author - Wing Hoy. Last edited on Feb12, 2021 */
/*-----------------DO NOT MODIFY--------*/
.global TestAsmCall
.global printf
.global cr

.text
TestAsmCall:
PUSH {lr}
/*--------------------------------------*/

/*-------Students write their code here ------------*/
// Nikhil Nayyar 1614962
// Joshua Gan 1573981
.equ size, 0x20001000
.equ firstArr, 0x20001004
.equ secondArr, 0x20001008
.equ strp1, 0x2000100C
.equ strp2, 0x20001010
.equ strp3, 0x20001014

mov r3, #0 // offset p1
mov r5, #0 // counter

RepeatP1: // Part 1
cmp r5, #3 // check if we reached 3 values added
blo Part1 // go to part 1 if we havent added 3 values yet
beq Endp1 // go on to part 2

Part1:
ldr r1, = firstArr
ldr r1, [r1] // load address of first array
ldr r1, [r1, r3] // get element from arr1
ldr r2, = secondArr
ldr r2, [r2] // load address of second array
ldr r2, [r2, r3] // get element from arr2

add r6, r1, r2 // add elements

ldr r4, = strp1
ldr r4, [r4] // load destination p1
str r6, [r4, r3] // store at destination

add r3, #4 // increase offset
add r5, #1 // increase counter

B RepeatP1 // repeat

Endp1:
// Part 2
ldr r0, = size
ldr r0, [r0] // load size in r0
ldr r1, = firstArr
ldr r1, [r1] // load address of first array
ldr r2, = secondArr
ldr r2, [r2] // load address of second array
ldr r4, = strp2 // change storage location for part2
ldr r4, [r4]
mov r5, #0 // set the counter back to 0
RepeatP2:
cmp r5, r0 // see if the counter has reached the end of the array
blo Part2 // if we havent reached the end continue adding
beq Endp2 // if we reached the end go to part3
Part2:
ldr r7, [r1] // get element of first array
ldr r3, [r2] // get element of second array
add r6, r7, r3 // add the elements together and store in r6
str r6, [r4] // store in destination

add r1, #0x4 // move to next locations
add r2, #0x4
add r4, #0x4
add r5, #1 // increase counter

B RepeatP2 // repeat

Endp2:
 // Part 3
ldr r0, = size
ldr r0, [r0] // load size in r0
ldr r1, = firstArr
ldr r1, [r1] // load address of first array in r1
ldr r2, = secondArr
ldr r2, [r2] // load address of second array in r2
ldr r4, = strp3 // change storage location for part3
ldr r4, [r4]
mov r5, #0 // set the counter back to 0
RepeatP3:
cmp r5, r0 // see if the counter has reached the end of the array
blo Part3 // if we havent reached the end continue adding
beq End // if we reached the end we are done

Part3:
ldr r7, [r1] // get element of first array
add r1, #4 // post increment first array
ldr r3, [r2] // get element of second array
add r2, #4 // post increment second array

add r6, r7, r3 // add the elements together store in r6
str r6, [r4] // store in destination
add r4, #4 // post increment storage location

add r5, #1 // increase counter

B RepeatP3
End:


/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
POP {PC}

.data
/*--------------------------------------*/
