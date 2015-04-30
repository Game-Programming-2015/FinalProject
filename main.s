	.file	"main.c"
@ GNU C version 3.3.2 (arm-thumb-elf)
@	compiled by GNU C version 3.3.1 (cygming special).
@ GGC heuristics: --param ggc-min-expand=64 --param ggc-min-heapsize=65470
@ options passed:  -fpreprocessed -mthumb-interwork -mlong-calls
@ -auxbase-strip -O2 -Wall -fverbose-asm
@ options enabled:  -fdefer-pop -fomit-frame-pointer
@ -foptimize-sibling-calls -fcse-follow-jumps -fcse-skip-blocks
@ -fexpensive-optimizations -fthread-jumps -fstrength-reduce -fpeephole
@ -fforce-mem -ffunction-cse -fkeep-static-consts -fcaller-saves
@ -freg-struct-return -fgcse -fgcse-lm -fgcse-sm -floop-optimize
@ -fcrossjumping -fif-conversion -fif-conversion2 -frerun-cse-after-loop
@ -frerun-loop-opt -fdelete-null-pointer-checks -fschedule-insns
@ -fschedule-insns2 -fsched-interblock -fsched-spec -fbranch-count-reg
@ -freorder-blocks -freorder-functions -fcprop-registers -fcommon
@ -fverbose-asm -fgnu-linker -fregmove -foptimize-register-move
@ -fargument-alias -fstrict-aliasing -fmerge-constants
@ -fzero-initialized-in-bss -fident -fpeephole2 -fguess-branch-probability
@ -fmath-errno -ftrapping-math -mapcs -mapcs-frame -mapcs-32 -msoft-float
@ -mthumb-interwork -mlong-calls

	.global	prevButton
	.data
	.align	1
	.type	prevButton, %object
	.size	prevButton, 2
prevButton:
	.short	-1
	.global	currButton
	.align	1
	.type	currButton, %object
	.size	currButton, 2
currButton:
	.short	-1
	.text
	.align	2
	.global	pollButtons
	.type	pollButtons, %function
