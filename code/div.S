
#include <features.h>
#include <sys/regdef.h>

#define EXC_STACK_SIZE 32

.text
//	.set noreorder

.global	invop_handler

invop_handler:
	la k0, exc_stack_end
	mfc0 k1, $12 
	srl k1, k1, 16 //Extract TID
	sll k1, k1, 5 //32 bytes
	sub k0, k0, k1
	sub k0, k0, 20 //Stack frame

.set noat 
	sw   a0, 0(k0) 
	sw   a1, 4(k0)
        sw   a2, 8(k0)
        sw   a3, 12(k0)
	sw   t0, 16(k0)

	mfc0 a0, $14
	addu a0, a0, -4 //EPC points to instruction after div
	lw a0, 0(a0) //Load 'er up
	andi t0, a0, 1 //Unsigned division is the LSB
	srl a0, a0, 16
	srl a1, a0, 5
	andi a0, a0, 0x1F
	andi a1, a1, 0x1F
	sll a0, a0, 4
	sll a1, a1, 4

	la a2, load_regs
	add a0, a0, a2
	add a1, a1, a2

	la a3, a0_loaded
	jr a0

a0_loaded:
	//Swao a0,a1 clobber a3
	addu a3, a0, 0
	addu a0, a1, 0
	addu a1, a3, 0

	la a3, a1_loaded
	jr a0

a1_loaded:
	j load_regs_done

//aX,t0 loads stuff on stack
load_regs:
LOADR0:
	addu a0, $0, 0
	jr a3
	nop
LOADR1:
	addu a0, $1, 0
	jr a3
	nop
LOADR2:
	addu a0, $2, 0
	jr a3
	nop
LOADR3:
	addu a0, $3, 0
	jr a3
	nop
LOADR4:
	lw a0, 0(k0)
	jr a3
	nop
LOADR5:
	lw a0, 4(k0)
	jr a3	
	nop
LOADR6:
	lw a0, 8(k0)
	jr a3
	nop	
LOADR7:
	lw a0, 12(k0)
 	jr a3
	nop
LOADR8:
	lw a0, 16(k0)
	jr a3
	nop
LOADR9:
	addu a0, $9, 0
	jr a3
	nop
LOADR10:
	addu a0, $10, 0
	jr a3
	nop
LOADR11:
	addu a0, $11, 0
	jr a3
	nop
LOADR12:
	addu a0, $12, 0
	jr a3
	nop
LOADR13:
	addu a0, $13, 0
	jr a3
	nop
LOADR14:
	addu a0, $14, 0
	jr a3
	nop
LOADR15:
	addu a0, $15, 0
	jr a3
	nop
LOADR16:
	addu a0, $16, 0
	jr a3
	nop
LOADR17:
	addu a0, $17, 0
	jr a3
	nop
LOADR18:
	addu a0, $18, 0
	jr a3
	nop
LOADR19:
	addu a0, $19, 0
	jr a3
	nop
LOADR20:
	addu a0, $20, 0
	jr a3
	nop
LOADR21:
	addu a0, $21, 0
	jr a3
	nop
LOADR22:
	addu a0, $22, 0
	jr a3
	nop
LOADR23:
	addu a0, $23, 0
	jr a3
	nop
LOADR24:
	addu a0, $24, 0
	jr a3
	nop
LOADR25:
	addu a0, $25, 0
	jr a3
	nop
LOADR26:
	addu a0, $26, 0
	jr a3
	nop
LOADR27:
	addu a0, $27, 0
	jr a3	
	nop
LOADR28:
	addu a0, $28, 0
	jr a3
	nop
LOADR29:
	addu a0, $29, 0
	jr a3
	nop
LOADR30:
	addu a0, $30, 0
	jr a3
	nop
LOADR31:
	addu a0, $31, 0
	jr a3 
	nop

load_regs_done:
	//a0 dividend, a1 divisor, k0 stack, t0 unsigned flag, a2, a3, k1 free
	bgtz t0, div_unsigned
	bgez a0, neg_a1
	neg a0, a0
	add t0,t0,2
neg_a1:	
	bgez a1, div_unsigned
	neg a1, a1
	add t0,t0,4
div_unsigned:
	//a2 = A, a3 = temp

	add k1, zero, 32
	add a2, zero, 0

divide_loop:
	bltz a2, shift_left_add
//shift_left_subtract
	srl a3, a0, 31
	sll a2, a2, 1
	sll a0, a0, 1
	or  a2, a2, a3

	subu a2, a2, a1

	j second_compare
shift_left_add:
	srl a3, a0, 31
	sll a2, a2, 1
	sll a0, a0, 1
	or  a2, a2, a3

	addu a2, a2, a1


second_compare:
	bltz a2, next_digit
	ori a0, a0, 1

next_digit:
	sub k1, k1, 1
	bgtz k1, divide_loop

	bgez a2, div_done
	add a2, a2, a1
div_done:

	addu a1, a2, 0

	//At this point a0 is the quotient and a1 is the remainder. both unsigned. a2,a3,k1 free. t0 is signs
        /* the sign of the remainder is the same as the sign of the dividend
          and the quotient is negated if the signs of the operands are
          opposite */
	and a2,t0,2
	beq a2, zero, sign_quotient
	neg a1, a1
sign_quotient:
	srl a2, a2, 1
	srl a3, t0, 2
	xor a2, a2, a3
	beq a2, zero, done_sign
	neg a0, a0
done_sign:

/*	add a2, t0, 0
	jal opc*/

	mtlo a0
	mthi a1

	lw   a0, 0(k0) 
	lw   a1, 4(k0)
        lw   a2, 8(k0)
        lw   a3, 12(k0)
	lw   t0, 16(k0)

	rfe

.global exc_stack
exc_stack:
	.fill (8*EXC_STACK_SIZE),1,0
exc_stack_end:
