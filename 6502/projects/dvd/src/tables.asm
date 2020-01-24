;;;;;;;;;;;;;;;;;;
;;;   TABLES   ;;;
;;;;;;;;;;;;;;;;;;

  .org $E000
    
palette:
  ;Four palettes for the backgrounds
  .db $0F,$30,$30,$30
  .db $0F,$0F,$0F,$0F
  .db $0F,$0F,$0F,$0F
  .db $0F,$0F,$0F,$0F

  ;Four palettes for the sprites
  .db $00,$30,$15,$14
  .db $00,$30,$38,$3C
  .db $00,$30,$15,$14
  .db $00,$30,$38,$3C

sprites:
     ;vert tile attr horiz
  .db $80, $32, $00, $80   ;sprite 0
  .db $80, $33, $00, $88   ;sprite 1
  .db $88, $34, $00, $80   ;sprite 2
  .db $88, $35, $00, $88   ;sprite 3