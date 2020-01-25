;;;;;;;;;;;;;;;;;;
;;;   TABLES   ;;;
;;;;;;;;;;;;;;;;;;

  .org $E000
  
horpos:
  .db $c0, $7a, $ef, $6b, $fd, $3b, $5c, $2d, $dd, $00, $12, $ef, $cb, $7d, $3b, $6c
  .db $2d, $dd, $00, $12, $ef, $6b, $6d, $3b, $5c, $00, $12, $ef, $cb, $7d, $3b, $4c
  .db $00, $cd, $7a, $00, $12, $ff, $5b, $7d, $3b, $4c, $dd, $00, $12, $ef, $cb, $7d
  .db $00, $2d, $dd, $00, $12, $ef, $cb, $7d, $3b, $6c, $cb, $5d, $3b, $4c, $12, $ef
  .db $2d, $3b, $5c, $00, $12, $ef, $cb, $7d, $3b, $4c, $dd, $c0, $7a, $ef, $cb, $fd
  .db $00, $7d, $3b, $4c, $dd, $00, $12, $ef, $cb, $7d, $4c, $00, $12, $5f, $cb, $7d

verpos:
  .db $2d, $dd, $60, $2d, $dd, $00, $12, $ef, $cb, $5d, $3b, $4c, $12, $ef, $cb, $7d
  .db $00, $2d, $cd, $7a, $12, $ef, $fb, $7d, $3b, $6c, $cb, $7a, $3b, $4c, $f2, $ef
  .db $2d, $3b, $5c, $c0, $7a, $ef, $cb, $fd, $3b, $4c, $dd, $c0, $7a, $ef, $cb, $fd
  .db $00, $7d, $3b, $4c, $dd, $00, $12, $ef, $cb, $7d, $4c, $00, $12, $5f, $cb, $7d
  .db $00, $62, $ef, $cb, $7d, $cb, $7a, $2d, $dd, $f0, $12, $ef, $cb, $7d, $3b, $4c
  .db $2d, $dd, $00, $c2, $7a, $6b, $7d, $fb, $4c, $00, $12, $5f, $cb, $7d, $3b, $4c

palette:
  .db $3B,$30,$56,$0F,  $22,$36,$17,$0F,  $22,$53,$21,$0F,  $22,$27,$34,$0F   ;;background palette
  .db $0f,$16,$3B,$0F,  $22,$3B,$17,$0F,  $3B,$3B,$3B,$0F,  $22,$27,$34,$0F   ;;sprite palette

sprites:
  ;   vert tile attr horiz
  .db $80, $32, $00, $80   ;sprite 0
  .db $80, $33, $00, $88   ;sprite 1
  .db $88, $34, $00, $80   ;sprite 2
  .db $88, $35, $00, $88   ;sprite 3