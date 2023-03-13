.global add_asm

add_asm:
        add	t1, a0, a1
        mv      a0, t1
        jr      ra
