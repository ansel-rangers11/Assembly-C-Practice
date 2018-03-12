.pos 0x100

          ld $s, r0
          ld (r0), r1           # r1 = s

          ld $n, r7
          ld (r7), r7           #r7 = studentcounter

repeat:   ld $1, r2              # r2 = 1 (counter)
          ld $5, r4
          not r4
          inc r4                 #r4 = -5
          add r2, r4             #r4 = counter - 5





loopeach: beq r4, avgsum
          ld (r1, r2, 4), r3   #grade of s[counter]
          ld 20(r1), r0        # r0 = comp avg summation
          add r3, r0           #compavg summation
          st r0, 20(r1)        #compavg = summation
          inc r4               #counter - 5 ++
          inc r2               #counter++
          br loopeach

avgsum:   shr $2, r0          #average of student
          st r0, 20(r1)       #store average of student into comp avg
          dec r7              #studentcounter--
          br students

students: beq r7, checkpoint
          ld $24, r0
          add r0, r1  #r0 = s
          br repeat





checkpoint: ld $n, r2
           ld (r2), r2
           dec r2           #r2 = i
outerloop: beq r2, alldone  # i > 0 ? If not, Finish
           br findlowest







findlowest: ld $s, r0
            ld (r0), r0

            ld $1, r1
            ld $20, r3          # location of avg in struct
            #mov r3, r5

nextsetof2: ld $s, r0
            ld (r0), r0
            mov r1, r4   #r4 = j
            mov r2, r5   #r5 = i
            not r5
            inc r5
            add r4, r5  #r5 = j - i
            bgt r5, iterated


            ld $20, r3
            mov r1, r5 #r5 = j copy
            dec r5
mini:       beq r5, continue  #to refresh r3, each time, the offset
            dec r5
            ld $24, r4
            add r4, r3
            br mini




continue:   shr $2, r3


            ld (r0, r3, 4), r4        #r4 = avg of struct 1, of avg[j-1]
            ld $6, r5
            add r5, r3
            ld (r0, r3, 4), r6          #r6 = avg of struct 2, of avg[j]
            ld $-6, r5
            add r5, r3          #r3 is back to j-1
            shl $2, r3


            not r6
            inc r6                              # - 2nd person avg         COMPARING AVERAGE
            add r4, r6                         # 1st person avg - 2nd person avg?
            bgt r6, firstpersonsmarterSoSwap
            br purgatory





firstpersonsmarterSoSwap: ld $s, r0
            ld (r0), r0
           add r3, r0          #base offsetted by r3 to j-1, to find the next set of 2 matches  WRONG HERE
           ld $-20, r7
           add r7, r0         #move back to the proper alignment, top of chunk of v[j-1]

           ld $0, r7          #r1 counter for 1st batch
           ld $6, r6           #r6 counter for 2nd batch


           #THIS IS WORKING FINE, but I think r2 is getting overwritten
swaploop:
           ld $-6, r5
           add r7, r5                    # counter - 6

           beq r5, purgatory       #if swap of struct of stuff is done, goto next set of 2 students and compare

           ld (r0, r7, 4), r5 #1st stu ID
           ld $6, r6
           add r6, r7
           ld (r0, r7, 4), r4 #1st stu ID

           st r5, (r0, r7, 4)
           ld $-6, r6
           add r6, r7
           st r4, (r0, r7, 4)
           inc r7



           br swaploop
purgatory:
           inc r1           #j++
           br nextsetof2

iterated: dec r2            # i--
          br outerloop


alldone: ld $n, r2
         ld (r2), r2
         shr $1, r2
         ld $s, r0
         ld (r0), r0
         ld $0, r3
lup:     beq r2, cont
         dec r2
         ld $6, r5
         add r5, r3
         br lup

cont:    ld (r0, r3, 4), r1
         ld $m, r0
         st r1, (r0)
         halt
















.pos 0x2000
n: .long 7         # just one student
m: .long 0          # put the answer here
s: .long base       # address of the array
base: .long 1234    # student ID
      .long 80 # grade 0
      .long 60 # grade 1
      .long 78 # grade 2
      .long 90 # grade 3
      .long 0 # computed average
      .long 1231    # student ID
      .long 50 # grade 0
      .long 55 # grade 1
      .long 60 # grade 2
      .long 65 # grade 3
      .long 0 # computed average
      .long 1005    # student ID
      .long 0 # grade 0
      .long 1 # grade 1
      .long 2 # grade 2
      .long 3 # grade 3
      .long 0 # computed average
      .long 1999    # student ID
      .long 20 # grade 0
      .long 21 # grade 1
      .long 22 # grade 2
      .long 23 # grade 3
      .long 0 # computed average
      .long 1555    # student ID
      .long 30 # grade 0
      .long 31 # grade 1
      .long 32 # grade 2
      .long 33 # grade 3
      .long 0 # computed average
      .long 1333    # student ID
      .long 40 # grade 0
      .long 41 # grade 1
      .long 42 # grade 2
      .long 43 # grade 3
      .long 0 # computed average
      .long 1500    # student ID
      .long 50 # grade 0
      .long 51 # grade 1
      .long 52 # grade 2
      .long 53 # grade 3
      .long 0 # computed average
