
main.elf:     file format elf32-tradlittlemips


Disassembly of section .text:

00000000 <__start>:
   0:	401a6800 	mfc0	k0,c0_cause
   4:	00200825 	move	at,at
   8:	409a6800 	mtc0	k0,c0_cause
   c:	001ad400 	sll	k0,k0,0x10
  10:	001ad482 	srl	k0,k0,0x12
  14:	13400003 	beqz	k0,24 <reset_handler>
  18:	00200825 	move	at,at
  1c:	1000001b 	b	8c <int_handler>
  20:	00200825 	move	at,at

00000024 <reset_handler>:
  24:	241a0001 	li	k0,1
  28:	24040001 	li	a0,1
  2c:	40846000 	mtc0	a0,c0_sr
  30:	0000f821 	move	ra,zero
  34:	0000e821 	move	sp,zero
  38:	23bd0800 	addi	sp,sp,2048
  3c:	8fa40000 	lw	a0,0(sp)
  40:	27a50004 	addiu	a1,sp,4
  44:	24860001 	addiu	a2,a0,1
  48:	00063080 	sll	a2,a2,0x2
  4c:	00c53020 	add	a2,a2,a1
  50:	3c070000 	lui	a3,0x0
  54:	24e70000 	addiu	a3,a3,0
  58:	27bdffe8 	addiu	sp,sp,-24
  5c:	3c020000 	lui	v0,0x0
  60:	24420000 	addiu	v0,v0,0
  64:	afa20010 	sw	v0,16(sp)
  68:	240400fd 	li	a0,253
  6c:	00800011 	mthi	a0
  70:	00002021 	move	a0,zero
  74:	00002010 	mfhi	a0
  78:	0c0000be 	jal	2f8 <main>
  7c:	00200825 	move	at,at
  80:	27bd0018 	addiu	sp,sp,24

00000084 <hlt>:
  84:	1000ffff 	b	84 <hlt>
  88:	00200825 	move	at,at

