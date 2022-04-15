sr = 44100
ksmps = 32
nchnls = 2

gacmb	init	0
garvb	init	0

	instr 	901
imaxamp	=	ampdb(p4)
kcarfreq	=	cpspch(p5)

imodfreq	=	p6
ilowndx		=	p7
indxdiff	=	p8-ilowndx

iattPch  	= 	p9
idecPch 	= 	p10
isusPch		=	p11
irelPch		= 	p12
iendPch		= 	p13

ipchAttLen 	= 	p14 
ipchDecLen 	= 	p15
ipchSusLen	=	p16
ipchRelLen	= 	p17

iattAmp  	= 	p18    
idecAmp   	= 	p19    
isusAmp 	= 	p20    
irelAmp 	= 	p21    
iendAmp    	= 	p22

iattLen  	= 	p23
idecLen   	= 	p24
isusLen 	= 	p25
irelLen 	= 	p26

iattAmpFD  	= 	p27    
idecAmpFD  	= 	p28    
isusAmpFD 	= 	p29    
irelAmpFD 	= 	p30    
iendAmpFD  	= 	p31

iattLenFD 	= 	p32
idecLenFD 	= 	p33
isusLenFD 	= 	p34
irelLenFD 	= 	p35

irvbsnd		= 	p36
icmbsnd		= 	p37

kpan 		line 	p38, p3, p39

kpchbnd		linseg	iattPch, ipchAttLen*p3, idecPch, ipchDecLen*p3, isusPch, ipchSusLen*p3, irelPch, ipchRelLen*p3, iendPch
aampenv		linseg	iattAmp, iattLen*p3, idecAmp, idecLen*p3, isusAmp, isusLen*p3, irelAmp, irelLen*p3, iendAmp

adevenv		linseg	iattAmpFD, iattLenFD*p3, idecAmpFD, idecLenFD*p3, isusAmpFD, isusLenFD*p3, irelAmpFD, irelLenFD*p3, iendAmpFD

amodosc		oscili	(ilowndx+indxdiff*adevenv)*imodfreq, imodfreq, 1
acarosc		oscili	imaxamp*aampenv, (kcarfreq*kpchbnd)+amodosc, 1
adeclk 		linsegr 0, .004, 1, p3, 1, .05, 0.01

		outs	(acarosc*kpan)*adeclk, (acarosc*(1-kpan))*adeclk
garvb		=	garvb+(acarosc*irvbsnd)
gacmb		=	gacmb+(acarosc*icmbsnd)
			endin

	instr	1 
iamp	= 	ampdb(p4)
ifreq	= 	cpspch(p5) 
ifn		= 	p6 
ilpf    =   p7
ihpf    =   p8
ipan	=	p9 
icmbsnd =	p10
irvbsnd =	p11

a1	loscil	iamp, ifreq, ifn
a1	butterlp a1, ilpf
a1	butterhp a1, ihpf
adeclk linsegr 0, .004, 1, p3, 1, .004, 0
		a1 = a1 * adeclk
    	outs a1*ipan, a1*(1-ipan)
gacmb   = gacmb+(a1*icmbsnd)
garvb   = garvb+(a1*irvbsnd)
    	endin

	instr 2
a1 oscil p4, p5, p6
adeclk linsegr 0, .004, 1, p3, .0, .0, 0
	out (a1*adeclk)
	endin

	instr 3
ain1 in 
adel linseg 0, p3*.5, 0.02, p3*.5, 0
aout flanger ain1, adel, .7
out aout
	endin

	instr 4
iamp = ampdb(p4)
kpchbnd		linseg	p5, p8*p3, p6, p9*p3, p7
a1	pluck iamp, p5+kpchbnd, p10, p11, p12
kpan line p13, p3, p14
	outs a1*kpan, a1*(1-kpan)
	endin

	instr 	5

kamp	= ampdb(p4)
kfreq   = p5
kdens	= p6
kampDev = p7
kpitchDev = p8
kgdur = p9
igfn = p10

;a1 	grain 	kamp, kfreq, kdens, kampDev, kpitchDev, kgdur, igfn  
a1 	grain kamp, kfreq, kdens, kampDev, kpitchDev, kgdur, igfn, 3, 1  
	out a1
	endin

	instr	6
iamp	= 	ampdb(p4)
ifreq	= 	p5
ifn		= 	p6
irvbsnd = 	p7
icmbsnd =   p8
a1	loscil	iamp, ifreq, ifn
garvb		=		garvb+(a1*irvbsnd)
gacmb		=		gacmb+(a1*icmbsnd)
	
	outs a1, a1
	endin

	instr 7
iamp	= 	p4
ipitch  = 	p5
iskip	=       p6
irvbsnd = 	p7
icmbsnd =       p8

a1, a2 diskin2 "../db/Doo-wop.wav", ipitch, iskip
	outs a1*iamp, a2*iamp
garvb		=		garvb+(a1*irvbsnd)
gacmb		=		gacmb+(a1*icmbsnd)
	endin 

		instr	128
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		p5
iatk	=		p6
irel	=		p7
icf1	=		p8
icf2	=		p9
ibw1	=		p10
ibw2	=		p11
kpan line p12, p3, p13
irvbsnd	= p14
icmbsnd	= p15

kenv	expseg	.001, iatk, iamp, idur/6, iamp*.4, idur-(iatk+irel+idur/6), iamp*.6, irel,.01
anoise	rand	ifrq
kcf		expon	icf1, idur, icf2
kbw		line	ibw1, idur, ibw2
afilt	reson	anoise, kcf, kbw, 2
       	outs  	(afilt*kenv)*kpan, (afilt*kenv)*(1-kpan)  
garvb		=		garvb+(afilt*irvbsnd)
gacmb		=		gacmb+(afilt*icmbsnd)
		endin

		instr 1001
ain1 		inch 0
		fout "../db/doo-wop_voc1.wav", 14, ain1
		outs ain1

;garvb		=		garvb+(ainauto*irvbsnd)
;gacmb		=		gacmb+(ainauto*icmbsnd)		
		endin


; EFFECTS

; DELAY
		instr	198
idur	=		p3
itime 	= 		p4
iloop 	= 		p5
kenv	linen	1, .01, idur, .01
acomb 	comb	gacmb, itime, iloop, 0
		out		acomb*kenv
gacmb	=		0
		endin

;REVERB
		instr 	199
idur	=		p3					
irvbtim	=		p4
ihiatn	=		p5
arvb	reverb2	garvb, irvbtim, ihiatn
		out		arvb
garvb	=		0
		endin



