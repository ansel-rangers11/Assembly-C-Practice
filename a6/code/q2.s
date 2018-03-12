.pos 0x100

  ld $i, r0    #r0 = &i
  ld $s, r4    #r4 = &s
  ld $a, r2    #r2 = &a
  ld (r4), r4  #r4 = s = temps = 0
  ld $-5, r1   #r1 = -5
  ld $0, r5    #r5 = count = 0



loop: mov r5, r6   #r6 = count
      add r1, r6   #r1 = count + (-5)
      beq r6, end  #if count == 5, goto end
      ld (r2, r5, 4), r3   #r3 = a[i]
      bgt r3, executes #if a[i] >0, goto executes
      inc r5             #count++


      br loop

executes: add r3, r4  #temps = a[i] + temps
          inc r5   #count++
          br loop





end:  ld $s, r7    #r7 = &s
      st r4, (r7)  #s = temps
      ld $i, r7    #r7 = &i
      st r5, (r7)  #i = count
      halt





.pos 0x1000
# static memory

i:  .long 10  #i
a:  .long 10  #a[0]
    .long -30 #a[1]
    .long -12 #a[2]
    .long 4   #a[3]
    .long 8   #a[4]
s:  .long 0   #s