0000008c <int_handler>:
  8c:	0000d021 	move	k0,zero
  90:	235a0900 	addi	k0,k0,2304
  94:	af410000 	sw	at,0(k0)
  98:	af420004 	sw	v0,4(k0)
  9c:	af430008 	sw	v1,8(k0)
  a0:	af44000c 	sw	a0,12(k0)
  a4:	af450010 	sw	a1,16(k0)
  a8:	af460014 	sw	a2,20(k0)
  ac:	af470018 	sw	a3,24(k0)
  b0:	af48001c 	sw	t0,28(k0)
  b4:	af490020 	sw	t1,32(k0)
  b8:	af4a0024 	sw	t2,36(k0)
  bc:	af4b0028 	sw	t3,40(k0)
  c0:	af4c002c 	sw	t4,44(k0)
  c4:	af4d0030 	sw	t5,48(k0)
  c8:	af4e0034 	sw	t6,52(k0)
  cc:	af4f0038 	sw	t7,56(k0)
  d0:	af58003c 	sw	t8,60(k0)
  d4:	af590040 	sw	t9,64(k0)
  d8:	af500044 	sw	s0,68(k0)
  dc:	af510048 	sw	s1,72(k0)
  e0:	af52004c 	sw	s2,76(k0)
  e4:	af530050 	sw	s3,80(k0)
  e8:	af540054 	sw	s4,84(k0)
  ec:	af550058 	sw	s5,88(k0)
  f0:	af56005c 	sw	s6,92(k0)
  f4:	af570060 	sw	s7,96(k0)
  f8:	af5e0064 	sw	s8,100(k0)
  fc:	af5c0068 	sw	gp,104(k0)
 100:	af5d006c 	sw	sp,108(k0)
 104:	af5f0070 	sw	ra,112(k0)
 108:	0000d810 	mfhi	k1
 10c:	af5b0074 	sw	k1,116(k0)
 110:	0000d812 	mflo	k1
 114:	af5b0078 	sw	k1,120(k0)
 118:	0340e821 	move	sp,k0
 11c:	27bdffe8 	addiu	sp,sp,-24
 120:	0c0000d4 	jal	350 <intc>
 124:	00200825 	move	at,at
 128:	27bd0018 	addiu	sp,sp,24
 12c:	8f410000 	lw	at,0(k0)
 130:	8f420004 	lw	v0,4(k0)
 134:	8f430008 	lw	v1,8(k0)
 138:	8f44000c 	lw	a0,12(k0)
 13c:	8f450010 	lw	a1,16(k0)
 140:	8f460014 	lw	a2,20(k0)
 144:	8f470018 	lw	a3,24(k0)
 148:	8f48001c 	lw	t0,28(k0)
 14c:	8f490020 	lw	t1,32(k0)
 150:	8f4a0024 	lw	t2,36(k0)
 154:	8f4b0028 	lw	t3,40(k0)
 158:	8f4c002c 	lw	t4,44(k0)
 15c:	8f4d0030 	lw	t5,48(k0)
 160:	8f4e0034 	lw	t6,52(k0)
 164:	8f4f0038 	lw	t7,56(k0)
 168:	8f58003c 	lw	t8,60(k0)
 16c:	8f590040 	lw	t9,64(k0)
 170:	8f500044 	lw	s0,68(k0)
 174:	8f510048 	lw	s1,72(k0)
 178:	8f52004c 	lw	s2,76(k0)
 17c:	8f530050 	lw	s3,80(k0)
 180:	8f540054 	lw	s4,84(k0)
 184:	8f550058 	lw	s5,88(k0)
 188:	8f56005c 	lw	s6,92(k0)
 18c:	8f570060 	lw	s7,96(k0)
 190:	8f5e0064 	lw	s8,100(k0)
 194:	8f5c0068 	lw	gp,104(k0)
 198:	8f5d006c 	lw	sp,108(k0)
 19c:	8f5f0070 	lw	ra,112(k0)
 1a0:	8f5b0074 	lw	k1,116(k0)
 1a4:	00200825 	move	at,at
 1a8:	03600011 	mthi	k1
 1ac:	8f5b0078 	lw	k1,120(k0)
 1b0:	00200825 	move	at,at
 1b4:	03600013 	mtlo	k1
 1b8:	401a7000 	mfc0	k0,c0_epc
 1bc:	00200825 	move	at,at
 1c0:	42000010 	rfe
 1c4:	00200825 	move	at,at
 1c8:	00200825 	move	at,at
 1cc:	00200825 	move	at,at

000001d0 <foo>:
 1d0:	24030002 	li	v1,2
 1d4:	14830004 	bne	a0,v1,1e8 <foo+0x18>
 1d8:	00200825 	move	at,at
 1dc:	34a2abab 	ori	v0,a1,0xabab
 1e0:	03e00008 	jr	ra
 1e4:	00200825 	move	at,at
 1e8:	30a2aaaa 	andi	v0,a1,0xaaaa
 1ec:	03e00008 	jr	ra
 1f0:	00200825 	move	at,at

000001f4 <printn>:
 1f4:	24840030 	addiu	a0,a0,48
 1f8:	3c020800 	lui	v0,0x800
 1fc:	a0440000 	sb	a0,0(v0)
 200:	03e00008 	jr	ra
 204:	00200825 	move	at,at

00000208 <printdur>:
 208:	27bdffd8 	addiu	sp,sp,-40
 20c:	afbf0024 	sw	ra,36(sp)
 210:	afb10020 	sw	s1,32(sp)
 214:	afb0001c 	sw	s0,28(sp)
 218:	00008021 	move	s0,zero
 21c:	2411000a 	li	s1,10
 220:	02002021 	move	a0,s0
 224:	0c00007d 	jal	1f4 <printn>
 228:	00200825 	move	at,at
 22c:	26100001 	addiu	s0,s0,1
 230:	1611fffb 	bne	s0,s1,220 <printdur+0x18>
 234:	00200825 	move	at,at
 238:	8fbf0024 	lw	ra,36(sp)
 23c:	8fb10020 	lw	s1,32(sp)
 240:	8fb0001c 	lw	s0,28(sp)
 244:	27bd0028 	addiu	sp,sp,40
 248:	03e00008 	jr	ra
 24c:	00200825 	move	at,at

