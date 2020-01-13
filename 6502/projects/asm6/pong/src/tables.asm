;;;;;;;;;;;;;;;;;;
;;;   TABLES   ;;;
;;;;;;;;;;;;;;;;;;

  .org $E000
    
palette:
  .db $22,$29,$1A,$0F,  $22,$36,$17,$0F,  $22,$53,$21,$0F,  $22,$27,$34,$0F   ;;background palette
  .db $22,$1C,$15,$14,  $22,$42,$38,$3C,  $22,$1C,$15,$14,  $22,$02,$38,$3C   ;;sprite palette

sprites:
     ;vert tile attr horiz
  .db $80, $32, $00, $80   ;sprite 0
  .db $80, $33, $00, $88   ;sprite 1
  .db $88, $34, $00, $80   ;sprite 2
  .db $88, $35, $00, $88   ;sprite 3