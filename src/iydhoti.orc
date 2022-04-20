sr 	= 44100
kr 	= 4410
ksmps 	= 10
nchnls 	= 2

	instr   102
iamp	= ampdb(p4)
ipitch	= cpspch(p5)
icar	= p6
imod	= p7
indx	= p8
ifn 	= p9
kpan	line 	p11, p3, p12
kenv	oscil  iamp, 1/p3, p10
a1   	foscil 	iamp*kenv, ipitch, icar, imod, indx, ifn
	outs     a1 * kpan, a1 *(1-kpan)
	endin

	instr   103
iamp	= ampdb(p4)
ipitch	= cpspch(p5)
icar	= p6
imod	= p7
indx	= p8
ifn 	= p9
kpan	line 	p11, p3, p12
kenv	oscil  iamp, 1/p3, p10
a1   	foscil 	iamp*kenv, ipitch, icar, imod, indx, ifn
	outs     a1 * kpan, a1 *(1-kpan)
	endin

;;	instr	128
;;idur	= p3
;;iamp	= p4
;;ifrq	= p5*1000
;;iatk	= p6
;;irel	= p7
;;icut1	= p8
;;icut2	= p9
;;
;;lPan fmod p2, 1
;;rPan - 1, lPan
;;
;;kpan	line 	lPan, idur, rPan
;;kenv	linen	iamp, iatk, idur, irel
;;kcut	expon	icut1, idur, icut2
;;anoise	rand	ifrq	
;;afilt	tone	anoise, kcut
;;       	outs	(afilt*kenv)*kpan, (afilt*kenv)*(1-kpan)  
;;		dispfft	afilt, idur, 4096
;;		endin

	instr	129
idur	= p3
iamp	= p4
ifrq	= p5*1000
iatk	= p6
irel	= p7
icut1	= p8
icut2	= p9
kpan	line 	p10, idur, p11
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt	tone	anoise, kcut
       	outs	(afilt*kenv)*kpan, (afilt*kenv)*(1-kpan)  
		dispfft	afilt, idur, 4096
		endin

	instr	130
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icut1	=		p8
icut2	=		p9
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt2	tone	anoise, kcut
afilt1	tone	afilt2, kcut
       	out  	afilt1*kenv
	dispfft	afilt1, idur, 4096
	endin
		
	instr	131
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icut1	=		p8
icut2	=		p9
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt3	tone	anoise, kcut
afilt2	tone	afilt3, kcut
afilt1	tone	afilt2, kcut
       	out  	afilt1*kenv
	dispfft	afilt1, idur, 4096
	endin
		
	instr	132
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icut1	=		p8
icut2	=		p9
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt4	tone	anoise, kcut
afilt3	tone	afilt4, kcut
afilt2	tone	afilt3, kcut
afilt1	tone	afilt2, kcut
       	out  	afilt1*kenv
	dispfft	afilt1, idur, 4096
	endin
