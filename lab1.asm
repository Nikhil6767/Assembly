//Author - Wing Hoy. Last edited on Jan 18, 2021 /
//-----------------DO NOT MODIFY--------/
.global TestAsmCall
.global printf
.global cr

.text
TestAsmCall:
PUSH {lr}
//--------------------------------------/
//-------Students write their code here ------------/
// Nikhil Nayyar 1614962
// Joshua Gan 1573981

.equ memStart, 0x20001000
.equ memEnd, 0x20002000
.equ Error, 0xFFFFFFFF
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

cmp r2,#0x30 // start by checking if its between 0-9
BHI HigherNum
BLO NotValid
BEQ number

CheckLowLetter:
cmp r2,#0x61 // compare if its between a-f
BHI HigherLowLetter
BLO NotValid
BEQ lowLetter

HigherLowLetter:
cmp r2,#0x66
BEQ lowLetter
BLO lowLetter
BHI NotValid

lowLetter:// value stored in r2 is ascii representation of lowercase letter so convert and store in r3
Sub r2,#0x57                                                                                             ;
Str r2,[r3]
Add r1,#0x4
Add r3,#0x4
Add r4,#1
B Repeat

CheckUpLetter:
cmp r2,#0x41 // compare if its between A-F
BHI HigherUpLetter
BLO NotValid
BEQ upLetter

HigherUpLetter:
cmp r2,#0x46
BEQ upLetter
BLO upLetter
BHI CheckLowLetter

upLetter:
Sub r2,#0x37// value stored in r2 is ascii representation of uppercase letter so convert and store in r3
Str r2,[r3]
Add r1,#0x4
Add r3,#0x4
Add r4,#1
B Repeat

HigherNum: // if its above 0 check if its below or equal to 9, otherwise check if its uppercase letter
cmp r2,#0x39
BEQ number
BLO number
BHI CheckUpLetter

number: // value stored in r2 is ascii representation of number so convert and store in r3
Sub r2, #48
Str r2,[r3]
Add r1,#0x4
Add r3,#0x4
Add r4,#1
B Repeat

NotValid:
Str r5,[r3]
Add r1,#0x4
Add r3,#0x4
Add r4,#1
B Repeat

End:

//-------Code ends here ---------------------/

//-----------------DO NOT MODIFY--------/
POP {PC}

.data
//--------------------------------------*/
