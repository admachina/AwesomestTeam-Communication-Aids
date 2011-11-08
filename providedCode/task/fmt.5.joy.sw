;
;--------------------
;
; class format_menu
;
;	var pmttop : 5, pmtlmar : 0, pmtlgh : SCRWID - pmtlmar,
;		backtop : pmttop, backlmar : pmtlmar,
;		crsctr : pmtlgh / 2 + pmtlmar, crstop : pmttop + 2,
;		crsmid : pmttop + 4, crsbot : pmttop + 6,
;
;	var backmsg : 'ERASE-LETTER:', crswid : '  --+--  ',
;		crosstr : '\RS;\backlmar;\backtop;' || backmsg ||
;			'\RS;\crsctr;\crstop + 1;|' ||
;			'\RS;\crsctr - length(crswid) / 2;\crsmid;' || crswid ||
;			'\RS;\crsctr;\crsbot - 1;|'
;		erastr : '\RS;\backlmar + length(backmsg);\backtop;\GS;' ||
;			'\RS;\pmtlmar;\crstop;\GS;' ||
;			'\RS;\crsctr - length(crswid) / 2 - 15;\crsmid;               ' ||
;			'\RS;\crsctr + length(crswid) / 2 + 1;\crsmid;\GS' ||
;			'\RS;\pmtlmar;\crsbot;\GS'
;
pmttop:	equ	5
pmtlmar:equ	0
pmtlgh:	equ	SCRWID - pmtlmar
;
backtop:equ	pmttop
backlmar:equ	pmtlmar
crsctr:	equ	pmtlgh / 2 + pmtlmar
crstop:	equ	pmttop + 2
crsmid:	equ	pmttop + 4
crsbot:	equ	pmttop + 6
;
crosstr:
	db	Lcrosstr
	db	RS,backlmar,backtop
backmsg:
	db	"ERASE-LETTER:"
Lbackmsg:equ	$-backmsg
	db	RS,crsctr,crstop + 1,"|"
	db	RS,crsctr - Lcrswid / 2,crsmid
crswid:
	db	"  --+--  "
Lcrswid:equ	$-crswid
	db	RS,crsctr,crsbot - 1,"|"
Lcrosstr:equ	$-crosstr-1
;
erastr:
	db	Lerastr
	db	RS,backlmar+Lbackmsg,backtop,GS
	db	RS,pmtlmar,crstop,GS
	db	RS,crsctr - Lcrswid / 2 - 15,crsmid,"               "
	db	RS,crsctr + Lcrswid / 2 + 1,crsmid,GS
	db	RS,pmtlmar,crsbot,GS
Lerastr:equ	$-erastr-1
;
;--------------------
;
;-- CROSS - print the cross
;
;	proc cross
;		pmtstr(crosstr)
;	end proc
;
cross:
	push	hl			; save register HL
;
	ld	hl,crosstr
	call	pmtstr			; pmtstr(crosstr)
;
	pop	hl			; restore register HL
	ret
;
;--------------------
;
;-- ERASE - erase menu text around cross
;
;	proc erase
;		pmtstr(erastr)
;	end proc
;
erase:
	push	hl			; save register HL
;
	ld	hl,erastr
	call	pmtstr			; pmtstr(erastr)
;
	pop	hl			; restore register HL
	ret
;
;---------------------
;
;-- FORMAT - format menu's in shape of input device
;--
;-- arguments:
;--
;--	HL - pointer to array of strings
;
;	proc format(string @str(NARY))
;
;-- CENTRE - calculate the centre position of a string in relation to the cross
;--
;-- arguments:
;--
;--	HL - pointer to the string
;
;		proc centre(string str)
;			return (length(str) - 1) / 2 + crsctr
;		end proc
;
;		move(backlmar+length(backmsg),backtop)
;		pmtstr(str(0))
;
;		move(centre(str(1)),crstop)
;		pmtstr(str(1))
;
;		move(crsctr - length(crswid) / 2 - length(str(2)),crsmid)
;		pmtstr(str(2))
;
;		move(crsctr + length(crswid) / 2 + 1,crsmid)
;		pmtstr(str(3))
;
;		move(centre(str(4)),crsbot)
;		pmtstr(str(4))
;	end proc
;
centre:
	ld	a,(hl)			; a <- length(str)
	dec	a
	srl	a
	neg
	add	crsctr			; return -((length(str) - 1) / 2) + crsctr
	ret
;
format:
	push	af			; save registers AF, DE, HL
	push	de
	push	hl
;
	ex	de,hl
	ld	h,backlmar + Lbackmsg
	ld	l,backtop
	call	move			; move(backlmar + length(backmsg),backtop)
	ex	de,hl
	call	pmtstr			; pmtstr(str(0))
;
	call	nextstr
	call	centre			; a <- centre(str(1))
	ex	de,hl
	ld	h,a
	ld	l,crstop
	call	move			; move(centre(str(1)),crstop)
	ex	de,hl
	call	pmtstr			; pmtstr(str(1))
;
	call	nextstr
	ld	a,(hl)			; a <- length(str(2))
	ex	de,hl
	neg
	add	crsctr - Lcrswid / 2	; a <- crsctr - length(crswid) / 2 - length(str(2))
	ld	h,a
	ld	l,crsmid
	call	move			; move(crsctr - length(crswid) / 2 - length(str(2)),crsmid)
	ex	de,hl
	call	pmtstr			; pmtstr(str(2))
;
	call	nextstr
	ex	de,hl
	ld	h,crsctr + Lcrswid / 2 + 1
	ld	l,crsmid
	call	move			; move(crsctr + length(crswid) / 2 + 1,crsmid)
	ex	de,hl
	call	pmtstr			; pmtstr(str(3))
;
	call	nextstr
	call	centre
	ex	de,hl
	ld	h,a
	ld	l,crsbot
	call	move			; move(centre(str(4)),crsbot)
	ex	de,hl
	call	pmtstr			; pmtstr(str(4))
;
;
	pop	hl
	pop	de
	pop	af			; restore registers AF, DE, HL
	ret
