;
;---------------------
;
; task input_device
;
;
;--------------------
;
;-- GETDATA - read data from input device
;--
;-- returns:
;--
;--	A - input value
;
;	proc getdata returns data : [0..NARY)
;		loop until input.ECB = WAIT exit
;			wait
;		pool
;
;		input.ECB <- BUSY
;		return input.DATA
;	end proc
;
getdata:
>1:
	ld	a,(inpECB)
	cp	WAIT			; input.ECB = WAIT ?
	jrz	>2			; exit
	call	wait
	jr	>1
>2:
	ld	a,BUSY
	ld	(inpECB),a		; input.ECB <- BUSY
	ld	a,(inpDATA)		; return input.DATA
	ret
;
;--------------------
;
;-- INPUT - this task is used to read from the input device asynchronously
;--
;-- interface:
;--
;--	ecb - indicates whether the input device is BUSY or WAITing
;--
;--	data - the value of the input device if ecb = WAIT, otherwise undefined
;
;	task input
;		interface { ECB : [BUSY, WAIT], DATA : [0..NARY) }
;
;-- GETCHAR - reads the input device and normalizes the value
;--
;-- returns:
;--
;--	A - normalized input value
;
;		proc getchar returns data : [0..NARY)
;			port buts : in(0bh) { valdata : 7, but5 : 4, but4 : 3, but3 : 2, but2 : 1, but1: 0 }
;	
;			loop until ~valdata exit
;				wait
;			pool
;	
;			loop unitl valdata exit
;				wait
;			pool
;	
;			if but1 then data <- 0
;			elif but2 then data <- 1
;			elif but3 then data <- 2
;			elif but4 then data <- 3
;			else data <- 4
;			fi
;			return data
;		end proc
;
;	task body
;		ECB <- BUSY
;		loop
;			loop until ECB = BUSY exit
;				wait
;			pool
;
;			DATA <- getchar
;			ECB <- WAIT
;		pool
;	end task
inpECB:
	ds	1
inpDATA:
	ds	1
buts:	equ	0bh
valdata:equ	7
but5:	equ	4
but4:	equ	3
but3:	equ	2
but2:	equ	1
but1:	equ	0
getchar:
movein:
>1:
	in	a,(buts)
	bit	valdata,a		; ~valdata ?
	jrz	>2			; exit
	call	wait
	jr	>1
>2:
moveout:
>1:
	in	a,(buts)
	bit	valdata,a		; valdata ?
	jrnz	>2			; exit
	call	wait
	jr	>1
>2:
testbit:
	bit	but1,a			; but1 ?
	jrz	>2			; no
	ld	a,0			; data <- 0
	jr	>1
>2:
	bit	but2,a			; but2 ?
	jrz	>3			; no
	ld	a,1			; data <- 1
	jr	>1
>3:
	bit	but3,a			; but3 ?
	jrz	>4			; no
	ld	a,2			; data <- 2
	jr	>1
>4:
	bit	but4,a			; but4 ?
	jrz	>5			; no
	ld	a,3			; data <- 3
	jr	>1
>5:
	ld	a,4			; data <- 4
>1:
	ret
;
input:
	ld	a,BUSY
	ld	(inpECB),a		; ECB <- BUSY
inploop:
>1:
	ld	a,(inpECB)
	cp	BUSY			; ECB = BUSY ?
	jrz	>2			; exit
	call	wait
	jr	>1
>2:
	call	getchar
	ld	(inpDATA),a		; DATA <- getchar
	ld	a,WAIT
	ld	(inpECB),a		; ECB <- WAIT
	jr	inploop
