sr		=	44100		
ksmps	=	64
nchnls	=	2

gacmb	init	0
garvb	init	0

	instr 	901
inotedur	=		p3
imaxamp		=		ampdb(p4)
kcarfreq	=		cpspch(p5)

kpchbnd		linseg	1, p7*p3, p6, cpspch(p8)*p3, 1

imodfreq	=		p9
ilowndx		=		p10
indxdiff	=		p11-p10

; PARAMETERS DEFINING THE ADSR AMPLITUDE ENVELOPE
; TIMES ARE A PERCENTAGE OF p3
;   attack amp  = p12    attack length  = p17
;   decay amp   = p13    decay length   = p18
;   sustain amp = p14    sustain length = p19
;   release amp = p15    release length = p20
;   end amp     = p16

; PARAMETERS DEFINING THE ADSR FREQ DEVIATION ENVELOPE
; TIMES ARE A PERCENTAGE OF p3
;   attack amp  = p21    attack length  = p26
;   decay amp   = p22    decay length   = p27
;   sustain amp = p23    sustain length = p28
;   release amp = p24    release length = p29
;   end amp     = p25

kpan line p30, p3, p31

irvbsnd	= p32
icmbsnd	= p33

aampenv		linseg	p12, p17*p3, p13, p18*p3, p14, p19*p3, p15, p20*p3, p16
adevenv		linseg	p21, p26*p3, p22, p27*p3, p23, p28*p3, p24, p29*p3, p25
amodosc		oscili	(ilowndx+indxdiff*adevenv)*imodfreq, imodfreq, 1
acarosc		oscili	imaxamp*aampenv, (kcarfreq*kpchbnd)+amodosc, 1
adeclk 		linsegr 0, .001, 1, p3, .0, .0, 0
			outs	(acarosc*kpan)*adeclk, (acarosc*(1-kpan))*adeclk
garvb		=		garvb+(acarosc*irvbsnd)
gacmb		=		gacmb+(acarosc*icmbsnd)
			endin

		instr 1
iamp = ampdb(p4)
ilen tableng p5
aphas phasor 1/(ilen/sr)
iphaseSet = 0
aphas = (aphas + iphaseSet) * ilen
kenv oscil p4, 1/p3, p6
asig tablekt aphas, p5
adeclk linsegr 0, .004, 1, p3, .0, .0, 0
asig = ((asig * iamp) * adeclk) * kenv
	outs asig
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

;		instr 1001
;ain1 	in
;out 	ain1
;		fout p4, 15, out 
;		endin

		instr	198
idur	=		p3
itime 	= 		p4
iloop 	= 		p5
kenv	linen	1, .01, idur, .01
acomb 	comb	gacmb, itime, iloop, 0
		out		acomb*kenv
gacmb	=		0
		endin

		instr 	199
idur	=		p3					
irvbtim	=		p4
ihiatn	=		p5
arvb	reverb2	garvb, irvbtim, ihiatn
		out		arvb
garvb	=		0
		endin

