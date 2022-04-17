f 1 0 4096 10 1	

f 6 0 1024 7 0 10 1 100 1 14 0 					; LINEAR AR ENVELOPE
f 7 0 4096 7 0 128 1 128 .6 512 .6 256 0		; LINEAR ADSR ENVELOPE
f 8 0 1024 5 .001 256 1 192 .5 256 .5 64 .001	; EXPONTENTIAL ADSR

; P1		P2			P3			P4			P5			P6		
; ins		strt		dur			amp			frq1		wav		
i 1			0 			6			7000		9.00		1		

;Pitch envelope
; P7		P8			P9
; envfn		frq2		frq3
  8			8.005		8.01	

;mix voices
; P10		P11			
; 
  0.5 		0.5		

;lfo
; P12		P13		P14
;
 3			1			10
