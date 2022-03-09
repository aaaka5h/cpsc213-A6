.pos 0x100
                    # Load vars
                    ld $n, r0              # r0 = &n
                    ld (r0), r0            # r0 = n
                    not r0                 # r0 = ~n
                    inc r0                 # r0 = -n
                    ld $0, r1              # r1 = i' = 0
                    ld $s, r2              # r2 = &s
                    ld (r2), r2            # r2 = s

                    # Compute average
avg_loop:           mov r1, r3             # r3 = i'
                    add r0, r3             # r3 = i' - n
                    bgt r3, sort_L0        # goto sort_L0 if (i>n)
                    beq r3, sort_L0        # goto sort_L0 if (i==n)
                    
                    # Add grades
                    mov r1, r3             # r3 = i'
                    shl $3, r3             # r3 = 8 * i'
                    mov r3, r4             # r4 = 8 * i'
                    shl $1, r4             # r4 = 16 * i'
                    add r4, r3             # r3 = 24 * i'
                    add r2, r3             # r3 = s[i']

                    ld 4(r3), r4           # r4 = grade[0]
                    ld 8(r3), r5           # r5 = grade[1]
                    add r5, r4             # r4 = grade[0] + grade[1]
                    ld 12(r3), r5          # r5 = grade[2]
                    add r5, r4             # r4 = r4 + grade[2]
                    ld 16(r3), r5          # r5 = grade[3]
                    add r5, r4             # r4 = sum of grades[0:3]
                    shr $2, r4             # r4 = avg of grades[0:3]
                    st r4, 20(r3)          # s[i'].average = avg of grades[0:3]

                    # increment i'
                    inc r1                 # i'++
                    br avg_loop            # goto avg_loop

                    # Sort students from worst to best
                    # Outer for loop
                    ld $n, r0              # r0 = &n
                    ld (r0), r0            # r0 = n
                    dec r0                 # r0 = n - 1
                    ld (r0), r1            # r1 = i' = n - 1
sort_L0:            mov r1, r3             # r3 = i'
                    not r3                 # r3 = ~i'
                    inc r3                 # r3 = -i'
                    bgt r3, end_sort       # goto end_sort if (-i > 0)
                    beq r3, end_sort       # goto end_sort if (-i == 0)

                    # Inner for loop
                    ld $1, r4              # r4 = j' = 1
sort_L1:            mov r1, r5             # r5 = i'
                    not r5                 # r5 = ~i'
                    inc r5                 # r5 = -i'
                    add r4, r5             # r5 = j' - i'
                    bgt r5, end_outer      # goto end_outer if (j' - i' > 0)
                    
                    # if statement
sort_if:            mov r4, r7             # r7 = j'
                    shl $3, r7             # r7 = 8 * j'
                    mov r7, r6             # r6 = 8 * j'
                    shl $1, r6             # r6 = 16 * j'
                    add r6, r7             # r7 = 24 * j'
                    add r2, r7             # r7 = s[j']
                    mov r7, r5             # r5 = s[j']
                    ld 20(r7), r7          # r7 = s[j'].average
                    ld $-24, r6            # r6 = -24
                    add r6, r5             # r5 = s[j'-1]
                    ld 20(r5), r5          # r5 = s[j'-1].average
                    not r5                 # r5 = ~s[j'-1].average
                    inc r5                 # r5 = -s[j'-1].average
                    add r5, r7             # r7 = s[j'].average - s[j'-1].average
                    bgt r7, end_inner      # goto end_inner if (s[j'].average - s[j'-1].average > 0)
                    beq r7, end_inner      # goto end_inner if (s[j'].average - s[j'-1].average == 0)

                    # Swap students
inner_if:           mov r4, r7             # r7 = j'
                    shl $3, r7             # r7 = 8 * j'
                    mov r7, r6             # r6 = 8 * j'
                    shl $1, r6             # r6 = 16 * j'
                    add r6, r7             # r7 = 24 * j'

                    add r2, r7             # r7 = s[j']
                    mov r7, r6             # r6 = temp = s[j']
                    ld $-24, r5            # r5 = -24
                    add r6, r5             # r5 = s[j'-1]
                    ld (r5), r3            # r3 = *s[j'-1]
                    st r3, (r7)            # *s[j'] = *s[j'-1]
                    ld (r6), r3            # r3 = *s[j']
                    st r3, (r5)            # s[j'-1] = s[j']  

                    # Increment j' at end of inner for loop
end_inner:          inc r4                 # j'++
                    br sort_L1             # goto sort_L1
                    
                    # Increment i' at end of outer for loop
end_outer:          dec r1                 # i'--
                    br sort_L0             # goto sort_L0
    
                    # End for loop
end_sort:           br find_median         # goto find_median

                    # Find median student
find_median:        ld $n, r0              # r0 = &n
                    ld (r0), r0            # r0 = n
                    shr $1, r0             # r0 = n/2
                    mov r0, r1             # r1 = n/2
                    shl $3, r0             # r0 = 8 * (n/2)
                    shl $4, r1             # r1 = 16 * (n/2)
                    add r1, r0             # r0 = 24 * (n/2)
                    ld $s, r1              # r1 = &s
                    ld (r1), r1            # r1 = s
                    add r1, r0             # r0 = &s[median]
                    ld (r0), r0            # r0 = s[median].sid
                    ld $m, r1              # r1 = &m
                    st r0, (r1)            # m = s[median].sid

                    halt                   # halt






                    





.pos 0x1000
n:                  .long 1                 # 1 students
m:                  .long 0                 # put the answer here
s:                  .long base              # address of the array

base:               .long 1234              # student ID
                    .long 80                # grade 0
                    .long 60                # grade 1
                    .long 78                # grade 2
                    .long 90                # grade 3
                    .long 0                 # b[5] = computed average   

                    .long 1235              # student ID
                    .long 50                # grade 0
                    .long 60                # grade 1
                    .long 70                # grade 2
                    .long 80                # grade 3
                    .long 0                 # computed average   

                    .long 1236              # student ID
                    .long 40                # grade 0
                    .long 20                # grade 1
                    .long 40                # grade 2
                    .long 20                # grade 3
                    .long 0                 # computed average     