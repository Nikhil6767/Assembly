/*Author - Wing Hoy. Last edited on Feb 12, 2021 */
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
.equ numData, 0x20001000 /* Sets variables to memory locations */
.equ xData, 0x20001004
.equ yData, 0x20001008
.equ temp, 0x2000100C
.equ final, 0x20001010

ldr r0, = final
ldr r0, [r0] // store final sum

ldr r1, = numData /* loads addresses into registers*/
ldr r1, [r1] // loads number of data points into r1

mov r5, #0 // previous sum
mov r6, #0x4 // store value of 4 in r6 to check x(k+1) and y(k+1)
mov r7, #0 // store an offset that updates each loop to move to next data point

repeat:
ldr r2, = xData
ldr r2, [r2] // loads xdata array
ldr r3, = yData
ldr r3, [r3] // loads ydata array
ldr r4, = temp
ldr r4, [r4] // load temp array
ldr r4, [r4, r7] // load temp array
cmp r1, #0x1 /* checks if the number of data points left is 0 */
BEQ finalSum /* if true go to find the final sum*/

ldr r4, [r2, r6] /* stores x(k+1) temporarily*/
ldr r2, [r2, r7] // gets first element from x array (on first loop r7 is 0 so no offset)
sub r4, r2 /* subtract x(k+1) from x(k)*/

cmp r4, #0x1 /* check if the delta x is 1 */
BEQ del1
cmp r4, #0x2 /* check if the delta x is 2 */
BEQ del2

del1:
ldr r4, [r3, r6] /* stores y(k+1) temporarily*/
ldr r3, [r3, r7] // gets first element of y array


add r4, r3 /* sum of y(k+1) and y(k)*/
add r5, r4

add r6, #0x4 // increase the two indexes
add r7, #0x4

sub r1, #0x01 /* reduce number of data points */
B repeat /* Branch to start */

del2:
ldr r4, [r3, r6] /* stores y(k+1) temporarily */
ldr r3, [r3, r7] // gets first element of y array

add r4, r3 /* sum of y(k+1) and y(k)*/
LSL r4, #0x01 /* left shift to emulate multiplying by 2*/

add r5,r4/* sum of the previous sums and new sum */

add r6, #0x4 // increase the two indexes
add r7, #0x4

sub r1, #0x01/* reduce number of data points */
B repeat/* Branch to start */

finalSum:
LSR r5, #0x1 /* right shift to emulate division by 2*/
str r5, [r0] // store the end sum

/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
POP {PC}

.data
/*--------------------------------------*/
