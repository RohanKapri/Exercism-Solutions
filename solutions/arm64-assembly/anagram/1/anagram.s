.text
.globl find_anagrams

find_anagrams:
        eor x5,x5,x5
mainloop1:
        ldrb w4,[x3,x5]
        cbz w4,addcandidatemaybe
        cmp w4,'A'
        b.lt lower1
        cmp w4,'Z'
        b.gt lower1
        add w4,w4,32
lower1:
        eor x8,x8,x8
        eor x9,x9,x9
        mov x6,x3
innerloop2:
        ldrb w7,[x6],#1
        cbz w7,endofinner2
        cmp w7,'A'
        b.lt lower2
        cmp w7,'Z'
        b.gt lower2
        add w7,w7,32
lower2: 
        cmp w4,w7
        b.ne notequal2
        add x8,x8,#1
notequal2:
        add x9,x9,#1
        b.al innerloop2
endofinner2:
        ldr x6,[x1]
innerloop3:
        ldrb w7,[x6],#1
        cbz w7,endofinner3 
        cmp w7,'A'
        b.lt lower3
        cmp w7,'Z'
        b.gt lower3
        add w7,w7,32
lower3:
        cmp w4,w7
        b.ne notequal3
        sub x8,x8,#1
notequal3:
        sub x9,x9,#1
        b.al innerloop3
endofinner3:
        eor x4,x4,x4
        cbnz x8, donotadd
        cbnz x9, donotadd
        add x5,x5,#1
        b.al mainloop1
addcandidatemaybe:
        eor x5,x5,x5
        ldr x6,[x1]
cmploop:
        ldrb w4, [x3, x5]
        cbz  w4,donotadd
        ldrb w7, [x6, x5]
        cmp w4,'A'
        b.lt lower4
        cmp w4,'Z'
        b.gt lower4
        add w4,w4,32
lower4:
        cmp w7,'A'
        b.lt lower5
        cmp w7,'Z'
        b.gt lower5
        add w7,w7,32
lower5: 
        add x5,x5,#1
        cmp w4,w7
        b.eq cmploop
addcandidate:
        mov x4,#1
donotadd:
        eor x5,x5,x5
        str w4,[x0],#4
        add x1,x1,#8
        sub x2,x2,#1
        cbnz x2,mainloop1
        ret