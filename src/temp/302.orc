sr = 44100
ksmps = 32
nchnls = 2

instr 1			
	idur	=	p3	
	iamp	=	p4	
	inamp	=	p5	
	ipch	=	cpspch(p6)	
	inpch	=	cpspch(p7)	
	itime	=	p8	
	kenv1	linseg	iamp, idur - itime, iamp, itime, inamp
	kenv2	linseg	ipch, idur - itime, ipch, itime, inpch
aosc1	oscil	kenv1, kenv2, 1, -1
out	aosc1
