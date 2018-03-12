.pos 0x100
start:
    ld $sb, r5       #r5 = &sb
    inca    r5       #r5 = &sb + 4
    gpc $6, r6       #r6 = gpc + 6
    j main           #goto main
    halt             #halt

f:
    deca r5            #r5 = r5 -4, allocate 1 more stack space (NULL, x[i], NULL, RA]
    ld $0, r0          #r0 = 0 = m
    ld 4(r5), r1       #r1 = x[i]
    ld $0x80000000, r2 #r2 = $0x80000000, masking
f_loop:
    beq r1, f_end      #is x[i]==0?
    mov r1, r3         #r3 = x[i]
    and r2, r3         #force everything in x[i] to be 0?
    beq r3, f_if1      #is r3 == 0?
    inc r0             #m++
f_if1:
    shl $1, r1         #x[i]*2
    br f_loop          #gotof_loop
f_end:
    inca r5            #r5 = r5 + 4
    j(r6)              #goto r6 address

main:
    deca r5
    deca r5           #allocate 2 stack spaces (NULL, NULL]
    st r6, 4(r5)      #(NULL, RA]
    ld $8, r4         #r4 = i = 8;
main_loop:
    beq r4, main_end  #is i==0?
    dec r4            #i--;
    ld $x, r0         #r0 = &x;
    ld (r0,r4,4), r0  #r0 = x[i];
    deca r5           #allocate 1 more stack space (NULL, NULL, RA]
    st r0, (r5)       #(x[i], NULL, RA]
    gpc $6, r6        #r6 = gpc +6
    j f               #goto f
    inca r5           #deallocate 1 stack space (NULL, RA]
    ld $y, r1         #r1 = &y
    st r0, (r1,r4,4)  #y[i] = bar(x[i])
    br main_loop
main_end:
    ld 4(r5), r6      #r6 = RA
    inca r5           #r5 = r5 +4
    inca r5           #r5 = r5 +4, collapse stack!
    j (r6)            #return

.pos 0x2000
x:
    .long 1
    .long 2
    .long 3
    .long 0xffffffff
    .long 0xfffffffe
    .long 0
    .long 184
    .long 340057058

y:
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0

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
