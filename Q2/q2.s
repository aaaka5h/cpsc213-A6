.pos 0x100

foo:                gpc $6, r6                  # update return address
                    j ping                      # goto ping
                    ld $1, r0                   # r0 = 1

.pos 0x264
ping:               j (r6)                     # return

