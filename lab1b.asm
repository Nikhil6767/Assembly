/*Author - Wing Hoy. Last edited on Jan 18, 2021 */
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

.equ memStart, 0x20001000
.equ memEnd, 0x20003000
.equ Error, 0x2A

ldr r1, = memStart
ldr r3, = memEnd
mov r4, #0
ldr r5, = Error

Repeat:
ldr r2,[r1]
cmp r2,#0x0D // check for enter
BEQ End

cmp r4,#50 // check if counter reached 50
BEQ End

cmp r2,#0x41 // check for A
BEQ Upper
BLO NotValid
BHI CheckUpper

CheckUpper: // check for Z
cmp r2,#0x5A
BEQ Upper
BLO Upper
BHI CheckLower

Upper: // convert from uppercase to lower case
Add r2,#0x20
Str r2,[r3]
Add r1,#0x4
Add r3,#0x4
Add r4,#1
B Repeat

CheckLower: // check for a
cmp r2,#0x61
BEQ Lower
BHI CheckLowerBound
BLO NotValid

CheckLowerBound: // check for z
cmp r2,#0x7A
BEQ Lower
BLO Lower
BHI NotValid

Lower: // convert from lowercase to uppercase
Sub r2,#0x20
Str r2,[r3]
Add r1,#0x4
Add r3,#0x4
Add r4,#1
B Repeat

NotValid: // store the not valid character
Str r5,[r3]
Add r1,#0x4
Add r3,#0x4
Add r4,#1
B Repeat

End:

/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
POP {PC}

.data
/*--------------------------------------*/