00000250 <printfoo>:
 250:	3c020000 	lui	v0,0x0
 254:	804203c8 	lb	v0,968(v0)
 258:	00200825 	move	at,at
 25c:	10400009 	beqz	v0,284 <printfoo+0x34>
 260:	00200825 	move	at,at
 264:	3c030000 	lui	v1,0x0
 268:	246303c9 	addiu	v1,v1,969
 26c:	3c040800 	lui	a0,0x800
 270:	a0820000 	sb	v0,0(a0)
 274:	80620000 	lb	v0,0(v1)
 278:	24630001 	addiu	v1,v1,1
 27c:	1440fffc 	bnez	v0,270 <printfoo+0x20>
 280:	00200825 	move	at,at
 284:	03e00008 	jr	ra
 288:	00200825 	move	at,at

0000028c <cache_test>:
 28c:	24032000 	li	v1,8192
 290:	3402ace1 	li	v0,0xace1
 294:	2406b400 	li	a2,-19456
 298:	24053000 	li	a1,12288
 29c:	ac620000 	sw	v0,0(v1)
 2a0:	00022042 	srl	a0,v0,0x1
 2a4:	30420001 	andi	v0,v0,0x1
 2a8:	00021023 	negu	v0,v0
 2ac:	00461024 	and	v0,v0,a2
 2b0:	3042ffff 	andi	v0,v0,0xffff
 2b4:	00441026 	xor	v0,v0,a0
 2b8:	24630004 	addiu	v1,v1,4
 2bc:	1465fff7 	bne	v1,a1,29c <cache_test+0x10>
 2c0:	00200825 	move	at,at
 2c4:	03e00008 	jr	ra
 2c8:	00200825 	move	at,at

000002cc <xor>:
 2cc:	24032000 	li	v1,8192
 2d0:	00001021 	move	v0,zero
 2d4:	24053000 	li	a1,12288
 2d8:	8c640000 	lw	a0,0(v1)
 2dc:	00200825 	move	at,at
 2e0:	00441026 	xor	v0,v0,a0
 2e4:	24630004 	addiu	v1,v1,4
 2e8:	1465fffb 	bne	v1,a1,2d8 <xor+0xc>
 2ec:	00200825 	move	at,at
 2f0:	03e00008 	jr	ra
 2f4:	00200825 	move	at,at

000002f8 <main>:
 2f8:	27bdffe0 	addiu	sp,sp,-32
 2fc:	afbf001c 	sw	ra,28(sp)
 300:	afb00018 	sw	s0,24(sp)
 304:	3c100800 	lui	s0,0x800
 308:	8e020008 	lw	v0,8(s0)
 30c:	00200825 	move	at,at
 310:	ae020000 	sw	v0,0(s0)
 314:	0c000082 	jal	208 <printdur>
 318:	00200825 	move	at,at
 31c:	0c0000a3 	jal	28c <cache_test>
 320:	00200825 	move	at,at
 324:	0c0000b3 	jal	2cc <xor>
 328:	00200825 	move	at,at
 32c:	ae020000 	sw	v0,0(s0)
 330:	0c000094 	jal	250 <printfoo>
 334:	00200825 	move	at,at
 338:	00001021 	move	v0,zero
 33c:	8fbf001c 	lw	ra,28(sp)
 340:	8fb00018 	lw	s0,24(sp)
 344:	27bd0020 	addiu	sp,sp,32
 348:	03e00008 	jr	ra
 34c:	00200825 	move	at,at

00000350 <intc>:
 350:	3c020000 	lui	v0,0x0
 354:	804203b0 	lb	v0,944(v0)
 358:	00200825 	move	at,at
 35c:	10400009 	beqz	v0,384 <intc+0x34>
 360:	00200825 	move	at,at
 364:	3c030000 	lui	v1,0x0
 368:	246303b1 	addiu	v1,v1,945
 36c:	3c040800 	lui	a0,0x800
 370:	a0820000 	sb	v0,0(a0)
 374:	80620000 	lb	v0,0(v1)
 378:	24630001 	addiu	v1,v1,1
 37c:	1440fffc 	bnez	v0,370 <intc+0x20>
 380:	00200825 	move	at,at
 384:	03e00008 	jr	ra
 388:	00200825 	move	at,at
 38c:	00200825 	move	at,at

