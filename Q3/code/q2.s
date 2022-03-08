.pos 0x100 
 L0:            ld $a, r2                 # r2 = &a
                ld $b, r3                 # r3 = &b
                ld $0, r0                 # r0 = i' = 0
                ld $n, r1                 # r1 = &n
                ld (r1), r1               # r1 = n
                not r1                    # r1 = ~n
                inc r1                    # r1 = -n
                add r0, r1                # r1 = i' - n
                beq r1, end               # goto end if (i<n)
                bgt r1, end               # goto end if (i<n)
                ld (r2, r0, 4), r2        # r2 = a[i']
                ld (r3, r0, 4), r3        # r3 = b[i']
                
                
L1:             


end:




.pos 0x100
                 ld   $0x0, r0            # r0 = temp_i = 0
                 ld   $a, r1              # r1 = address of a[0]
                 ld   $0x0, r2            # r2 = temp_s = 0
                 ld   $0xfffffff6, r4     # r4 = -10
loop:            mov  r0, r5              # r5 = temp_i
                 add  r4, r5              # r5 = temp_i-10
                 beq  r5, end_loop        # if temp_i=10 goto +4
                 ld   (r1, r0, 4), r3     # r3 = a[temp_i]
                 add  r3, r2              # temp_s += a[temp_i]
                 inc  r0                  # temp_i++
                 br   loop                # goto -7
end_loop:        ld   $s, r1              # r1 = address of s
                 st   r2, 0x0(r1)         # s = temp_s
                 st   r0, 0x4(r1)         # i = temp_i
                 halt                     
.pos 0x1000
i:               .long 0xffffffff         # i = -1
n:               .long 0x00000005         # n = 5
a:               .long 0x0000000a         # a[0] = 10
                 .long 0x00000014         # a[1] = 20
                 .long 0x0000001e         # a[2] = 30
                 .long 0x00000028         # a[3] = 40
                 .long 0x00000032         # a[4] = 50
b:               .long 0x0000000b         # b[0] = 11   
                 .long 0x00000014         # b[1] = 20
                 .long 0x0000001c         # b[2] = 28
                 .long 0x0000002c         # b[3] = 44
                 .long 0x00000030         # b[4] = 48
c:               .long 0x00000000         # c = 0