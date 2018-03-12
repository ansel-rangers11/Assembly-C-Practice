.pos 0x100

            ld $i, r0
            ld (r0), r2  #r2 = i
            beq r2, beq
afterbeq:


            ld $4, r1
            st r1, (r0)
            gpc $4, r5
            j 4(r5)
            br next
after:      halt



next:       ld $5, r5
            st r5, (r0)  #i = 5
            j after

beq:        ld $6, r5
            st r5, (r0)  #i = 6
            bgt r5, afterbeq




.pos 0x1000
# static memory

i:  .long 0
a:  .long 0
    .long 0
    .long 0
    .long 0
    .long 0
s:  .long 0
b:  .long 0
