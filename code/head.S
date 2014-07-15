#include <features.h>
#include <sys/regdef.h>

#define STACK_SIZE 1024

.text
//	.set noreorder

	.global	__start
	.global cinv_dcache
	.global clean_dcache
	.global inv_dcache
	.global get_tid
	.type	__start,%function
	.type	__uClibc_start_main,%function
	.weak	_init
	.weak	_fini
	.type	__uClibc_start_main,%function
/* Stick in a dummy reference to main(), so that if an application
 * is linking when the main() function is in a static library (.a)
 * we can be sure that main() actually gets linked in */
	.type	main,%function

/*this is the exception vector*/
__start:
/* load cause register */
	mfc0 k0, $13
	mtc0 k0, $13
	sll  k0, k0, 16
	srl  k0, k0, 18
	addu k1, zero, 1
	beq  k0, k1, int_handler
	beq  k0, zero, reset_handler

/* not reset */
	b    invop_handler


reset_handler:
/*	la v0, StartTest
	jalr v0 */
/*
   li    $2,-67*19
   ori   $3,$0,19
   div   $0,$2,$3

	addu v1,zero,7
	addu v0,zero,2
	div zero, v1, v0*/

.global end_test
end_test:

/* 	mul testing */
	addu v0, zero, 0x3
	addu v1, zero, 0x2
	mtlo v0
	mthi v1
	multu v0, v1
	mflo v0

/* shift right logical */
	addu  v0, zero, 0xFF0
	sll v0,v0,20
	srl v0,v0,20
//	cache 0x1, 0x10(v0)

	//TODO: zero bss should not be done for not cpu0 boot	
zerobss:
	mfc0 v0, $12 
	srl v0, v0, 16 //Extract TID
	bnez v0, 4f
        nop

	la v0, _fbss
	la v1, _end
	addiu v1,v1,4
3:
	sw zero,0(v0)
	addiu v0,v0,4 
	bltu v0,v1,3b

4:	
	addu  k0, zero, 1  /* k0 must be non zero for exceptions to work */   
	addu  a0, zero, 1  /* enable interupts. probably not a good time */
	mtc0 a0, $12

	nop //Not sure if this is required
	mfc0 v0, $12 
	srl v0, v0, 16 //Extract TID
	//addu v0, v0, 1
	addu v1, zero, STACK_SIZE
	multu v0, v1
	mflo v1
	la v0, stack_end
	subu sp, v0, v1
	

	move ra, zero	    /* no return, but since the jal kills $31, skip this */

	addu a0, zero, 253
	mthi a0
	move a0, zero
	mfhi a0
	
	//Jump to main
	addiu sp, sp, -16  
	mfc0 a0, $12 
	srl a0, a0, 16 //Extract TID

	jal main

	addiu sp, sp, 16
	/* Crash if somehow `exit' returns anyways.  */
hlt:
	b   hlt

cinv_dcache:
	cache 0x9, 0(a0)
	jr ra
	nop

clean_dcache:
	cache 0x5, 0(a0)
	jr ra
	nop

inv_dcache:
	cache 0x1, 0(a0)
	jr ra
	nop

get_tid:
	mfc0 v0, $12 
	srl v0, v0, 16 //Extract TID
	jr ra
	nop

int_handler:
/*	mfc0 k0, $14
	jr k0 */
	mfc0 k0, $12 
	srl k0, k0, 16 //Extract TID
	addu k1, zero, STACK_SIZE
	multu k0,k1
	mflo k1
	la k0, int_stack_end
	sub k0,k0,k1 //Very top of threads stack
	sub k0,k0,124 //Frame for vector

.set noat 
	sw   $1, 0(k0) 
	sw   v0, 4(k0)
        sw   v1, 8(k0)
        sw   a0, 12(k0)
        sw   a1, 16(k0)
        sw   a2, 20(k0)
	sw   a3, 24(k0)
	sw   t0, 28(k0)
	sw   t1, 32(k0)
	sw   t2, 36(k0)
  	sw   t3, 40(k0)
	sw   t4, 44(k0)
	sw   t5, 48(k0)
	sw   t6, 52(k0)
	sw   t7, 56(k0)
	sw   t8, 60(k0)
	sw   t9, 64(k0)
	sw   s0, 68(k0)
	sw   s1, 72(k0)
	sw   s2, 76(k0)
	sw   s3, 80(k0)
	sw   s4, 84(k0)
	sw   s5, 88(k0)
	sw   s6, 92(k0)
	sw   s7, 96(k0)
 	sw   s8, 100(k0)
	sw   gp, 104(k0)
	sw   sp, 108(k0)
	sw   ra, 112(k0) 
	mfhi k1
	sw   k1, 116(k0)
        mflo k1
	sw   k1, 120(k0)

	move sp, k0

	addiu sp, sp, -24   /* 16 + 4 rounded up to multiple of 8 */
			    /* multiple of 8 for longlong/double support */

	/* Ok, run intrrupt handler */
	jal intc

exc_return:

	addiu sp, sp, 24    /* undo stack argument */

	lw   $1, 0(k0) 
	lw   v0, 4(k0)
        lw   v1, 8(k0)
        lw   a0, 12(k0)
        lw   a1, 16(k0)
        lw   a2, 20(k0)
	lw   a3, 24(k0)
	lw   t0, 28(k0)
	lw   t1, 32(k0)
	lw   t2, 36(k0)
  	lw   t3, 40(k0)
	lw   t4, 44(k0)
	lw   t5, 48(k0)
	lw   t6, 52(k0)
	lw   t7, 56(k0)
	lw   t8, 60(k0)
	lw   t9, 64(k0)
	lw   s0, 68(k0)
	lw   s1, 72(k0)
	lw   s2, 76(k0)
	lw   s3, 80(k0)
	lw   s4, 84(k0)
	lw   s5, 88(k0)
	lw   s6, 92(k0)
	lw   s7, 96(k0)
 	lw   s8, 100(k0)
	lw   gp, 104(k0)
	lw   sp, 108(k0)
	lw   ra, 112(k0) 
	lw   k1, 116(k0)
	mthi k1
	lw   k1, 120(k0)
        mtlo k1

	mfc0 k0, $14
	nop
	rfe /* TODO: need to use RFE when it is available */

	.section ".data"
	
.global stack
stack:
	.fill (8*STACK_SIZE),1,0
stack_end:

.global int_stack
int_stack:
	.fill (8*STACK_SIZE),1,0
int_stack_end:

