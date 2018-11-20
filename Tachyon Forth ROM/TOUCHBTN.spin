CON

  BUTTON_PINS   = $FF           ' The QuickStart's touch buttons are on the eight LSBs
  SAMPLES       = 32            ' Require 32 high redings to return true

PUB Start


DAT

                        org
              byte ".ROM"                       ' ROM signature
              word @TOUCHBTNend-@TOUCHBTN       ' size
              byte "TOUCHBTN  "                 ' name
              '     1234567890
     
                        org 0
TOUCHBTN                                                                                                                                    
              rdlong    WaitTime, par               ' save value passed in as delay period
              mov       outa, #BUTTON_PINS          ' set TestPins high, but keep as inputs

              mov       Wait, cnt                   ' preset the counter
              add       Wait, WaitTime
Loop
              or        dira, #BUTTON_PINS          ' set TestPins as outputs (high)
              andn      dira, #BUTTON_PINS          ' set TestPins as inputs (floating)
              mov       Reading, #BUTTON_PINS       ' create a mask of applicable pins
              waitcnt   Wait, WaitTime              ' wait for the voltage to decay
              andn      Reading, ina                ' clear decayed pins from the mask
              and       Accumulator, Reading        ' accumulate sucessive samples
' maybe preet index to 32, syb 1 and then bez?              
              add       Index, 1                    ' inc loop index
              cmp       Index, #SAMPLES             ' enough samples?
 if_b         jmp       #Loop                       ' nope keep going
              wrlong    Accumulator, par            ' @32 samples, update hub variable  
              mov       Accumulator, #BUTTON_PINS   ' reset accumulator
              mov       Index, $01                  ' reset index                                         
              jmp       #Loop                       ' keep on going
              
TOUCHBTNend

Index         long      $01                             ' loop index save accumualted value
                                                        ' at $20 (#32), i.e. SAMPLES
Accumulator   long      $FF
Reading       res       1
WaitTime      res       1
Wait          res       1