pollButtons:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r1, .L2
	ldr	r3, .L2+4
	ldrh	r0, [r1, #0]	@ movhi	@  currButton
	mov	r2, #67108864
	strh	r0, [r3, #0]	@ movhi 	@  prevButton
	add	r2, r2, #304
	ldrh	r3, [r2, #0]
	mvn	r3, r3
	@ lr needed for prologue
	strh	r3, [r1, #0]	@ movhi 	@  currButton
	bx	lr
.L3:
	.align	2
.L2:
	.word	currButton
	.word	prevButton
	.size	pollButtons, .-pollButtons
	.align	2
	.global	checkPressed
	.type	checkPressed, %function
checkPressed:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L6
	ldrh	r2, [r3, #0]	@  currButton
	tst	r2, r0	@  button
	@ lr needed for prologue
	mov	r3, #0	@  button
	beq	.L5
	ldr	r3, .L6+4
	ldrh	r2, [r3, #0]	@  prevButton
	tst	r2, r0	@  button
	movne	r3, #0	@  button
	moveq	r3, #1	@  button
.L5:
	mov	r0, r3	@  button
	bx	lr
.L7:
	.align	2
.L6:
	.word	currButton
	.word	prevButton
	.size	checkPressed, .-checkPressed
	.align	2
	.global	checkHeld
	.type	checkHeld, %function
checkHeld:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L10
	ldrh	r2, [r3, #0]	@  currButton
	tst	r2, r0	@  button
	@ lr needed for prologue
	mov	r3, #0	@  button
	beq	.L9
	ldr	r3, .L10+4
	ldrh	r2, [r3, #0]	@  prevButton
	tst	r2, r0	@  button
	moveq	r3, #0	@  button
	movne	r3, #1	@  button
.L9:
	mov	r0, r3	@  button
	bx	lr
.L11:
	.align	2
.L10:
	.word	currButton
	.word	prevButton
	.size	checkHeld, .-checkHeld
	.align	2
	.global	checkReleased
	.type	checkReleased, %function
checkReleased:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L14
	ldrh	r2, [r3, #0]	@  currButton
	tst	r2, r0	@  button
	@ lr needed for prologue
	mov	r3, #0	@  button
	bne	.L13
	ldr	r3, .L14+4
	ldrh	r2, [r3, #0]	@  prevButton
	tst	r2, r0	@  button
	moveq	r3, #0	@  button
	movne	r3, #1	@  button
.L13:
	mov	r0, r3	@  button
	bx	lr
.L15:
	.align	2
.L14:
	.word	currButton
	.word	prevButton
	.size	checkReleased, .-checkReleased
	.align	2
	.global	checkHeldReleased
	.type	checkHeldReleased, %function
checkHeldReleased:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L18
	ldrh	r2, [r3, #0]	@  currButton
	tst	r2, r0	@  button
	@ lr needed for prologue
	mov	r3, #0	@  button
	bne	.L17
	ldr	r3, .L18+4
	ldrh	r2, [r3, #0]	@  prevButton
	tst	r2, r0	@  button
	movne	r3, #0	@  button
	moveq	r3, #1	@  button
.L17:
	mov	r0, r3	@  button
	bx	lr
.L19:
	.align	2
.L18:
	.word	currButton
	.word	prevButton
	.size	checkHeldReleased, .-checkHeldReleased
	.align	2
	.global	checkState
	.type	checkState, %function
checkState:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L21
	ldrh	r2, [r3, #0]	@  currButton
	and	r2, r2, r0	@  button,  button
	mov	r0, r2	@  button
	@ lr needed for prologue
	bx	lr
.L22:
	.align	2
.L21:
	.word	currButton
	.size	checkState, .-checkState
	.global	videoBuffer
	.data
	.align	2
	.type	videoBuffer, %object
	.size	videoBuffer, 4
videoBuffer:
	.word	100663296
	.global	paletteMem
	.align	2
	.type	paletteMem, %object
	.size	paletteMem, 4
paletteMem:
	.word	83886080
	.global	scanlineCounter
	.align	2
	.type	scanlineCounter, %object
	.size	scanlineCounter, 4
scanlineCounter:
	.word	67108870
	.text
	.align	2
	.global	waitVBlank
	.type	waitVBlank, %function
waitVBlank:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L27
	ldr	r2, [r3, #0]	@  scanlineCounter
	@ lr needed for prologue
.L24:
	ldrh	r3, [r2, #0]
	cmp	r3, #159
	bls	.L24
	bx	lr
.L28:
	.align	2
.L27:
	.word	scanlineCounter
	.size	waitVBlank, .-waitVBlank
	.align	2
	.global	addToPalette
	.type	addToPalette, %function
addToPalette:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r2, #256	@  end
	movge	r2, #256	@  end
	cmp	r1, r2	@  start,  end
	str	lr, [sp, #-4]!
	bge	.L36
	ldr	r3, .L37
	ldr	ip, [r3, #0]	@  paletteMem
.L34:
	mov	r3, r1, asl #1	@  start
	ldrh	lr, [r3, r0]	@ movhi	@ * palette
	add	r1, r1, #1	@  start,  start
	cmp	r1, r2	@  start,  end
	strh	lr, [r3, ip]	@ movhi 
	blt	.L34
.L36:
	ldr	lr, [sp], #4
	bx	lr
.L38:
	.align	2
.L37:
	.word	paletteMem
	.size	addToPalette, .-addToPalette
	.align	2
	.global	copyColumn
	.type	copyColumn, %function
copyColumn:
	@ Function supports interworking.
	@ args = 16, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r3, #0	@  sourceHeight
	stmfd	sp!, {r4, lr}
	mov	ip, r2	@  sourceWidth
	mov	r4, r3	@  sourceHeight
	ble	.L46
	add	r2, sp, #8
	ldmia	r2, {r2, r3}	@ phole ldm
	add	lr, r2, r3, asl #1	@  destination,  destStart
	ldr	r3, [sp, #16]	@  destWidth,  destWidth
	add	r0, r0, r1, asl #1	@  source,  sourceStart
	mov	r2, ip, asl #1	@  sourceWidth
	mov	r1, r3, asl #1	@  destWidth
	mov	ip, r4	@  y,  sourceHeight
.L44:
	ldrh	r3, [r0, #0]
	subs	ip, ip, #1	@  y,  y
	strh	r3, [lr, #0]	@ movhi 
	add	r0, r0, r2
	add	lr, lr, r1
	bne	.L44
.L46:
	ldmfd	sp!, {r4, lr}
	bx	lr
	.size	copyColumn, .-copyColumn
	.global	spriteData
	.data
	.align	2
	.type	spriteData, %object
	.size	spriteData, 4
spriteData:
	.word	100728832
	.text
	.align	2
	.global	copySpritePalette
	.type	copySpritePalette, %function
copySpritePalette:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r1, #83886080
	@ lr needed for prologue
	mov	r2, #0	@  i
	add	r1, r1, #512
.L52:
	mov	r3, r2, asl #1	@  i
	ldrh	ip, [r3, r0]	@ movhi	@ * myPalette
	add	r2, r2, #1	@  i,  i
	cmp	r2, #255	@  i
	strh	ip, [r3, r1]	@ movhi 
	ble	.L52
	bx	lr
	.size	copySpritePalette, .-copySpritePalette
	.align	2
	.global	writeToOAM
	.type	writeToOAM, %function
writeToOAM:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	ldr	ip, .L70
	mov	r0, #0	@  i
.L65:
	mov	r2, r0, asl #3	@  i
	mov	r1, #3	@  attr
.L64:
	ldrh	lr, [r2, ip]	@ movhi	@  <variable>.attributes.attribute
	add	r3, r2, #117440512
	subs	r1, r1, #1	@  attr,  attr
	strh	lr, [r3, #0]	@ movhi 
	add	r2, r2, #2
	bpl	.L64
	add	r0, r0, #1	@  i,  i
	cmp	r0, #127	@  i
	ble	.L65
	ldr	lr, [sp], #4
	bx	lr
.L71:
	.align	2
.L70:
	.word	sprites
	.size	writeToOAM, .-writeToOAM
	.align	2
	.global	copyToSpriteData
	.type	copyToSpriteData, %function
copyToSpriteData:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	mov	r4, r1, lsr #1	@  length
	mov	lr, #0	@  i
	cmp	lr, r4	@  i
	bcs	.L79
	ldr	r3, .L80
	ldr	r1, [r3, #0]	@  spriteData
	mov	ip, r2, asl #1	@  location
.L77:
	mov	r3, lr, asl #1	@  i
	ldrh	r2, [r3, r0]	@ * image
	add	lr, lr, #1	@  i,  i
	cmp	lr, r4	@  i
	strh	r2, [ip, r1]	@ movhi 
	add	ip, ip, #2
	bcc	.L77
.L79:
	ldmfd	sp!, {r4, lr}
	bx	lr
.L81:
	.align	2
.L80:
	.word	spriteData
	.size	copyToSpriteData, .-copyToSpriteData
	.align	2
	.global	copyToSpritePalette
	.type	copyToSpritePalette, %function
copyToSpritePalette:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	r3, #83886080	@  palette
	mov	ip, sp
	add	r3, r3, #512	@  palette,  palette
	stmfd	sp!, {fp, ip, lr, pc}
	mov	r1, r0	@  palette
	sub	fp, ip, #4
	mov	r0, r3	@  palette
	mov	r2, #256
	ldr	r3, .L83
	mov	lr, pc
	bx	r3
	ldmea	fp, {fp, sp, lr}
	bx	lr
.L84:
	.align	2
.L83:
	.word	memcpy
	.size	copyToSpritePalette, .-copyToSpritePalette
	.align	2
	.global	moveObject
	.type	moveObject, %function
moveObject:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	cmp	r1, #0	@  horizontal
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	mov	r6, r0	@  object
	mov	r7, r2	@  vertical
	mov	sl, r3	@  hitmap
	beq	.L86
	ldr	r3, [r0, #20]	@  <variable>.hSpeed
	cmp	r3, #0
	mvnlt	r5, #0	@  horizontalSign
	blt	.L88
	movle	r5, #0	@  horizontalSign
	movgt	r5, #1	@  horizontalSign
.L88:
	muls	r4, r1, r3	@  i,  horizontal
	beq	.L86
	ldr	r3, [fp, #4]	@  hOffset
	ldr	r9, .L108
	add	r8, r5, r3	@  horizontal,  horizontalSign
.L95:
	mov	r0, r6	@  object
	mov	r1, r8	@  horizontal
	ldr	r2, [fp, #8]	@  vOffset
	mov	r3, sl	@  hitmap
	mov	lr, pc
	bx	r9
	cmp	r0, #0	@  r
	bne	.L86
	ldr	r3, [r6, #0]	@  <variable>.parentSprite
	ldrh	r2, [r3, #2]
	mov	r1, r2, asl #23
	mov	r1, r1, lsr #23
	add	r1, r1, r5	@  horizontalSign
	mov	r2, r2, lsr #9
	orr	r2, r2, r1, asl #23
	mov	r2, r2, ror #23
	subs	r4, r4, r5	@  i,  i,  horizontalSign
	strh	r2, [r3, #2]	@ movhi 
	bne	.L95
.L86:
	cmp	r7, #0	@  vertical
	beq	.L96
	ldr	r3, [r6, #24]	@  <variable>.vSpeed
	cmp	r3, #0
	mvnlt	r5, #0	@  verticalSign
	blt	.L98
	movle	r5, #0	@  verticalSign
	movgt	r5, #1	@  verticalSign
.L98:
	muls	r4, r7, r3	@  i,  vertical
	beq	.L96
	ldr	r3, [fp, #8]	@  vOffset
	ldr	r9, .L108
	add	r7, r5, r3	@  vertical,  verticalSign
.L105:
	mov	r0, r6	@  object
	ldr	r1, [fp, #4]	@  hOffset
	mov	r2, r7	@  vertical
	mov	r3, sl	@  hitmap
	mov	lr, pc
	bx	r9
	cmp	r0, #0	@  r
	bne	.L96
	ldr	r2, [r6, #0]	@  <variable>.parentSprite
	ldrb	r3, [r2, #0]	@ zero_extendqisi2	@  <variable>.fields.y
	subs	r4, r4, r5	@  i,  i,  verticalSign
	add	r3, r3, r5	@  verticalSign
	strb	r3, [r2, #0]	@  <variable>.fields.y
	bne	.L105
.L96:
	mov	r0, #0
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L109:
	.align	2
.L108:
	.word	hitDetection
	.size	moveObject, .-moveObject
	.align	2
	.global	hitDetectionBackground
	.type	hitDetectionBackground, %function
hitDetectionBackground:
	@ Function supports interworking.
	@ args = 40, pretend = 16, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #16
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	sub	fp, ip, #20
	add	ip, fp, #4
	sub	sp, sp, #8
	stmia	ip, {r0, r1, r2, r3}
	ldr	r3, [fp, #20]	@  hb.parentSprite
	ldrb	r0, [r3, #0]	@ zero_extendqisi2
	ldrh	r1, [r3, #2]
	ldr	r3, [fp, #8]	@  hb.y
	ldrh	r2, [fp, #28]	@  vOffset
	add	r0, r0, r3
	mov	r1, r1, asl #23
	ldrsh	ip, [fp, #24]	@  hOffset,  hOffset
	ldr	lr, [fp, #4]	@  hb.x
	add	r0, r0, r2
	mov	r1, r1, lsr #23
	mov	ip, ip, asl #16	@  hOffset
	add	r1, r1, lr
	mov	r2, r0, asr #31
	add	r1, r1, ip, lsr #16
	add	r2, r0, r2, lsr #24
	bic	r2, r2, #255
	mov	r3, r1, asr #31
	rsb	r6, r2, r0	@  yCheck
	add	r3, r1, r3, lsr #24
	ldr	r2, [fp, #16]	@  hb.ySize
	bic	r3, r3, #255
	rsb	r4, r3, r1	@  xCheck
	add	r2, r6, r2	@  yCheck
	ldr	r3, [fp, #12]	@  hb.xSize
	mov	r8, #0	@  r
	str	ip, [fp, #-44]
	str	r2, [fp, #-48]	@  finalY
	add	sl, r4, r3	@  finalX,  xCheck
	mov	r5, r8	@  xDone,  r
	mov	r9, r8	@  yDone,  r
.L127:
	mov	r3, r6, asr #31	@  yCheck
	add	r3, r6, r3, lsr #29	@  yCheck
	mov	r7, r3, asr #3
.L123:
	mov	r3, r4, asr #31	@  xCheck
	ldr	r2, [fp, #40]	@  doCollisions
	add	r3, r4, r3, lsr #29	@  xCheck
	mov	r3, r3, asr #3
	add	r3, r3, r7, asl #5
	cmp	r2, #0
	ldr	r2, [fp, #32]	@  bgHitMap
	mov	r3, r3, asl #1
	ldrh	r3, [r3, r2]	@  bgItem
	ldr	r1, [fp, #36]	@  parentObject
	mov	r0, r3	@  bgItem
	bne	.L135
.L118:
	cmp	r8, r3	@  r,  bgItem
	movlt	r8, r3	@  r,  bgItem
	cmp	r5, #1	@  xDone
	add	r4, r4, #8	@  xCheck,  xCheck
	beq	.L132
	cmp	r4, sl	@  xCheck,  finalX
	movge	r5, #1	@  xDone
	movge	r4, sl	@  xCheck,  finalX
	cmp	r5, #2	@  xDone
	bne	.L123
.L132:
	ldr	r3, [fp, #20]	@  hb.parentSprite
	ldrh	r3, [r3, #2]
	ldr	lr, [fp, #4]	@  hb.x
	mov	r3, r3, asl #23
	ldr	r2, [fp, #-44]
	mov	r3, r3, lsr #23
	add	r3, r3, lr
	add	r3, r3, r2, lsr #16
	mov	r2, r3, asr #31
	add	r2, r3, r2, lsr #24
	bic	r2, r2, #255
	cmp	r9, #1	@  yDone
	rsb	r4, r2, r3	@  xCheck
	mov	r5, #0	@  xDone
	add	r6, r6, #8	@  yCheck,  yCheck
	beq	.L133
	ldr	r3, [fp, #-48]	@  finalY
	cmp	r6, r3	@  yCheck
	movge	r9, #1	@  yDone
	movge	r6, r3	@  yCheck
	cmp	r9, #2	@  yDone
	bne	.L127
.L133:
	mov	r0, r8	@  r
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L135:
	ldr	ip, [r1, #16]	@  <variable>.collisionHandler
	mov	lr, pc
	bx	ip
	mov	r3, r0	@  bgItem
	b	.L118
	.size	hitDetectionBackground, .-hitDetectionBackground
	.align	2
	.global	hitDetection
	.type	hitDetection, %function
hitDetection:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	mov	r9, r1, asl #16	@  hOffset
	mov	sl, r2, asl #16	@  vOffset
	sub	sp, sp, #44
	sub	fp, ip, #4
	mov	r8, r3	@  hitmap
	mov	r7, #0	@  r
	mov	r3, r9, lsr #16
	mov	r2, sl, lsr #16
	str	r3, [sp, #4]
	str	r2, [sp, #8]
	str	r8, [sp, #12]	@  hitmap
	str	r0, [sp, #16]	@  object
	str	r7, [sp, #20]	@  r
	ldr	ip, [r0, #4]	@  <variable>.masterHitBox
	ldr	r3, [ip, #16]
	str	r3, [sp, #0]
	mov	r4, r0	@  object
	ldmia	ip, {r0, r1, r2, r3}
	bl	hitDetectionBackground
	cmp	r0, r7	@  object
	beq	.L137
	ldr	lr, [r4, #8]	@  <variable>.hitBoxList
	sub	r5, fp, #60
	ldmia	lr!, {r0, r1, r2, r3}
	mov	ip, r5
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [r4, #12]	@  <variable>.hitBoxCount
	ldr	r2, [lr, #0]
	cmp	r7, r3	@  r
	str	r2, [ip, #0]
	mov	r6, r7	@  i,  r
	blt	.L143
.L137:
	mov	r0, r7	@  r
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L143:
	mov	lr, sl, lsr #16
	mov	ip, r9, lsr #16
	str	lr, [sp, #8]
	ldr	lr, [fp, #-44]	@  currenthb
	ldmia	r5, {r0, r1, r2, r3}
	str	ip, [sp, #4]
	mov	ip, #1
	str	ip, [sp, #20]
	str	lr, [sp, #0]
	str	r8, [sp, #12]	@  hitmap
	str	r4, [sp, #16]	@  object
	bl	hitDetectionBackground
	ldr	r3, [r4, #12]	@  <variable>.hitBoxCount
	add	r6, r6, #1	@  i,  i
	cmp	r7, r0	@  r,  hitValue
	movlt	r7, r0	@  r,  hitValue
	cmp	r6, r3	@  i
	blt	.L143
	b	.L137
	.size	hitDetection, .-hitDetection
	.align	2
	.global	gravityControls
	.type	gravityControls, %function
gravityControls:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, fp, ip, lr, pc}
	add	r2, r2, #1	@  vOffset,  vOffset
	sub	fp, ip, #4
	mov	r4, r0	@  object
	bl	hitDetection
	cmp	r0, #0	@  object
	ldreq	r3, [r4, #24]	@  <variable>.vSpeed
	addeq	r3, r3, #1
	beq	.L149
	ldr	r3, [r4, #24]	@  <variable>.vSpeed
	cmp	r3, #0
	ble	.L145
	mov	r3, #0
.L149:
	str	r3, [r4, #24]	@  <variable>.vSpeed
.L145:
	ldmea	fp, {r4, fp, sp, lr}
	bx	lr
	.size	gravityControls, .-gravityControls
	.align	2
	.global	playerCollisionHandler
	.type	playerCollisionHandler, %function
playerCollisionHandler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	subs	r0, r0, #0	@  r,  collisionID
	movne	r0, #1	@  r
	@ lr needed for prologue
	bx	lr
	.size	playerCollisionHandler, .-playerCollisionHandler
	.align	2
	.global	DMAFastCopy
	.type	DMAFastCopy, %function
DMAFastCopy:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	ip, #67108864
	cmp	r3, #-2080374784	@  mode
	cmpne	r3, #-2147483648	@  mode
	orr	r2, r2, r3	@  count,  mode
	streq	r0, [ip, #212]	@  source
	@ lr needed for prologue
	streq	r1, [ip, #216]	@  dest
	streq	r2, [ip, #220]
	bx	lr
	.size	DMAFastCopy, .-DMAFastCopy
	.global	sample
	.data
	.align	1
	.type	sample, %object
	.size	sample, 2
sample:
	.short	2097
	.global	SamplePosition0
	.bss
	.global	SamplePosition0
	.align	1
	.type	SamplePosition0, %object
	.size	SamplePosition0, 2
SamplePosition0:
	.space	2
	.global	SampleLength0
	.global	SampleLength0
	.align	1
	.type	SampleLength0, %object
	.size	SampleLength0, 2
SampleLength0:
	.space	2
	.global	SamplePosition1
	.global	SamplePosition1
	.align	1
	.type	SamplePosition1, %object
	.size	SamplePosition1, 2
SamplePosition1:
	.space	2
	.global	SampleLength1
	.global	SampleLength1
	.align	1
	.type	SampleLength1, %object
	.size	SampleLength1, 2
SampleLength1:
	.space	2
	.global	playing
	.global	playing
	.align	2
	.type	playing, %object
	.size	playing, 4
playing:
	.space	4
	.global	__divsi3
	.global	__floatsidf
	.global	__muldf3
	.global	__fixunsdfsi
	.text
	.align	2
	.global	PlaySound
	.type	PlaySound, %function
PlaySound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	mov	r2, #67108864
	mvn	r5, #18688
	mov	r3, #47872
	sub	fp, ip, #4
	mov	ip, #67108864
	mov	lr, ip
	mov	r4, r5
	strh	r3, [r2, #130]	@ movhi 
	cmp	r1, #0	@  music
	mov	r3, #128	@ movhi
	add	ip, ip, #160
	sub	r5, r5, #191
	add	lr, lr, #164
	sub	r4, r4, #191
	mov	r6, r1	@  music
	strh	r3, [r2, #132]	@ movhi 
	bne	.L158
	ldr	r3, [r0, #0]	@  <variable>.pBuffer
	str	r3, [r2, #188]
	str	ip, [r2, #192]
	ldr	r3, .L160+8
	strh	r5, [r2, #198]	@ movhi 
	ldr	r0, [r0, #8]	@  theSound,  <variable>.length
	ldrh	r1, [r3, #0]	@  music,  sample
	ldr	r3, .L160+12
	mov	lr, pc
	bx	r3
	ldr	r3, .L160+16
	mov	lr, pc
	bx	r3
	adr	r2, .L160
	ldmia	r2, {r2-r3}
	ldr	ip, .L160+20
	mov	lr, pc
	bx	ip
	ldr	r3, .L160+24
	mov	lr, pc
	bx	r3
	ldr	r3, .L160+28
	ldr	r2, .L160+32
	strh	r0, [r3, #0]	@ movhi 	@  theSound,  SampleLength0
	strh	r6, [r2, #0]	@ movhi 	@  music,  SamplePosition0
.L157:
	ldmea	fp, {r4, r5, r6, fp, sp, lr}
	bx	lr
.L158:
	ldr	ip, [r0, #0]	@  <variable>.pBuffer
	ldr	r3, .L160+8
	str	ip, [r2, #200]
	str	lr, [r2, #204]
	strh	r4, [r2, #210]	@ movhi 
	ldrh	r1, [r3, #0]	@  music,  sample
	ldr	r3, .L160+36
	ldr	r2, .L160+12
	str	ip, [r3, #0]	@  playing
	ldr	r0, [r0, #8]	@  theSound,  <variable>.length
	mov	lr, pc
	bx	r2
	ldr	r3, .L160+16
	mov	lr, pc
	bx	r3
	adr	r2, .L160
	ldmia	r2, {r2-r3}
	ldr	ip, .L160+20
	mov	lr, pc
	bx	ip
	ldr	r3, .L160+24
	mov	lr, pc
	bx	r3
	ldr	r3, .L160+40
	ldr	r2, .L160+44
	strh	r0, [r3, #0]	@ movhi 	@  theSound,  SampleLength1
	mov	r3, #0	@ movhi
	strh	r3, [r2, #0]	@ movhi 	@  SamplePosition1
	b	.L157
.L161:
	.align	2
.L160:
	.word	1076831191
	.word	171798692
	.word	sample
	.word	__divsi3
	.word	__floatsidf
	.word	__muldf3
	.word	__fixunsdfsi
	.word	SampleLength0
	.word	SamplePosition0
	.word	playing
	.word	SampleLength1
	.word	SamplePosition1
	.size	PlaySound, .-PlaySound
	.align	2
	.global	MyHandler
	.type	MyHandler, %function
MyHandler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, lr}
	mov	r3, #67108864
	add	r3, r3, #520
	mov	r1, #0	@ movhi
	mov	r2, #512
	strh	r1, [r3, #0]	@ movhi 
	add	r2, r2, #67108866
	ldrh	r3, [r2, #0]
	mov	r3, r3, asl #16
	mov	r0, #512
	mov	ip, #67108864
	tst	r3, #65536
	ldr	r4, .L168
	add	r0, r0, #67108866
	add	ip, ip, #520
	mov	lr, r3, asr #16	@  Int_Flag
	beq	.L163
	ldrh	r1, [r4, #0]	@  SampleLength0
	cmp	r1, #0
	ldr	r7, .L168+4
	ldr	r2, .L168+8
	beq	.L164
	ldrh	r3, [r2, #0]	@  SamplePosition0
	add	r3, r3, #1
	strh	r3, [r2, #0]	@ movhi 	@  SamplePosition0
	ldrh	r2, [r2, #0]	@  SamplePosition0
	cmp	r2, r1
	movhi	r2, #0	@ movhi
	movhi	r3, #67108864
	strhih	r2, [r3, #198]	@ movhi 
	strhih	r2, [r4, #0]	@ movhi 	@  SampleLength0
.L164:
	ldr	r3, .L168+12
	ldrh	r1, [r3, #0]	@  SampleLength1
	cmp	r1, #0
	beq	.L163
	ldrh	r2, [r7, #0]	@  SamplePosition1
	add	r2, r2, #1
	strh	r2, [r7, #0]	@ movhi 	@  SamplePosition1
	ldrh	r3, [r7, #0]	@  SamplePosition1
	mov	r5, #67108864
	mvn	r6, #18688
	cmp	r3, r1
	mov	r4, r5
	sub	r6, r6, #191
	add	r5, r5, #164
	bls	.L163
	ldr	r3, .L168+16
	ldr	r2, [r3, #0]	@  playing
	mov	r3, #0	@ movhi
	str	r2, [r4, #200]
	strh	r3, [r7, #0]	@ movhi 	@  SamplePosition1
	str	r5, [r4, #204]
	strh	r6, [r4, #210]	@ movhi 
.L163:
	mov	r1, #1	@ movhi
	strh	lr, [r0, #0]	@ movhi 	@  Int_Flag
	strh	r1, [ip, #0]	@ movhi 
	ldmfd	sp!, {r4, r5, r6, r7, lr}
	bx	lr
.L169:
	.align	2
.L168:
	.word	SampleLength0
	.word	SamplePosition1
	.word	SamplePosition0
	.word	SampleLength1
	.word	playing
	.size	MyHandler, .-MyHandler
	.align	2
	.global	StopSound
	.type	StopSound, %function
StopSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #67108864
	add	r3, r3, #520
	mov	r1, #0	@ movhi
	strh	r1, [r3, #0]	@ movhi 
	mov	r2, #512
	cmp	r0, #0	@  channel
	add	r2, r2, #67108866
	ldrsh	r1, [r2, #0]	@  Int_Flag
	mov	r3, #67108864
	movne	r2, #0	@ movhi
	strneh	r2, [r3, #210]	@ movhi 
	streqh	r0, [r3, #198]	@ movhi 	@  channel
	ldrne	r3, .L173
	ldreq	r3, .L173+4
	strneh	r2, [r3, #0]	@ movhi 	@  SampleLength1
	streqh	r0, [r3, #0]	@ movhi 	@  channel,  SampleLength0
	mov	r3, #512
	add	r3, r3, #67108866
	mov	r2, #67108864
	strh	r1, [r3, #0]	@ movhi 	@  Int_Flag
	add	r2, r2, #520
	mov	r3, #1	@ movhi
	@ lr needed for prologue
	strh	r3, [r2, #0]	@ movhi 
	bx	lr
.L174:
	.align	2
.L173:
	.word	SampleLength1
	.word	SampleLength0
	.size	StopSound, .-StopSound
	.align	2
	.global	setInterruptHandler
	.type	setInterruptHandler, %function
setInterruptHandler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	mov	ip, #67108864
	add	r1, ip, #512
	ldrh	r3, [r1, #0]
	orr	r3, r3, #1
	strh	r3, [r1, #0]	@ movhi 
	ldr	r3, .L176
	ldrh	r2, [ip, #4]
	mov	r1, #50331648
	add	r1, r1, #32512
	orr	r2, r2, #8
	add	lr, ip, #520
	str	r3, [r1, #252]
	mov	r3, #1	@ movhi
	strh	r2, [ip, #4]	@ movhi 
	strh	r3, [lr, #0]	@ movhi 
	ldr	lr, [sp], #4
	bx	lr
.L177:
	.align	2
.L176:
	.word	MyHandler
	.size	setInterruptHandler, .-setInterruptHandler
	.align	2
	.global	loadLevelOneHitMap
	.type	loadLevelOneHitMap, %function
loadLevelOneHitMap:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 4124
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	r4, fp, #4096	@  location
	sub	sp, sp, #4096
	sub	r4, r4, #40	@  location,  location
	sub	sp, sp, #28
	mov	r5, r0	@  location
	mov	r2, #4096
	mov	r1, #0
	mov	r0, r4	@  location
	ldr	r3, .L179
	mov	lr, pc
	bx	r3
	sub	r8, fp, #4096
	sub	r2, fp, #4096
	mov	r3, #1016
	mov	sl, #1020
	str	r3, [r2, #-44]
	str	sl, [r8, #-48]
	mov	r3, #1264
	mov	sl, #1744
	str	r3, [r2, #-52]
	str	sl, [r8, #-56]
	mov	r3, #2976
	add	sl, r4, #1016	@  location
	str	r3, [r2, #-60]
	str	sl, [r8, #-64]
	mov	r3, #2
	mov	r8, #1016
	add	sl, r8, r3
	sub	r8, fp, #4096
	str	sl, [r8, #-44]
	add	r8, r4, #1020	@  location
	sub	sl, fp, #4096
	str	r8, [sl, #-68]
	mov	sl, #1020
	add	r8, sl, r3
	sub	sl, fp, #4096
	str	r8, [sl, #-48]
	mov	r8, #1264
	add	sl, r8, r3
	sub	r8, fp, #4096
	str	sl, [r8, #-52]
	mov	sl, #1744
	add	r8, sl, r3
	sub	sl, fp, #4096
	str	r8, [sl, #-56]
	mov	r8, #2976
	add	sl, r8, r3
	sub	r8, fp, #4096
	str	sl, [r8, #-60]
	mov	sl, #1232
	add	sl, sl, #14
	strh	r3, [r4, sl]	@ movhi 	@  LevelOnePlatforms_Map
	ldr	r8, [r8, #-52]
	sub	sl, fp, #4096
	mov	ip, #1
	ldr	sl, [sl, #-64]
	strh	ip, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	sub	r8, fp, #4096
	strh	ip, [sl, #0]	@ movhi 	@  LevelOnePlatforms_Map
	ldr	r8, [r8, #-44]
	sub	sl, fp, #4096
	ldr	sl, [sl, #-68]
	strh	ip, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	sub	r8, fp, #4096
	strh	ip, [sl, #0]	@ movhi 	@  LevelOnePlatforms_Map
	ldr	r8, [r8, #-48]
	mov	sl, #1232
	add	sl, sl, #8
	strh	ip, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	strh	r3, [r4, sl]	@ movhi 	@  LevelOnePlatforms_Map
	mov	r8, #1232
	mov	sl, #1232
	add	r8, r8, #10
	add	sl, sl, #12
	strh	r3, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	strh	r3, [r4, sl]	@ movhi 	@  LevelOnePlatforms_Map
	mov	r3, #1248
	add	r3, r3, #12
	strh	ip, [r4, r3]	@ movhi 	@  LevelOnePlatforms_Map
	sub	r3, fp, #2864
	sub	r3, r3, #8
	strh	ip, [r3, #0]	@ movhi 	@  LevelOnePlatforms_Map
	mov	r6, #1024
	mov	r0, r5	@  location
	mov	r8, #1248
	mov	r5, #3
	mov	sl, #1456
	mov	r3, #1456
	add	r6, r6, r5
	add	r8, r8, #14
	add	sl, sl, #8
	add	r3, r3, #10
	mov	lr, #4
	strh	ip, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	strh	r5, [r4, sl]	@ movhi 	@  LevelOnePlatforms_Map
	strh	r6, [r4, r3]	@ movhi 	@  LevelOnePlatforms_Map
	mov	r8, #1488
	mov	sl, #1488
	mov	r3, #1680
	add	r8, r8, lr
	add	r3, r3, lr
	add	sl, sl, #6
	strh	r5, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	strh	r6, [r4, sl]	@ movhi 	@  LevelOnePlatforms_Map
	strh	lr, [r4, r3]	@ movhi 	@  LevelOnePlatforms_Map
	mov	r3, #1680
	add	r3, r3, #10
	strh	lr, [r4, r3]	@ movhi 	@  LevelOnePlatforms_Map
	sub	r3, fp, #2384
	sub	r3, r3, #8
	strh	r5, [r3, #0]	@ movhi 	@  LevelOnePlatforms_Map
	mov	r3, #1952
	add	r3, r3, #14
	strh	r6, [r4, r3]	@ movhi 	@  LevelOnePlatforms_Map
	sub	r3, fp, #1888
	sub	r3, r3, #8
	strh	r5, [r3, #0]	@ movhi 	@  LevelOnePlatforms_Map
	mov	r8, #1680
	mov	r3, #2240
	add	r8, r8, #6
	add	r3, r3, #2
	strh	lr, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	strh	r6, [r4, r3]	@ movhi 	@  LevelOnePlatforms_Map
	sub	r8, fp, #4096
	mov	sl, #1680
	mov	r3, #2240
	add	sl, sl, #8
	ldr	r8, [r8, #-56]
	add	r3, r3, #10
	strh	lr, [r4, sl]	@ movhi 	@  LevelOnePlatforms_Map
	strh	r6, [r4, r3]	@ movhi 	@  LevelOnePlatforms_Map
	mov	sl, #1952
	mov	r3, #3456
	strh	r6, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	add	sl, sl, #12
	add	r3, r3, #14
	mov	r8, #2176
	strh	r5, [r4, sl]	@ movhi 	@  LevelOnePlatforms_Map
	add	r8, r8, #12
	strh	lr, [r4, r3]	@ movhi 	@  LevelOnePlatforms_Map
	mov	sl, #2176
	sub	r3, fp, #656
	strh	lr, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	add	sl, sl, #14
	strh	r5, [r3, #0]	@ movhi 	@  LevelOnePlatforms_Map
	mov	r8, #2240
	sub	r3, fp, #1440
	mov	r9, #2688
	add	r8, r8, lr
	strh	lr, [r4, sl]	@ movhi 	@  LevelOnePlatforms_Map
	sub	r3, r3, #8
	mov	sl, #2240
	strh	r5, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	add	sl, sl, #6
	strh	lr, [r3, #0]	@ movhi 	@  LevelOnePlatforms_Map
	mov	r8, #2464
	add	r3, r9, lr
	strh	r6, [r4, sl]	@ movhi 	@  LevelOnePlatforms_Map
	add	r8, r8, #8
	strh	lr, [r4, r3]	@ movhi 	@  LevelOnePlatforms_Map
	mov	sl, #2464
	sub	r3, fp, #1152
	strh	r5, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	add	sl, sl, #10
	sub	r3, r3, #8
	mov	r8, #3472
	strh	r6, [r4, sl]	@ movhi 	@  LevelOnePlatforms_Map
	add	r8, r8, #10
	add	sl, r9, #2
	strh	r5, [r3, #0]	@ movhi 	@  LevelOnePlatforms_Map
	sub	r3, fp, #672
	strh	r6, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	strh	lr, [r4, sl]	@ movhi 	@  LevelOnePlatforms_Map
	add	r8, r9, #6
	sub	sl, fp, #4096
	strh	lr, [r3, #0]	@ movhi 	@  LevelOnePlatforms_Map
	mov	r3, #3456
	strh	lr, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	ldr	sl, [sl, #-60]
	add	r3, r3, #10
	mov	r7, #2240
	mov	r8, #3472
	add	r7, r7, #8
	strh	lr, [r4, r3]	@ movhi 	@  LevelOnePlatforms_Map
	sub	ip, fp, #660
	sub	r3, fp, #668
	add	r8, r8, #6
	strh	lr, [r3, #0]	@ movhi 	@  LevelOnePlatforms_Map
	mov	r1, r4	@  location
	mov	r2, #2048
	strh	r5, [r4, r7]	@ movhi 	@  LevelOnePlatforms_Map
	strh	r6, [r4, sl]	@ movhi 	@  LevelOnePlatforms_Map
	strh	r5, [ip, #0]	@ movhi 	@  LevelOnePlatforms_Map
	strh	r6, [r4, r8]	@ movhi 	@  LevelOnePlatforms_Map
	ldr	r3, .L179+4
	mov	lr, pc
	bx	r3
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L180:
	.align	2
.L179:
	.word	memset
	.word	memcpy
	.size	loadLevelOneHitMap, .-loadLevelOneHitMap
	.section	.rodata
.LC0:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	2
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	2
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	2
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	2
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	2
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	2
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	2
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	2
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	2
	.byte	5
	.byte	2
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	2
	.byte	5
	.byte	2
	.byte	5
	.byte	2
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.byte	3
	.byte	3
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.byte	3
	.byte	3
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.text
	.align	2
	.global	loadLevelOnePlatformTiles
	.type	loadLevelOnePlatformTiles, %function
loadLevelOnePlatformTiles:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 320
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #320
	sub	r4, fp, #340	@  location
	mov	r5, r0	@  location
	mov	r2, #320
	ldr	r1, .L182
	mov	r0, r4	@  location
	ldr	r3, .L182+4
	mov	lr, pc
	bx	r3
	mov	r0, r4	@  location
	mov	r1, r5	@  location
	mov	r2, #80
	mov	r3, #-2080374784
	bl	DMAFastCopy
	ldmea	fp, {r4, r5, fp, sp, lr}
	bx	lr
.L183:
	.align	2
.L182:
	.word	.LC0
	.word	memcpy
	.size	loadLevelOnePlatformTiles, .-loadLevelOnePlatformTiles
	.align	2
	.global	loadLevelOnePalette
	.type	loadLevelOnePalette, %function
loadLevelOnePalette:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 572
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	r9, fp, #552
	sub	sp, sp, #572
	mov	r2, #512
	mov	r1, #0
	mov	r0, r9
	ldr	r3, .L185
	mov	lr, pc
	bx	r3
	mov	r0, r9
	mvn	r9, #508
	sub	r9, r9, #1
	str	r9, [fp, #-556]
	mov	r9, #5248
	add	r9, r9, #58
	str	r9, [fp, #-564]
	mov	r9, #-2113929216
	mov	r9, r9, asr #22
	str	r9, [fp, #-572]
	mvn	r9, #500
	sub	r9, r9, #1
	str	r9, [fp, #-580]
	mov	r9, #16896
	add	r9, r9, #16
	str	r9, [fp, #-588]
	mov	r9, #10752
	add	r9, r9, #21
	str	r9, [fp, #-596]
	mov	r9, #10880
	add	r9, r9, #7
	str	r9, [fp, #-604]
	mov	r9, #-2063597568
	mov	r4, #-2147483648
	mov	r9, r9, asr #22
	mov	ip, #8448
	str	r9, [fp, #-612]
	mov	r3, r4
	sub	r9, fp, #40
	mov	r4, r4, asr #22
	add	ip, ip, #8
	mov	r2, #-2130706432
	strh	ip, [r9, r4]	@ movhi 	@  LevelOnePalette_Palette
	mov	r2, r2, asr #22
	ldr	r4, [fp, #-556]
	mov	r9, #8448
	str	r2, [fp, #-560]
	sub	ip, fp, #40
	add	r9, r9, #11
	mvn	r2, #504
	strh	r9, [ip, r4]	@ movhi 	@  LevelOnePalette_Palette
	sub	r2, r2, #1
	sub	ip, fp, #512
	str	r2, [fp, #-568]
	ldrh	r9, [ip, #-52]	@ movhi
	ldr	r4, [fp, #-560]
	mov	r2, #10496
	sub	ip, fp, #40
	add	r2, r2, #23
	str	r2, [fp, #-576]
	strh	r9, [ip, r4]	@ movhi 	@  LevelOnePalette_Palette
	mov	lr, #21760
	ldr	r4, [fp, #-568]
	sub	r9, fp, #512
	add	lr, lr, #74
	strh	lr, [ip, r4]	@ movhi 	@  LevelOnePalette_Palette
	mov	r2, #-2097152000
	ldrh	lr, [r9, #-64]	@ movhi
	ldr	ip, [fp, #-572]
	sub	r9, fp, #40
	mov	r2, r2, asr #22
	str	r2, [fp, #-584]
	strh	lr, [r9, ip]	@ movhi 	@  LevelOnePalette_Palette
	mvn	r2, #496
	ldr	r9, [fp, #-580]
	mov	ip, #21760
	sub	r4, fp, #40
	sub	lr, fp, #512
	sub	r2, r2, #1
	add	ip, ip, #82
	str	r2, [fp, #-592]
	strh	ip, [r4, r9]	@ movhi 	@  LevelOnePalette_Palette
	mov	r2, #-2080374784
	ldrh	r9, [lr, #-76]	@ movhi
	ldr	r4, [fp, #-584]
	sub	lr, fp, #40
	sub	ip, fp, #512
	mov	r2, r2, asr #22
	strh	r9, [lr, r4]	@ movhi 	@  LevelOnePalette_Palette
	str	r2, [fp, #-600]
	ldrh	r4, [ip, #-84]	@ movhi
	ldr	lr, [fp, #-592]
	mvn	r2, #492
	sub	ip, fp, #40
	sub	r9, fp, #512
	sub	r2, r2, #1
	str	r2, [fp, #-608]
	strh	r4, [ip, lr]	@ movhi 	@  LevelOnePalette_Palette
	ldrh	lr, [r9, #-92]	@ movhi
	ldr	ip, [fp, #-600]
	sub	r9, fp, #40
	strh	lr, [r9, ip]	@ movhi 	@  LevelOnePalette_Palette
	mov	sl, #11776
	ldr	r9, [fp, #-608]
	ldr	lr, [fp, #-612]
	mov	r6, #25344
	sub	r4, fp, #40
	sub	ip, fp, #40
	add	sl, sl, #24
	add	r6, r6, #24
	mvn	r7, #488
	mov	r5, #5952
	mov	r8, #-2046820352
	sub	r7, r7, #1
	add	r5, r5, #26
	mov	r8, r8, asr #22
	strh	sl, [r4, r9]	@ movhi 	@  LevelOnePalette_Palette
	strh	r6, [ip, lr]	@ movhi 	@  LevelOnePalette_Palette
	sub	r9, fp, #40
	mvn	ip, #32768
	mov	r1, #83886080
	mov	r2, #256
	strh	r5, [r4, r7]	@ movhi 	@  LevelOnePalette_Palette
	strh	ip, [r9, r8]	@ movhi 	@  LevelOnePalette_Palette
	bl	DMAFastCopy
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L186:
	.align	2
.L185:
	.word	memset
	.size	loadLevelOnePalette, .-loadLevelOnePalette
	.global	ChameleonData
	.section	.rodata
	.align	1
	.type	ChameleonData, %object
	.size	ChameleonData, 10240
ChameleonData:
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	5911
	.short	5888
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	588
	.short	0
	.short	23
	.short	5890
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	2
	.short	19712
	.short	77
	.short	19712
	.short	77
	.short	0
	.short	77
	.short	0
	.short	77
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	76
	.short	0
	.short	2
	.short	0
	.short	19532
	.short	19712
	.short	77
	.short	0
	.short	19456
	.short	0
	.short	77
	.short	0
	.short	5912
	.short	5911
	.short	5964
	.short	19479
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	19456
	.short	0
	.short	0
	.short	5888
	.short	19456
	.short	0
	.short	0
	.short	5888
	.short	5888
	.short	0
	.short	0
	.short	5911
	.short	19790
	.short	5966
	.short	0
	.short	0
	.short	0
	.short	5964
	.short	5911
	.short	0
	.short	0
	.short	2
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	535
	.short	5964
	.short	535
	.short	5964
	.short	535
	.short	5911
	.short	535
	.short	5911
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	19533
	.short	19789
	.short	19789
	.short	19789
	.short	257
	.short	1
	.short	0
	.short	256
	.short	19969
	.short	1
	.short	0
	.short	256
	.short	257
	.short	1
	.short	0
	.short	256
	.short	19533
	.short	19789
	.short	19789
	.short	19789
	.short	535
	.short	5964
	.short	6167
	.short	19532
	.short	535
	.short	5911
	.short	6167
	.short	5912
	.short	5911
	.short	5964
	.short	19479
	.short	19532
	.short	19788
	.short	77
	.short	6144
	.short	24
	.short	257
	.short	19789
	.short	0
	.short	76
	.short	334
	.short	19532
	.short	19456
	.short	76
	.short	257
	.short	19789
	.short	0
	.short	0
	.short	19788
	.short	77
	.short	0
	.short	0
	.short	5911
	.short	589
	.short	5965
	.short	23
	.short	5911
	.short	19790
	.short	5966
	.short	23
	.short	5911
	.short	5911
	.short	5911
	.short	23
	.short	23
	.short	5911
	.short	5911
	.short	0
	.short	76
	.short	76
	.short	0
	.short	0
	.short	76
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	5911
	.short	5888
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	588
	.short	0
	.short	23
	.short	5890
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	2
	.short	19712
	.short	77
	.short	19712
	.short	77
	.short	0
	.short	77
	.short	0
	.short	77
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	76
	.short	0
	.short	2
	.short	0
	.short	19532
	.short	19712
	.short	77
	.short	0
	.short	19456
	.short	0
	.short	77
	.short	0
	.short	5912
	.short	5911
	.short	5964
	.short	19479
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	19456
	.short	0
	.short	0
	.short	5888
	.short	19456
	.short	0
	.short	0
	.short	5888
	.short	5888
	.short	0
	.short	0
	.short	5911
	.short	19790
	.short	5966
	.short	0
	.short	0
	.short	0
	.short	5964
	.short	5911
	.short	0
	.short	0
	.short	2
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	535
	.short	5964
	.short	535
	.short	5964
	.short	535
	.short	5911
	.short	535
	.short	5911
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	19789
	.short	19533
	.short	19789
	.short	19788
	.short	257
	.short	1
	.short	0
	.short	256
	.short	19969
	.short	1
	.short	0
	.short	256
	.short	257
	.short	1
	.short	0
	.short	256
	.short	19789
	.short	19533
	.short	19789
	.short	19788
	.short	535
	.short	5964
	.short	6167
	.short	19532
	.short	535
	.short	5911
	.short	6167
	.short	5912
	.short	5911
	.short	5964
	.short	19479
	.short	19532
	.short	19789
	.short	77
	.short	6144
	.short	24
	.short	257
	.short	19532
	.short	0
	.short	76
	.short	334
	.short	19789
	.short	19456
	.short	76
	.short	257
	.short	19532
	.short	0
	.short	0
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	5911
	.short	589
	.short	5965
	.short	23
	.short	5911
	.short	19790
	.short	5966
	.short	23
	.short	5911
	.short	5911
	.short	5911
	.short	23
	.short	23
	.short	5911
	.short	5911
	.short	0
	.short	76
	.short	76
	.short	0
	.short	0
	.short	76
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	5911
	.short	5888
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	588
	.short	0
	.short	23
	.short	5890
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	2
	.short	19712
	.short	77
	.short	19712
	.short	77
	.short	0
	.short	77
	.short	0
	.short	77
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	76
	.short	0
	.short	2
	.short	0
	.short	19532
	.short	19712
	.short	77
	.short	0
	.short	19456
	.short	0
	.short	77
	.short	0
	.short	5912
	.short	5911
	.short	5964
	.short	19479
	.short	5964
	.short	19456
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	19456
	.short	0
	.short	0
	.short	5888
	.short	19456
	.short	0
	.short	0
	.short	5888
	.short	5888
	.short	0
	.short	0
	.short	5911
	.short	19790
	.short	5966
	.short	0
	.short	5911
	.short	589
	.short	5965
	.short	23
	.short	5911
	.short	19790
	.short	5966
	.short	23
	.short	77
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	5964
	.short	5911
	.short	0
	.short	0
	.short	2
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	535
	.short	5964
	.short	535
	.short	5964
	.short	535
	.short	5911
	.short	535
	.short	5911
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	19533
	.short	19789
	.short	19789
	.short	19789
	.short	257
	.short	1
	.short	0
	.short	256
	.short	19969
	.short	1
	.short	0
	.short	256
	.short	257
	.short	1
	.short	0
	.short	256
	.short	19533
	.short	19789
	.short	19789
	.short	19789
	.short	535
	.short	5964
	.short	6167
	.short	19532
	.short	535
	.short	5911
	.short	6167
	.short	5912
	.short	5911
	.short	5964
	.short	19479
	.short	19532
	.short	19788
	.short	77
	.short	6144
	.short	24
	.short	257
	.short	19789
	.short	0
	.short	76
	.short	334
	.short	19532
	.short	19456
	.short	76
	.short	257
	.short	19789
	.short	0
	.short	0
	.short	19788
	.short	77
	.short	0
	.short	0
	.short	2381
	.short	2381
	.short	2381
	.short	2381
	.short	2381
	.short	2381
	.short	2381
	.short	2381
	.short	77
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	5911
	.short	5911
	.short	23
	.short	23
	.short	5911
	.short	5911
	.short	0
	.short	76
	.short	76
	.short	0
	.short	0
	.short	76
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	5911
	.short	5888
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	588
	.short	0
	.short	23
	.short	5890
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	2
	.short	19712
	.short	77
	.short	19712
	.short	77
	.short	0
	.short	77
	.short	0
	.short	77
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	76
	.short	0
	.short	2
	.short	0
	.short	19532
	.short	19712
	.short	77
	.short	0
	.short	19456
	.short	0
	.short	77
	.short	0
	.short	5912
	.short	5911
	.short	5964
	.short	19479
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	19456
	.short	0
	.short	0
	.short	5888
	.short	19456
	.short	0
	.short	0
	.short	5888
	.short	5888
	.short	0
	.short	0
	.short	5911
	.short	19790
	.short	5966
	.short	0
	.short	0
	.short	0
	.short	5964
	.short	5911
	.short	0
	.short	0
	.short	2
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	535
	.short	5964
	.short	535
	.short	5964
	.short	535
	.short	5911
	.short	535
	.short	5911
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	9987
	.short	3
	.short	0
	.short	0
	.short	770
	.short	2
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	0
	.short	535
	.short	5964
	.short	6167
	.short	19532
	.short	535
	.short	5911
	.short	6167
	.short	5912
	.short	5911
	.short	5964
	.short	19479
	.short	19532
	.short	19712
	.short	19789
	.short	6144
	.short	24
	.short	19712
	.short	19789
	.short	0
	.short	76
	.short	768
	.short	807
	.short	19456
	.short	76
	.short	512
	.short	515
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	5911
	.short	589
	.short	5965
	.short	23
	.short	5911
	.short	19790
	.short	5966
	.short	23
	.short	5911
	.short	5911
	.short	5911
	.short	23
	.short	23
	.short	5911
	.short	5911
	.short	0
	.short	76
	.short	76
	.short	0
	.short	0
	.short	76
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	5911
	.short	5888
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	588
	.short	0
	.short	23
	.short	5890
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	2
	.short	19712
	.short	77
	.short	19712
	.short	77
	.short	0
	.short	77
	.short	0
	.short	77
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	76
	.short	0
	.short	2
	.short	0
	.short	19532
	.short	19712
	.short	77
	.short	0
	.short	19456
	.short	0
	.short	77
	.short	0
	.short	5912
	.short	5911
	.short	5964
	.short	19479
	.short	5964
	.short	19456
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	19456
	.short	0
	.short	0
	.short	5888
	.short	19456
	.short	0
	.short	0
	.short	5888
	.short	5888
	.short	0
	.short	0
	.short	5911
	.short	19790
	.short	5966
	.short	0
	.short	5911
	.short	589
	.short	5965
	.short	23
	.short	5911
	.short	19790
	.short	5966
	.short	23
	.short	77
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	5964
	.short	5911
	.short	0
	.short	0
	.short	2
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	535
	.short	5964
	.short	535
	.short	5964
	.short	535
	.short	5911
	.short	535
	.short	5911
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	9987
	.short	3
	.short	0
	.short	0
	.short	770
	.short	2
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	0
	.short	535
	.short	5964
	.short	6167
	.short	19532
	.short	535
	.short	5911
	.short	6167
	.short	5912
	.short	5911
	.short	5964
	.short	19479
	.short	19532
	.short	19712
	.short	19789
	.short	6144
	.short	24
	.short	19712
	.short	19789
	.short	0
	.short	76
	.short	768
	.short	807
	.short	19456
	.short	76
	.short	512
	.short	515
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	2381
	.short	2381
	.short	2381
	.short	2381
	.short	2381
	.short	2381
	.short	2381
	.short	2381
	.short	77
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	5911
	.short	5911
	.short	23
	.short	23
	.short	5911
	.short	5911
	.short	0
	.short	76
	.short	76
	.short	0
	.short	0
	.short	76
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	5911
	.short	5888
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	588
	.short	0
	.short	23
	.short	5890
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	2
	.short	19712
	.short	77
	.short	19712
	.short	77
	.short	0
	.short	77
	.short	0
	.short	77
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	19456
	.short	19532
	.short	19712
	.short	77
	.short	0
	.short	19456
	.short	0
	.short	77
	.short	0
	.short	5888
	.short	5911
	.short	5964
	.short	6167
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	0
	.short	0
	.short	0
	.short	5888
	.short	19790
	.short	5966
	.short	23
	.short	5911
	.short	589
	.short	5965
	.short	23
	.short	5911
	.short	19790
	.short	5966
	.short	23
	.short	5911
	.short	5911
	.short	5911
	.short	23
	.short	0
	.short	0
	.short	5964
	.short	5911
	.short	0
	.short	0
	.short	2
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	535
	.short	5964
	.short	535
	.short	5964
	.short	535
	.short	5911
	.short	535
	.short	5911
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	19533
	.short	19789
	.short	19789
	.short	19789
	.short	257
	.short	1
	.short	0
	.short	256
	.short	19969
	.short	1
	.short	0
	.short	256
	.short	257
	.short	1
	.short	0
	.short	256
	.short	19533
	.short	19789
	.short	19789
	.short	19789
	.short	535
	.short	5964
	.short	19479
	.short	5964
	.short	535
	.short	5911
	.short	6167
	.short	19480
	.short	5911
	.short	5964
	.short	6167
	.short	19480
	.short	19788
	.short	77
	.short	0
	.short	0
	.short	257
	.short	19789
	.short	0
	.short	0
	.short	334
	.short	19532
	.short	0
	.short	0
	.short	257
	.short	19789
	.short	0
	.short	0
	.short	19788
	.short	77
	.short	0
	.short	0
	.short	5911
	.short	5911
	.short	5911
	.short	23
	.short	5964
	.short	5911
	.short	5911
	.short	23
	.short	5911
	.short	5911
	.short	76
	.short	0
	.short	19456
	.short	0
	.short	76
	.short	0
	.short	19532
	.short	0
	.short	76
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	5911
	.short	5888
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	588
	.short	0
	.short	23
	.short	5890
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	2
	.short	19712
	.short	77
	.short	19712
	.short	77
	.short	0
	.short	77
	.short	0
	.short	77
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	0
	.short	2
	.short	0
	.short	5888
	.short	19712
	.short	77
	.short	0
	.short	19532
	.short	0
	.short	77
	.short	19456
	.short	5964
	.short	5911
	.short	5964
	.short	6167
	.short	5912
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	0
	.short	0
	.short	0
	.short	5888
	.short	19790
	.short	5966
	.short	23
	.short	5911
	.short	589
	.short	5965
	.short	23
	.short	5911
	.short	19790
	.short	5966
	.short	2304
	.short	5911
	.short	5911
	.short	23
	.short	2381
	.short	5911
	.short	23
	.short	2304
	.short	19721
	.short	5911
	.short	23
	.short	2381
	.short	9
	.short	0
	.short	0
	.short	5964
	.short	5911
	.short	0
	.short	0
	.short	2
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	535
	.short	5964
	.short	535
	.short	5964
	.short	535
	.short	5911
	.short	535
	.short	5911
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	19533
	.short	19789
	.short	19789
	.short	19789
	.short	257
	.short	1
	.short	0
	.short	256
	.short	19969
	.short	1
	.short	0
	.short	256
	.short	257
	.short	1
	.short	0
	.short	256
	.short	19533
	.short	19789
	.short	19789
	.short	19789
	.short	535
	.short	5964
	.short	6167
	.short	19532
	.short	535
	.short	5911
	.short	19479
	.short	5964
	.short	5911
	.short	5964
	.short	6167
	.short	5912
	.short	19788
	.short	77
	.short	0
	.short	0
	.short	257
	.short	19789
	.short	0
	.short	0
	.short	334
	.short	19532
	.short	0
	.short	0
	.short	257
	.short	19789
	.short	0
	.short	0
	.short	19788
	.short	77
	.short	0
	.short	0
	.short	5911
	.short	2304
	.short	19721
	.short	0
	.short	23
	.short	2381
	.short	9
	.short	5911
	.short	2381
	.short	19721
	.short	5888
	.short	5911
	.short	19789
	.short	9
	.short	5911
	.short	19479
	.short	19712
	.short	5965
	.short	5911
	.short	0
	.short	19456
	.short	5964
	.short	19479
	.short	0
	.short	19456
	.short	0
	.short	0
	.short	76
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	5911
	.short	5888
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	588
	.short	0
	.short	23
	.short	5890
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	2
	.short	19712
	.short	77
	.short	19712
	.short	77
	.short	0
	.short	77
	.short	0
	.short	77
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	19456
	.short	19532
	.short	19712
	.short	77
	.short	0
	.short	19456
	.short	0
	.short	77
	.short	0
	.short	5888
	.short	5911
	.short	5964
	.short	6167
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	0
	.short	0
	.short	0
	.short	5888
	.short	19790
	.short	5966
	.short	23
	.short	5911
	.short	589
	.short	5965
	.short	23
	.short	5911
	.short	19790
	.short	5966
	.short	23
	.short	5911
	.short	5911
	.short	5911
	.short	23
	.short	0
	.short	0
	.short	5964
	.short	5911
	.short	0
	.short	0
	.short	2
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	535
	.short	5964
	.short	535
	.short	5964
	.short	535
	.short	5911
	.short	535
	.short	5911
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	9987
	.short	3
	.short	0
	.short	0
	.short	770
	.short	2
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	0
	.short	535
	.short	5964
	.short	19479
	.short	5964
	.short	535
	.short	5911
	.short	6167
	.short	19480
	.short	5911
	.short	5964
	.short	6167
	.short	19480
	.short	19712
	.short	19789
	.short	0
	.short	0
	.short	19712
	.short	19789
	.short	0
	.short	0
	.short	768
	.short	807
	.short	0
	.short	0
	.short	512
	.short	515
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	5911
	.short	5911
	.short	5911
	.short	23
	.short	5964
	.short	5911
	.short	5911
	.short	23
	.short	5911
	.short	5911
	.short	76
	.short	0
	.short	19456
	.short	0
	.short	76
	.short	0
	.short	19532
	.short	0
	.short	76
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	5911
	.short	5888
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	588
	.short	0
	.short	23
	.short	5890
	.short	23
	.short	19458
	.short	76
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5888
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	2
	.short	19712
	.short	77
	.short	19712
	.short	77
	.short	0
	.short	77
	.short	0
	.short	77
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	0
	.short	2
	.short	0
	.short	5888
	.short	19712
	.short	77
	.short	0
	.short	19532
	.short	0
	.short	77
	.short	19456
	.short	5964
	.short	5911
	.short	5964
	.short	6167
	.short	5912
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	0
	.short	0
	.short	0
	.short	5888
	.short	19790
	.short	5966
	.short	23
	.short	5911
	.short	589
	.short	5965
	.short	23
	.short	5911
	.short	19790
	.short	5966
	.short	2304
	.short	5911
	.short	5911
	.short	23
	.short	2381
	.short	5911
	.short	23
	.short	2304
	.short	19721
	.short	5911
	.short	23
	.short	2381
	.short	9
	.short	0
	.short	0
	.short	5964
	.short	5911
	.short	0
	.short	0
	.short	2
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	5911
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	535
	.short	5964
	.short	535
	.short	5964
	.short	535
	.short	5911
	.short	535
	.short	5911
	.short	5911
	.short	5964
	.short	5911
	.short	5964
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	9987
	.short	3
	.short	0
	.short	0
	.short	770
	.short	2
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	0
	.short	535
	.short	5964
	.short	6167
	.short	19532
	.short	535
	.short	5911
	.short	19479
	.short	5964
	.short	5911
	.short	5964
	.short	6167
	.short	5912
	.short	19712
	.short	19789
	.short	0
	.short	0
	.short	19712
	.short	19789
	.short	0
	.short	0
	.short	768
	.short	807
	.short	0
	.short	0
	.short	512
	.short	515
	.short	0
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	5911
	.short	2304
	.short	19721
	.short	0
	.short	23
	.short	2381
	.short	9
	.short	5911
	.short	2381
	.short	19721
	.short	5888
	.short	5911
	.short	19789
	.short	9
	.short	5911
	.short	19479
	.short	19712
	.short	5965
	.short	5911
	.short	0
	.short	19456
	.short	5964
	.short	19479
	.short	0
	.short	19456
	.short	0
	.short	0
	.short	76
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2304
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	9
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19721
	.short	19721
	.short	19721
	.short	19721
	.short	19721
	.short	19721
	.short	19721
	.short	19721
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19721
	.short	19721
	.short	19721
	.short	19465
	.short	19721
	.short	19721
	.short	19721
	.short	19465
	.short	0
	.short	0
	.short	0
	.short	2304
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2380
	.short	0
	.short	0
	.short	0
	.short	2380
	.short	0
	.short	0
	.short	0
	.short	9
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.space	5120
	.global	ChameleonPalette
	.align	1
	.type	ChameleonPalette, %object
	.size	ChameleonPalette, 512
ChameleonPalette:
	.short	6328
	.short	2
	.short	1086
	.short	3194
	.short	6358
	.short	7404
	.short	2131
	.short	1071
	.short	1066
	.short	8478
	.short	11645
	.short	17981
	.short	23261
	.short	29734
	.short	23785
	.short	15625
	.short	8358
	.short	20516
	.short	10242
	.short	29963
	.short	30160
	.short	30292
	.short	30456
	.short	2982
	.short	5864
	.short	7656
	.short	6438
	.short	1701
	.short	1378
	.short	8107
	.short	16305
	.short	22454
	.short	3005
	.short	4921
	.short	7696
	.short	6474
	.short	1717
	.short	495
	.short	297
	.short	7101
	.short	12221
	.short	18365
	.short	23485
	.short	2556
	.short	5590
	.short	7536
	.short	6410
	.short	1397
	.short	1296
	.short	203
	.short	5660
	.short	10876
	.short	15037
	.short	23390
	.short	29784
	.short	23764
	.short	16623
	.short	10474
	.short	21554
	.short	16429
	.short	10248
	.short	29945
	.short	30042
	.short	30267
	.short	30428
	.short	27523
	.short	21190
	.short	15880
	.short	10566
	.short	20130
	.short	15873
	.short	11649
	.short	28585
	.short	28590
	.short	29619
	.short	30648
	.short	10570
	.short	19026
	.short	27482
	.short	32767
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	bg0map
	.data
	.align	2
	.type	bg0map, %object
	.size	bg0map, 4
bg0map:
	.word	100726784
	.global	bg1map
	.align	2
	.type	bg1map, %object
	.size	bg1map, 4
bg1map:
	.word	100696064
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	ldr	r3, .L192
	sub	fp, ip, #4
	mov	lr, pc
	bx	r3
	ldr	r5, .L192+4
	ldr	r4, .L192+8
.L191:
	mov	lr, pc
	bx	r5
	mov	lr, pc
	bx	r4
	b	.L191
.L193:
	.align	2
.L192:
	.word	init
	.word	update
	.word	draw
	.size	main, .-main
	.align	2
	.global	init
	.type	init, %function
init:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	mov	r1, #0
	mov	r3, #67108864
	stmfd	sp!, {fp, ip, lr, pc}
	ldr	r2, .L195
	str	r1, [r3, #0]
	sub	fp, ip, #4
	mov	lr, pc
	bx	r2
	ldr	r3, .L195+4
	mov	lr, pc
	bx	r3
	ldr	r2, .L195+8
	mov	lr, pc
	bx	r2
	ldmea	fp, {fp, sp, lr}
	bx	lr
.L196:
	.align	2
.L195:
	.word	backgroundSetup
	.word	objectSetup
	.word	timerSetup
	.size	init, .-init
	.align	2
	.global	timerSetup
	.type	timerSetup, %function
timerSetup:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	ldr	r3, .L198
	sub	fp, ip, #4
	mov	lr, pc
	bx	r3
	ldr	r2, .L198+4
	mov	lr, pc
	bx	r2
	ldmea	fp, {fp, sp, lr}
	bx	lr
.L199:
	.align	2
.L198:
	.word	buttonTimerSetup
	.word	soundTimerSetup
	.size	timerSetup, .-timerSetup
	.align	2
	.global	soundTimerSetup
	.type	soundTimerSetup, %function
soundTimerSetup:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #256
	mov	r3, #67108864
	add	r3, r3, r2
	mvn	r1, #2096	@ movhi
	strh	r1, [r3, #0]	@ movhi 
	add	r2, r2, #67108866
	mov	r3, #128	@ movhi
	@ lr needed for prologue
	strh	r3, [r2, #0]	@ movhi 
	bx	lr
	.size	soundTimerSetup, .-soundTimerSetup
	.align	2
	.global	buttonTimerSetup
	.type	buttonTimerSetup, %function
buttonTimerSetup:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r0, #67108864
	add	ip, r0, #264
	mov	r3, #59904
	mov	r2, #264
	strh	r3, [ip, #0]	@ movhi 
	add	r2, r2, #67108866
	mov	r3, #1	@ movhi
	mov	r1, #268
	strh	r3, [r2, #0]	@ movhi 
	add	r1, r1, #67108866
	mov	r3, #133	@ movhi
	strh	r3, [r1, #0]	@ movhi 
	ldrh	r3, [r2, #0]
	orr	r3, r3, #128
	strh	r3, [r2, #0]	@ movhi 
	add	r0, r0, #268
	ldrh	r2, [r0, #0]
	ldr	r3, .L202
	@ lr needed for prologue
	strh	r2, [r3, #0]	@ movhi 	@  prev_timer3
	bx	lr
.L203:
	.align	2
.L202:
	.word	prev_timer3
	.size	buttonTimerSetup, .-buttonTimerSetup
	.align	2
	.global	objectSetup
	.type	objectSetup, %function
objectSetup:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	mov	r2, #67108864
	ldr	r3, [r2, #0]
	orr	r3, r3, #4160
	sub	fp, ip, #4
	str	r3, [r2, #0]
	ldr	ip, .L212
	mov	r0, #0	@  i
	mvn	lr, #95
.L209:
	add	r1, ip, r0, asl #3	@  i
	ldrh	r3, [r1, #2]
	bic	r3, r3, #268
	bic	r3, r3, #3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r3, #240
	strh	r3, [r1, #2]	@ movhi 
	strb	lr, [ip, r0, asl #3]	@  <variable>.fields.y
	ldrb	r3, [r1, #1]	@ zero_extendqisi2
	orr	r3, r3, #32
	strb	r3, [r1, #1]
	ldrb	r2, [r1, #3]	@ zero_extendqisi2
	ldrb	r3, [r1, #1]	@ zero_extendqisi2
	bic	r2, r2, #64
	bic	r3, r3, #128
	add	r0, r0, #1	@  i,  i
	orr	r2, r2, #128
	orr	r3, r3, #64
	cmp	r0, #127	@  i
	strb	r3, [r1, #1]
	strb	r2, [r1, #3]
	ble	.L209
	mov	r1, #83886080
	mov	r3, #-2147483648
	ldr	r0, .L212+4
	add	r1, r1, #512
	mov	r2, #256
	bl	DMAFastCopy
	ldr	r0, .L212+8
	mov	r1, #5120
	mov	r2, #0
	bl	copyToSpriteData
	ldr	r3, .L212+12
	mov	lr, pc
	bx	r3
	ldmea	fp, {fp, sp, lr}
	bx	lr
.L213:
	.align	2
.L212:
	.word	sprites
	.word	ChameleonPalette
	.word	ChameleonData
	.word	playerObjectSetup
	.size	objectSetup, .-objectSetup
	.align	2
	.global	playerObjectSetup
	.type	playerObjectSetup, %function
playerObjectSetup:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	ldr	r1, .L215
	ldrh	r3, [r1, #2]
	ldrh	r2, [r1, #4]
	and	r3, r3, #65024
	ldr	r4, .L215+4
	strh	r3, [r1, #2]	@ movhi 
	ldr	r3, .L215+8
	mov	r5, #0
	and	r2, r2, #64512
	strh	r2, [r1, #4]	@ movhi 
	sub	fp, ip, #4
	str	r1, [r4, #0]	@  moveableHead.parentSprite
	str	r3, [r4, #16]	@  moveableHead.collisionHandler
	mov	r0, #20
	strb	r5, [r1, #0]	@  <variable>.fields.y
	ldr	r3, .L215+12
	str	r5, [r4, #20]	@  moveableHead.hSpeed
	str	r5, [r4, #24]	@  moveableHead.vSpeed
	str	r5, [r4, #28]	@  moveableHead.next
	mov	lr, pc
	bx	r3
	mov	r3, #1
	ldr	r1, [r4, #0]	@  moveableHead.parentSprite
	str	r3, [r4, #12]	@  moveableHead.hitBoxCount
	mov	r2, #16
	mov	r3, #32
	str	r5, [r0, #4]	@  <variable>.y
	str	r3, [r0, #8]	@  <variable>.xSize
	str	r2, [r0, #12]	@  <variable>.ySize
	str	r1, [r0, #16]	@  <variable>.parentSprite
	str	r0, [r4, #8]	@  moveableHead.hitBoxList
	str	r0, [r4, #4]	@  moveableHead.masterHitBox
	str	r5, [r0, #0]	@  <variable>.x
	ldmea	fp, {r4, r5, fp, sp, lr}
	bx	lr
.L216:
	.align	2
.L215:
	.word	sprites
	.word	moveableHead
	.word	playerCollisionHandler
	.word	malloc
	.size	playerObjectSetup, .-playerObjectSetup
	.align	2
	.global	backgroundSetup
	.type	backgroundSetup, %function
backgroundSetup:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #16
	ldr	r4, .L225
	mov	r0, #4096
	mov	lr, pc
	bx	r4
	ldr	r5, .L225+4
	mov	r3, r0
	str	r3, [r5, #0]	@  hitMap
	mov	r0, #4096
	mov	lr, pc
	bx	r4
	mov	r1, #67108864
	ldr	r3, [r1, #0]
	orr	r3, r3, #768
	ldr	r2, .L225+8
	str	r3, [r1, #0]
	mov	r3, #8064	@ movhi
	strh	r3, [r1, #8]	@ movhi 
	mov	r3, #4224	@ movhi
	str	r0, [r2, #0]	@  backMap
	strh	r3, [r1, #10]	@ movhi 
	bl	loadLevelOnePalette
	mov	r0, #100663296
	bl	loadLevelOnePlatformTiles
	ldr	r0, [r5, #0]	@  hitMap
	bl	loadLevelOneHitMap
	ldr	r7, .L225+12
	mov	r4, #0	@  i
	mov	r8, #32
.L222:
	ldr	ip, [r7, #0]	@  bg0map
	ldr	r0, [r5, #0]	@  hitMap
	mov	r1, r4	@  i
	str	r4, [sp, #4]	@  i
	mov	r2, #64
	mov	r3, r8
	add	r4, r4, #1	@  i,  i
	str	ip, [sp, #0]
	str	r8, [sp, #8]
	str	r8, [sp, #12]
	bl	copyColumn
	cmp	r4, #29	@  i
	ble	.L222
	ldr	ip, .L225+16
	ldr	lr, .L225+20
	ldr	r0, [r5, #0]	@  hitMap
	mov	r4, #30
	mov	r5, #149	@  i
	str	r4, [ip, #0]	@  nextRightDestination
	str	r5, [lr, #0]	@  i,  nextLeft
	ldr	ip, .L225+24
	ldr	lr, .L225+28
	ldr	r7, [r7, #0]	@  bg0map
	mov	r6, #31
	str	r4, [ip, #0]	@  nextRight
	str	r6, [lr, #0]	@  nextLeftDestination
	mov	r1, r5	@  i
	mov	r3, r8
	mov	r2, #64
	str	r7, [sp, #0]
	stmib	sp, {r6, r8}	@ phole stm
	str	r8, [sp, #12]
	bl	copyColumn
	ldr	r3, .L225+32
	mov	r1, #0
	str	r1, [r3, #0]	@  scrolling_y
	ldr	r2, .L225+36
	ldr	r3, .L225+40
	mov	ip, #67108864
	mvn	r0, #0
	strh	r1, [ip, #16]	@ movhi 
	str	r0, [r3, #0]	@  goingRight
	str	r1, [r2, #0]	@  scrolling_x
	strh	r1, [ip, #18]	@ movhi 
	ldmea	fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	bx	lr
.L226:
	.align	2
.L225:
	.word	malloc
	.word	hitMap
	.word	backMap
	.word	bg0map
	.word	nextRightDestination
	.word	nextLeft
	.word	nextRight
	.word	nextLeftDestination
	.word	scrolling_y
	.word	scrolling_x
	.word	goingRight
	.size	backgroundSetup, .-backgroundSetup
	.align	2
	.global	update
	.type	update, %function
update:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	ldr	r5, .L229
	mov	r4, #67108864
	add	r4, r4, #268
	ldrh	r2, [r4, #0]
	ldrh	r3, [r5, #0]	@  prev_timer3
	cmp	r2, r3
	sub	fp, ip, #4
	beq	.L227
	bl	pollButtons
	ldrh	r3, [r4, #0]
	ldr	r2, .L229+4
	strh	r3, [r5, #0]	@ movhi 	@  prev_timer3
	mov	lr, pc
	bx	r2
	ldr	r3, .L229+8
	mov	lr, pc
	bx	r3
.L227:
	ldmea	fp, {r4, r5, fp, sp, lr}
	bx	lr
.L230:
	.align	2
.L229:
	.word	prev_timer3
	.word	playerMovement
	.word	scrollControls
	.size	update, .-update
	.align	2
	.global	playerMovement
	.type	playerMovement, %function
playerMovement:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #8
	mov	r0, #16
	bl	checkState
	mov	r3, r0
	cmp	r3, #0
	ldr	r7, .L240
	mov	r0, #32
	beq	.L232
	ldr	r3, [r7, #0]	@  moveableHead.parentSprite
	ldrb	r2, [r3, #3]	@ zero_extendqisi2
	mov	r1, #4
	bic	r2, r2, #16
	strb	r2, [r3, #3]
.L238:
	str	r1, [r7, #20]	@  moveableHead.hSpeed
.L233:
	mov	r0, #64
	bl	checkPressed
	mov	r3, r0
	cmp	r3, #0
	ldr	r6, .L240+4
	ldr	r5, .L240+8
	ldr	r4, .L240+12
	ldr	r0, .L240
	ldreq	r5, .L240+8
	ldreq	r6, .L240+4
	ldreq	r4, .L240+12
	bne	.L239
.L236:
	ldr	r1, [r5, #0]	@  scrolling_x
	ldr	r2, [r6, #0]	@  scrolling_y
	ldr	r3, [r4, #0]	@  bg0map
	ldr	r0, .L240
	bl	gravityControls
	ldr	r2, [r5, #0]	@  scrolling_x
	ldr	r3, [r4, #0]	@  bg0map
	str	r2, [sp, #0]
	mov	r1, #1
	ldr	ip, [r6, #0]	@  scrolling_y
	mov	r2, r1
	ldr	r0, .L240
	str	ip, [sp, #4]
	bl	moveObject
	ldmea	fp, {r4, r5, r6, r7, fp, sp, lr}
	bx	lr
.L239:
	ldr	r2, [r6, #0]	@  scrolling_y
	ldr	r3, [r4, #0]	@  bg0map
	ldr	r1, [r5, #0]	@  scrolling_x
	add	r2, r2, #1
	bl	hitDetection
	cmp	r0, #0
	mvnne	r3, #9
	strne	r3, [r7, #24]	@  moveableHead.vSpeed
	b	.L236
.L232:
	bl	checkState
	cmp	r0, #0
	ldr	r7, .L240
	ldreq	r7, .L240
	streq	r0, [r7, #20]	@  moveableHead.hSpeed
	beq	.L233
	ldr	r3, [r7, #0]	@  moveableHead.parentSprite
	ldrb	r2, [r3, #3]	@ zero_extendqisi2
	orr	r2, r2, #16
	strb	r2, [r3, #3]
	mvn	r1, #3
	b	.L238
.L241:
	.align	2
.L240:
	.word	moveableHead
	.word	scrolling_y
	.word	scrolling_x
	.word	bg0map
	.size	playerMovement, .-playerMovement
	.align	2
	.global	scrollControls
	.type	scrollControls, %function
scrollControls:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	ldr	r4, .L267
	mov	r3, #956
	ldr	r2, [r4, #0]	@  scrolling_x
	add	r3, r3, #2
	cmp	r2, r3
	sub	fp, ip, #4
	bgt	.L244
	ldr	r6, .L267+4
	ldr	r2, [r6, #0]	@  moveableHead.parentSprite
	ldrh	r3, [r2, #2]
	mov	r3, r3, asl #23
	mov	r3, r3, lsr #23
	cmp	r3, #160
	ble	.L244
	ldr	r5, .L267+8
.L247:
	mov	lr, pc
	bx	r5
	ldr	r1, [r6, #0]	@  moveableHead.parentSprite
	ldrh	r2, [r1, #2]
	mov	r3, r2, asl #23
	sub	r3, r3, #8388608
	orr	r3, r3, r2, lsr #9
	mov	r3, r3, ror #23
	strh	r3, [r1, #2]	@ movhi 
	mov	r2, #956
	ldr	r3, [r4, #0]	@  scrolling_x
	add	r2, r2, #2
	cmp	r3, r2
	bgt	.L244
	ldr	r2, [r6, #0]	@  moveableHead.parentSprite
	ldrh	r3, [r2, #2]
	mov	r3, r3, asl #23
	mov	r3, r3, lsr #23
	cmp	r3, #160
	bgt	.L247
.L244:
	ldr	r3, [r4, #0]	@  scrolling_x
	cmp	r3, #0
	ble	.L249
	ldr	r6, .L267+4
	ldr	r2, [r6, #0]	@  moveableHead.parentSprite
	ldrh	r3, [r2, #2]
	mov	r3, r3, asl #23
	mov	r3, r3, lsr #23
	cmp	r3, #39
	bgt	.L249
	ldr	r5, .L267+12
.L252:
	mov	lr, pc
	bx	r5
	ldr	r1, [r6, #0]	@  moveableHead.parentSprite
	ldrh	r2, [r1, #2]
	mov	r3, r2, asl #23
	add	r3, r3, #8388608
	orr	r3, r3, r2, lsr #9
	mov	r3, r3, ror #23
	strh	r3, [r1, #2]	@ movhi 
	ldr	r2, [r4, #0]	@  scrolling_x
	cmp	r2, #0
	ble	.L249
	ldr	r2, [r6, #0]	@  moveableHead.parentSprite
	ldrh	r3, [r2, #2]
	mov	r3, r3, asl #23
	mov	r3, r3, lsr #23
	cmp	r3, #39
	ble	.L252
.L249:
	ldr	r0, .L267+16
	ldr	r3, [r0, #0]	@  scrolling_y
	cmp	r3, #255
	bgt	.L254
	ldr	r6, .L267+4
	ldr	r3, [r6, #0]	@  moveableHead.parentSprite
	ldrb	r2, [r3, #0]	@ zero_extendqisi2	@  <variable>.fields.y
	cmp	r2, #120
	mov	lr, r6
	bls	.L254
	mov	ip, r0
.L257:
	ldr	r1, [lr, #0]	@  moveableHead.parentSprite
	ldr	r3, [r0, #0]	@  scrolling_y
	ldrb	r2, [r1, #0]	@ zero_extendqisi2	@  <variable>.fields.y
	add	r3, r3, #1
	sub	r2, r2, #1
	str	r3, [r0, #0]	@  scrolling_y
	strb	r2, [r1, #0]	@  <variable>.fields.y
	ldr	r3, [ip, #0]	@  scrolling_y
	cmp	r3, #255
	bgt	.L254
	ldr	r3, [r6, #0]	@  moveableHead.parentSprite
	ldrb	r2, [r3, #0]	@ zero_extendqisi2	@  <variable>.fields.y
	cmp	r2, #120
	bhi	.L257
.L254:
	ldr	r0, .L267+16
	ldr	r3, [r0, #0]	@  scrolling_y
	cmp	r3, #0
	ble	.L259
	ldr	r6, .L267+4
	ldr	r3, [r6, #0]	@  moveableHead.parentSprite
	ldrb	r2, [r3, #0]	@ zero_extendqisi2	@  <variable>.fields.y
	cmp	r2, #39
	mov	lr, r6
	bhi	.L259
	mov	ip, r0
.L262:
	ldr	r1, [lr, #0]	@  moveableHead.parentSprite
	ldr	r3, [r0, #0]	@  scrolling_y
	ldrb	r2, [r1, #0]	@ zero_extendqisi2	@  <variable>.fields.y
	sub	r3, r3, #1
	add	r2, r2, #1
	str	r3, [r0, #0]	@  scrolling_y
	strb	r2, [r1, #0]	@  <variable>.fields.y
	ldr	r3, [ip, #0]	@  scrolling_y
	cmp	r3, #0
	ble	.L259
	ldr	r3, [r6, #0]	@  moveableHead.parentSprite
	ldrb	r2, [r3, #0]	@ zero_extendqisi2	@  <variable>.fields.y
	cmp	r2, #39
	bls	.L262
.L259:
	ldmea	fp, {r4, r5, r6, fp, sp, lr}
	bx	lr
.L268:
	.align	2
.L267:
	.word	scrolling_x
	.word	moveableHead
	.word	rightScroll
	.word	leftScroll
	.word	scrolling_y
	.size	scrollControls, .-scrollControls
	.align	2
	.global	rightScroll
	.type	rightScroll, %function
rightScroll:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	ldr	r1, .L277
	sub	fp, ip, #4
	sub	sp, sp, #16
	ldr	r2, [r1, #0]	@  scrolling_x
	add	r2, r2, #1
	mov	r3, r2, asr #31
	add	r3, r2, r3, lsr #29
	bic	r3, r3, #7
	rsb	r5, r3, r2
	cmp	r5, #1
	str	r2, [r1, #0]	@  scrolling_x
	beq	.L276
.L269:
	ldmea	fp, {r4, r5, r6, r7, fp, sp, lr}
	bx	lr
.L276:
	ldr	r3, .L277+4
	ldr	r6, .L277+8
	ldr	r0, [r3, #0]	@  hitMap
	ldr	r3, .L277+12
	ldr	r7, .L277+16
	ldr	r4, [r3, #0]	@  bg0map
	mov	ip, #32
	ldr	lr, [r6, #0]	@  nextRightDestination
	mov	r3, ip
	ldr	r1, [r7, #0]	@  nextRight
	mov	r2, #64
	stmia	sp, {r4, lr}	@ phole stm
	str	ip, [sp, #8]
	str	ip, [sp, #12]
	bl	copyColumn
	ldr	r3, [r7, #0]	@  nextRight
	ldr	ip, .L277+20
	add	r3, r3, #1
	ldr	r2, [r6, #0]	@  nextRightDestination
	cmp	r3, #149
	str	r3, [r7, #0]	@  nextRight
	ldr	lr, .L277+24
	movgt	r3, #0
	ldr	r1, [ip, #0]	@  nextLeft
	add	r2, r2, #1
	strgt	r3, [r7, #0]	@  nextRight
	cmp	r2, #31
	movgt	r3, #0
	ldr	r0, [lr, #0]	@  nextLeftDestination
	add	r1, r1, #1
	str	r2, [r6, #0]	@  nextRightDestination
	strgt	r3, [r6, #0]	@  nextRightDestination
	cmp	r1, #149
	movgt	r3, #0
	add	r0, r0, #1
	str	r1, [ip, #0]	@  nextLeft
	ldr	r4, .L277+28
	strgt	r3, [ip, #0]	@  nextLeft
	cmp	r0, #31
	movgt	r3, #0
	str	r0, [lr, #0]	@  nextLeftDestination
	strgt	r3, [lr, #0]	@  nextLeftDestination
	ldr	r3, [r4, #0]	@  goingRight
	cmp	r3, #0
	bne	.L275
	ldr	r3, [r7, #0]	@  nextRight
	ldr	r2, [r6, #0]	@  nextRightDestination
	ldr	r1, [ip, #0]	@  nextLeft
	ldr	r0, [lr, #0]	@  nextLeftDestination
	add	r3, r3, #1
	add	r2, r2, #1
	add	r1, r1, #1
	add	r0, r0, #1
	str	r3, [r7, #0]	@  nextRight
	str	r2, [r6, #0]	@  nextRightDestination
	str	r1, [ip, #0]	@  nextLeft
	str	r0, [lr, #0]	@  nextLeftDestination
.L275:
	str	r5, [r4, #0]	@  goingRight
	b	.L269
.L278:
	.align	2
.L277:
	.word	scrolling_x
	.word	hitMap
	.word	nextRightDestination
	.word	bg0map
	.word	nextRight
	.word	nextLeft
	.word	nextLeftDestination
	.word	goingRight
	.size	rightScroll, .-rightScroll
	.align	2
	.global	leftScroll
	.type	leftScroll, %function
leftScroll:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	ldr	r1, .L287
	sub	fp, ip, #4
	sub	sp, sp, #16
	ldr	r2, [r1, #0]	@  scrolling_x
	sub	r2, r2, #1
	mov	r3, r2, asr #31
	add	r3, r2, r3, lsr #29
	bic	r3, r3, #7
	rsb	r3, r3, r2
	cmp	r3, #7
	str	r2, [r1, #0]	@  scrolling_x
	beq	.L286
.L279:
	ldmea	fp, {r4, r5, r6, r7, fp, sp, lr}
	bx	lr
.L286:
	ldr	r3, .L287+4
	ldr	r6, .L287+8
	ldr	r0, [r3, #0]	@  hitMap
	ldr	r3, .L287+12
	ldr	r5, .L287+16
	ldr	r4, [r3, #0]	@  bg0map
	mov	ip, #32
	ldr	lr, [r6, #0]	@  nextLeftDestination
	mov	r3, ip
	ldr	r1, [r5, #0]	@  nextLeft
	mov	r2, #64
	stmia	sp, {r4, lr}	@ phole stm
	str	ip, [sp, #8]
	str	ip, [sp, #12]
	ldr	r4, .L287+20
	bl	copyColumn
	ldr	r7, .L287+24
	ldr	lr, .L287+28
	ldr	r1, [r4, #0]	@  nextRightDestination
	ldr	r2, [lr, #0]	@  nextRight
	ldr	r0, [r5, #0]	@  nextLeft
	ldr	ip, [r6, #0]	@  nextLeftDestination
	ldr	r3, [r7, #0]	@  goingRight
	sub	r2, r2, #1
	sub	r1, r1, #1
	sub	r0, r0, #1
	sub	ip, ip, #1
	cmp	r3, #0
	str	r2, [lr, #0]	@  nextRight
	str	r1, [r4, #0]	@  nextRightDestination
	str	r0, [r5, #0]	@  nextLeft
	str	ip, [r6, #0]	@  nextLeftDestination
	beq	.L281
	sub	r3, r2, #1
	sub	r2, r1, #1
	sub	r1, r0, #1
	sub	r0, ip, #1
	str	r3, [lr, #0]	@  nextRight
	str	r2, [r4, #0]	@  nextRightDestination
	str	r1, [r5, #0]	@  nextLeft
	str	r0, [r6, #0]	@  nextLeftDestination
.L281:
	ldr	r3, [lr, #0]	@  nextRight
	cmp	r3, #0
	movlt	r3, #149
	strlt	r3, [lr, #0]	@  nextRight
	ldr	r3, [r4, #0]	@  nextRightDestination
	cmp	r3, #0
	movlt	r3, #31
	strlt	r3, [r4, #0]	@  nextRightDestination
	ldr	r3, [r5, #0]	@  nextLeft
	cmp	r3, #0
	movlt	r3, #149
	strlt	r3, [r5, #0]	@  nextLeft
	ldr	r3, [r6, #0]	@  nextLeftDestination
	cmp	r3, #0
	movlt	r3, #31
	strlt	r3, [r6, #0]	@  nextLeftDestination
	mov	r3, #0
	str	r3, [r7, #0]	@  goingRight
	b	.L279
.L288:
	.align	2
.L287:
	.word	scrolling_x
	.word	hitMap
	.word	nextLeftDestination
	.word	bg0map
	.word	nextLeft
	.word	nextRightDestination
	.word	goingRight
	.word	nextRight
	.size	leftScroll, .-leftScroll
	.align	2
	.global	draw
	.type	draw, %function
draw:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	bl	waitVBlank
	ldr	r2, .L311
	ldrh	r3, [r2, #0]	@  scrolling_x
	ldr	r2, .L311+4
	ldrh	r1, [r2, #0]	@  scrolling_y
	mov	r2, #67108864
	strh	r3, [r2, #16]	@ movhi 
	strh	r1, [r2, #18]	@ movhi 
	strh	r3, [r2, #20]	@ movhi 
	strh	r1, [r2, #22]	@ movhi 
	bl	writeToOAM
	ldr	r3, .L311+8
	mov	ip, #0	@  i
	mov	r1, #1020
	ldr	r2, [r3, #0]	@  bg1map
	add	r1, r1, #3
	mov	r0, ip	@  i,  i
.L294:
	mov	r3, ip, asl #1	@  i
	add	ip, ip, #1	@  i,  i
	cmp	ip, r1	@  i
	strh	r0, [r3, r2]	@ movhi 	@  i
	ble	.L294
	ldr	r2, .L311+12
	ldr	r1, [r2, #4]	@  moveableHead.masterHitBox
	ldr	r3, [r1, #12]	@  <variable>.ySize
	mov	r2, r3, asr #31
	add	r3, r3, r2, lsr #29
	mov	r3, r3, asr #3
	cmp	r0, r3	@  i
	mov	ip, #0	@  i
	bgt	.L308
	str	r3, [fp, #-44]
	mov	r2, r1
	mov	r9, r1
.L304:
	ldr	r2, [r2, #8]	@  <variable>.xSize
	mov	r3, r2, asr #31
	adds	r3, r2, r3, lsr #29
	mov	lr, #0	@  j
	bmi	.L310
	ldr	r2, .L311+12
	ldr	r3, [r2, #4]	@  moveableHead.masterHitBox
	ldr	r1, [r3, #8]	@  <variable>.xSize
	ldr	r3, .L311+8
	mov	r2, r1, asr #31
	add	r1, r1, r2, lsr #29
	ldr	r8, [r3, #0]	@  bg1map
	ldr	r2, .L311+4
	ldr	r3, .L311
	ldr	sl, .L311+16
	ldr	r6, [r2, #0]	@  scrolling_y
	ldr	r7, [r3, #0]	@  scrolling_x
	mov	r5, r1, asr #3
	mov	r4, ip, asl #3	@  i
.L303:
	ldrb	r3, [sl, #0]	@ zero_extendqisi2
	ldrh	r2, [sl, #2]	@  sprites
	add	r3, r3, r6
	mov	r2, r2, asl #23
	add	r3, r3, r4
	mov	r2, r2, lsr #23
	mov	r1, r3, asr #31
	add	r2, r2, r7
	add	r2, r2, lr, asl #3	@  j
	add	r1, r3, r1, lsr #24
	bic	r1, r1, #255
	mov	r0, r2, asr #31
	rsb	r3, r1, r3
	add	r0, r2, r0, lsr #24
	mov	r1, r3, asr #31
	bic	r0, r0, #255
	rsb	r2, r0, r2
	add	r3, r3, r1, lsr #29
	mov	r3, r3, asr #3
	mov	r1, r2, asr #31
	add	r2, r2, r1, lsr #29
	mov	r3, r3, asl #5
	add	r3, r3, r2, asr #3
	add	lr, lr, #1	@  j,  j
	mov	r3, r3, asl #1
	mov	r2, #10	@ movhi
	cmp	lr, r5	@  j
	strh	r2, [r3, r8]	@ movhi 
	ble	.L303
.L310:
	ldr	r3, [fp, #-44]
	add	ip, ip, #1	@  i,  i
	cmp	ip, r3	@  i
	mov	r2, r9
	ble	.L304
.L308:
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L312:
	.align	2
.L311:
	.word	scrolling_x
	.word	scrolling_y
	.word	bg1map
	.word	moveableHead
	.word	sprites
	.size	draw, .-draw
	.align	2
	.global	getLocationValue
	.type	getLocationValue, %function
getLocationValue:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, r1, asr #31	@  y
	add	r1, r1, r3, lsr #29	@  y
	mov	r1, r1, asr #3
	mov	r3, r0, asr #31	@  x
	add	r0, r0, r3, lsr #29	@  x
	mov	r1, r1, asl #5
	add	r1, r1, r0, asr #3
	mov	r1, r1, asl #1
	ldrh	r0, [r1, r2]	@  x, * bg
	@ lr needed for prologue
	bx	lr
	.size	getLocationValue, .-getLocationValue
	.comm	sprites, 1024, 32
	.comm	nextRight, 4, 32
	.comm	nextLeft, 4, 32
	.comm	nextRightDestination, 4, 32
	.comm	nextLeftDestination, 4, 32
	.comm	goingRight, 4, 32
	.comm	scrolling_x, 4, 32
	.comm	scrolling_y, 4, 32
	.comm	hitMap, 4, 32
	.comm	backMap, 4, 32
	.comm	prev_timer3, 2, 16
	.comm	moveableHead, 32, 32
	.ident	"GCC: (GNU) 3.3.2"
