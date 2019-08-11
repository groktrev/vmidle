;*****************************************************************************
;Copyright (c) 2007, Trevor Scroggins
;All rights reserved.
;
;Redistribution and use in source and binary forms, with or without
;modification, are permitted provided that the following conditions are met:
;
;1. Redistributions of source code must retain the above copyright notice,
;this list of conditions and the following disclaimer.
;
;2. Redistributions in binary form must reproduce the above copyright notice,
;this list of conditions and the following disclaimer in the documentation
;and/or other materials provided with the distribution.
;
;THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;POSSIBILITY OF SUCH DAMAGE.
;*****************************************************************************
begin_resident:

        dd      0xffffffff
        dw      0x8000
int28_prev:
        dw      strategy
        dw      interrupt
        db      "VMIDLE$ "

int28:
        pushf
        sti
        hlt
        popf
        jmp     far [cs:int28_prev]

        align   16,int3

end_resident:
;*****************************************************************************
begin_transient:

request:
        dd      0

strategy:
        mov     [cs:request],bx
        mov     [cs:request+0x02],es
        retf

interrupt:
        pusha
        lds     bx,[cs:request]
        cmp     byte [bx+0x02],0
        jz      short init
        or      word [bx+0x03],0x8003
exit:
        popa
        retf

init:
        or      word [bx+0x03],0x0100
        mov     word [bx+0x0e],end_resident
        mov     word [bx+0x10],cs
        push    cs
        pop     ds
        mov     dx,banner
        mov     ah,0x09
        int     0x21
        mov     ax,0x3528
        int     0x21
        mov     [cs:int28_prev],bx
        mov     [cs:int28_prev+0x02],es
        mov     dx,int28
        mov     ax,0x2528
        int     0x21
        jmp     short exit

banner:
        db "VMIDLE Device Version 1.0",13,10
        db "Copyright (c) 2007, Trevor Scroggins",13,10
        db "All rights reserved.",13,10
        db "$"

end_transient:
;*****************************************************************************
