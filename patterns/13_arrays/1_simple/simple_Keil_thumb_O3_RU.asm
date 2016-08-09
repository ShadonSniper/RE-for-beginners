_main
          PUSH    {R4,R5,LR}
; §выделить место для 20 переменных типа int + еще одной переменной§
          SUB     SP, SP, #0x54   

; §первый цикл§

          MOVS    R0, #0          ; i
          MOV     R5, SP          ; §указатель на первый элемент массива§

loc_1CE                           
          LSLS    R1, R0, #1      ; R1=i<<1 (§то же что и§ i*2)
          LSLS    R2, R0, #2      ; R2=i<<2 (§то же что и§ i*4)
          ADDS    R0, R0, #1      ; i=i+1
          CMP     R0, #20         ; i<20?
          STR     R1, [R5,R2]     ; §сохранить R1 в *(R5+R2) (то же что и R5+i*4)§
          BLT     loc_1CE         ; §да, i<20, запустить тело цикла снова§

; §второй цикл§

          MOVS    R4, #0          ; i=0
loc_1DC                           
          LSLS    R0, R4, #2      ; R0=i<<2 (§то же что и§ i*4)
          LDR     R2, [R5,R0]     ; §загрузить из§ *(R5+R0) (§то же что и§ R5+i*4)
          MOVS    R1, R4
          ADR     R0, aADD        ; "a[%d]=%d\n"
          BL      __2printf
          ADDS    R4, R4, #1      ; i=i+1
          CMP     R4, #20         ; i<20?
          BLT     loc_1DC         ; §да, i<20, запустить тело цикла снова§
          MOVS    R0, #0          ; §значение для возврата§
; §освободить блок в стеке, выделенное для 20-и переменных типа int и еще одной переменной§
          ADD     SP, SP, #0x54   
          POP     {R4,R5,PC}