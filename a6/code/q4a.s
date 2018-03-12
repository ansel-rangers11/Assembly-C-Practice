.pos 0x0
                 ld   $sb, r5            #goto stack base address
                 inca r5                 #go to TRUE bottom of stack
                 gpc  $6, r6             #r6 = gpc + 6
                 j    0x300              #jump to main function
                 halt
.pos 0x100
                 .long 0x00001000
.pos 0x200

                 ld   0x0(r5), r0        #r0 = 3                    1
                 ld   0x4(r5), r1        #r1 = 4                    2
                 ld   $0x100, r2         #r2 = 0x100
                 ld   0x0(r2), r2        #r2 = 0x1000 = a
                 ld   (r2, r1, 4), r3    #r3 = a[4]                 a[2]
                 add  r3, r0             #r0 = a[4] + 3             a[2] + 1
                 st   r0, (r2, r1, 4)    #a[4] = a[4] + 3           a[2] = a[2] + 1
                 j    0x0(r6)            #jump back to 0x300 mid of function
.pos 0x300
                 ld   $0xfffffff4, r0     #r0 = -12
                 add  r0, r5              #move stack pointer 3 spaces up
                 st   r6, 0x8(r5)         #ra is saved
                 ld   $0x1, r0            #r0 = 1
                 st   r0, 0x0(r5)         #1 stored in stack
                 ld   $0x2, r0            #r0 = 2
                 st   r0, 0x4(r5)         #2 stored in stack under 1
                 ld   $0xfffffff8, r0     # r0 = -8
                 add  r0, r5              #move stack pointer 2 spaces up
                 ld   $0x3, r0            #r0 = 3
                 st   r0, 0x0(r5)         #3 is stored in stack (3, NULL, 1, 2, RA]
                 ld   $0x4, r0            #r0 = 4
                 st   r0, 0x4(r5)         #4 is stored in stack (3, 4, 1, 2, RA]
                 gpc  $6, r6
                 j    0x200               #JUMP TO 0x200
                 ld   $0x8, r0            #r0 = 8
                 add  r0, r5              #Deallocate top 2 positions in stack (1, 2, RA]
                 ld   0x0(r5), r1         #r1 = 1
                 ld   0x4(r5), r2         #r2 = 2
                 ld   $0xfffffff8, r0     #r0 = -8
                 add  r0, r5              #Allocate stack pointer 2 spaces up (3*, 4*, 1, 2, RA]
                 st   r1, 0x0(r5)         #(1, 4*, 1, 2, RA])
                 st   r2, 0x4(r5)         #(1, 2, 1, 2, RA]
                 gpc  $6, r6
                 j    0x200               #JUMP TO 0x200, a[2] manipulation
                 ld   $0x8, r0            #r0 = 8
                 add  r0, r5              #Deallocate top 2 positions in stack  (1, 2, RA]
                 ld   0x8(r5), r6         #r6 = RA
                 ld   $0xc, r0            #r0 = ret val = 12
                 add  r0, r5              #COLLAPSE STAC (];
                 j    0x0(r6)             #jump back to r6
.pos 0x1000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
                 .long 0x00000000
.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0
