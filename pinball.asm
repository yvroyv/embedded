;----------------------------------------------------------------------------------
;-- Company: TUC
;-- Engineer: Vrouvakis Giannis / Felekis Panagiotis
;-- 
;-- Create Date:    10/23/2017 
;-- Design Name: 	First Milestone of Pinball
;-- Module Name:    Pinball
;-- Project Name:   PinBall HRY411
;-- Target Devices: avr90s8515
;-- Tool versions:  AVR studio 4.09
;-- Description:    Score counter with 2 attepts 

.include "8515def.inc"

.def tri =r20    ; constant for points
.def bump =r21	 ; constant for points
.def spot =r22   ; constant for points
.def Temp =r16   ; Score counter
.def delay =r17  ; Delay 
.def delay2 =r18 ; Delay

ldi Temp,0
ldi tri,5
ldi bump,10
ldi spot,20

RESET: 
ser Temp
out DDRB,Temp

LOOP:

out PORTB,temp   ; Add to Score (pin 0,1,2) or Lose(pin 3) 

sbis PIND,0x00  
sub Temp,tri
sbis PIND,0x01
sub  Temp,bump
sbis PIND,0x02
sub  Temp,spot
sbis PIND,0x03
rjmp dly1

dly :            ; Filling 2 counters to create latency
dec delay
brne dly
dec delay2 
brne dly

rjmp loop



LOOP1:

out PORTB,temp  ; Add to Score (pin 0,1,2) or Lose(pin 3) 

sbis PIND,0x00
sub Temp,tri
sbis PIND,0x01
sub  Temp,bump
sbis PIND,0x02
sub  Temp,spot
sbis PIND,0x03
rjmp dly2

dly1 :
dec delay
brne dly1
dec delay2 
brne dly1

rjmp loop1

LOOP2:

out PORTB,temp    ; Add to Score (pin 0,1,2) or Lose(pin 3) 

sbis PIND,0x00
sub Temp,tri
sbis PIND,0x01
sub  Temp,bump
sbis PIND,0x02
sub  Temp,spot
sbis PIND,0x03
rjmp LOST

dly2 :
dec delay
brne dly2
dec delay2 
brne dly2

rjmp loop2

LOST :

sub temp,temp    ; Delete score , use pin4 to try again
dec temp
out PORTB,temp
sbis PIND,0x04
rjmp dly


dly3 : 
dec delay
brne dly3
dec delay2
brne dly3
rjmp lost