Disassembly of section .reginfo:

00000390 <.reginfo>:
 390:	fffffffe 	0xfffffffe
	...
 3a4:	00008420 	0x8420

Disassembly of section .data:

000003b0 <__data_start>:
 3b0:	316c6568 	andi	t4,t3,0x6568
 3b4:	7266206f 	0x7266206f
 3b8:	69206d6f 	0x69206d6f
 3bc:	7265746e 	0x7265746e
 3c0:	74707572 	jalx	1c1d5c8 <_gp+0x1c151a8>
 3c4:	00000000 	nop

000003c8 <hello>:
 3c8:	316c6568 	andi	t4,t3,0x6568
 3cc:	6f77206f 	0x6f77206f
 3d0:	21646c72 	addi	a0,t3,27762
 3d4:	2069202c 	addi	t1,v1,8236
 3d8:	646e6f77 	0x646e6f77
 3dc:	69207265 	0x69207265
 3e0:	68742066 	0x68742066
 3e4:	63642065 	0x63642065
 3e8:	65686361 	0x65686361
 3ec:	6e616320 	0x6e616320
 3f0:	68207427 	0x68207427
 3f4:	6c646e61 	0x6c646e61
 3f8:	77732065 	jalx	dcc8194 <_gp+0xdcbfd74>
 3fc:	68637469 	0x68637469
 400:	20676e69 	addi	a3,v1,28265
 404:	73796177 	0x73796177
 408:	726f202c 	0x726f202c
 40c:	61687720 	0x61687720
 410:	68742074 	0x68742074
 414:	72702065 	0x72702065
 418:	656c626f 	0x656c626f
 41c:	6f63206d 	0x6f63206d
 420:	20646c75 	addi	a0,v1,27765
 424:	73736f70 	0x73736f70
 428:	796c6269 	0x796c6269
 42c:	00656220 	0x656220

Disassembly of section .pdr:

00000000 <.pdr>:
   0:	000001d0 	0x1d0
	...
  18:	0000001d 	0x1d
  1c:	0000001f 	0x1f
  20:	000001f4 	0x1f4
	...
  38:	0000001d 	0x1d
  3c:	0000001f 	0x1f
  40:	00000208 	0x208
  44:	80030000 	lb	v1,0(zero)
  48:	fffffffc 	0xfffffffc
	...
  54:	00000028 	0x28
  58:	0000001d 	0x1d
  5c:	0000001f 	0x1f
  60:	00000250 	0x250
	...
  78:	0000001d 	0x1d
  7c:	0000001f 	0x1f
  80:	0000028c 	syscall	0xa
	...
  98:	0000001d 	0x1d
  9c:	0000001f 	0x1f
  a0:	000002cc 	syscall	0xb
	...
  b8:	0000001d 	0x1d
  bc:	0000001f 	0x1f
  c0:	000002f8 	0x2f8
  c4:	80010000 	lb	at,0(zero)
  c8:	fffffffc 	0xfffffffc
	...
  d4:	00000020 	add	zero,zero,zero
  d8:	0000001d 	0x1d
  dc:	0000001f 	0x1f
  e0:	00000350 	0x350
	...
  f8:	0000001d 	0x1d
  fc:	0000001f 	0x1f

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	xori	v1,s2,0x4347
   4:	65442820 	0x65442820
   8:	6e616962 	0x6e616962
   c:	372e3420 	ori	t6,t9,0x3420
  10:	352d322e 	ori	t5,t1,0x322e
  14:	2e342029 	sltiu	s4,s1,8233
  18:	00322e37 	0x322e37

Disassembly of section .gnu.attributes:

00000000 <.gnu.attributes>:
   0:	00000f41 	0xf41
   4:	756e6700 	jalx	5b99c00 <_gp+0x5b917e0>
   8:	00070100 	sll	zero,a3,0x4
   c:	03040000 	0x3040000
