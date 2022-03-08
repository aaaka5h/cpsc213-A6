.pos 0x100 
                ld $a, r2                 # r2 = &a
                ld $b, r3                 # r3 = &b
                ld $0, r0                 # r0 = i' = 0
                ld $n, r1                 # r1 = &n
                ld (r1), r1               # r1 = n
                not r1                    # r1 = ~n
                inc r1                    # r1 = -n
                ld $c, r4                 # r4 = &c
                ld (r4), r4               # r4 = c'

L0:             
                mov r0, r7                # r7 = i'
                add r1, r7                # r7 = i' - n
                beq r7, end               # goto end if (i=n)
                bgt r7, end               # goto end if (i>n)
                ld (r2, r0, 4), r5        # r5 = a[i']
                ld (r3, r0, 4), r6        # r6 = b[i']
                not r5                    # r3 = ~a[i']
                inc r5                    # r3 = -a[i']

L1:             add r5, r6                # r3 = b[i'] - a[i']
                beq r6, L2                # goto L2 if (a[i] = b[i'])
                bgt r6, L2                # goto L2 if (a[i'] < b[i'])   
                inc r4                    # c' = c' + 1

L2:             inc r0                    # i' = i' + 1
                br L0                     # goto L0

end:            ld $i, r1                 # r0 = &i
                st r0, (r1)               # i = i'
                ld $c, r2                 # r2 = &c
                st r4, (r2)               # c = c'

                halt                     
.pos 0x1000
i:               .long 0xffffffff         # i = -1
n:               .long 0x00000005         # n = 5
a:               .long 0x0000000a         # a[0] = 10
                 .long 0x00000014         # a[1] = 20
                 .long 0x0000001e         # a[2] = 30
                 .long 0x00000028         # a[3] = 40
                 .long 0x0000002e         # a[4] = 46

b:               .long 0x0000000b         # b[0] = 11   
                 .long 0x00000014         # b[1] = 20
                 .long 0x0000001c         # b[2] = 28
                 .long 0x0000002c         # b[3] = 44
                 .long 0x00000030         # b[4] = 48
c:               .long 0x00000000         # c = 0