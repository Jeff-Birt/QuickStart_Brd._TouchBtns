
: TOUCH ( pins -- result )
    DUP #32 FOR             ' dirst DUP is our accumualtor area'
     H F DUP 1 ms
     P@ ANDN ROT AND SWAP
    NEXT
    DROP
;

: QDEMO ( -- )
    $00FF0000 OUTPUTS
    BEGIN
     $FF TOUCH 8<< 8<< 
     $FF00FFFF P@ AND OR P!
    AGAIN
;

// TO REMOVE ROMS  $C000 $4000 $FF EFILL

// To load and run Touch Button driver in a COG
long touches --- hold result of touch cog accumulator
80,000 touches !
" TOUCHBTN  "  3 touches LOADCOG

touches @ .