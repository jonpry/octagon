
main.elf:     file format elf32-tradlittlemips


Disassembly of section .text:

00000000 <__start>:
       0:	401a6800 	mfc0	k0,c0_cause
       4:	409a6800 	mtc0	k0,c0_cause
       8:	001ad400 	sll	k0,k0,0x10
       c:	001ad482 	srl	k0,k0,0x12
      10:	241b0001 	li	k1,1
      14:	135b0047 	beq	k0,k1,134 <int_handler>
      18:	00200825 	move	at,at
      1c:	13400003 	beqz	k0,2c <end_test>
      20:	00200825 	move	at,at
      24:	10000096 	b	280 <invop_handler>
      28:	00200825 	move	at,at

0000002c <end_test>:
      2c:	24020003 	li	v0,3
      30:	24030002 	li	v1,2
      34:	00400013 	mtlo	v0
      38:	00600011 	mthi	v1
      3c:	00430019 	multu	v0,v1
      40:	00001012 	mflo	v0
      44:	24020ff0 	li	v0,4080
      48:	00021500 	sll	v0,v0,0x14
      4c:	00021502 	srl	v0,v0,0x14

00000050 <zerobss>:
      50:	40026000 	mfc0	v0,c0_status
      54:	00021402 	srl	v0,v0,0x10
      58:	1440000c 	bnez	v0,8c <zerobss+0x3c>
      5c:	00200825 	move	at,at
      60:	00200825 	move	at,at
      64:	3c020001 	lui	v0,0x1
      68:	244283e0 	addiu	v0,v0,-31776
      6c:	3c030001 	lui	v1,0x1
      70:	2463ac58 	addiu	v1,v1,-21416
      74:	24630004 	addiu	v1,v1,4
      78:	ac400000 	sw	zero,0(v0)
      7c:	24420004 	addiu	v0,v0,4
      80:	0043082b 	sltu	at,v0,v1
      84:	1420fffc 	bnez	at,78 <zerobss+0x28>
      88:	00200825 	move	at,at
      8c:	241a0001 	li	k0,1
      90:	24040001 	li	a0,1
      94:	40846000 	mtc0	a0,c0_status
      98:	00200825 	move	at,at
      9c:	40026000 	mfc0	v0,c0_status
      a0:	00021402 	srl	v0,v0,0x10
      a4:	24030400 	li	v1,1024
      a8:	00430019 	multu	v0,v1
      ac:	00001812 	mflo	v1
      b0:	3c020000 	lui	v0,0x0
      b4:	24426340 	addiu	v0,v0,25408
      b8:	0043e823 	subu	sp,v0,v1
      bc:	0000f821 	move	ra,zero
      c0:	240400fd 	li	a0,253
      c4:	00800011 	mthi	a0
      c8:	00002021 	move	a0,zero
      cc:	00002010 	mfhi	a0
      d0:	27bdfff0 	addiu	sp,sp,-16
      d4:	40046000 	mfc0	a0,c0_status
      d8:	00042402 	srl	a0,a0,0x10
      dc:	0c0005a6 	jal	1698 <main>
      e0:	00200825 	move	at,at
      e4:	27bd0010 	addiu	sp,sp,16

000000e8 <hlt>:
      e8:	1000ffff 	b	e8 <hlt>
      ec:	00200825 	move	at,at

000000f0 <cinv_dcache>:
      f0:	bc890000 	cache	0x9,0(a0)
      f4:	03e00008 	jr	ra
      f8:	00200825 	move	at,at
      fc:	00200825 	move	at,at

00000100 <clean_dcache>:
     100:	bc850000 	cache	0x5,0(a0)
     104:	03e00008 	jr	ra
     108:	00200825 	move	at,at
     10c:	00200825 	move	at,at

00000110 <inv_dcache>:
     110:	bc810000 	cache	0x1,0(a0)
     114:	03e00008 	jr	ra
     118:	00200825 	move	at,at
     11c:	00200825 	move	at,at

00000120 <get_tid>:
     120:	40026000 	mfc0	v0,c0_status
     124:	00021402 	srl	v0,v0,0x10
     128:	03e00008 	jr	ra
     12c:	00200825 	move	at,at
     130:	00200825 	move	at,at

00000134 <int_handler>:
     134:	401a6000 	mfc0	k0,c0_status
     138:	001ad402 	srl	k0,k0,0x10
     13c:	241b0400 	li	k1,1024
     140:	035b0019 	multu	k0,k1
     144:	0000d812 	mflo	k1
     148:	3c1a0001 	lui	k0,0x1
     14c:	275a8340 	addiu	k0,k0,-31936
     150:	035bd022 	sub	k0,k0,k1
     154:	235aff84 	addi	k0,k0,-124
     158:	af410000 	sw	at,0(k0)
     15c:	af420004 	sw	v0,4(k0)
     160:	af430008 	sw	v1,8(k0)
     164:	af44000c 	sw	a0,12(k0)
     168:	af450010 	sw	a1,16(k0)
     16c:	af460014 	sw	a2,20(k0)
     170:	af470018 	sw	a3,24(k0)
     174:	af48001c 	sw	t0,28(k0)
     178:	af490020 	sw	t1,32(k0)
     17c:	af4a0024 	sw	t2,36(k0)
     180:	af4b0028 	sw	t3,40(k0)
     184:	af4c002c 	sw	t4,44(k0)
     188:	af4d0030 	sw	t5,48(k0)
     18c:	af4e0034 	sw	t6,52(k0)
     190:	af4f0038 	sw	t7,56(k0)
     194:	af58003c 	sw	t8,60(k0)
     198:	af590040 	sw	t9,64(k0)
     19c:	af500044 	sw	s0,68(k0)
     1a0:	af510048 	sw	s1,72(k0)
     1a4:	af52004c 	sw	s2,76(k0)
     1a8:	af530050 	sw	s3,80(k0)
     1ac:	af540054 	sw	s4,84(k0)
     1b0:	af550058 	sw	s5,88(k0)
     1b4:	af56005c 	sw	s6,92(k0)
     1b8:	af570060 	sw	s7,96(k0)
     1bc:	af5e0064 	sw	s8,100(k0)
     1c0:	af5c0068 	sw	gp,104(k0)
     1c4:	af5d006c 	sw	sp,108(k0)
     1c8:	af5f0070 	sw	ra,112(k0)
     1cc:	0000d810 	mfhi	k1
     1d0:	af5b0074 	sw	k1,116(k0)
     1d4:	0000d812 	mflo	k1
     1d8:	af5b0078 	sw	k1,120(k0)
     1dc:	0340e821 	move	sp,k0
     1e0:	27bdffe8 	addiu	sp,sp,-24
     1e4:	0c0005fa 	jal	17e8 <intc>
     1e8:	00200825 	move	at,at

000001ec <exc_return>:
     1ec:	27bd0018 	addiu	sp,sp,24
     1f0:	8f410000 	lw	at,0(k0)
     1f4:	8f420004 	lw	v0,4(k0)
     1f8:	8f430008 	lw	v1,8(k0)
     1fc:	8f44000c 	lw	a0,12(k0)
     200:	8f450010 	lw	a1,16(k0)
     204:	8f460014 	lw	a2,20(k0)
     208:	8f470018 	lw	a3,24(k0)
     20c:	8f48001c 	lw	t0,28(k0)
     210:	8f490020 	lw	t1,32(k0)
     214:	8f4a0024 	lw	t2,36(k0)
     218:	8f4b0028 	lw	t3,40(k0)
     21c:	8f4c002c 	lw	t4,44(k0)
     220:	8f4d0030 	lw	t5,48(k0)
     224:	8f4e0034 	lw	t6,52(k0)
     228:	8f4f0038 	lw	t7,56(k0)
     22c:	8f58003c 	lw	t8,60(k0)
     230:	8f590040 	lw	t9,64(k0)
     234:	8f500044 	lw	s0,68(k0)
     238:	8f510048 	lw	s1,72(k0)
     23c:	8f52004c 	lw	s2,76(k0)
     240:	8f530050 	lw	s3,80(k0)
     244:	8f540054 	lw	s4,84(k0)
     248:	8f550058 	lw	s5,88(k0)
     24c:	8f56005c 	lw	s6,92(k0)
     250:	8f570060 	lw	s7,96(k0)
     254:	8f5e0064 	lw	s8,100(k0)
     258:	8f5c0068 	lw	gp,104(k0)
     25c:	8f5d006c 	lw	sp,108(k0)
     260:	8f5f0070 	lw	ra,112(k0)
     264:	8f5b0074 	lw	k1,116(k0)
     268:	03600011 	mthi	k1
     26c:	8f5b0078 	lw	k1,120(k0)
     270:	03600013 	mtlo	k1
     274:	401a7000 	mfc0	k0,c0_epc
     278:	00200825 	move	at,at
     27c:	42000010 	rfe

00000280 <invop_handler>:
     280:	3c1a0000 	lui	k0,0x0
     284:	275a06f4 	addiu	k0,k0,1780
     288:	401b6000 	mfc0	k1,c0_status
     28c:	001bdc02 	srl	k1,k1,0x10
     290:	001bd940 	sll	k1,k1,0x5
     294:	035bd022 	sub	k0,k0,k1
     298:	235affec 	addi	k0,k0,-20
     29c:	af440000 	sw	a0,0(k0)
     2a0:	af450004 	sw	a1,4(k0)
     2a4:	af460008 	sw	a2,8(k0)
     2a8:	af47000c 	sw	a3,12(k0)
     2ac:	af480010 	sw	t0,16(k0)
     2b0:	40047000 	mfc0	a0,c0_epc
     2b4:	2484fffc 	addiu	a0,a0,-4
     2b8:	8c840000 	lw	a0,0(a0)
     2bc:	30880001 	andi	t0,a0,0x1
     2c0:	00042402 	srl	a0,a0,0x10
     2c4:	00042942 	srl	a1,a0,0x5
     2c8:	3084001f 	andi	a0,a0,0x1f
     2cc:	30a5001f 	andi	a1,a1,0x1f
     2d0:	00042100 	sll	a0,a0,0x4
     2d4:	00052900 	sll	a1,a1,0x4
     2d8:	3c060000 	lui	a2,0x0
     2dc:	24c6031c 	addiu	a2,a2,796
     2e0:	00862020 	add	a0,a0,a2
     2e4:	00a62820 	add	a1,a1,a2
     2e8:	3c070000 	lui	a3,0x0
     2ec:	24e702f8 	addiu	a3,a3,760
     2f0:	00800008 	jr	a0
     2f4:	00200825 	move	at,at

000002f8 <a0_loaded>:
     2f8:	24870000 	addiu	a3,a0,0
     2fc:	24a40000 	addiu	a0,a1,0
     300:	24e50000 	addiu	a1,a3,0
     304:	3c070000 	lui	a3,0x0
     308:	24e70314 	addiu	a3,a3,788
     30c:	00800008 	jr	a0
     310:	00200825 	move	at,at

00000314 <a1_loaded>:
     314:	08000147 	j	51c <load_regs_done>
     318:	00200825 	move	at,at

0000031c <LOADR0>:
     31c:	24040000 	li	a0,0
     320:	00e00008 	jr	a3
     324:	00200825 	move	at,at
     328:	00200825 	move	at,at

0000032c <LOADR1>:
     32c:	24240000 	addiu	a0,at,0
     330:	00e00008 	jr	a3
     334:	00200825 	move	at,at
     338:	00200825 	move	at,at

0000033c <LOADR2>:
     33c:	24440000 	addiu	a0,v0,0
     340:	00e00008 	jr	a3
     344:	00200825 	move	at,at
     348:	00200825 	move	at,at

0000034c <LOADR3>:
     34c:	24640000 	addiu	a0,v1,0
     350:	00e00008 	jr	a3
     354:	00200825 	move	at,at
     358:	00200825 	move	at,at

0000035c <LOADR4>:
     35c:	8f440000 	lw	a0,0(k0)
     360:	00e00008 	jr	a3
     364:	00200825 	move	at,at
     368:	00200825 	move	at,at

0000036c <LOADR5>:
     36c:	8f440004 	lw	a0,4(k0)
     370:	00e00008 	jr	a3
     374:	00200825 	move	at,at
     378:	00200825 	move	at,at

0000037c <LOADR6>:
     37c:	8f440008 	lw	a0,8(k0)
     380:	00e00008 	jr	a3
     384:	00200825 	move	at,at
     388:	00200825 	move	at,at

0000038c <LOADR7>:
     38c:	8f44000c 	lw	a0,12(k0)
     390:	00e00008 	jr	a3
     394:	00200825 	move	at,at
     398:	00200825 	move	at,at

0000039c <LOADR8>:
     39c:	8f440010 	lw	a0,16(k0)
     3a0:	00e00008 	jr	a3
     3a4:	00200825 	move	at,at
     3a8:	00200825 	move	at,at

000003ac <LOADR9>:
     3ac:	25240000 	addiu	a0,t1,0
     3b0:	00e00008 	jr	a3
     3b4:	00200825 	move	at,at
     3b8:	00200825 	move	at,at

000003bc <LOADR10>:
     3bc:	25440000 	addiu	a0,t2,0
     3c0:	00e00008 	jr	a3
     3c4:	00200825 	move	at,at
     3c8:	00200825 	move	at,at

000003cc <LOADR11>:
     3cc:	25640000 	addiu	a0,t3,0
     3d0:	00e00008 	jr	a3
     3d4:	00200825 	move	at,at
     3d8:	00200825 	move	at,at

000003dc <LOADR12>:
     3dc:	25840000 	addiu	a0,t4,0
     3e0:	00e00008 	jr	a3
     3e4:	00200825 	move	at,at
     3e8:	00200825 	move	at,at

000003ec <LOADR13>:
     3ec:	25a40000 	addiu	a0,t5,0
     3f0:	00e00008 	jr	a3
     3f4:	00200825 	move	at,at
     3f8:	00200825 	move	at,at

000003fc <LOADR14>:
     3fc:	25c40000 	addiu	a0,t6,0
     400:	00e00008 	jr	a3
     404:	00200825 	move	at,at
     408:	00200825 	move	at,at

0000040c <LOADR15>:
     40c:	25e40000 	addiu	a0,t7,0
     410:	00e00008 	jr	a3
     414:	00200825 	move	at,at
     418:	00200825 	move	at,at

0000041c <LOADR16>:
     41c:	26040000 	addiu	a0,s0,0
     420:	00e00008 	jr	a3
     424:	00200825 	move	at,at
     428:	00200825 	move	at,at

0000042c <LOADR17>:
     42c:	26240000 	addiu	a0,s1,0
     430:	00e00008 	jr	a3
     434:	00200825 	move	at,at
     438:	00200825 	move	at,at

0000043c <LOADR18>:
     43c:	26440000 	addiu	a0,s2,0
     440:	00e00008 	jr	a3
     444:	00200825 	move	at,at
     448:	00200825 	move	at,at

0000044c <LOADR19>:
     44c:	26640000 	addiu	a0,s3,0
     450:	00e00008 	jr	a3
     454:	00200825 	move	at,at
     458:	00200825 	move	at,at

0000045c <LOADR20>:
     45c:	26840000 	addiu	a0,s4,0
     460:	00e00008 	jr	a3
     464:	00200825 	move	at,at
     468:	00200825 	move	at,at

0000046c <LOADR21>:
     46c:	26a40000 	addiu	a0,s5,0
     470:	00e00008 	jr	a3
     474:	00200825 	move	at,at
     478:	00200825 	move	at,at

0000047c <LOADR22>:
     47c:	26c40000 	addiu	a0,s6,0
     480:	00e00008 	jr	a3
     484:	00200825 	move	at,at
     488:	00200825 	move	at,at

0000048c <LOADR23>:
     48c:	26e40000 	addiu	a0,s7,0
     490:	00e00008 	jr	a3
     494:	00200825 	move	at,at
     498:	00200825 	move	at,at

0000049c <LOADR24>:
     49c:	27040000 	addiu	a0,t8,0
     4a0:	00e00008 	jr	a3
     4a4:	00200825 	move	at,at
     4a8:	00200825 	move	at,at

000004ac <LOADR25>:
     4ac:	27240000 	addiu	a0,t9,0
     4b0:	00e00008 	jr	a3
     4b4:	00200825 	move	at,at
     4b8:	00200825 	move	at,at

000004bc <LOADR26>:
     4bc:	27440000 	addiu	a0,k0,0
     4c0:	00e00008 	jr	a3
     4c4:	00200825 	move	at,at
     4c8:	00200825 	move	at,at

000004cc <LOADR27>:
     4cc:	27640000 	addiu	a0,k1,0
     4d0:	00e00008 	jr	a3
     4d4:	00200825 	move	at,at
     4d8:	00200825 	move	at,at

000004dc <LOADR28>:
     4dc:	27840000 	addiu	a0,gp,0
     4e0:	00e00008 	jr	a3
     4e4:	00200825 	move	at,at
     4e8:	00200825 	move	at,at

000004ec <LOADR29>:
     4ec:	27a40000 	addiu	a0,sp,0
     4f0:	00e00008 	jr	a3
     4f4:	00200825 	move	at,at
     4f8:	00200825 	move	at,at

000004fc <LOADR30>:
     4fc:	27c40000 	addiu	a0,s8,0
     500:	00e00008 	jr	a3
     504:	00200825 	move	at,at
     508:	00200825 	move	at,at

0000050c <LOADR31>:
     50c:	27e40000 	addiu	a0,ra,0
     510:	00e00008 	jr	a3
     514:	00200825 	move	at,at
     518:	00200825 	move	at,at

0000051c <load_regs_done>:
     51c:	1d000009 	bgtz	t0,544 <div_unsigned>
     520:	00200825 	move	at,at
     524:	04810003 	bgez	a0,534 <neg_a1>
     528:	00200825 	move	at,at
     52c:	00042022 	neg	a0,a0
     530:	21080002 	addi	t0,t0,2

00000534 <neg_a1>:
     534:	04a10003 	bgez	a1,544 <div_unsigned>
     538:	00200825 	move	at,at
     53c:	00052822 	neg	a1,a1
     540:	21080004 	addi	t0,t0,4

00000544 <div_unsigned>:
     544:	201b0020 	addi	k1,zero,32
     548:	20060000 	addi	a2,zero,0

0000054c <divide_loop>:
     54c:	04c00008 	bltz	a2,570 <shift_left_add>
     550:	00200825 	move	at,at
     554:	00043fc2 	srl	a3,a0,0x1f
     558:	00063040 	sll	a2,a2,0x1
     55c:	00042040 	sll	a0,a0,0x1
     560:	00c73025 	or	a2,a2,a3
     564:	00c53023 	subu	a2,a2,a1
     568:	08000161 	j	584 <second_compare>
     56c:	00200825 	move	at,at

00000570 <shift_left_add>:
     570:	00043fc2 	srl	a3,a0,0x1f
     574:	00063040 	sll	a2,a2,0x1
     578:	00042040 	sll	a0,a0,0x1
     57c:	00c73025 	or	a2,a2,a3
     580:	00c53021 	addu	a2,a2,a1

00000584 <second_compare>:
     584:	04c00002 	bltz	a2,590 <next_digit>
     588:	00200825 	move	at,at
     58c:	34840001 	ori	a0,a0,0x1

00000590 <next_digit>:
     590:	237bffff 	addi	k1,k1,-1
     594:	1f60ffed 	bgtz	k1,54c <divide_loop>
     598:	00200825 	move	at,at
     59c:	04c10002 	bgez	a2,5a8 <div_done>
     5a0:	00200825 	move	at,at
     5a4:	00c53020 	add	a2,a2,a1

000005a8 <div_done>:
     5a8:	24c50000 	addiu	a1,a2,0
     5ac:	31060002 	andi	a2,t0,0x2
     5b0:	10c00002 	beqz	a2,5bc <sign_quotient>
     5b4:	00200825 	move	at,at
     5b8:	00052822 	neg	a1,a1

000005bc <sign_quotient>:
     5bc:	00063042 	srl	a2,a2,0x1
     5c0:	00083882 	srl	a3,t0,0x2
     5c4:	00c73026 	xor	a2,a2,a3
     5c8:	10c00002 	beqz	a2,5d4 <done_sign>
     5cc:	00200825 	move	at,at
     5d0:	00042022 	neg	a0,a0

000005d4 <done_sign>:
     5d4:	00800013 	mtlo	a0
     5d8:	00a00011 	mthi	a1
     5dc:	8f440000 	lw	a0,0(k0)
     5e0:	8f450004 	lw	a1,4(k0)
     5e4:	8f460008 	lw	a2,8(k0)
     5e8:	8f47000c 	lw	a3,12(k0)
     5ec:	8f480010 	lw	t0,16(k0)
     5f0:	42000010 	rfe

000005f4 <exc_stack>:
	...

000006f4 <exc_stack_end>:
     6f4:	00200825 	move	at,at
     6f8:	00200825 	move	at,at
     6fc:	00200825 	move	at,at

00000700 <StartTest>:
     700:	3c140800 	lui	s4,0x800
     704:	3415000a 	li	s5,0xa
     708:	34160058 	li	s6,0x58
     70c:	3417000d 	li	s7,0xd
     710:	3c180000 	lui	t8,0x0
     714:	27184340 	addiu	t8,t8,17216
     718:	a2970000 	sb	s7,0(s4)
     71c:	a2950000 	sb	s5,0(s4)
     720:	a2970000 	sb	s7,0(s4)
     724:	a2950000 	sb	s5,0(s4)
     728:	a2970000 	sb	s7,0(s4)
     72c:	a2950000 	sb	s5,0(s4)
     730:	a2970000 	sb	s7,0(s4)
     734:	a2950000 	sb	s5,0(s4)

00000738 <ArthmeticTest>:
     738:	34020041 	li	v0,0x41
     73c:	a2820000 	sb	v0,0(s4)
     740:	34020072 	li	v0,0x72
     744:	a2820000 	sb	v0,0(s4)
     748:	34020069 	li	v0,0x69
     74c:	a2820000 	sb	v0,0(s4)
     750:	34020074 	li	v0,0x74
     754:	a2820000 	sb	v0,0(s4)
     758:	34020068 	li	v0,0x68
     75c:	a2820000 	sb	v0,0(s4)
     760:	a2970000 	sb	s7,0(s4)
     764:	a2950000 	sb	s5,0(s4)
     768:	34020061 	li	v0,0x61
     76c:	a2820000 	sb	v0,0(s4)
     770:	34030005 	li	v1,0x5
     774:	3404003c 	li	a0,0x3c
     778:	00641020 	add	v0,v1,a0
     77c:	a2820000 	sb	v0,0(s4)
     780:	a2970000 	sb	s7,0(s4)
     784:	a2950000 	sb	s5,0(s4)
     788:	34020062 	li	v0,0x62
     78c:	a2820000 	sb	v0,0(s4)
     790:	3404003c 	li	a0,0x3c
     794:	20820005 	addi	v0,a0,5
     798:	a2820000 	sb	v0,0(s4)
     79c:	a2970000 	sb	s7,0(s4)
     7a0:	a2950000 	sb	s5,0(s4)
     7a4:	34020063 	li	v0,0x63
     7a8:	a2820000 	sb	v0,0(s4)
     7ac:	34040032 	li	a0,0x32
     7b0:	2485000f 	addiu	a1,a0,15
     7b4:	a2850000 	sb	a1,0(s4)
     7b8:	a2970000 	sb	s7,0(s4)
     7bc:	a2950000 	sb	s5,0(s4)
     7c0:	34020064 	li	v0,0x64
     7c4:	a2820000 	sb	v0,0(s4)
     7c8:	34030005 	li	v1,0x5
     7cc:	3404003c 	li	a0,0x3c
     7d0:	00641020 	add	v0,v1,a0
     7d4:	a2820000 	sb	v0,0(s4)
     7d8:	a2970000 	sb	s7,0(s4)
     7dc:	a2950000 	sb	s5,0(s4)
     7e0:	34020065 	li	v0,0x65
     7e4:	a2820000 	sb	v0,0(s4)
     7e8:	34021dde 	li	v0,0x1dde
     7ec:	34030075 	li	v1,0x75
     7f0:	0043001a 	div	zero,v0,v1
     7f4:	00200825 	move	at,at
     7f8:	00002012 	mflo	a0
     7fc:	a2840000 	sb	a0,0(s4)
     800:	00002010 	mfhi	a0
     804:	20840019 	addi	a0,a0,25
     808:	a2840000 	sb	a0,0(s4)
     80c:	2402fb07 	li	v0,-1273
     810:	34030013 	li	v1,0x13
     814:	0043001a 	div	zero,v0,v1
     818:	00200825 	move	at,at
     81c:	00002012 	mflo	a0
     820:	00042022 	neg	a0,a0
     824:	a2840000 	sb	a0,0(s4)
     828:	3402061c 	li	v0,0x61c
     82c:	2403ffe9 	li	v1,-23
     830:	0043001a 	div	zero,v0,v1
     834:	00200825 	move	at,at
     838:	00002012 	mflo	a0
     83c:	00042022 	neg	a0,a0
     840:	a2840000 	sb	a0,0(s4)
     844:	2402fc7f 	li	v0,-897
     848:	2403fff3 	li	v1,-13
     84c:	0043001a 	div	zero,v0,v1
     850:	00002012 	mflo	a0
     854:	a2840000 	sb	a0,0(s4)
     858:	a2970000 	sb	s7,0(s4)
     85c:	a2950000 	sb	s5,0(s4)
     860:	34020066 	li	v0,0x66
     864:	a2820000 	sb	v0,0(s4)
     868:	3402034d 	li	v0,0x34d
     86c:	3403000d 	li	v1,0xd
     870:	0043001b 	divu	zero,v0,v1
     874:	00200825 	move	at,at
     878:	00002012 	mflo	a0
     87c:	a2840000 	sb	a0,0(s4)
     880:	a2970000 	sb	s7,0(s4)
     884:	a2950000 	sb	s5,0(s4)
     888:	34020067 	li	v0,0x67
     88c:	a2820000 	sb	v0,0(s4)
     890:	34020005 	li	v0,0x5
     894:	3403000d 	li	v1,0xd
     898:	00430018 	mult	v0,v1
     89c:	00200825 	move	at,at
     8a0:	00002012 	mflo	a0
     8a4:	a2840000 	sb	a0,0(s4)
     8a8:	2402fffb 	li	v0,-5
     8ac:	3403000d 	li	v1,0xd
     8b0:	00430018 	mult	v0,v1
     8b4:	00002810 	mfhi	a1
     8b8:	00002012 	mflo	a0
     8bc:	00042022 	neg	a0,a0
     8c0:	00852021 	addu	a0,a0,a1
     8c4:	20840002 	addi	a0,a0,2
     8c8:	a2840000 	sb	a0,0(s4)
     8cc:	34020005 	li	v0,0x5
     8d0:	2403fff3 	li	v1,-13
     8d4:	00430018 	mult	v0,v1
     8d8:	00002810 	mfhi	a1
     8dc:	00002012 	mflo	a0
     8e0:	00042022 	neg	a0,a0
     8e4:	00852021 	addu	a0,a0,a1
     8e8:	20840003 	addi	a0,a0,3
     8ec:	a2840000 	sb	a0,0(s4)
     8f0:	2402fffb 	li	v0,-5
     8f4:	2403fff3 	li	v1,-13
     8f8:	00430018 	mult	v0,v1
     8fc:	00002810 	mfhi	a1
     900:	00002012 	mflo	a0
     904:	00852021 	addu	a0,a0,a1
     908:	20840003 	addi	a0,a0,3
     90c:	a2840000 	sb	a0,0(s4)
     910:	3c04fe98 	lui	a0,0xfe98
     914:	348462e5 	ori	a0,a0,0x62e5
     918:	3c050006 	lui	a1,0x6
     91c:	34a58db8 	ori	a1,a1,0x8db8
     920:	00850018 	mult	a0,a1
     924:	00003010 	mfhi	a2
     928:	24c7097a 	addiu	a3,a2,2426
     92c:	a2870000 	sb	a3,0(s4)
     930:	a2970000 	sb	s7,0(s4)
     934:	a2950000 	sb	s5,0(s4)
     938:	34020068 	li	v0,0x68
     93c:	a2820000 	sb	v0,0(s4)
     940:	34020005 	li	v0,0x5
     944:	3403000d 	li	v1,0xd
     948:	00430019 	multu	v0,v1
     94c:	00200825 	move	at,at
     950:	00002012 	mflo	a0
     954:	a2840000 	sb	a0,0(s4)
     958:	a2970000 	sb	s7,0(s4)
     95c:	a2950000 	sb	s5,0(s4)
     960:	34020069 	li	v0,0x69
     964:	a2820000 	sb	v0,0(s4)
     968:	3402000a 	li	v0,0xa
     96c:	3403000c 	li	v1,0xc
     970:	0043202a 	slt	a0,v0,v1
     974:	20850040 	addi	a1,a0,64
     978:	a2850000 	sb	a1,0(s4)
     97c:	0062202a 	slt	a0,v1,v0
     980:	20850042 	addi	a1,a0,66
     984:	a2850000 	sb	a1,0(s4)
     988:	2402fff0 	li	v0,-16
     98c:	0043202a 	slt	a0,v0,v1
     990:	20850042 	addi	a1,a0,66
     994:	a2850000 	sb	a1,0(s4)
     998:	0062202a 	slt	a0,v1,v0
     99c:	20850044 	addi	a1,a0,68
     9a0:	a2850000 	sb	a1,0(s4)
     9a4:	2403ffff 	li	v1,-1
     9a8:	0043202a 	slt	a0,v0,v1
     9ac:	20850044 	addi	a1,a0,68
     9b0:	a2850000 	sb	a1,0(s4)
     9b4:	0062202a 	slt	a0,v1,v0
     9b8:	20850046 	addi	a1,a0,70
     9bc:	a2850000 	sb	a1,0(s4)
     9c0:	a2970000 	sb	s7,0(s4)
     9c4:	a2950000 	sb	s5,0(s4)
     9c8:	3402006a 	li	v0,0x6a
     9cc:	a2820000 	sb	v0,0(s4)
     9d0:	3402000a 	li	v0,0xa
     9d4:	2844000c 	slti	a0,v0,12
     9d8:	20850040 	addi	a1,a0,64
     9dc:	a2850000 	sb	a1,0(s4)
     9e0:	28440008 	slti	a0,v0,8
     9e4:	20850042 	addi	a1,a0,66
     9e8:	a2850000 	sb	a1,0(s4)
     9ec:	a2970000 	sb	s7,0(s4)
     9f0:	a2950000 	sb	s5,0(s4)
     9f4:	3402006b 	li	v0,0x6b
     9f8:	a2820000 	sb	v0,0(s4)
     9fc:	3402000a 	li	v0,0xa
     a00:	2c44000c 	sltiu	a0,v0,12
     a04:	20850040 	addi	a1,a0,64
     a08:	a2850000 	sb	a1,0(s4)
     a0c:	2c440008 	sltiu	a0,v0,8
     a10:	20850042 	addi	a1,a0,66
     a14:	a2850000 	sb	a1,0(s4)
     a18:	a2970000 	sb	s7,0(s4)
     a1c:	a2950000 	sb	s5,0(s4)
     a20:	3402006c 	li	v0,0x6c
     a24:	a2820000 	sb	v0,0(s4)
     a28:	3402000a 	li	v0,0xa
     a2c:	3403000c 	li	v1,0xc
     a30:	0043202a 	slt	a0,v0,v1
     a34:	20850040 	addi	a1,a0,64
     a38:	a2850000 	sb	a1,0(s4)
     a3c:	0062202a 	slt	a0,v1,v0
     a40:	20850042 	addi	a1,a0,66
     a44:	a2850000 	sb	a1,0(s4)
     a48:	a2970000 	sb	s7,0(s4)
     a4c:	a2950000 	sb	s5,0(s4)
     a50:	3402006d 	li	v0,0x6d
     a54:	a2820000 	sb	v0,0(s4)
     a58:	34030046 	li	v1,0x46
     a5c:	34040005 	li	a0,0x5
     a60:	00641022 	sub	v0,v1,a0
     a64:	a2820000 	sb	v0,0(s4)
     a68:	a2970000 	sb	s7,0(s4)
     a6c:	a2950000 	sb	s5,0(s4)
     a70:	3402006e 	li	v0,0x6e
     a74:	a2820000 	sb	v0,0(s4)
     a78:	34030046 	li	v1,0x46
     a7c:	34040005 	li	a0,0x5
     a80:	00641022 	sub	v0,v1,a0
     a84:	a2820000 	sb	v0,0(s4)
     a88:	a2970000 	sb	s7,0(s4)
     a8c:	a2950000 	sb	s5,0(s4)

00000a90 <BranchTest>:
     a90:	34020042 	li	v0,0x42
     a94:	a2820000 	sb	v0,0(s4)
     a98:	34020072 	li	v0,0x72
     a9c:	a2820000 	sb	v0,0(s4)
     aa0:	34020061 	li	v0,0x61
     aa4:	a2820000 	sb	v0,0(s4)
     aa8:	3402006e 	li	v0,0x6e
     aac:	a2820000 	sb	v0,0(s4)
     ab0:	34020063 	li	v0,0x63
     ab4:	a2820000 	sb	v0,0(s4)
     ab8:	34020068 	li	v0,0x68
     abc:	a2820000 	sb	v0,0(s4)
     ac0:	a2970000 	sb	s7,0(s4)
     ac4:	a2950000 	sb	s5,0(s4)
     ac8:	34020061 	li	v0,0x61
     acc:	a2820000 	sb	v0,0(s4)
     ad0:	340a0041 	li	t2,0x41
     ad4:	340b0042 	li	t3,0x42
     ad8:	a28a0000 	sb	t2,0(s4)
     adc:	10000002 	b	ae8 <BranchTest+0x58>
     ae0:	00200825 	move	at,at
     ae4:	a2960000 	sb	s6,0(s4)
     ae8:	a28b0000 	sb	t3,0(s4)
     aec:	a2970000 	sb	s7,0(s4)
     af0:	a2950000 	sb	s5,0(s4)
     af4:	34020062 	li	v0,0x62
     af8:	a2820000 	sb	v0,0(s4)
     afc:	340a0041 	li	t2,0x41
     b00:	340b0042 	li	t3,0x42
     b04:	340c0043 	li	t4,0x43
     b08:	340d0044 	li	t5,0x44
     b0c:	340e0045 	li	t6,0x45
     b10:	340f0058 	li	t7,0x58
     b14:	a28a0000 	sb	t2,0(s4)
     b18:	04110006 	bal	b34 <BranchTest+0xa4>
     b1c:	00200825 	move	at,at
     b20:	a28d0000 	sb	t5,0(s4)
     b24:	a28e0000 	sb	t6,0(s4)
     b28:	10000007 	b	b48 <BranchTest+0xb8>
     b2c:	00200825 	move	at,at
     b30:	a28f0000 	sb	t7,0(s4)
     b34:	a28b0000 	sb	t3,0(s4)
     b38:	a28c0000 	sb	t4,0(s4)
     b3c:	03e00008 	jr	ra
     b40:	00200825 	move	at,at
     b44:	a2960000 	sb	s6,0(s4)
     b48:	a2970000 	sb	s7,0(s4)
     b4c:	a2950000 	sb	s5,0(s4)
     b50:	34020063 	li	v0,0x63
     b54:	a2820000 	sb	v0,0(s4)
     b58:	340a0041 	li	t2,0x41
     b5c:	340b0042 	li	t3,0x42
     b60:	340c0043 	li	t4,0x43
     b64:	340d0044 	li	t5,0x44
     b68:	34020064 	li	v0,0x64
     b6c:	3403007b 	li	v1,0x7b
     b70:	3404007b 	li	a0,0x7b
     b74:	a28a0000 	sb	t2,0(s4)
     b78:	10430006 	beq	v0,v1,b94 <BranchTest+0x104>
     b7c:	00200825 	move	at,at
     b80:	a28b0000 	sb	t3,0(s4)
     b84:	a28c0000 	sb	t4,0(s4)
     b88:	10640002 	beq	v1,a0,b94 <BranchTest+0x104>
     b8c:	00200825 	move	at,at
     b90:	a2960000 	sb	s6,0(s4)
     b94:	a28d0000 	sb	t5,0(s4)
     b98:	a2970000 	sb	s7,0(s4)
     b9c:	a2950000 	sb	s5,0(s4)
     ba0:	34020064 	li	v0,0x64
     ba4:	a2820000 	sb	v0,0(s4)
     ba8:	340a0041 	li	t2,0x41
     bac:	340b0042 	li	t3,0x42
     bb0:	340c0043 	li	t4,0x43
     bb4:	340d0044 	li	t5,0x44
     bb8:	340f0058 	li	t7,0x58
     bbc:	34020064 	li	v0,0x64
     bc0:	3c03ffff 	lui	v1,0xffff
     bc4:	34631234 	ori	v1,v1,0x1234
     bc8:	3404007b 	li	a0,0x7b
     bcc:	a28a0000 	sb	t2,0(s4)
     bd0:	04610006 	bgez	v1,bec <BranchTest+0x15c>
     bd4:	00200825 	move	at,at
     bd8:	a28b0000 	sb	t3,0(s4)
     bdc:	a28c0000 	sb	t4,0(s4)
     be0:	04410002 	bgez	v0,bec <BranchTest+0x15c>
     be4:	00200825 	move	at,at
     be8:	a2960000 	sb	s6,0(s4)
     bec:	04010002 	b	bf8 <BranchTest+0x168>
     bf0:	00200825 	move	at,at
     bf4:	a28f0000 	sb	t7,0(s4)
     bf8:	a28d0000 	sb	t5,0(s4)
     bfc:	a2970000 	sb	s7,0(s4)
     c00:	a2950000 	sb	s5,0(s4)
     c04:	34020065 	li	v0,0x65
     c08:	a2820000 	sb	v0,0(s4)
     c0c:	340a0041 	li	t2,0x41
     c10:	340b0042 	li	t3,0x42
     c14:	340c0043 	li	t4,0x43
     c18:	340d0044 	li	t5,0x44
     c1c:	340e0045 	li	t6,0x45
     c20:	340f0058 	li	t7,0x58
     c24:	3c03ffff 	lui	v1,0xffff
     c28:	34631234 	ori	v1,v1,0x1234
     c2c:	04710009 	bgezal	v1,c54 <BranchTest+0x1c4>
     c30:	00200825 	move	at,at
     c34:	a28a0000 	sb	t2,0(s4)
     c38:	04110006 	bal	c54 <BranchTest+0x1c4>
     c3c:	00200825 	move	at,at
     c40:	a28d0000 	sb	t5,0(s4)
     c44:	a28e0000 	sb	t6,0(s4)
     c48:	10000007 	b	c68 <BranchTest+0x1d8>
     c4c:	00200825 	move	at,at
     c50:	a28f0000 	sb	t7,0(s4)
     c54:	a28b0000 	sb	t3,0(s4)
     c58:	a28c0000 	sb	t4,0(s4)
     c5c:	03e00008 	jr	ra
     c60:	00200825 	move	at,at
     c64:	a2960000 	sb	s6,0(s4)
     c68:	a2970000 	sb	s7,0(s4)
     c6c:	a2950000 	sb	s5,0(s4)
     c70:	34020066 	li	v0,0x66
     c74:	a2820000 	sb	v0,0(s4)
     c78:	340a0041 	li	t2,0x41
     c7c:	340b0042 	li	t3,0x42
     c80:	340c0043 	li	t4,0x43
     c84:	340d0044 	li	t5,0x44
     c88:	34020064 	li	v0,0x64
     c8c:	3c03ffff 	lui	v1,0xffff
     c90:	34631234 	ori	v1,v1,0x1234
     c94:	a28a0000 	sb	t2,0(s4)
     c98:	1c600006 	bgtz	v1,cb4 <BranchTest+0x224>
     c9c:	00200825 	move	at,at
     ca0:	a28b0000 	sb	t3,0(s4)
     ca4:	a28c0000 	sb	t4,0(s4)
     ca8:	1c400002 	bgtz	v0,cb4 <BranchTest+0x224>
     cac:	00200825 	move	at,at
     cb0:	a2960000 	sb	s6,0(s4)
     cb4:	a28d0000 	sb	t5,0(s4)
     cb8:	a2970000 	sb	s7,0(s4)
     cbc:	a2950000 	sb	s5,0(s4)
     cc0:	34020067 	li	v0,0x67
     cc4:	a2820000 	sb	v0,0(s4)
     cc8:	340a0041 	li	t2,0x41
     ccc:	340b0042 	li	t3,0x42
     cd0:	340c0043 	li	t4,0x43
     cd4:	340d0044 	li	t5,0x44
     cd8:	34020064 	li	v0,0x64
     cdc:	3c03ffff 	lui	v1,0xffff
     ce0:	34631234 	ori	v1,v1,0x1234
     ce4:	a28a0000 	sb	t2,0(s4)
     ce8:	18400006 	blez	v0,d04 <BranchTest+0x274>
     cec:	00200825 	move	at,at
     cf0:	a28b0000 	sb	t3,0(s4)
     cf4:	a28c0000 	sb	t4,0(s4)
     cf8:	18600002 	blez	v1,d04 <BranchTest+0x274>
     cfc:	00200825 	move	at,at
     d00:	a2960000 	sb	s6,0(s4)
     d04:	18000002 	blez	zero,d10 <BranchTest+0x280>
     d08:	00200825 	move	at,at
     d0c:	a2960000 	sb	s6,0(s4)
     d10:	a28d0000 	sb	t5,0(s4)
     d14:	a2970000 	sb	s7,0(s4)
     d18:	a2950000 	sb	s5,0(s4)
     d1c:	34020068 	li	v0,0x68
     d20:	a2820000 	sb	v0,0(s4)
     d24:	340a0041 	li	t2,0x41
     d28:	340b0042 	li	t3,0x42
     d2c:	340c0043 	li	t4,0x43
     d30:	340d0044 	li	t5,0x44
     d34:	340e0045 	li	t6,0x45
     d38:	34020064 	li	v0,0x64
     d3c:	3c03ffff 	lui	v1,0xffff
     d40:	34631234 	ori	v1,v1,0x1234
     d44:	34040000 	li	a0,0x0
     d48:	a28a0000 	sb	t2,0(s4)
     d4c:	04400006 	bltz	v0,d68 <BranchTest+0x2d8>
     d50:	00200825 	move	at,at
     d54:	a28b0000 	sb	t3,0(s4)
     d58:	a28c0000 	sb	t4,0(s4)
     d5c:	04600002 	bltz	v1,d68 <BranchTest+0x2d8>
     d60:	00200825 	move	at,at
     d64:	a2960000 	sb	s6,0(s4)
     d68:	04800002 	bltz	a0,d74 <BranchTest+0x2e4>
     d6c:	00200825 	move	at,at
     d70:	a28d0000 	sb	t5,0(s4)
     d74:	a28e0000 	sb	t6,0(s4)
     d78:	a2970000 	sb	s7,0(s4)
     d7c:	a2950000 	sb	s5,0(s4)
     d80:	34020069 	li	v0,0x69
     d84:	a2820000 	sb	v0,0(s4)
     d88:	340a0041 	li	t2,0x41
     d8c:	340b0042 	li	t3,0x42
     d90:	340c0043 	li	t4,0x43
     d94:	340d0044 	li	t5,0x44
     d98:	340e0045 	li	t6,0x45
     d9c:	340f0058 	li	t7,0x58
     da0:	3c03ffff 	lui	v1,0xffff
     da4:	34631234 	ori	v1,v1,0x1234
     da8:	04100009 	bltzal	zero,dd0 <BranchTest+0x340>
     dac:	00200825 	move	at,at
     db0:	a28a0000 	sb	t2,0(s4)
     db4:	04700006 	bltzal	v1,dd0 <BranchTest+0x340>
     db8:	00200825 	move	at,at
     dbc:	a28d0000 	sb	t5,0(s4)
     dc0:	a28e0000 	sb	t6,0(s4)
     dc4:	10000007 	b	de4 <BranchTest+0x354>
     dc8:	00200825 	move	at,at
     dcc:	a28f0000 	sb	t7,0(s4)
     dd0:	a28b0000 	sb	t3,0(s4)
     dd4:	a28c0000 	sb	t4,0(s4)
     dd8:	03e00008 	jr	ra
     ddc:	00200825 	move	at,at
     de0:	a2960000 	sb	s6,0(s4)
     de4:	a2970000 	sb	s7,0(s4)
     de8:	a2950000 	sb	s5,0(s4)
     dec:	3402006a 	li	v0,0x6a
     df0:	a2820000 	sb	v0,0(s4)
     df4:	340a0041 	li	t2,0x41
     df8:	340b0042 	li	t3,0x42
     dfc:	340c0043 	li	t4,0x43
     e00:	340d0044 	li	t5,0x44
     e04:	34020064 	li	v0,0x64
     e08:	3403007b 	li	v1,0x7b
     e0c:	3404007b 	li	a0,0x7b
     e10:	a28a0000 	sb	t2,0(s4)
     e14:	14640006 	bne	v1,a0,e30 <BranchTest+0x3a0>
     e18:	00200825 	move	at,at
     e1c:	a28b0000 	sb	t3,0(s4)
     e20:	a28c0000 	sb	t4,0(s4)
     e24:	14430002 	bne	v0,v1,e30 <BranchTest+0x3a0>
     e28:	00200825 	move	at,at
     e2c:	a2960000 	sb	s6,0(s4)
     e30:	a28d0000 	sb	t5,0(s4)
     e34:	a2970000 	sb	s7,0(s4)
     e38:	a2950000 	sb	s5,0(s4)
     e3c:	3402006b 	li	v0,0x6b
     e40:	a2820000 	sb	v0,0(s4)
     e44:	340a0041 	li	t2,0x41
     e48:	340b0042 	li	t3,0x42
     e4c:	340f0058 	li	t7,0x58
     e50:	a28a0000 	sb	t2,0(s4)
     e54:	08000398 	j	e60 <BranchTest+0x3d0>
     e58:	00200825 	move	at,at
     e5c:	a28f0000 	sb	t7,0(s4)
     e60:	a28b0000 	sb	t3,0(s4)
     e64:	a2970000 	sb	s7,0(s4)
     e68:	a2950000 	sb	s5,0(s4)
     e6c:	3402006c 	li	v0,0x6c
     e70:	a2820000 	sb	v0,0(s4)
     e74:	340a0041 	li	t2,0x41
     e78:	340b0042 	li	t3,0x42
     e7c:	340c0043 	li	t4,0x43
     e80:	340d0044 	li	t5,0x44
     e84:	340e0045 	li	t6,0x45
     e88:	340f0058 	li	t7,0x58
     e8c:	a28a0000 	sb	t2,0(s4)
     e90:	0c0003ab 	jal	eac <BranchTest+0x41c>
     e94:	00200825 	move	at,at
     e98:	a28d0000 	sb	t5,0(s4)
     e9c:	a28e0000 	sb	t6,0(s4)
     ea0:	10000007 	b	ec0 <BranchTest+0x430>
     ea4:	00200825 	move	at,at
     ea8:	a28f0000 	sb	t7,0(s4)
     eac:	a28b0000 	sb	t3,0(s4)
     eb0:	a28c0000 	sb	t4,0(s4)
     eb4:	03e00008 	jr	ra
     eb8:	00200825 	move	at,at
     ebc:	a2960000 	sb	s6,0(s4)
     ec0:	a2970000 	sb	s7,0(s4)
     ec4:	a2950000 	sb	s5,0(s4)
     ec8:	3402006d 	li	v0,0x6d
     ecc:	a2820000 	sb	v0,0(s4)
     ed0:	340a0041 	li	t2,0x41
     ed4:	340b0042 	li	t3,0x42
     ed8:	340c0043 	li	t4,0x43
     edc:	340d0044 	li	t5,0x44
     ee0:	340e0045 	li	t6,0x45
     ee4:	340f0058 	li	t7,0x58
     ee8:	3c030000 	lui	v1,0x0
     eec:	24630f10 	addiu	v1,v1,3856
     ef0:	a28a0000 	sb	t2,0(s4)
     ef4:	0060f809 	jalr	v1
     ef8:	00200825 	move	at,at
     efc:	a28d0000 	sb	t5,0(s4)
     f00:	a28e0000 	sb	t6,0(s4)
     f04:	10000007 	b	f24 <BranchTest+0x494>
     f08:	00200825 	move	at,at
     f0c:	a28f0000 	sb	t7,0(s4)
     f10:	a28b0000 	sb	t3,0(s4)
     f14:	a28c0000 	sb	t4,0(s4)
     f18:	03e00008 	jr	ra
     f1c:	00200825 	move	at,at
     f20:	a2960000 	sb	s6,0(s4)
     f24:	a2970000 	sb	s7,0(s4)
     f28:	a2950000 	sb	s5,0(s4)
     f2c:	3402006e 	li	v0,0x6e
     f30:	a2820000 	sb	v0,0(s4)
     f34:	340a0041 	li	t2,0x41
     f38:	340b0042 	li	t3,0x42
     f3c:	340f0058 	li	t7,0x58
     f40:	3c030000 	lui	v1,0x0
     f44:	24630f58 	addiu	v1,v1,3928
     f48:	a28a0000 	sb	t2,0(s4)
     f4c:	00600008 	jr	v1
     f50:	00200825 	move	at,at
     f54:	a28f0000 	sb	t7,0(s4)
     f58:	a28b0000 	sb	t3,0(s4)
     f5c:	a2970000 	sb	s7,0(s4)
     f60:	a2950000 	sb	s5,0(s4)
     f64:	3402006f 	li	v0,0x6f
     f68:	a2820000 	sb	v0,0(s4)
     f6c:	34020041 	li	v0,0x41
     f70:	00200825 	move	at,at
     f74:	a2820000 	sb	v0,0(s4)
     f78:	a2970000 	sb	s7,0(s4)
     f7c:	a2950000 	sb	s5,0(s4)

00000f80 <LoadTest>:
     f80:	3402004c 	li	v0,0x4c
     f84:	a2820000 	sb	v0,0(s4)
     f88:	3402006f 	li	v0,0x6f
     f8c:	a2820000 	sb	v0,0(s4)
     f90:	34020061 	li	v0,0x61
     f94:	a2820000 	sb	v0,0(s4)
     f98:	34020064 	li	v0,0x64
     f9c:	a2820000 	sb	v0,0(s4)
     fa0:	a2970000 	sb	s7,0(s4)
     fa4:	a2950000 	sb	s5,0(s4)
     fa8:	34020061 	li	v0,0x61
     fac:	a2820000 	sb	v0,0(s4)
     fb0:	00181025 	or	v0,zero,t8
     fb4:	3c03fc43 	lui	v1,0xfc43
     fb8:	34634241 	ori	v1,v1,0x4241
     fbc:	ac430010 	sw	v1,16(v0)
     fc0:	80440010 	lb	a0,16(v0)
     fc4:	a2840000 	sb	a0,0(s4)
     fc8:	80440011 	lb	a0,17(v0)
     fcc:	a2840000 	sb	a0,0(s4)
     fd0:	80440012 	lb	a0,18(v0)
     fd4:	a2840000 	sb	a0,0(s4)
     fd8:	80420013 	lb	v0,19(v0)
     fdc:	00021a03 	sra	v1,v0,0x8
     fe0:	20630045 	addi	v1,v1,69
     fe4:	a2830000 	sb	v1,0(s4)
     fe8:	20420049 	addi	v0,v0,73
     fec:	a2820000 	sb	v0,0(s4)
     ff0:	a2970000 	sb	s7,0(s4)
     ff4:	a2950000 	sb	s5,0(s4)
     ff8:	34020062 	li	v0,0x62
     ffc:	a2820000 	sb	v0,0(s4)
    1000:	00181025 	or	v0,zero,t8
    1004:	3c034443 	lui	v1,0x4443
    1008:	34634241 	ori	v1,v1,0x4241
    100c:	ac430010 	sw	v1,16(v0)
    1010:	80440010 	lb	a0,16(v0)
    1014:	a2840000 	sb	a0,0(s4)
    1018:	80440011 	lb	a0,17(v0)
    101c:	a2840000 	sb	a0,0(s4)
    1020:	80440012 	lb	a0,18(v0)
    1024:	a2840000 	sb	a0,0(s4)
    1028:	80420013 	lb	v0,19(v0)
    102c:	a2820000 	sb	v0,0(s4)
    1030:	a2970000 	sb	s7,0(s4)
    1034:	a2950000 	sb	s5,0(s4)
    1038:	34020063 	li	v0,0x63
    103c:	a2820000 	sb	v0,0(s4)
    1040:	00181025 	or	v0,zero,t8
    1044:	3c030042 	lui	v1,0x42
    1048:	34630041 	ori	v1,v1,0x41
    104c:	ac430010 	sw	v1,16(v0)
    1050:	84440010 	lh	a0,16(v0)
    1054:	a2840000 	sb	a0,0(s4)
    1058:	84420012 	lh	v0,18(v0)
    105c:	a2820000 	sb	v0,0(s4)
    1060:	a2970000 	sb	s7,0(s4)
    1064:	a2950000 	sb	s5,0(s4)
    1068:	34020064 	li	v0,0x64
    106c:	a2820000 	sb	v0,0(s4)
    1070:	00181025 	or	v0,zero,t8
    1074:	3c030042 	lui	v1,0x42
    1078:	34630041 	ori	v1,v1,0x41
    107c:	ac430010 	sw	v1,16(v0)
    1080:	84440010 	lh	a0,16(v0)
    1084:	a2840000 	sb	a0,0(s4)
    1088:	84420012 	lh	v0,18(v0)
    108c:	a2820000 	sb	v0,0(s4)
    1090:	a2970000 	sb	s7,0(s4)
    1094:	a2950000 	sb	s5,0(s4)
    1098:	34020065 	li	v0,0x65
    109c:	a2820000 	sb	v0,0(s4)
    10a0:	00181025 	or	v0,zero,t8
    10a4:	24030041 	li	v1,65
    10a8:	ac430010 	sw	v1,16(v0)
    10ac:	34030000 	li	v1,0x0
    10b0:	8c420010 	lw	v0,16(v0)
    10b4:	a2820000 	sb	v0,0(s4)
    10b8:	a2970000 	sb	s7,0(s4)
    10bc:	a2950000 	sb	s5,0(s4)
    10c0:	34020066 	li	v0,0x66
    10c4:	a2820000 	sb	v0,0(s4)
    10c8:	00181025 	or	v0,zero,t8
    10cc:	24030041 	li	v1,65
    10d0:	ac430010 	sw	v1,16(v0)
    10d4:	34030000 	li	v1,0x0
    10d8:	88420010 	lwl	v0,16(v0)
    10dc:	98420010 	lwr	v0,16(v0)
    10e0:	a2820000 	sb	v0,0(s4)
    10e4:	a2970000 	sb	s7,0(s4)
    10e8:	a2950000 	sb	s5,0(s4)
    10ec:	34020067 	li	v0,0x67
    10f0:	a2820000 	sb	v0,0(s4)
    10f4:	34020041 	li	v0,0x41
    10f8:	a2820000 	sb	v0,0(s4)
    10fc:	a2970000 	sb	s7,0(s4)
    1100:	a2950000 	sb	s5,0(s4)
    1104:	34020068 	li	v0,0x68
    1108:	a2820000 	sb	v0,0(s4)
    110c:	00182025 	or	a0,zero,t8
    1110:	34024241 	li	v0,0x4241
    1114:	a4820010 	sh	v0,16(a0)
    1118:	80830010 	lb	v1,16(a0)
    111c:	a2830000 	sb	v1,0(s4)
    1120:	80820011 	lb	v0,17(a0)
    1124:	a2820000 	sb	v0,0(s4)
    1128:	a2970000 	sb	s7,0(s4)
    112c:	a2950000 	sb	s5,0(s4)
    1130:	34020069 	li	v0,0x69
    1134:	a2820000 	sb	v0,0(s4)
    1138:	00181025 	or	v0,zero,t8
    113c:	3c034443 	lui	v1,0x4443
    1140:	34634241 	ori	v1,v1,0x4241
    1144:	ac430010 	sw	v1,16(v0)
    1148:	80440010 	lb	a0,16(v0)
    114c:	a2840000 	sb	a0,0(s4)
    1150:	80440011 	lb	a0,17(v0)
    1154:	a2840000 	sb	a0,0(s4)
    1158:	80440012 	lb	a0,18(v0)
    115c:	a2840000 	sb	a0,0(s4)
    1160:	80420013 	lb	v0,19(v0)
    1164:	a2820000 	sb	v0,0(s4)
    1168:	a2970000 	sb	s7,0(s4)
    116c:	a2950000 	sb	s5,0(s4)
    1170:	3402006a 	li	v0,0x6a
    1174:	a2820000 	sb	v0,0(s4)
    1178:	00181025 	or	v0,zero,t8
    117c:	3c034443 	lui	v1,0x4443
    1180:	34634241 	ori	v1,v1,0x4241
    1184:	a8430010 	swl	v1,16(v0)
    1188:	b8430010 	swr	v1,16(v0)
    118c:	80440010 	lb	a0,16(v0)
    1190:	a2840000 	sb	a0,0(s4)
    1194:	80440011 	lb	a0,17(v0)
    1198:	a2840000 	sb	a0,0(s4)
    119c:	80440012 	lb	a0,18(v0)
    11a0:	a2840000 	sb	a0,0(s4)
    11a4:	80420013 	lb	v0,19(v0)
    11a8:	a2820000 	sb	v0,0(s4)
    11ac:	a2970000 	sb	s7,0(s4)
    11b0:	a2950000 	sb	s5,0(s4)

000011b4 <LogicalTest>:
    11b4:	3402004c 	li	v0,0x4c
    11b8:	a2820000 	sb	v0,0(s4)
    11bc:	3402006f 	li	v0,0x6f
    11c0:	a2820000 	sb	v0,0(s4)
    11c4:	34020067 	li	v0,0x67
    11c8:	a2820000 	sb	v0,0(s4)
    11cc:	34020069 	li	v0,0x69
    11d0:	a2820000 	sb	v0,0(s4)
    11d4:	34020063 	li	v0,0x63
    11d8:	a2820000 	sb	v0,0(s4)
    11dc:	a2970000 	sb	s7,0(s4)
    11e0:	a2950000 	sb	s5,0(s4)
    11e4:	34020061 	li	v0,0x61
    11e8:	a2820000 	sb	v0,0(s4)
    11ec:	34020741 	li	v0,0x741
    11f0:	340360f3 	li	v1,0x60f3
    11f4:	00432024 	and	a0,v0,v1
    11f8:	a2840000 	sb	a0,0(s4)
    11fc:	a2970000 	sb	s7,0(s4)
    1200:	a2950000 	sb	s5,0(s4)
    1204:	34020062 	li	v0,0x62
    1208:	a2820000 	sb	v0,0(s4)
    120c:	34020741 	li	v0,0x741
    1210:	304460f3 	andi	a0,v0,0x60f3
    1214:	a2840000 	sb	a0,0(s4)
    1218:	a2970000 	sb	s7,0(s4)
    121c:	a2950000 	sb	s5,0(s4)
    1220:	34020063 	li	v0,0x63
    1224:	a2820000 	sb	v0,0(s4)
    1228:	3c020041 	lui	v0,0x41
    122c:	00021c02 	srl	v1,v0,0x10
    1230:	a2830000 	sb	v1,0(s4)
    1234:	a2970000 	sb	s7,0(s4)
    1238:	a2950000 	sb	s5,0(s4)
    123c:	34020064 	li	v0,0x64
    1240:	a2820000 	sb	v0,0(s4)
    1244:	3c02f0ff 	lui	v0,0xf0ff
    1248:	3442f08e 	ori	v0,v0,0xf08e
    124c:	3c030f0f 	lui	v1,0xf0f
    1250:	34630f30 	ori	v1,v1,0xf30
    1254:	00432027 	nor	a0,v0,v1
    1258:	a2840000 	sb	a0,0(s4)
    125c:	a2970000 	sb	s7,0(s4)
    1260:	a2950000 	sb	s5,0(s4)
    1264:	34020065 	li	v0,0x65
    1268:	a2820000 	sb	v0,0(s4)
    126c:	34020040 	li	v0,0x40
    1270:	34030001 	li	v1,0x1
    1274:	00432025 	or	a0,v0,v1
    1278:	a2840000 	sb	a0,0(s4)
    127c:	a2970000 	sb	s7,0(s4)
    1280:	a2950000 	sb	s5,0(s4)
    1284:	34020066 	li	v0,0x66
    1288:	a2820000 	sb	v0,0(s4)
    128c:	34020040 	li	v0,0x40
    1290:	34440001 	ori	a0,v0,0x1
    1294:	a2840000 	sb	a0,0(s4)
    1298:	a2970000 	sb	s7,0(s4)
    129c:	a2950000 	sb	s5,0(s4)
    12a0:	34020067 	li	v0,0x67
    12a4:	a2820000 	sb	v0,0(s4)
    12a8:	3402f043 	li	v0,0xf043
    12ac:	3403f002 	li	v1,0xf002
    12b0:	00432026 	xor	a0,v0,v1
    12b4:	a2840000 	sb	a0,0(s4)
    12b8:	a2970000 	sb	s7,0(s4)
    12bc:	a2950000 	sb	s5,0(s4)
    12c0:	34020068 	li	v0,0x68
    12c4:	a2820000 	sb	v0,0(s4)
    12c8:	3402f043 	li	v0,0xf043
    12cc:	3844f002 	xori	a0,v0,0xf002
    12d0:	a2840000 	sb	a0,0(s4)
    12d4:	a2970000 	sb	s7,0(s4)
    12d8:	a2950000 	sb	s5,0(s4)

000012dc <MoveTest>:
    12dc:	3402004d 	li	v0,0x4d
    12e0:	a2820000 	sb	v0,0(s4)
    12e4:	3402006f 	li	v0,0x6f
    12e8:	a2820000 	sb	v0,0(s4)
    12ec:	34020076 	li	v0,0x76
    12f0:	a2820000 	sb	v0,0(s4)
    12f4:	34020065 	li	v0,0x65
    12f8:	a2820000 	sb	v0,0(s4)
    12fc:	a2970000 	sb	s7,0(s4)
    1300:	a2950000 	sb	s5,0(s4)
    1304:	34020061 	li	v0,0x61
    1308:	a2820000 	sb	v0,0(s4)
    130c:	34020041 	li	v0,0x41
    1310:	00400011 	mthi	v0
    1314:	00001810 	mfhi	v1
    1318:	a2830000 	sb	v1,0(s4)
    131c:	a2970000 	sb	s7,0(s4)
    1320:	a2950000 	sb	s5,0(s4)
    1324:	34020062 	li	v0,0x62
    1328:	a2820000 	sb	v0,0(s4)
    132c:	34020041 	li	v0,0x41
    1330:	00400013 	mtlo	v0
    1334:	00001812 	mflo	v1
    1338:	a2830000 	sb	v1,0(s4)
    133c:	a2970000 	sb	s7,0(s4)
    1340:	a2950000 	sb	s5,0(s4)
    1344:	34020063 	li	v0,0x63
    1348:	a2820000 	sb	v0,0(s4)
    134c:	34020041 	li	v0,0x41
    1350:	00400011 	mthi	v0
    1354:	00001810 	mfhi	v1
    1358:	a2830000 	sb	v1,0(s4)
    135c:	a2970000 	sb	s7,0(s4)
    1360:	a2950000 	sb	s5,0(s4)
    1364:	34020064 	li	v0,0x64
    1368:	a2820000 	sb	v0,0(s4)
    136c:	34020041 	li	v0,0x41
    1370:	00400013 	mtlo	v0
    1374:	00001812 	mflo	v1
    1378:	a2830000 	sb	v1,0(s4)
    137c:	a2970000 	sb	s7,0(s4)
    1380:	a2950000 	sb	s5,0(s4)

00001384 <ShiftTest>:
    1384:	34020053 	li	v0,0x53
    1388:	a2820000 	sb	v0,0(s4)
    138c:	34020068 	li	v0,0x68
    1390:	a2820000 	sb	v0,0(s4)
    1394:	34020069 	li	v0,0x69
    1398:	a2820000 	sb	v0,0(s4)
    139c:	34020066 	li	v0,0x66
    13a0:	a2820000 	sb	v0,0(s4)
    13a4:	34020074 	li	v0,0x74
    13a8:	a2820000 	sb	v0,0(s4)
    13ac:	a2970000 	sb	s7,0(s4)
    13b0:	a2950000 	sb	s5,0(s4)
    13b4:	34020061 	li	v0,0x61
    13b8:	a2820000 	sb	v0,0(s4)
    13bc:	3c024041 	lui	v0,0x4041
    13c0:	34424243 	ori	v0,v0,0x4243
    13c4:	00021a00 	sll	v1,v0,0x8
    13c8:	00031e02 	srl	v1,v1,0x18
    13cc:	a2830000 	sb	v1,0(s4)
    13d0:	a2970000 	sb	s7,0(s4)
    13d4:	a2950000 	sb	s5,0(s4)
    13d8:	34020062 	li	v0,0x62
    13dc:	a2820000 	sb	v0,0(s4)
    13e0:	3c024041 	lui	v0,0x4041
    13e4:	34424243 	ori	v0,v0,0x4243
    13e8:	34030008 	li	v1,0x8
    13ec:	00621804 	sllv	v1,v0,v1
    13f0:	00031e02 	srl	v1,v1,0x18
    13f4:	a2830000 	sb	v1,0(s4)
    13f8:	a2970000 	sb	s7,0(s4)
    13fc:	a2950000 	sb	s5,0(s4)
    1400:	34020063 	li	v0,0x63
    1404:	a2820000 	sb	v0,0(s4)
    1408:	3c024041 	lui	v0,0x4041
    140c:	34424243 	ori	v0,v0,0x4243
    1410:	00021c03 	sra	v1,v0,0x10
    1414:	a2830000 	sb	v1,0(s4)
    1418:	3c028400 	lui	v0,0x8400
    141c:	00021e43 	sra	v1,v0,0x19
    1420:	2063ff80 	addi	v1,v1,-128
    1424:	a2830000 	sb	v1,0(s4)
    1428:	a2970000 	sb	s7,0(s4)
    142c:	a2950000 	sb	s5,0(s4)
    1430:	34020064 	li	v0,0x64
    1434:	a2820000 	sb	v0,0(s4)
    1438:	3c024041 	lui	v0,0x4041
    143c:	34424243 	ori	v0,v0,0x4243
    1440:	34030010 	li	v1,0x10
    1444:	00621807 	srav	v1,v0,v1
    1448:	a2830000 	sb	v1,0(s4)
    144c:	34030019 	li	v1,0x19
    1450:	3c028400 	lui	v0,0x8400
    1454:	00621807 	srav	v1,v0,v1
    1458:	2063ff80 	addi	v1,v1,-128
    145c:	a2830000 	sb	v1,0(s4)
    1460:	a2970000 	sb	s7,0(s4)
    1464:	a2950000 	sb	s5,0(s4)
    1468:	34020065 	li	v0,0x65
    146c:	a2820000 	sb	v0,0(s4)
    1470:	3c024041 	lui	v0,0x4041
    1474:	34424243 	ori	v0,v0,0x4243
    1478:	00021c02 	srl	v1,v0,0x10
    147c:	a2830000 	sb	v1,0(s4)
    1480:	3c028400 	lui	v0,0x8400
    1484:	00021e42 	srl	v1,v0,0x19
    1488:	a2830000 	sb	v1,0(s4)
    148c:	a2970000 	sb	s7,0(s4)
    1490:	a2950000 	sb	s5,0(s4)
    1494:	34020066 	li	v0,0x66
    1498:	a2820000 	sb	v0,0(s4)
    149c:	3c024041 	lui	v0,0x4041
    14a0:	34424243 	ori	v0,v0,0x4243
    14a4:	34030010 	li	v1,0x10
    14a8:	00622006 	srlv	a0,v0,v1
    14ac:	a2840000 	sb	a0,0(s4)
    14b0:	34030019 	li	v1,0x19
    14b4:	3c028400 	lui	v0,0x8400
    14b8:	00621806 	srlv	v1,v0,v1
    14bc:	a2830000 	sb	v1,0(s4)
    14c0:	a2970000 	sb	s7,0(s4)
    14c4:	a2950000 	sb	s5,0(s4)
    14c8:	34020044 	li	v0,0x44
    14cc:	a2820000 	sb	v0,0(s4)
    14d0:	3402006f 	li	v0,0x6f
    14d4:	a2820000 	sb	v0,0(s4)
    14d8:	3402006e 	li	v0,0x6e
    14dc:	a2820000 	sb	v0,0(s4)
    14e0:	34020065 	li	v0,0x65
    14e4:	a2820000 	sb	v0,0(s4)
    14e8:	a2970000 	sb	s7,0(s4)
    14ec:	a2950000 	sb	s5,0(s4)
    14f0:	0800000b 	j	2c <end_test>
    14f4:	00200825 	move	at,at
    14f8:	00200825 	move	at,at
    14fc:	00200825 	move	at,at

00001500 <foo>:
    1500:	24030002 	li	v1,2
    1504:	14830004 	bne	a0,v1,1518 <foo+0x18>
    1508:	00200825 	move	at,at
    150c:	34a2abab 	ori	v0,a1,0xabab
    1510:	03e00008 	jr	ra
    1514:	00200825 	move	at,at
    1518:	30a2aaaa 	andi	v0,a1,0xaaaa
    151c:	03e00008 	jr	ra
    1520:	00200825 	move	at,at

00001524 <printn>:
    1524:	24840030 	addiu	a0,a0,48
    1528:	3c020800 	lui	v0,0x800
    152c:	a0440000 	sb	a0,0(v0)
    1530:	03e00008 	jr	ra
    1534:	00200825 	move	at,at

00001538 <printdur>:
    1538:	27bdffd8 	addiu	sp,sp,-40
    153c:	afbf0024 	sw	ra,36(sp)
    1540:	afb10020 	sw	s1,32(sp)
    1544:	afb0001c 	sw	s0,28(sp)
    1548:	00008021 	move	s0,zero
    154c:	2411000a 	li	s1,10
    1550:	02002021 	move	a0,s0
    1554:	0c000549 	jal	1524 <printn>
    1558:	00200825 	move	at,at
    155c:	26100001 	addiu	s0,s0,1
    1560:	1611fffb 	bne	s0,s1,1550 <printdur+0x18>
    1564:	00200825 	move	at,at
    1568:	8fbf0024 	lw	ra,36(sp)
    156c:	8fb10020 	lw	s1,32(sp)
    1570:	8fb0001c 	lw	s0,28(sp)
    1574:	27bd0028 	addiu	sp,sp,40
    1578:	03e00008 	jr	ra
    157c:	00200825 	move	at,at

00001580 <printfoo>:
    1580:	3c020001 	lui	v0,0x1
    1584:	8042836c 	lb	v0,-31892(v0)
    1588:	00200825 	move	at,at
    158c:	10400009 	beqz	v0,15b4 <printfoo+0x34>
    1590:	00200825 	move	at,at
    1594:	3c030001 	lui	v1,0x1
    1598:	2463836d 	addiu	v1,v1,-31891
    159c:	3c040800 	lui	a0,0x800
    15a0:	a0820000 	sb	v0,0(a0)
    15a4:	80620000 	lb	v0,0(v1)
    15a8:	24630001 	addiu	v1,v1,1
    15ac:	1440fffc 	bnez	v0,15a0 <printfoo+0x20>
    15b0:	00200825 	move	at,at
    15b4:	03e00008 	jr	ra
    15b8:	00200825 	move	at,at

000015bc <cache_test>:
    15bc:	3c030001 	lui	v1,0x1
    15c0:	3402ace1 	li	v0,0xace1
    15c4:	2406b400 	li	a2,-19456
    15c8:	3c050001 	lui	a1,0x1
    15cc:	24a51000 	addiu	a1,a1,4096
    15d0:	ac620000 	sw	v0,0(v1)
    15d4:	00022042 	srl	a0,v0,0x1
    15d8:	30420001 	andi	v0,v0,0x1
    15dc:	00021023 	negu	v0,v0
    15e0:	00461024 	and	v0,v0,a2
    15e4:	3042ffff 	andi	v0,v0,0xffff
    15e8:	00441026 	xor	v0,v0,a0
    15ec:	24630004 	addiu	v1,v1,4
    15f0:	1465fff7 	bne	v1,a1,15d0 <cache_test+0x14>
    15f4:	00200825 	move	at,at
    15f8:	03e00008 	jr	ra
    15fc:	00200825 	move	at,at

00001600 <xor>:
    1600:	3c030001 	lui	v1,0x1
    1604:	00001021 	move	v0,zero
    1608:	3c050001 	lui	a1,0x1
    160c:	24a51000 	addiu	a1,a1,4096
    1610:	8c640000 	lw	a0,0(v1)
    1614:	00200825 	move	at,at
    1618:	00441026 	xor	v0,v0,a0
    161c:	24630004 	addiu	v1,v1,4
    1620:	1465fffb 	bne	v1,a1,1610 <xor+0x10>
    1624:	00200825 	move	at,at
    1628:	03e00008 	jr	ra
    162c:	00200825 	move	at,at

00001630 <mul>:
    1630:	00a40018 	mult	a1,a0
    1634:	00001012 	mflo	v0
    1638:	03e00008 	jr	ra
    163c:	00200825 	move	at,at

00001640 <div2>:
    1640:	0085001b 	divu	zero,a0,a1
    1644:	00001012 	mflo	v0
    1648:	03e00008 	jr	ra
    164c:	00200825 	move	at,at

00001650 <my_printf>:
    1650:	27bdff58 	addiu	sp,sp,-168
    1654:	afbf00a4 	sw	ra,164(sp)
    1658:	afa500ac 	sw	a1,172(sp)
    165c:	afa600b0 	sw	a2,176(sp)
    1660:	afa700b4 	sw	a3,180(sp)
    1664:	00802821 	move	a1,a0
    1668:	27a600ac 	addiu	a2,sp,172
    166c:	afa60098 	sw	a2,152(sp)
    1670:	27a40018 	addiu	a0,sp,24
    1674:	0c000b38 	jal	2ce0 <my_vsprintf>
    1678:	00200825 	move	at,at
    167c:	27a40018 	addiu	a0,sp,24
    1680:	0c000bb3 	jal	2ecc <printstr>
    1684:	00200825 	move	at,at
    1688:	8fbf00a4 	lw	ra,164(sp)
    168c:	27bd00a8 	addiu	sp,sp,168
    1690:	03e00008 	jr	ra
    1694:	00200825 	move	at,at

00001698 <main>:
    1698:	27bdffc8 	addiu	sp,sp,-56
    169c:	afbf0034 	sw	ra,52(sp)
    16a0:	afb10030 	sw	s1,48(sp)
    16a4:	afb0002c 	sw	s0,44(sp)
    16a8:	00808821 	move	s1,a0
    16ac:	3c100800 	lui	s0,0x800
    16b0:	ae040000 	sw	a0,0(s0)
    16b4:	24020062 	li	v0,98
    16b8:	a2020000 	sb	v0,0(s0)
    16bc:	24020063 	li	v0,99
    16c0:	a6020000 	sh	v0,0(s0)
    16c4:	8e020008 	lw	v0,8(s0)
    16c8:	00200825 	move	at,at
    16cc:	afa20020 	sw	v0,32(sp)
    16d0:	ae020000 	sw	v0,0(s0)
    16d4:	0c000ba0 	jal	2e80 <term_init>
    16d8:	00200825 	move	at,at
    16dc:	3c040000 	lui	a0,0x0
    16e0:	24843bd0 	addiu	a0,a0,15312
    16e4:	0c000594 	jal	1650 <my_printf>
    16e8:	00200825 	move	at,at
    16ec:	3c040000 	lui	a0,0x0
    16f0:	24843be8 	addiu	a0,a0,15336
    16f4:	02202821 	move	a1,s1
    16f8:	0c000594 	jal	1650 <my_printf>
    16fc:	00200825 	move	at,at
    1700:	3c040000 	lui	a0,0x0
    1704:	24843c04 	addiu	a0,a0,15364
    1708:	27a50020 	addiu	a1,sp,32
    170c:	0c000594 	jal	1650 <my_printf>
    1710:	00200825 	move	at,at
    1714:	3c02aabb 	lui	v0,0xaabb
    1718:	3442ccdd 	ori	v0,v0,0xccdd
    171c:	afa20010 	sw	v0,16(sp)
    1720:	3c040000 	lui	a0,0x0
    1724:	24843c20 	addiu	a0,a0,15392
    1728:	24050005 	li	a1,5
    172c:	240601f4 	li	a2,500
    1730:	24070020 	li	a3,32
    1734:	0c000594 	jal	1650 <my_printf>
    1738:	00200825 	move	at,at
    173c:	24040002 	li	a0,2
    1740:	24050006 	li	a1,6
    1744:	0c00058c 	jal	1630 <mul>
    1748:	00200825 	move	at,at
    174c:	3c040000 	lui	a0,0x0
    1750:	24843c38 	addiu	a0,a0,15416
    1754:	00402821 	move	a1,v0
    1758:	0c000594 	jal	1650 <my_printf>
    175c:	00200825 	move	at,at
    1760:	2404000d 	li	a0,13
    1764:	24050002 	li	a1,2
    1768:	0c000590 	jal	1640 <div2>
    176c:	00200825 	move	at,at
    1770:	3c040000 	lui	a0,0x0
    1774:	24843c48 	addiu	a0,a0,15432
    1778:	00402821 	move	a1,v0
    177c:	0c000594 	jal	1650 <my_printf>
    1780:	00200825 	move	at,at
    1784:	0c00054e 	jal	1538 <printdur>
    1788:	00200825 	move	at,at
    178c:	0c00056f 	jal	15bc <cache_test>
    1790:	00200825 	move	at,at
    1794:	0c000580 	jal	1600 <xor>
    1798:	00200825 	move	at,at
    179c:	00408821 	move	s1,v0
    17a0:	3c040000 	lui	a0,0x0
    17a4:	24843c58 	addiu	a0,a0,15448
    17a8:	00402821 	move	a1,v0
    17ac:	0c000594 	jal	1650 <my_printf>
    17b0:	00200825 	move	at,at
    17b4:	ae110000 	sw	s1,0(s0)
    17b8:	0c000560 	jal	1580 <printfoo>
    17bc:	00200825 	move	at,at
    17c0:	240403e8 	li	a0,1000
    17c4:	0c000c89 	jal	3224 <dhry>
    17c8:	00200825 	move	at,at
    17cc:	00001021 	move	v0,zero
    17d0:	8fbf0034 	lw	ra,52(sp)
    17d4:	8fb10030 	lw	s1,48(sp)
    17d8:	8fb0002c 	lw	s0,44(sp)
    17dc:	27bd0038 	addiu	sp,sp,56
    17e0:	03e00008 	jr	ra
    17e4:	00200825 	move	at,at

000017e8 <intc>:
    17e8:	3c020001 	lui	v0,0x1
    17ec:	80428354 	lb	v0,-31916(v0)
    17f0:	00200825 	move	at,at
    17f4:	10400009 	beqz	v0,181c <intc+0x34>
    17f8:	00200825 	move	at,at
    17fc:	3c030001 	lui	v1,0x1
    1800:	24638355 	addiu	v1,v1,-31915
    1804:	3c040800 	lui	a0,0x800
    1808:	a0820000 	sb	v0,0(a0)
    180c:	80620000 	lb	v0,0(v1)
    1810:	24630001 	addiu	v1,v1,1
    1814:	1440fffc 	bnez	v0,1808 <intc+0x20>
    1818:	00200825 	move	at,at
    181c:	03e00008 	jr	ra
    1820:	00200825 	move	at,at

00001824 <opc>:
    1824:	3c020800 	lui	v0,0x800
    1828:	ac440000 	sw	a0,0(v0)
    182c:	ac450000 	sw	a1,0(v0)
    1830:	ac460000 	sw	a2,0(v0)
    1834:	3c020001 	lui	v0,0x1
    1838:	80428340 	lb	v0,-31936(v0)
    183c:	00200825 	move	at,at
    1840:	10400009 	beqz	v0,1868 <opc+0x44>
    1844:	00200825 	move	at,at
    1848:	3c030001 	lui	v1,0x1
    184c:	24638341 	addiu	v1,v1,-31935
    1850:	3c040800 	lui	a0,0x800
    1854:	a0820000 	sb	v0,0(a0)
    1858:	80620000 	lb	v0,0(v1)
    185c:	24630001 	addiu	v1,v1,1
    1860:	1440fffc 	bnez	v0,1854 <opc+0x30>
    1864:	00200825 	move	at,at
    1868:	03e00008 	jr	ra
    186c:	00200825 	move	at,at

00001870 <ksprintn>:
    1870:	8fab0010 	lw	t3,16(sp)
    1874:	a0800000 	sb	zero,0(a0)
    1878:	00801021 	move	v0,a0
    187c:	00c04021 	move	t0,a2
    1880:	3c0a0000 	lui	t2,0x0
    1884:	254a3df0 	addiu	t2,t2,15856
    1888:	00a6001b 	divu	zero,a1,a2
    188c:	00001810 	mfhi	v1
    1890:	006a1821 	addu	v1,v1,t2
    1894:	80630000 	lb	v1,0(v1)
    1898:	24420001 	addiu	v0,v0,1
    189c:	11600009 	beqz	t3,18c4 <ksprintn+0x54>
    18a0:	00200825 	move	at,at
    18a4:	306300ff 	andi	v1,v1,0xff
    18a8:	2469ff9f 	addiu	t1,v1,-97
    18ac:	312900ff 	andi	t1,t1,0xff
    18b0:	2d29001a 	sltiu	t1,t1,26
    18b4:	00094940 	sll	t1,t1,0x5
    18b8:	00691823 	subu	v1,v1,t1
    18bc:	00031e00 	sll	v1,v1,0x18
    18c0:	00031e03 	sra	v1,v1,0x18
    18c4:	a0430000 	sb	v1,0(v0)
    18c8:	00a8001b 	divu	zero,a1,t0
    18cc:	00002812 	mflo	a1
    18d0:	14a0ffed 	bnez	a1,1888 <ksprintn+0x18>
    18d4:	00200825 	move	at,at
    18d8:	10e00003 	beqz	a3,18e8 <ksprintn+0x78>
    18dc:	00200825 	move	at,at
    18e0:	00442023 	subu	a0,v0,a0
    18e4:	ace40000 	sw	a0,0(a3)
    18e8:	03e00008 	jr	ra
    18ec:	00200825 	move	at,at

000018f0 <my_putchar>:
    18f0:	8ca20004 	lw	v0,4(a1)
    18f4:	8ca30000 	lw	v1,0(a1)
    18f8:	00200825 	move	at,at
    18fc:	00621821 	addu	v1,v1,v0
    1900:	a0640000 	sb	a0,0(v1)
    1904:	24420001 	addiu	v0,v0,1
    1908:	aca20004 	sw	v0,4(a1)
    190c:	03e00008 	jr	ra
    1910:	00200825 	move	at,at

00001914 <kvprintf>:
    1914:	27bdff68 	addiu	sp,sp,-152
    1918:	afbf0094 	sw	ra,148(sp)
    191c:	afbe0090 	sw	s8,144(sp)
    1920:	afb7008c 	sw	s7,140(sp)
    1924:	afb60088 	sw	s6,136(sp)
    1928:	afb50084 	sw	s5,132(sp)
    192c:	afb40080 	sw	s4,128(sp)
    1930:	afb3007c 	sw	s3,124(sp)
    1934:	afb20078 	sw	s2,120(sp)
    1938:	afb10074 	sw	s1,116(sp)
    193c:	afb00070 	sw	s0,112(sp)
    1940:	0080b821 	move	s7,a0
    1944:	00a09021 	move	s2,a1
    1948:	00c0a021 	move	s4,a2
    194c:	afa700a4 	sw	a3,164(sp)
    1950:	10a00004 	beqz	a1,1964 <kvprintf+0x50>
    1954:	00200825 	move	at,at
    1958:	0000a821 	move	s5,zero
    195c:	0800065a 	j	1968 <kvprintf+0x54>
    1960:	00200825 	move	at,at
    1964:	00c0a821 	move	s5,a2
    1968:	16e00003 	bnez	s7,1978 <kvprintf+0x64>
    196c:	00200825 	move	at,at
    1970:	3c020000 	lui	v0,0x0
    1974:	24573c70 	addiu	s7,v0,15472
    1978:	8fa300a4 	lw	v1,164(sp)
    197c:	00200825 	move	at,at
    1980:	2462fffe 	addiu	v0,v1,-2
    1984:	2c420023 	sltiu	v0,v0,35
    1988:	14400003 	bnez	v0,1998 <kvprintf+0x84>
    198c:	00200825 	move	at,at
    1990:	2404000a 	li	a0,10
    1994:	afa400a4 	sw	a0,164(sp)
    1998:	0000b021 	move	s6,zero
    199c:	00009821 	move	s3,zero
    19a0:	3c020000 	lui	v0,0x0
    19a4:	24423c90 	addiu	v0,v0,15504
    19a8:	afa20050 	sw	v0,80(sp)
    19ac:	3c020000 	lui	v0,0x0
    19b0:	24423df0 	addiu	v0,v0,15856
    19b4:	afa2004c 	sw	v0,76(sp)
    19b8:	02e08821 	move	s1,s7
    19bc:	08000672 	j	19c8 <kvprintf+0xb4>
    19c0:	00200825 	move	at,at
    19c4:	03c0b021 	move	s6,s8
    19c8:	02201021 	move	v0,s1
    19cc:	02d1b023 	subu	s6,s6,s1
    19d0:	24110025 	li	s1,37
    19d4:	08000684 	j	1a10 <kvprintf+0xfc>
    19d8:	00200825 	move	at,at
    19dc:	10800497 	beqz	a0,2c3c <kvprintf+0x1328>
    19e0:	00200825 	move	at,at
    19e4:	12400007 	beqz	s2,1a04 <kvprintf+0xf0>
    19e8:	00200825 	move	at,at
    19ec:	02802821 	move	a1,s4
    19f0:	0240c821 	move	t9,s2
    19f4:	0320f809 	jalr	t9
    19f8:	00200825 	move	at,at
    19fc:	08000683 	j	1a0c <kvprintf+0xf8>
    1a00:	00200825 	move	at,at
    1a04:	a2a30000 	sb	v1,0(s5)
    1a08:	26b50001 	addiu	s5,s5,1
    1a0c:	02001021 	move	v0,s0
    1a10:	0056f021 	addu	s8,v0,s6
    1a14:	80430000 	lb	v1,0(v0)
    1a18:	00200825 	move	at,at
    1a1c:	306400ff 	andi	a0,v1,0xff
    1a20:	24500001 	addiu	s0,v0,1
    1a24:	1491ffed 	bne	a0,s1,19dc <kvprintf+0xc8>
    1a28:	00200825 	move	at,at
    1a2c:	1660ffed 	bnez	s3,19e4 <kvprintf+0xd0>
    1a30:	00200825 	move	at,at
    1a34:	afbe005c 	sw	s8,92(sp)
    1a38:	02a0c021 	move	t8,s5
    1a3c:	0040b821 	move	s7,v0
    1a40:	24030020 	li	v1,32
    1a44:	afa30060 	sw	v1,96(sp)
    1a48:	00007821 	move	t7,zero
    1a4c:	00007021 	move	t6,zero
    1a50:	0000b021 	move	s6,zero
    1a54:	00003821 	move	a3,zero
    1a58:	00004821 	move	t1,zero
    1a5c:	00006821 	move	t5,zero
    1a60:	00006021 	move	t4,zero
    1a64:	00004021 	move	t0,zero
    1a68:	afa00058 	sw	zero,88(sp)
    1a6c:	afa00054 	sw	zero,84(sp)
    1a70:	afa00048 	sw	zero,72(sp)
    1a74:	00005821 	move	t3,zero
    1a78:	00005021 	move	t2,zero
    1a7c:	080006b7 	j	1adc <kvprintf+0x1c8>
    1a80:	00200825 	move	at,at
    1a84:	240c0001 	li	t4,1
    1a88:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    1a8c:	00200825 	move	at,at
    1a90:	24040001 	li	a0,1
    1a94:	afa40058 	sw	a0,88(sp)
    1a98:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    1a9c:	00200825 	move	at,at
    1aa0:	afa300a8 	sw	v1,168(sp)
    1aa4:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    1aa8:	00200825 	move	at,at
    1aac:	24060030 	li	a2,48
    1ab0:	afa60060 	sw	a2,96(sp)
    1ab4:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    1ab8:	00200825 	move	at,at
    1abc:	afa40048 	sw	a0,72(sp)
    1ac0:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    1ac4:	00200825 	move	at,at
    1ac8:	24090001 	li	t1,1
    1acc:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    1ad0:	00200825 	move	at,at
    1ad4:	240a0001 	li	t2,1
    1ad8:	02208021 	move	s0,s1
    1adc:	82050000 	lb	a1,0(s0)
    1ae0:	00200825 	move	at,at
    1ae4:	30a400ff 	andi	a0,a1,0xff
    1ae8:	26110001 	addiu	s1,s0,1
    1aec:	2483ffdd 	addiu	v1,a0,-35
    1af0:	306600ff 	andi	a2,v1,0xff
    1af4:	2cc60058 	sltiu	a2,a2,88
    1af8:	10c00013 	beqz	a2,1b48 <kvprintf+0x234>
    1afc:	00200825 	move	at,at
    1b00:	306300ff 	andi	v1,v1,0xff
    1b04:	00031880 	sll	v1,v1,0x2
    1b08:	8fb90050 	lw	t9,80(sp)
    1b0c:	00200825 	move	at,at
    1b10:	03231821 	addu	v1,t9,v1
    1b14:	8c630000 	lw	v1,0(v1)
    1b18:	00200825 	move	at,at
    1b1c:	00600008 	jr	v1
    1b20:	00200825 	move	at,at
    1b24:	2484ffd0 	addiu	a0,a0,-48
    1b28:	82030001 	lb	v1,1(s0)
    1b2c:	00200825 	move	at,at
    1b30:	2465ffd0 	addiu	a1,v1,-48
    1b34:	2ca5000a 	sltiu	a1,a1,10
    1b38:	14a00040 	bnez	a1,1c3c <kvprintf+0x328>
    1b3c:	00200825 	move	at,at
    1b40:	0800071b 	j	1c6c <kvprintf+0x358>
    1b44:	00200825 	move	at,at
    1b48:	02209821 	move	s3,s1
    1b4c:	02f1182b 	sltu	v1,s7,s1
    1b50:	00408021 	move	s0,v0
    1b54:	1460041e 	bnez	v1,2bd0 <kvprintf+0x12bc>
    1b58:	00200825 	move	at,at
    1b5c:	03c0b021 	move	s6,s8
    1b60:	24130001 	li	s3,1
    1b64:	08000672 	j	19c8 <kvprintf+0xb4>
    1b68:	00200825 	move	at,at
    1b6c:	24080001 	li	t0,1
    1b70:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    1b74:	00200825 	move	at,at
    1b78:	24030001 	li	v1,1
    1b7c:	afa30054 	sw	v1,84(sp)
    1b80:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    1b84:	00200825 	move	at,at
    1b88:	12400007 	beqz	s2,1ba8 <kvprintf+0x294>
    1b8c:	00200825 	move	at,at
    1b90:	02802821 	move	a1,s4
    1b94:	0240c821 	move	t9,s2
    1b98:	0320f809 	jalr	t9
    1b9c:	00200825 	move	at,at
    1ba0:	080006ec 	j	1bb0 <kvprintf+0x29c>
    1ba4:	00200825 	move	at,at
    1ba8:	a3050000 	sb	a1,0(t8)
    1bac:	27150001 	addiu	s5,t8,1
    1bb0:	8fa2005c 	lw	v0,92(sp)
    1bb4:	00200825 	move	at,at
    1bb8:	24560001 	addiu	s6,v0,1
    1bbc:	08000672 	j	19c8 <kvprintf+0xb4>
    1bc0:	00200825 	move	at,at
    1bc4:	15800012 	bnez	t4,1c10 <kvprintf+0x2fc>
    1bc8:	00200825 	move	at,at
    1bcc:	8fa400a8 	lw	a0,168(sp)
    1bd0:	00200825 	move	at,at
    1bd4:	24830004 	addiu	v1,a0,4
    1bd8:	8c860000 	lw	a2,0(a0)
    1bdc:	00200825 	move	at,at
    1be0:	afa60048 	sw	a2,72(sp)
    1be4:	04c1ffae 	bgez	a2,1aa0 <kvprintf+0x18c>
    1be8:	00200825 	move	at,at
    1bec:	8fb90054 	lw	t9,84(sp)
    1bf0:	00200825 	move	at,at
    1bf4:	2f390001 	sltiu	t9,t9,1
    1bf8:	afb90054 	sw	t9,84(sp)
    1bfc:	00063023 	negu	a2,a2
    1c00:	afa60048 	sw	a2,72(sp)
    1c04:	afa300a8 	sw	v1,168(sp)
    1c08:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    1c0c:	00200825 	move	at,at
    1c10:	8fa300a8 	lw	v1,168(sp)
    1c14:	00200825 	move	at,at
    1c18:	8c6f0000 	lw	t7,0(v1)
    1c1c:	24630004 	addiu	v1,v1,4
    1c20:	afa300a8 	sw	v1,168(sp)
    1c24:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    1c28:	00200825 	move	at,at
    1c2c:	1180ff9f 	beqz	t4,1aac <kvprintf+0x198>
    1c30:	00200825 	move	at,at
    1c34:	080006c9 	j	1b24 <kvprintf+0x210>
    1c38:	00200825 	move	at,at
    1c3c:	26310001 	addiu	s1,s1,1
    1c40:	00042840 	sll	a1,a0,0x1
    1c44:	000420c0 	sll	a0,a0,0x3
    1c48:	00a42021 	addu	a0,a1,a0
    1c4c:	00831821 	addu	v1,a0,v1
    1c50:	2464ffd0 	addiu	a0,v1,-48
    1c54:	82230000 	lb	v1,0(s1)
    1c58:	00200825 	move	at,at
    1c5c:	2465ffd0 	addiu	a1,v1,-48
    1c60:	2ca5000a 	sltiu	a1,a1,10
    1c64:	14a0fff5 	bnez	a1,1c3c <kvprintf+0x328>
    1c68:	00200825 	move	at,at
    1c6c:	1180ff93 	beqz	t4,1abc <kvprintf+0x1a8>
    1c70:	00200825 	move	at,at
    1c74:	00807821 	move	t7,a0
    1c78:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    1c7c:	00200825 	move	at,at
    1c80:	8fa200a8 	lw	v0,168(sp)
    1c84:	00200825 	move	at,at
    1c88:	8c440000 	lw	a0,0(v0)
    1c8c:	00200825 	move	at,at
    1c90:	afa40048 	sw	a0,72(sp)
    1c94:	0080b021 	move	s6,a0
    1c98:	24460008 	addiu	a2,v0,8
    1c9c:	afa600a8 	sw	a2,168(sp)
    1ca0:	8c570004 	lw	s7,4(v0)
    1ca4:	00200825 	move	at,at
    1ca8:	82e60000 	lb	a2,0(s7)
    1cac:	afa00010 	sw	zero,16(sp)
    1cb0:	27a40020 	addiu	a0,sp,32
    1cb4:	02c02821 	move	a1,s6
    1cb8:	00003821 	move	a3,zero
    1cbc:	0c00061c 	jal	1870 <ksprintn>
    1cc0:	00200825 	move	at,at
    1cc4:	00408021 	move	s0,v0
    1cc8:	80440000 	lb	a0,0(v0)
    1ccc:	00200825 	move	at,at
    1cd0:	10800011 	beqz	a0,1d18 <kvprintf+0x404>
    1cd4:	00200825 	move	at,at
    1cd8:	2610ffff 	addiu	s0,s0,-1
    1cdc:	12400007 	beqz	s2,1cfc <kvprintf+0x3e8>
    1ce0:	00200825 	move	at,at
    1ce4:	02802821 	move	a1,s4
    1ce8:	0240c821 	move	t9,s2
    1cec:	0320f809 	jalr	t9
    1cf0:	00200825 	move	at,at
    1cf4:	08000741 	j	1d04 <kvprintf+0x3f0>
    1cf8:	00200825 	move	at,at
    1cfc:	a2a40000 	sb	a0,0(s5)
    1d00:	26b50001 	addiu	s5,s5,1
    1d04:	27de0001 	addiu	s8,s8,1
    1d08:	82040000 	lb	a0,0(s0)
    1d0c:	00200825 	move	at,at
    1d10:	1480fff1 	bnez	a0,1cd8 <kvprintf+0x3c4>
    1d14:	00200825 	move	at,at
    1d18:	12c0ff2a 	beqz	s6,19c4 <kvprintf+0xb0>
    1d1c:	00200825 	move	at,at
    1d20:	26f70001 	addiu	s7,s7,1
    1d24:	afa00044 	sw	zero,68(sp)
    1d28:	03c0b021 	move	s6,s8
    1d2c:	241e0001 	li	s8,1
    1d30:	08000794 	j	1e50 <kvprintf+0x53c>
    1d34:	00200825 	move	at,at
    1d38:	26f00001 	addiu	s0,s7,1
    1d3c:	2442ffff 	addiu	v0,v0,-1
    1d40:	005e1004 	sllv	v0,s8,v0
    1d44:	8fa30048 	lw	v1,72(sp)
    1d48:	00200825 	move	at,at
    1d4c:	00431024 	and	v0,v0,v1
    1d50:	14400009 	bnez	v0,1d78 <kvprintf+0x464>
    1d54:	00200825 	move	at,at
    1d58:	82e20001 	lb	v0,1(s7)
    1d5c:	00200825 	move	at,at
    1d60:	28420021 	slti	v0,v0,33
    1d64:	10400034 	beqz	v0,1e38 <kvprintf+0x524>
    1d68:	00200825 	move	at,at
    1d6c:	0200b821 	move	s7,s0
    1d70:	08000794 	j	1e50 <kvprintf+0x53c>
    1d74:	00200825 	move	at,at
    1d78:	8fa20044 	lw	v0,68(sp)
    1d7c:	00200825 	move	at,at
    1d80:	10400004 	beqz	v0,1d94 <kvprintf+0x480>
    1d84:	00200825 	move	at,at
    1d88:	2404002c 	li	a0,44
    1d8c:	08000766 	j	1d98 <kvprintf+0x484>
    1d90:	00200825 	move	at,at
    1d94:	2404003c 	li	a0,60
    1d98:	12400007 	beqz	s2,1db8 <kvprintf+0x4a4>
    1d9c:	00200825 	move	at,at
    1da0:	02802821 	move	a1,s4
    1da4:	0240c821 	move	t9,s2
    1da8:	0320f809 	jalr	t9
    1dac:	00200825 	move	at,at
    1db0:	08000770 	j	1dc0 <kvprintf+0x4ac>
    1db4:	00200825 	move	at,at
    1db8:	a2a40000 	sb	a0,0(s5)
    1dbc:	26b50001 	addiu	s5,s5,1
    1dc0:	26d60001 	addiu	s6,s6,1
    1dc4:	82e20001 	lb	v0,1(s7)
    1dc8:	00200825 	move	at,at
    1dcc:	00402021 	move	a0,v0
    1dd0:	28430021 	slti	v1,v0,33
    1dd4:	14600013 	bnez	v1,1e24 <kvprintf+0x510>
    1dd8:	00200825 	move	at,at
    1ddc:	12400007 	beqz	s2,1dfc <kvprintf+0x4e8>
    1de0:	00200825 	move	at,at
    1de4:	02802821 	move	a1,s4
    1de8:	0240c821 	move	t9,s2
    1dec:	0320f809 	jalr	t9
    1df0:	00200825 	move	at,at
    1df4:	08000781 	j	1e04 <kvprintf+0x4f0>
    1df8:	00200825 	move	at,at
    1dfc:	a2a20000 	sb	v0,0(s5)
    1e00:	26b50001 	addiu	s5,s5,1
    1e04:	26d60001 	addiu	s6,s6,1
    1e08:	26100001 	addiu	s0,s0,1
    1e0c:	82020000 	lb	v0,0(s0)
    1e10:	00200825 	move	at,at
    1e14:	00402021 	move	a0,v0
    1e18:	28430021 	slti	v1,v0,33
    1e1c:	1060ffef 	beqz	v1,1ddc <kvprintf+0x4c8>
    1e20:	00200825 	move	at,at
    1e24:	afbe0044 	sw	s8,68(sp)
    1e28:	0200b821 	move	s7,s0
    1e2c:	08000794 	j	1e50 <kvprintf+0x53c>
    1e30:	00200825 	move	at,at
    1e34:	02e08021 	move	s0,s7
    1e38:	26170001 	addiu	s7,s0,1
    1e3c:	82020001 	lb	v0,1(s0)
    1e40:	00200825 	move	at,at
    1e44:	28420021 	slti	v0,v0,33
    1e48:	1040fffa 	beqz	v0,1e34 <kvprintf+0x520>
    1e4c:	00200825 	move	at,at
    1e50:	82e20000 	lb	v0,0(s7)
    1e54:	00200825 	move	at,at
    1e58:	1440ffb7 	bnez	v0,1d38 <kvprintf+0x424>
    1e5c:	00200825 	move	at,at
    1e60:	02c08021 	move	s0,s6
    1e64:	8fa30044 	lw	v1,68(sp)
    1e68:	00200825 	move	at,at
    1e6c:	1060fed6 	beqz	v1,19c8 <kvprintf+0xb4>
    1e70:	00200825 	move	at,at
    1e74:	12400008 	beqz	s2,1e98 <kvprintf+0x584>
    1e78:	00200825 	move	at,at
    1e7c:	2404003e 	li	a0,62
    1e80:	02802821 	move	a1,s4
    1e84:	0240c821 	move	t9,s2
    1e88:	0320f809 	jalr	t9
    1e8c:	00200825 	move	at,at
    1e90:	080007a9 	j	1ea4 <kvprintf+0x590>
    1e94:	00200825 	move	at,at
    1e98:	2403003e 	li	v1,62
    1e9c:	a2a30000 	sb	v1,0(s5)
    1ea0:	26b50001 	addiu	s5,s5,1
    1ea4:	26160001 	addiu	s6,s0,1
    1ea8:	08000672 	j	19c8 <kvprintf+0xb4>
    1eac:	00200825 	move	at,at
    1eb0:	8fa200a8 	lw	v0,168(sp)
    1eb4:	00200825 	move	at,at
    1eb8:	24500004 	addiu	s0,v0,4
    1ebc:	8c440000 	lw	a0,0(v0)
    1ec0:	12400007 	beqz	s2,1ee0 <kvprintf+0x5cc>
    1ec4:	00200825 	move	at,at
    1ec8:	02802821 	move	a1,s4
    1ecc:	0240c821 	move	t9,s2
    1ed0:	0320f809 	jalr	t9
    1ed4:	00200825 	move	at,at
    1ed8:	080007ba 	j	1ee8 <kvprintf+0x5d4>
    1edc:	00200825 	move	at,at
    1ee0:	a3040000 	sb	a0,0(t8)
    1ee4:	27150001 	addiu	s5,t8,1
    1ee8:	8fa2005c 	lw	v0,92(sp)
    1eec:	00200825 	move	at,at
    1ef0:	24560001 	addiu	s6,v0,1
    1ef4:	afb000a8 	sw	s0,168(sp)
    1ef8:	08000672 	j	19c8 <kvprintf+0xb4>
    1efc:	00200825 	move	at,at
    1f00:	8fa200a8 	lw	v0,168(sp)
    1f04:	00200825 	move	at,at
    1f08:	8c500000 	lw	s0,0(v0)
    1f0c:	24430008 	addiu	v1,v0,8
    1f10:	afa300a8 	sw	v1,168(sp)
    1f14:	8c420004 	lw	v0,4(v0)
    1f18:	00200825 	move	at,at
    1f1c:	afa20058 	sw	v0,88(sp)
    1f20:	8fa40048 	lw	a0,72(sp)
    1f24:	00200825 	move	at,at
    1f28:	14800003 	bnez	a0,1f38 <kvprintf+0x624>
    1f2c:	00200825 	move	at,at
    1f30:	24060010 	li	a2,16
    1f34:	afa60048 	sw	a2,72(sp)
    1f38:	8fb90048 	lw	t9,72(sp)
    1f3c:	00200825 	move	at,at
    1f40:	0219c821 	addu	t9,s0,t9
    1f44:	afb90054 	sw	t9,84(sp)
    1f48:	03c0b021 	move	s6,s8
    1f4c:	8fbe0048 	lw	s8,72(sp)
    1f50:	08000816 	j	2058 <kvprintf+0x744>
    1f54:	00200825 	move	at,at
    1f58:	92020000 	lbu	v0,0(s0)
    1f5c:	00200825 	move	at,at
    1f60:	00021102 	srl	v0,v0,0x4
    1f64:	8fa3004c 	lw	v1,76(sp)
    1f68:	00200825 	move	at,at
    1f6c:	00431021 	addu	v0,v0,v1
    1f70:	80440000 	lb	a0,0(v0)
    1f74:	12400012 	beqz	s2,1fc0 <kvprintf+0x6ac>
    1f78:	00200825 	move	at,at
    1f7c:	02802821 	move	a1,s4
    1f80:	0240c821 	move	t9,s2
    1f84:	0320f809 	jalr	t9
    1f88:	00200825 	move	at,at
    1f8c:	92020000 	lbu	v0,0(s0)
    1f90:	00200825 	move	at,at
    1f94:	3042000f 	andi	v0,v0,0xf
    1f98:	8fa3004c 	lw	v1,76(sp)
    1f9c:	00200825 	move	at,at
    1fa0:	00431021 	addu	v0,v0,v1
    1fa4:	80440000 	lb	a0,0(v0)
    1fa8:	02802821 	move	a1,s4
    1fac:	0240c821 	move	t9,s2
    1fb0:	0320f809 	jalr	t9
    1fb4:	00200825 	move	at,at
    1fb8:	080007fb 	j	1fec <kvprintf+0x6d8>
    1fbc:	00200825 	move	at,at
    1fc0:	a2a40000 	sb	a0,0(s5)
    1fc4:	92020000 	lbu	v0,0(s0)
    1fc8:	00200825 	move	at,at
    1fcc:	3042000f 	andi	v0,v0,0xf
    1fd0:	8fa3004c 	lw	v1,76(sp)
    1fd4:	00200825 	move	at,at
    1fd8:	00431021 	addu	v0,v0,v1
    1fdc:	90420000 	lbu	v0,0(v0)
    1fe0:	00200825 	move	at,at
    1fe4:	a2a20001 	sb	v0,1(s5)
    1fe8:	26b50002 	addiu	s5,s5,2
    1fec:	26d60002 	addiu	s6,s6,2
    1ff0:	26100001 	addiu	s0,s0,1
    1ff4:	13c00018 	beqz	s8,2058 <kvprintf+0x744>
    1ff8:	00200825 	move	at,at
    1ffc:	8fa60058 	lw	a2,88(sp)
    2000:	00200825 	move	at,at
    2004:	80c40000 	lb	a0,0(a2)
    2008:	00200825 	move	at,at
    200c:	10800012 	beqz	a0,2058 <kvprintf+0x744>
    2010:	00200825 	move	at,at
    2014:	00c0b821 	move	s7,a2
    2018:	12400007 	beqz	s2,2038 <kvprintf+0x724>
    201c:	00200825 	move	at,at
    2020:	02802821 	move	a1,s4
    2024:	0240c821 	move	t9,s2
    2028:	0320f809 	jalr	t9
    202c:	00200825 	move	at,at
    2030:	08000810 	j	2040 <kvprintf+0x72c>
    2034:	00200825 	move	at,at
    2038:	a2a40000 	sb	a0,0(s5)
    203c:	26b50001 	addiu	s5,s5,1
    2040:	26d60001 	addiu	s6,s6,1
    2044:	26f70001 	addiu	s7,s7,1
    2048:	82e40000 	lb	a0,0(s7)
    204c:	00200825 	move	at,at
    2050:	1480fff1 	bnez	a0,2018 <kvprintf+0x704>
    2054:	00200825 	move	at,at
    2058:	27deffff 	addiu	s8,s8,-1
    205c:	8fa20054 	lw	v0,84(sp)
    2060:	00200825 	move	at,at
    2064:	1602ffbc 	bne	s0,v0,1f58 <kvprintf+0x644>
    2068:	00200825 	move	at,at
    206c:	08000672 	j	19c8 <kvprintf+0xb4>
    2070:	00200825 	move	at,at
    2074:	1120fe94 	beqz	t1,1ac8 <kvprintf+0x1b4>
    2078:	00200825 	move	at,at
    207c:	00004821 	move	t1,zero
    2080:	240d0001 	li	t5,1
    2084:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    2088:	00200825 	move	at,at
    208c:	24070001 	li	a3,1
    2090:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    2094:	00200825 	move	at,at
    2098:	1140fe8e 	beqz	t2,1ad4 <kvprintf+0x1c0>
    209c:	00200825 	move	at,at
    20a0:	240b0001 	li	t3,1
    20a4:	00005021 	move	t2,zero
    20a8:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    20ac:	00200825 	move	at,at
    20b0:	10e0000c 	beqz	a3,20e4 <kvprintf+0x7d0>
    20b4:	00200825 	move	at,at
    20b8:	8fa300a8 	lw	v1,168(sp)
    20bc:	00200825 	move	at,at
    20c0:	8c620000 	lw	v0,0(v1)
    20c4:	8fa4005c 	lw	a0,92(sp)
    20c8:	00200825 	move	at,at
    20cc:	ac440000 	sw	a0,0(v0)
    20d0:	03c0b021 	move	s6,s8
    20d4:	24630004 	addiu	v1,v1,4
    20d8:	afa300a8 	sw	v1,168(sp)
    20dc:	08000672 	j	19c8 <kvprintf+0xb4>
    20e0:	00200825 	move	at,at
    20e4:	1160000e 	beqz	t3,2120 <kvprintf+0x80c>
    20e8:	00200825 	move	at,at
    20ec:	8fa600a8 	lw	a2,168(sp)
    20f0:	00200825 	move	at,at
    20f4:	8cc20000 	lw	v0,0(a2)
    20f8:	8fb9005c 	lw	t9,92(sp)
    20fc:	00200825 	move	at,at
    2100:	ac590000 	sw	t9,0(v0)
    2104:	00191fc3 	sra	v1,t9,0x1f
    2108:	ac430004 	sw	v1,4(v0)
    210c:	03c0b021 	move	s6,s8
    2110:	24c60004 	addiu	a2,a2,4
    2114:	afa600a8 	sw	a2,168(sp)
    2118:	08000672 	j	19c8 <kvprintf+0xb4>
    211c:	00200825 	move	at,at
    2120:	1140000c 	beqz	t2,2154 <kvprintf+0x840>
    2124:	00200825 	move	at,at
    2128:	8fa300a8 	lw	v1,168(sp)
    212c:	00200825 	move	at,at
    2130:	8c620000 	lw	v0,0(v1)
    2134:	8fa4005c 	lw	a0,92(sp)
    2138:	00200825 	move	at,at
    213c:	ac440000 	sw	a0,0(v0)
    2140:	03c0b021 	move	s6,s8
    2144:	24630004 	addiu	v1,v1,4
    2148:	afa300a8 	sw	v1,168(sp)
    214c:	08000672 	j	19c8 <kvprintf+0xb4>
    2150:	00200825 	move	at,at
    2154:	11c0000c 	beqz	t6,2188 <kvprintf+0x874>
    2158:	00200825 	move	at,at
    215c:	8fa600a8 	lw	a2,168(sp)
    2160:	00200825 	move	at,at
    2164:	8cc20000 	lw	v0,0(a2)
    2168:	8fb9005c 	lw	t9,92(sp)
    216c:	00200825 	move	at,at
    2170:	ac590000 	sw	t9,0(v0)
    2174:	03c0b021 	move	s6,s8
    2178:	24c60004 	addiu	a2,a2,4
    217c:	afa600a8 	sw	a2,168(sp)
    2180:	08000672 	j	19c8 <kvprintf+0xb4>
    2184:	00200825 	move	at,at
    2188:	1120000c 	beqz	t1,21bc <kvprintf+0x8a8>
    218c:	00200825 	move	at,at
    2190:	8fa300a8 	lw	v1,168(sp)
    2194:	00200825 	move	at,at
    2198:	8c620000 	lw	v0,0(v1)
    219c:	8fa4005c 	lw	a0,92(sp)
    21a0:	00200825 	move	at,at
    21a4:	a4440000 	sh	a0,0(v0)
    21a8:	03c0b021 	move	s6,s8
    21ac:	24630004 	addiu	v1,v1,4
    21b0:	afa300a8 	sw	v1,168(sp)
    21b4:	08000672 	j	19c8 <kvprintf+0xb4>
    21b8:	00200825 	move	at,at
    21bc:	11a0000c 	beqz	t5,21f0 <kvprintf+0x8dc>
    21c0:	00200825 	move	at,at
    21c4:	8fa600a8 	lw	a2,168(sp)
    21c8:	00200825 	move	at,at
    21cc:	8cc20000 	lw	v0,0(a2)
    21d0:	8fb9005c 	lw	t9,92(sp)
    21d4:	00200825 	move	at,at
    21d8:	a0590000 	sb	t9,0(v0)
    21dc:	03c0b021 	move	s6,s8
    21e0:	24c60004 	addiu	a2,a2,4
    21e4:	afa600a8 	sw	a2,168(sp)
    21e8:	08000672 	j	19c8 <kvprintf+0xb4>
    21ec:	00200825 	move	at,at
    21f0:	8fa300a8 	lw	v1,168(sp)
    21f4:	00200825 	move	at,at
    21f8:	8c620000 	lw	v0,0(v1)
    21fc:	8fa4005c 	lw	a0,92(sp)
    2200:	00200825 	move	at,at
    2204:	ac440000 	sw	a0,0(v0)
    2208:	03c0b021 	move	s6,s8
    220c:	24630004 	addiu	v1,v1,4
    2210:	afa300a8 	sw	v1,168(sp)
    2214:	08000672 	j	19c8 <kvprintf+0xb4>
    2218:	00200825 	move	at,at
    221c:	8fa60048 	lw	a2,72(sp)
    2220:	00200825 	move	at,at
    2224:	2cc60001 	sltiu	a2,a2,1
    2228:	afa60058 	sw	a2,88(sp)
    222c:	8fb900a8 	lw	t9,168(sp)
    2230:	00200825 	move	at,at
    2234:	8f370000 	lw	s7,0(t9)
    2238:	27390004 	addiu	t9,t9,4
    223c:	afb900a8 	sw	t9,168(sp)
    2240:	00001021 	move	v0,zero
    2244:	24030010 	li	v1,16
    2248:	afa30068 	sw	v1,104(sp)
    224c:	08000b0b 	j	2c2c <kvprintf+0x1318>
    2250:	00200825 	move	at,at
    2254:	240b0001 	li	t3,1
    2258:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    225c:	00200825 	move	at,at
    2260:	15000104 	bnez	t0,2674 <kvprintf+0xd60>
    2264:	00200825 	move	at,at
    2268:	8fa400a4 	lw	a0,164(sp)
    226c:	00200825 	move	at,at
    2270:	afa40068 	sw	a0,104(sp)
    2274:	00001021 	move	v0,zero
    2278:	0800094a 	j	2528 <kvprintf+0xc14>
    227c:	00200825 	move	at,at
    2280:	8fa200a8 	lw	v0,168(sp)
    2284:	00200825 	move	at,at
    2288:	24460004 	addiu	a2,v0,4
    228c:	afa600a8 	sw	a2,168(sp)
    2290:	8c500000 	lw	s0,0(v0)
    2294:	00200825 	move	at,at
    2298:	16000003 	bnez	s0,22a8 <kvprintf+0x994>
    229c:	00200825 	move	at,at
    22a0:	3c190000 	lui	t9,0x0
    22a4:	27303c7c 	addiu	s0,t9,15484
    22a8:	1180000a 	beqz	t4,22d4 <kvprintf+0x9c0>
    22ac:	00200825 	move	at,at
    22b0:	19e00024 	blez	t7,2344 <kvprintf+0xa30>
    22b4:	00200825 	move	at,at
    22b8:	82020000 	lb	v0,0(s0)
    22bc:	00200825 	move	at,at
    22c0:	14400015 	bnez	v0,2318 <kvprintf+0xa04>
    22c4:	00200825 	move	at,at
    22c8:	0000b021 	move	s6,zero
    22cc:	080008d2 	j	2348 <kvprintf+0xa34>
    22d0:	00200825 	move	at,at
    22d4:	82020000 	lb	v0,0(s0)
    22d8:	00200825 	move	at,at
    22dc:	1040000a 	beqz	v0,2308 <kvprintf+0x9f4>
    22e0:	00200825 	move	at,at
    22e4:	00001821 	move	v1,zero
    22e8:	24630001 	addiu	v1,v1,1
    22ec:	02031021 	addu	v0,s0,v1
    22f0:	80420000 	lb	v0,0(v0)
    22f4:	00200825 	move	at,at
    22f8:	1440fffb 	bnez	v0,22e8 <kvprintf+0x9d4>
    22fc:	00200825 	move	at,at
    2300:	080008c3 	j	230c <kvprintf+0x9f8>
    2304:	00200825 	move	at,at
    2308:	00001821 	move	v1,zero
    230c:	0060b021 	move	s6,v1
    2310:	080008d2 	j	2348 <kvprintf+0xa34>
    2314:	00200825 	move	at,at
    2318:	0000b021 	move	s6,zero
    231c:	26d60001 	addiu	s6,s6,1
    2320:	12cf0009 	beq	s6,t7,2348 <kvprintf+0xa34>
    2324:	00200825 	move	at,at
    2328:	02161021 	addu	v0,s0,s6
    232c:	80420000 	lb	v0,0(v0)
    2330:	00200825 	move	at,at
    2334:	1440fff9 	bnez	v0,231c <kvprintf+0xa08>
    2338:	00200825 	move	at,at
    233c:	080008d2 	j	2348 <kvprintf+0xa34>
    2340:	00200825 	move	at,at
    2344:	0000b021 	move	s6,zero
    2348:	8fa20048 	lw	v0,72(sp)
    234c:	00200825 	move	at,at
    2350:	00561023 	subu	v0,v0,s6
    2354:	afa20048 	sw	v0,72(sp)
    2358:	8fa30054 	lw	v1,84(sp)
    235c:	00200825 	move	at,at
    2360:	14600009 	bnez	v1,2388 <kvprintf+0xa74>
    2364:	00200825 	move	at,at
    2368:	18400007 	blez	v0,2388 <kvprintf+0xa74>
    236c:	00200825 	move	at,at
    2370:	2444ffff 	addiu	a0,v0,-1
    2374:	afa40058 	sw	a0,88(sp)
    2378:	0040b821 	move	s7,v0
    237c:	8fbe0060 	lw	s8,96(sp)
    2380:	080008ea 	j	23a8 <kvprintf+0xa94>
    2384:	00200825 	move	at,at
    2388:	26c6ffff 	addiu	a2,s6,-1
    238c:	afa60058 	sw	a2,88(sp)
    2390:	02c0b821 	move	s7,s6
    2394:	16c0001c 	bnez	s6,2408 <kvprintf+0xaf4>
    2398:	00200825 	move	at,at
    239c:	03c0b021 	move	s6,s8
    23a0:	08000915 	j	2454 <kvprintf+0xb40>
    23a4:	00200825 	move	at,at
    23a8:	12400008 	beqz	s2,23cc <kvprintf+0xab8>
    23ac:	00200825 	move	at,at
    23b0:	03c02021 	move	a0,s8
    23b4:	02802821 	move	a1,s4
    23b8:	0240c821 	move	t9,s2
    23bc:	0320f809 	jalr	t9
    23c0:	00200825 	move	at,at
    23c4:	080008f5 	j	23d4 <kvprintf+0xac0>
    23c8:	00200825 	move	at,at
    23cc:	a2be0000 	sb	s8,0(s5)
    23d0:	26b50001 	addiu	s5,s5,1
    23d4:	26f7ffff 	addiu	s7,s7,-1
    23d8:	16e0fff3 	bnez	s7,23a8 <kvprintf+0xa94>
    23dc:	00200825 	move	at,at
    23e0:	2402ffff 	li	v0,-1
    23e4:	afa20048 	sw	v0,72(sp)
    23e8:	8fa3005c 	lw	v1,92(sp)
    23ec:	00200825 	move	at,at
    23f0:	247e0001 	addiu	s8,v1,1
    23f4:	8fa40058 	lw	a0,88(sp)
    23f8:	00200825 	move	at,at
    23fc:	009ef021 	addu	s8,a0,s8
    2400:	080008e2 	j	2388 <kvprintf+0xa74>
    2404:	00200825 	move	at,at
    2408:	82040000 	lb	a0,0(s0)
    240c:	26100001 	addiu	s0,s0,1
    2410:	12400007 	beqz	s2,2430 <kvprintf+0xb1c>
    2414:	00200825 	move	at,at
    2418:	02802821 	move	a1,s4
    241c:	0240c821 	move	t9,s2
    2420:	0320f809 	jalr	t9
    2424:	00200825 	move	at,at
    2428:	0800090e 	j	2438 <kvprintf+0xb24>
    242c:	00200825 	move	at,at
    2430:	a2a40000 	sb	a0,0(s5)
    2434:	26b50001 	addiu	s5,s5,1
    2438:	26f7ffff 	addiu	s7,s7,-1
    243c:	16e0fff2 	bnez	s7,2408 <kvprintf+0xaf4>
    2440:	00200825 	move	at,at
    2444:	27de0001 	addiu	s8,s8,1
    2448:	8fa20058 	lw	v0,88(sp)
    244c:	00200825 	move	at,at
    2450:	005eb021 	addu	s6,v0,s8
    2454:	8fa30054 	lw	v1,84(sp)
    2458:	00200825 	move	at,at
    245c:	1060fd5a 	beqz	v1,19c8 <kvprintf+0xb4>
    2460:	00200825 	move	at,at
    2464:	8fa40048 	lw	a0,72(sp)
    2468:	00200825 	move	at,at
    246c:	1880fd56 	blez	a0,19c8 <kvprintf+0xb4>
    2470:	00200825 	move	at,at
    2474:	2490ffff 	addiu	s0,a0,-1
    2478:	0080b821 	move	s7,a0
    247c:	8fbe0060 	lw	s8,96(sp)
    2480:	12400008 	beqz	s2,24a4 <kvprintf+0xb90>
    2484:	00200825 	move	at,at
    2488:	03c02021 	move	a0,s8
    248c:	02802821 	move	a1,s4
    2490:	0240c821 	move	t9,s2
    2494:	0320f809 	jalr	t9
    2498:	00200825 	move	at,at
    249c:	0800092b 	j	24ac <kvprintf+0xb98>
    24a0:	00200825 	move	at,at
    24a4:	a2be0000 	sb	s8,0(s5)
    24a8:	26b50001 	addiu	s5,s5,1
    24ac:	26f7ffff 	addiu	s7,s7,-1
    24b0:	16e0fff3 	bnez	s7,2480 <kvprintf+0xb6c>
    24b4:	00200825 	move	at,at
    24b8:	26d60001 	addiu	s6,s6,1
    24bc:	0216b021 	addu	s6,s0,s6
    24c0:	08000672 	j	19c8 <kvprintf+0xb4>
    24c4:	00200825 	move	at,at
    24c8:	24160001 	li	s6,1
    24cc:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    24d0:	00200825 	move	at,at
    24d4:	00001021 	move	v0,zero
    24d8:	2403000a 	li	v1,10
    24dc:	afa30068 	sw	v1,104(sp)
    24e0:	0800094a 	j	2528 <kvprintf+0xc14>
    24e4:	00200825 	move	at,at
    24e8:	24020001 	li	v0,1
    24ec:	24040010 	li	a0,16
    24f0:	afa40068 	sw	a0,104(sp)
    24f4:	0800094a 	j	2528 <kvprintf+0xc14>
    24f8:	00200825 	move	at,at
    24fc:	240e0001 	li	t6,1
    2500:	080006b6 	j	1ad8 <kvprintf+0x1c4>
    2504:	00200825 	move	at,at
    2508:	00001021 	move	v0,zero
    250c:	24060008 	li	a2,8
    2510:	afa60068 	sw	a2,104(sp)
    2514:	0800094a 	j	2528 <kvprintf+0xc14>
    2518:	00200825 	move	at,at
    251c:	00001021 	move	v0,zero
    2520:	24190010 	li	t9,16
    2524:	afb90068 	sw	t9,104(sp)
    2528:	10e00008 	beqz	a3,254c <kvprintf+0xc38>
    252c:	00200825 	move	at,at
    2530:	8fa300a8 	lw	v1,168(sp)
    2534:	00200825 	move	at,at
    2538:	8c770000 	lw	s7,0(v1)
    253c:	24630004 	addiu	v1,v1,4
    2540:	afa300a8 	sw	v1,168(sp)
    2544:	08000b0b 	j	2c2c <kvprintf+0x1318>
    2548:	00200825 	move	at,at
    254c:	1160000b 	beqz	t3,257c <kvprintf+0xc68>
    2550:	00200825 	move	at,at
    2554:	8fa600a8 	lw	a2,168(sp)
    2558:	00200825 	move	at,at
    255c:	24c40007 	addiu	a0,a2,7
    2560:	2403fff8 	li	v1,-8
    2564:	00831824 	and	v1,a0,v1
    2568:	24790008 	addiu	t9,v1,8
    256c:	afb900a8 	sw	t9,168(sp)
    2570:	8c770000 	lw	s7,0(v1)
    2574:	08000b0b 	j	2c2c <kvprintf+0x1318>
    2578:	00200825 	move	at,at
    257c:	12c00008 	beqz	s6,25a0 <kvprintf+0xc8c>
    2580:	00200825 	move	at,at
    2584:	8fa300a8 	lw	v1,168(sp)
    2588:	00200825 	move	at,at
    258c:	8c770000 	lw	s7,0(v1)
    2590:	24630004 	addiu	v1,v1,4
    2594:	afa300a8 	sw	v1,168(sp)
    2598:	08000b0b 	j	2c2c <kvprintf+0x1318>
    259c:	00200825 	move	at,at
    25a0:	11400008 	beqz	t2,25c4 <kvprintf+0xcb0>
    25a4:	00200825 	move	at,at
    25a8:	8fa400a8 	lw	a0,168(sp)
    25ac:	00200825 	move	at,at
    25b0:	8c970000 	lw	s7,0(a0)
    25b4:	24840004 	addiu	a0,a0,4
    25b8:	afa400a8 	sw	a0,168(sp)
    25bc:	08000b0b 	j	2c2c <kvprintf+0x1318>
    25c0:	00200825 	move	at,at
    25c4:	11c00008 	beqz	t6,25e8 <kvprintf+0xcd4>
    25c8:	00200825 	move	at,at
    25cc:	8fa600a8 	lw	a2,168(sp)
    25d0:	00200825 	move	at,at
    25d4:	8cd70000 	lw	s7,0(a2)
    25d8:	24c60004 	addiu	a2,a2,4
    25dc:	afa600a8 	sw	a2,168(sp)
    25e0:	08000b0b 	j	2c2c <kvprintf+0x1318>
    25e4:	00200825 	move	at,at
    25e8:	11200008 	beqz	t1,260c <kvprintf+0xcf8>
    25ec:	00200825 	move	at,at
    25f0:	8fb900a8 	lw	t9,168(sp)
    25f4:	00200825 	move	at,at
    25f8:	97370000 	lhu	s7,0(t9)
    25fc:	27390004 	addiu	t9,t9,4
    2600:	afb900a8 	sw	t9,168(sp)
    2604:	08000b0b 	j	2c2c <kvprintf+0x1318>
    2608:	00200825 	move	at,at
    260c:	11a00008 	beqz	t5,2630 <kvprintf+0xd1c>
    2610:	00200825 	move	at,at
    2614:	8fa300a8 	lw	v1,168(sp)
    2618:	00200825 	move	at,at
    261c:	90770000 	lbu	s7,0(v1)
    2620:	24630004 	addiu	v1,v1,4
    2624:	afa300a8 	sw	v1,168(sp)
    2628:	08000b0b 	j	2c2c <kvprintf+0x1318>
    262c:	00200825 	move	at,at
    2630:	8fa400a8 	lw	a0,168(sp)
    2634:	00200825 	move	at,at
    2638:	8c970000 	lw	s7,0(a0)
    263c:	24840004 	addiu	a0,a0,4
    2640:	afa400a8 	sw	a0,168(sp)
    2644:	08000b0b 	j	2c2c <kvprintf+0x1318>
    2648:	00200825 	move	at,at
    264c:	24080001 	li	t0,1
    2650:	2406000a 	li	a2,10
    2654:	afa60068 	sw	a2,104(sp)
    2658:	080009a0 	j	2680 <kvprintf+0xd6c>
    265c:	00200825 	move	at,at
    2660:	24080001 	li	t0,1
    2664:	24190010 	li	t9,16
    2668:	afb90068 	sw	t9,104(sp)
    266c:	080009a0 	j	2680 <kvprintf+0xd6c>
    2670:	00200825 	move	at,at
    2674:	8fa200a4 	lw	v0,164(sp)
    2678:	00200825 	move	at,at
    267c:	afa20068 	sw	v0,104(sp)
    2680:	10e00008 	beqz	a3,26a4 <kvprintf+0xd90>
    2684:	00200825 	move	at,at
    2688:	8fa300a8 	lw	v1,168(sp)
    268c:	00200825 	move	at,at
    2690:	8c770000 	lw	s7,0(v1)
    2694:	24630004 	addiu	v1,v1,4
    2698:	afa300a8 	sw	v1,168(sp)
    269c:	080009e7 	j	279c <kvprintf+0xe88>
    26a0:	00200825 	move	at,at
    26a4:	1160000b 	beqz	t3,26d4 <kvprintf+0xdc0>
    26a8:	00200825 	move	at,at
    26ac:	8fa400a8 	lw	a0,168(sp)
    26b0:	00200825 	move	at,at
    26b4:	24830007 	addiu	v1,a0,7
    26b8:	2402fff8 	li	v0,-8
    26bc:	00621024 	and	v0,v1,v0
    26c0:	24460008 	addiu	a2,v0,8
    26c4:	afa600a8 	sw	a2,168(sp)
    26c8:	8c570000 	lw	s7,0(v0)
    26cc:	080009e7 	j	279c <kvprintf+0xe88>
    26d0:	00200825 	move	at,at
    26d4:	12c00008 	beqz	s6,26f8 <kvprintf+0xde4>
    26d8:	00200825 	move	at,at
    26dc:	8fb900a8 	lw	t9,168(sp)
    26e0:	00200825 	move	at,at
    26e4:	8f370000 	lw	s7,0(t9)
    26e8:	27390004 	addiu	t9,t9,4
    26ec:	afb900a8 	sw	t9,168(sp)
    26f0:	080009e7 	j	279c <kvprintf+0xe88>
    26f4:	00200825 	move	at,at
    26f8:	11400008 	beqz	t2,271c <kvprintf+0xe08>
    26fc:	00200825 	move	at,at
    2700:	8fa200a8 	lw	v0,168(sp)
    2704:	00200825 	move	at,at
    2708:	8c570000 	lw	s7,0(v0)
    270c:	24420004 	addiu	v0,v0,4
    2710:	afa200a8 	sw	v0,168(sp)
    2714:	080009e7 	j	279c <kvprintf+0xe88>
    2718:	00200825 	move	at,at
    271c:	11c00008 	beqz	t6,2740 <kvprintf+0xe2c>
    2720:	00200825 	move	at,at
    2724:	8fa300a8 	lw	v1,168(sp)
    2728:	00200825 	move	at,at
    272c:	8c770000 	lw	s7,0(v1)
    2730:	24630004 	addiu	v1,v1,4
    2734:	afa300a8 	sw	v1,168(sp)
    2738:	080009e7 	j	279c <kvprintf+0xe88>
    273c:	00200825 	move	at,at
    2740:	11200008 	beqz	t1,2764 <kvprintf+0xe50>
    2744:	00200825 	move	at,at
    2748:	8fa400a8 	lw	a0,168(sp)
    274c:	00200825 	move	at,at
    2750:	84970000 	lh	s7,0(a0)
    2754:	24840004 	addiu	a0,a0,4
    2758:	afa400a8 	sw	a0,168(sp)
    275c:	080009e7 	j	279c <kvprintf+0xe88>
    2760:	00200825 	move	at,at
    2764:	11a00008 	beqz	t5,2788 <kvprintf+0xe74>
    2768:	00200825 	move	at,at
    276c:	8fa600a8 	lw	a2,168(sp)
    2770:	00200825 	move	at,at
    2774:	80d70000 	lb	s7,0(a2)
    2778:	24c60004 	addiu	a2,a2,4
    277c:	afa600a8 	sw	a2,168(sp)
    2780:	080009e7 	j	279c <kvprintf+0xe88>
    2784:	00200825 	move	at,at
    2788:	8fb900a8 	lw	t9,168(sp)
    278c:	00200825 	move	at,at
    2790:	8f370000 	lw	s7,0(t9)
    2794:	27390004 	addiu	t9,t9,4
    2798:	afb900a8 	sw	t9,168(sp)
    279c:	1100000a 	beqz	t0,27c8 <kvprintf+0xeb4>
    27a0:	00200825 	move	at,at
    27a4:	06e1000d 	bgez	s7,27dc <kvprintf+0xec8>
    27a8:	00200825 	move	at,at
    27ac:	0017b823 	negu	s7,s7
    27b0:	8fb60048 	lw	s6,72(sp)
    27b4:	00001021 	move	v0,zero
    27b8:	24030001 	li	v1,1
    27bc:	afa30064 	sw	v1,100(sp)
    27c0:	080009fa 	j	27e8 <kvprintf+0xed4>
    27c4:	00200825 	move	at,at
    27c8:	8fb60048 	lw	s6,72(sp)
    27cc:	00001021 	move	v0,zero
    27d0:	afa00064 	sw	zero,100(sp)
    27d4:	080009fa 	j	27e8 <kvprintf+0xed4>
    27d8:	00200825 	move	at,at
    27dc:	8fb60048 	lw	s6,72(sp)
    27e0:	00001021 	move	v0,zero
    27e4:	afa00064 	sw	zero,100(sp)
    27e8:	afa20010 	sw	v0,16(sp)
    27ec:	27a40020 	addiu	a0,sp,32
    27f0:	02e02821 	move	a1,s7
    27f4:	8fa60068 	lw	a2,104(sp)
    27f8:	27a70044 	addiu	a3,sp,68
    27fc:	0c00061c 	jal	1870 <ksprintn>
    2800:	00200825 	move	at,at
    2804:	00408021 	move	s0,v0
    2808:	8fa40058 	lw	a0,88(sp)
    280c:	00200825 	move	at,at
    2810:	10800017 	beqz	a0,2870 <kvprintf+0xf5c>
    2814:	00200825 	move	at,at
    2818:	12e00015 	beqz	s7,2870 <kvprintf+0xf5c>
    281c:	00200825 	move	at,at
    2820:	24020008 	li	v0,8
    2824:	8fa60068 	lw	a2,104(sp)
    2828:	00200825 	move	at,at
    282c:	14c20007 	bne	a2,v0,284c <kvprintf+0xf38>
    2830:	00200825 	move	at,at
    2834:	8fa20044 	lw	v0,68(sp)
    2838:	00200825 	move	at,at
    283c:	24420001 	addiu	v0,v0,1
    2840:	afa20044 	sw	v0,68(sp)
    2844:	08000a1c 	j	2870 <kvprintf+0xf5c>
    2848:	00200825 	move	at,at
    284c:	24020010 	li	v0,16
    2850:	8fb90068 	lw	t9,104(sp)
    2854:	00200825 	move	at,at
    2858:	17220005 	bne	t9,v0,2870 <kvprintf+0xf5c>
    285c:	00200825 	move	at,at
    2860:	8fa20044 	lw	v0,68(sp)
    2864:	00200825 	move	at,at
    2868:	24420002 	addiu	v0,v0,2
    286c:	afa20044 	sw	v0,68(sp)
    2870:	8fa20064 	lw	v0,100(sp)
    2874:	00200825 	move	at,at
    2878:	10400005 	beqz	v0,2890 <kvprintf+0xf7c>
    287c:	00200825 	move	at,at
    2880:	8fa20044 	lw	v0,68(sp)
    2884:	00200825 	move	at,at
    2888:	24420001 	addiu	v0,v0,1
    288c:	afa20044 	sw	v0,68(sp)
    2890:	8fa30054 	lw	v1,84(sp)
    2894:	00200825 	move	at,at
    2898:	14600027 	bnez	v1,2938 <kvprintf+0x1024>
    289c:	00200825 	move	at,at
    28a0:	24020030 	li	v0,48
    28a4:	8fa40060 	lw	a0,96(sp)
    28a8:	00200825 	move	at,at
    28ac:	10820022 	beq	a0,v0,2938 <kvprintf+0x1024>
    28b0:	00200825 	move	at,at
    28b4:	12c00020 	beqz	s6,2938 <kvprintf+0x1024>
    28b8:	00200825 	move	at,at
    28bc:	8fa20044 	lw	v0,68(sp)
    28c0:	00200825 	move	at,at
    28c4:	02c21023 	subu	v0,s6,v0
    28c8:	afa20048 	sw	v0,72(sp)
    28cc:	1840001a 	blez	v0,2938 <kvprintf+0x1024>
    28d0:	00200825 	move	at,at
    28d4:	245effff 	addiu	s8,v0,-1
    28d8:	0040b021 	move	s6,v0
    28dc:	afb70048 	sw	s7,72(sp)
    28e0:	0080b821 	move	s7,a0
    28e4:	12400008 	beqz	s2,2908 <kvprintf+0xff4>
    28e8:	00200825 	move	at,at
    28ec:	02e02021 	move	a0,s7
    28f0:	02802821 	move	a1,s4
    28f4:	0240c821 	move	t9,s2
    28f8:	0320f809 	jalr	t9
    28fc:	00200825 	move	at,at
    2900:	08000a44 	j	2910 <kvprintf+0xffc>
    2904:	00200825 	move	at,at
    2908:	a2b70000 	sb	s7,0(s5)
    290c:	26b50001 	addiu	s5,s5,1
    2910:	26d6ffff 	addiu	s6,s6,-1
    2914:	16c0fff3 	bnez	s6,28e4 <kvprintf+0xfd0>
    2918:	00200825 	move	at,at
    291c:	8fb70048 	lw	s7,72(sp)
    2920:	2402ffff 	li	v0,-1
    2924:	afa20048 	sw	v0,72(sp)
    2928:	8fa3005c 	lw	v1,92(sp)
    292c:	00200825 	move	at,at
    2930:	24620001 	addiu	v0,v1,1
    2934:	03c2f021 	addu	s8,s8,v0
    2938:	8fa40064 	lw	a0,100(sp)
    293c:	00200825 	move	at,at
    2940:	10800010 	beqz	a0,2984 <kvprintf+0x1070>
    2944:	00200825 	move	at,at
    2948:	12400008 	beqz	s2,296c <kvprintf+0x1058>
    294c:	00200825 	move	at,at
    2950:	2404002d 	li	a0,45
    2954:	02802821 	move	a1,s4
    2958:	0240c821 	move	t9,s2
    295c:	0320f809 	jalr	t9
    2960:	00200825 	move	at,at
    2964:	08000a5e 	j	2978 <kvprintf+0x1064>
    2968:	00200825 	move	at,at
    296c:	2402002d 	li	v0,45
    2970:	a2a20000 	sb	v0,0(s5)
    2974:	26b50001 	addiu	s5,s5,1
    2978:	27d60001 	addiu	s6,s8,1
    297c:	08000a62 	j	2988 <kvprintf+0x1074>
    2980:	00200825 	move	at,at
    2984:	03c0b021 	move	s6,s8
    2988:	8fa20058 	lw	v0,88(sp)
    298c:	00200825 	move	at,at
    2990:	10400030 	beqz	v0,2a54 <kvprintf+0x1140>
    2994:	00200825 	move	at,at
    2998:	12e0002e 	beqz	s7,2a54 <kvprintf+0x1140>
    299c:	00200825 	move	at,at
    29a0:	24020008 	li	v0,8
    29a4:	8fa30068 	lw	v1,104(sp)
    29a8:	00200825 	move	at,at
    29ac:	14620010 	bne	v1,v0,29f0 <kvprintf+0x10dc>
    29b0:	00200825 	move	at,at
    29b4:	12400008 	beqz	s2,29d8 <kvprintf+0x10c4>
    29b8:	00200825 	move	at,at
    29bc:	24040030 	li	a0,48
    29c0:	02802821 	move	a1,s4
    29c4:	0240c821 	move	t9,s2
    29c8:	0320f809 	jalr	t9
    29cc:	00200825 	move	at,at
    29d0:	08000a79 	j	29e4 <kvprintf+0x10d0>
    29d4:	00200825 	move	at,at
    29d8:	24020030 	li	v0,48
    29dc:	a2a20000 	sb	v0,0(s5)
    29e0:	26b50001 	addiu	s5,s5,1
    29e4:	26d60001 	addiu	s6,s6,1
    29e8:	08000a95 	j	2a54 <kvprintf+0x1140>
    29ec:	00200825 	move	at,at
    29f0:	24020010 	li	v0,16
    29f4:	8fa30068 	lw	v1,104(sp)
    29f8:	00200825 	move	at,at
    29fc:	14620015 	bne	v1,v0,2a54 <kvprintf+0x1140>
    2a00:	00200825 	move	at,at
    2a04:	1240000d 	beqz	s2,2a3c <kvprintf+0x1128>
    2a08:	00200825 	move	at,at
    2a0c:	24040030 	li	a0,48
    2a10:	02802821 	move	a1,s4
    2a14:	0240c821 	move	t9,s2
    2a18:	0320f809 	jalr	t9
    2a1c:	00200825 	move	at,at
    2a20:	24040078 	li	a0,120
    2a24:	02802821 	move	a1,s4
    2a28:	0240c821 	move	t9,s2
    2a2c:	0320f809 	jalr	t9
    2a30:	00200825 	move	at,at
    2a34:	08000a94 	j	2a50 <kvprintf+0x113c>
    2a38:	00200825 	move	at,at
    2a3c:	24020030 	li	v0,48
    2a40:	a2a20000 	sb	v0,0(s5)
    2a44:	24020078 	li	v0,120
    2a48:	a2a20001 	sb	v0,1(s5)
    2a4c:	26b50002 	addiu	s5,s5,2
    2a50:	26d60002 	addiu	s6,s6,2
    2a54:	8fa20054 	lw	v0,84(sp)
    2a58:	00200825 	move	at,at
    2a5c:	14400005 	bnez	v0,2a74 <kvprintf+0x1160>
    2a60:	00200825 	move	at,at
    2a64:	8fa30048 	lw	v1,72(sp)
    2a68:	00200825 	move	at,at
    2a6c:	14600007 	bnez	v1,2a8c <kvprintf+0x1178>
    2a70:	00200825 	move	at,at
    2a74:	82040000 	lb	a0,0(s0)
    2a78:	00200825 	move	at,at
    2a7c:	14800023 	bnez	a0,2b0c <kvprintf+0x11f8>
    2a80:	00200825 	move	at,at
    2a84:	08000ad3 	j	2b4c <kvprintf+0x1238>
    2a88:	00200825 	move	at,at
    2a8c:	8fa20044 	lw	v0,68(sp)
    2a90:	8fa40048 	lw	a0,72(sp)
    2a94:	00200825 	move	at,at
    2a98:	00822023 	subu	a0,a0,v0
    2a9c:	afa40048 	sw	a0,72(sp)
    2aa0:	1880fff4 	blez	a0,2a74 <kvprintf+0x1160>
    2aa4:	00200825 	move	at,at
    2aa8:	2497ffff 	addiu	s7,a0,-1
    2aac:	0080f021 	move	s8,a0
    2ab0:	afb30048 	sw	s3,72(sp)
    2ab4:	8fb30060 	lw	s3,96(sp)
    2ab8:	12400008 	beqz	s2,2adc <kvprintf+0x11c8>
    2abc:	00200825 	move	at,at
    2ac0:	02602021 	move	a0,s3
    2ac4:	02802821 	move	a1,s4
    2ac8:	0240c821 	move	t9,s2
    2acc:	0320f809 	jalr	t9
    2ad0:	00200825 	move	at,at
    2ad4:	08000ab9 	j	2ae4 <kvprintf+0x11d0>
    2ad8:	00200825 	move	at,at
    2adc:	a2b30000 	sb	s3,0(s5)
    2ae0:	26b50001 	addiu	s5,s5,1
    2ae4:	27deffff 	addiu	s8,s8,-1
    2ae8:	17c0fff3 	bnez	s8,2ab8 <kvprintf+0x11a4>
    2aec:	00200825 	move	at,at
    2af0:	8fb30048 	lw	s3,72(sp)
    2af4:	2402ffff 	li	v0,-1
    2af8:	afa20048 	sw	v0,72(sp)
    2afc:	26d60001 	addiu	s6,s6,1
    2b00:	02f6b021 	addu	s6,s7,s6
    2b04:	08000a9d 	j	2a74 <kvprintf+0x1160>
    2b08:	00200825 	move	at,at
    2b0c:	2610ffff 	addiu	s0,s0,-1
    2b10:	12400007 	beqz	s2,2b30 <kvprintf+0x121c>
    2b14:	00200825 	move	at,at
    2b18:	02802821 	move	a1,s4
    2b1c:	0240c821 	move	t9,s2
    2b20:	0320f809 	jalr	t9
    2b24:	00200825 	move	at,at
    2b28:	08000ace 	j	2b38 <kvprintf+0x1224>
    2b2c:	00200825 	move	at,at
    2b30:	a2a40000 	sb	a0,0(s5)
    2b34:	26b50001 	addiu	s5,s5,1
    2b38:	26d60001 	addiu	s6,s6,1
    2b3c:	82040000 	lb	a0,0(s0)
    2b40:	00200825 	move	at,at
    2b44:	1480fff1 	bnez	a0,2b0c <kvprintf+0x11f8>
    2b48:	00200825 	move	at,at
    2b4c:	8fa20054 	lw	v0,84(sp)
    2b50:	00200825 	move	at,at
    2b54:	1040fb9c 	beqz	v0,19c8 <kvprintf+0xb4>
    2b58:	00200825 	move	at,at
    2b5c:	8fa30048 	lw	v1,72(sp)
    2b60:	00200825 	move	at,at
    2b64:	1060fb98 	beqz	v1,19c8 <kvprintf+0xb4>
    2b68:	00200825 	move	at,at
    2b6c:	8fb00044 	lw	s0,68(sp)
    2b70:	00200825 	move	at,at
    2b74:	00708023 	subu	s0,v1,s0
    2b78:	1a00fb93 	blez	s0,19c8 <kvprintf+0xb4>
    2b7c:	00200825 	move	at,at
    2b80:	2617ffff 	addiu	s7,s0,-1
    2b84:	8fbe0060 	lw	s8,96(sp)
    2b88:	12400008 	beqz	s2,2bac <kvprintf+0x1298>
    2b8c:	00200825 	move	at,at
    2b90:	03c02021 	move	a0,s8
    2b94:	02802821 	move	a1,s4
    2b98:	0240c821 	move	t9,s2
    2b9c:	0320f809 	jalr	t9
    2ba0:	00200825 	move	at,at
    2ba4:	08000aed 	j	2bb4 <kvprintf+0x12a0>
    2ba8:	00200825 	move	at,at
    2bac:	a2be0000 	sb	s8,0(s5)
    2bb0:	26b50001 	addiu	s5,s5,1
    2bb4:	2610ffff 	addiu	s0,s0,-1
    2bb8:	1600fff3 	bnez	s0,2b88 <kvprintf+0x1274>
    2bbc:	00200825 	move	at,at
    2bc0:	26d60001 	addiu	s6,s6,1
    2bc4:	02f6b021 	addu	s6,s7,s6
    2bc8:	08000672 	j	19c8 <kvprintf+0xb4>
    2bcc:	00200825 	move	at,at
    2bd0:	82040000 	lb	a0,0(s0)
    2bd4:	26100001 	addiu	s0,s0,1
    2bd8:	12400007 	beqz	s2,2bf8 <kvprintf+0x12e4>
    2bdc:	00200825 	move	at,at
    2be0:	02802821 	move	a1,s4
    2be4:	0240c821 	move	t9,s2
    2be8:	0320f809 	jalr	t9
    2bec:	00200825 	move	at,at
    2bf0:	08000b00 	j	2c00 <kvprintf+0x12ec>
    2bf4:	00200825 	move	at,at
    2bf8:	a2a40000 	sb	a0,0(s5)
    2bfc:	26b50001 	addiu	s5,s5,1
    2c00:	1613fff3 	bne	s0,s3,2bd0 <kvprintf+0x12bc>
    2c04:	00200825 	move	at,at
    2c08:	8fa2005c 	lw	v0,92(sp)
    2c0c:	00200825 	move	at,at
    2c10:	24560001 	addiu	s6,v0,1
    2c14:	26e20001 	addiu	v0,s7,1
    2c18:	02629823 	subu	s3,s3,v0
    2c1c:	02d3b021 	addu	s6,s6,s3
    2c20:	24130001 	li	s3,1
    2c24:	08000672 	j	19c8 <kvprintf+0xb4>
    2c28:	00200825 	move	at,at
    2c2c:	8fb60048 	lw	s6,72(sp)
    2c30:	afa00064 	sw	zero,100(sp)
    2c34:	080009fa 	j	27e8 <kvprintf+0xed4>
    2c38:	00200825 	move	at,at
    2c3c:	03c01021 	move	v0,s8
    2c40:	8fbf0094 	lw	ra,148(sp)
    2c44:	8fbe0090 	lw	s8,144(sp)
    2c48:	8fb7008c 	lw	s7,140(sp)
    2c4c:	8fb60088 	lw	s6,136(sp)
    2c50:	8fb50084 	lw	s5,132(sp)
    2c54:	8fb40080 	lw	s4,128(sp)
    2c58:	8fb3007c 	lw	s3,124(sp)
    2c5c:	8fb20078 	lw	s2,120(sp)
    2c60:	8fb10074 	lw	s1,116(sp)
    2c64:	8fb00070 	lw	s0,112(sp)
    2c68:	27bd0098 	addiu	sp,sp,152
    2c6c:	03e00008 	jr	ra
    2c70:	00200825 	move	at,at

00002c74 <my_sprintf>:
    2c74:	27bdffc8 	addiu	sp,sp,-56
    2c78:	afbf0034 	sw	ra,52(sp)
    2c7c:	afb00030 	sw	s0,48(sp)
    2c80:	00808021 	move	s0,a0
    2c84:	afa60040 	sw	a2,64(sp)
    2c88:	afa70044 	sw	a3,68(sp)
    2c8c:	afa40020 	sw	a0,32(sp)
    2c90:	afa00024 	sw	zero,36(sp)
    2c94:	27a20040 	addiu	v0,sp,64
    2c98:	afa20028 	sw	v0,40(sp)
    2c9c:	afa20010 	sw	v0,16(sp)
    2ca0:	00a02021 	move	a0,a1
    2ca4:	3c050000 	lui	a1,0x0
    2ca8:	24a518f0 	addiu	a1,a1,6384
    2cac:	27a60020 	addiu	a2,sp,32
    2cb0:	2407000a 	li	a3,10
    2cb4:	0c000645 	jal	1914 <kvprintf>
    2cb8:	00200825 	move	at,at
    2cbc:	8fa20024 	lw	v0,36(sp)
    2cc0:	00200825 	move	at,at
    2cc4:	02028021 	addu	s0,s0,v0
    2cc8:	a2000000 	sb	zero,0(s0)
    2ccc:	8fbf0034 	lw	ra,52(sp)
    2cd0:	8fb00030 	lw	s0,48(sp)
    2cd4:	27bd0038 	addiu	sp,sp,56
    2cd8:	03e00008 	jr	ra
    2cdc:	00200825 	move	at,at

00002ce0 <my_vsprintf>:
    2ce0:	27bdffd0 	addiu	sp,sp,-48
    2ce4:	afbf002c 	sw	ra,44(sp)
    2ce8:	afb00028 	sw	s0,40(sp)
    2cec:	00808021 	move	s0,a0
    2cf0:	afa40020 	sw	a0,32(sp)
    2cf4:	afa00024 	sw	zero,36(sp)
    2cf8:	afa60010 	sw	a2,16(sp)
    2cfc:	00a02021 	move	a0,a1
    2d00:	3c050000 	lui	a1,0x0
    2d04:	24a518f0 	addiu	a1,a1,6384
    2d08:	27a60020 	addiu	a2,sp,32
    2d0c:	2407000a 	li	a3,10
    2d10:	0c000645 	jal	1914 <kvprintf>
    2d14:	00200825 	move	at,at
    2d18:	8fa20024 	lw	v0,36(sp)
    2d1c:	00200825 	move	at,at
    2d20:	02028021 	addu	s0,s0,v0
    2d24:	a2000000 	sb	zero,0(s0)
    2d28:	8fbf002c 	lw	ra,44(sp)
    2d2c:	8fb00028 	lw	s0,40(sp)
    2d30:	27bd0030 	addiu	sp,sp,48
    2d34:	03e00008 	jr	ra
    2d38:	00200825 	move	at,at
    2d3c:	00200825 	move	at,at

00002d40 <strchar>:
    2d40:	00801021 	move	v0,a0
    2d44:	80830000 	lb	v1,0(a0)
    2d48:	00200825 	move	at,at
    2d4c:	1060000c 	beqz	v1,2d80 <strchar+0x40>
    2d50:	00200825 	move	at,at
    2d54:	14650005 	bne	v1,a1,2d6c <strchar+0x2c>
    2d58:	00200825 	move	at,at
    2d5c:	03e00008 	jr	ra
    2d60:	00200825 	move	at,at
    2d64:	10650009 	beq	v1,a1,2d8c <strchar+0x4c>
    2d68:	00200825 	move	at,at
    2d6c:	24420001 	addiu	v0,v0,1
    2d70:	80430000 	lb	v1,0(v0)
    2d74:	00200825 	move	at,at
    2d78:	1460fffa 	bnez	v1,2d64 <strchar+0x24>
    2d7c:	00200825 	move	at,at
    2d80:	10650002 	beq	v1,a1,2d8c <strchar+0x4c>
    2d84:	00200825 	move	at,at
    2d88:	00001021 	move	v0,zero
    2d8c:	03e00008 	jr	ra
    2d90:	00200825 	move	at,at

00002d94 <strcomp>:
    2d94:	90a30000 	lbu	v1,0(a1)
    2d98:	90820000 	lbu	v0,0(a0)
    2d9c:	00200825 	move	at,at
    2da0:	00431023 	subu	v0,v0,v1
    2da4:	1440000f 	bnez	v0,2de4 <strcomp+0x50>
    2da8:	00200825 	move	at,at
    2dac:	10600017 	beqz	v1,2e0c <strcomp+0x78>
    2db0:	00200825 	move	at,at
    2db4:	24840001 	addiu	a0,a0,1
    2db8:	24a50001 	addiu	a1,a1,1
    2dbc:	90a30000 	lbu	v1,0(a1)
    2dc0:	90820000 	lbu	v0,0(a0)
    2dc4:	00200825 	move	at,at
    2dc8:	00431023 	subu	v0,v0,v1
    2dcc:	14400005 	bnez	v0,2de4 <strcomp+0x50>
    2dd0:	00200825 	move	at,at
    2dd4:	1460fff7 	bnez	v1,2db4 <strcomp+0x20>
    2dd8:	00200825 	move	at,at
    2ddc:	03e00008 	jr	ra
    2de0:	00200825 	move	at,at
    2de4:	04400005 	bltz	v0,2dfc <strcomp+0x68>
    2de8:	00200825 	move	at,at
    2dec:	1c400006 	bgtz	v0,2e08 <strcomp+0x74>
    2df0:	00200825 	move	at,at
    2df4:	03e00008 	jr	ra
    2df8:	00200825 	move	at,at
    2dfc:	2402ffff 	li	v0,-1
    2e00:	03e00008 	jr	ra
    2e04:	00200825 	move	at,at
    2e08:	24020001 	li	v0,1
    2e0c:	03e00008 	jr	ra
    2e10:	00200825 	move	at,at

00002e14 <strcopy>:
    2e14:	00801021 	move	v0,a0
    2e18:	00801821 	move	v1,a0
    2e1c:	80a60000 	lb	a2,0(a1)
    2e20:	00200825 	move	at,at
    2e24:	a0660000 	sb	a2,0(v1)
    2e28:	24630001 	addiu	v1,v1,1
    2e2c:	24a50001 	addiu	a1,a1,1
    2e30:	14c0fffa 	bnez	a2,2e1c <strcopy+0x8>
    2e34:	00200825 	move	at,at
    2e38:	03e00008 	jr	ra
    2e3c:	00200825 	move	at,at

00002e40 <term_init_half>:
    2e40:	27bdffe0 	addiu	sp,sp,-32
    2e44:	afbf001c 	sw	ra,28(sp)
    2e48:	afb00018 	sw	s0,24(sp)
    2e4c:	24900040 	addiu	s0,a0,64
    2e50:	ac800000 	sw	zero,0(a0)
    2e54:	ac800040 	sw	zero,64(a0)
    2e58:	0c000040 	jal	100 <clean_dcache>
    2e5c:	00200825 	move	at,at
    2e60:	02002021 	move	a0,s0
    2e64:	0c000040 	jal	100 <clean_dcache>
    2e68:	00200825 	move	at,at
    2e6c:	8fbf001c 	lw	ra,28(sp)
    2e70:	8fb00018 	lw	s0,24(sp)
    2e74:	27bd0020 	addiu	sp,sp,32
    2e78:	03e00008 	jr	ra
    2e7c:	00200825 	move	at,at

00002e80 <term_init>:
    2e80:	27bdffe0 	addiu	sp,sp,-32
    2e84:	afbf001c 	sw	ra,28(sp)
    2e88:	afb00018 	sw	s0,24(sp)
    2e8c:	00808021 	move	s0,a0
    2e90:	24840040 	addiu	a0,a0,64
    2e94:	00042380 	sll	a0,a0,0xe
    2e98:	0c000b90 	jal	2e40 <term_init_half>
    2e9c:	00200825 	move	at,at
    2ea0:	00102380 	sll	a0,s0,0xe
    2ea4:	3c020010 	lui	v0,0x10
    2ea8:	24422000 	addiu	v0,v0,8192
    2eac:	00822021 	addu	a0,a0,v0
    2eb0:	0c000b90 	jal	2e40 <term_init_half>
    2eb4:	00200825 	move	at,at
    2eb8:	8fbf001c 	lw	ra,28(sp)
    2ebc:	8fb00018 	lw	s0,24(sp)
    2ec0:	27bd0020 	addiu	sp,sp,32
    2ec4:	03e00008 	jr	ra
    2ec8:	00200825 	move	at,at

00002ecc <printstr>:
    2ecc:	27bdffc8 	addiu	sp,sp,-56
    2ed0:	afbf0034 	sw	ra,52(sp)
    2ed4:	afb50030 	sw	s5,48(sp)
    2ed8:	afb4002c 	sw	s4,44(sp)
    2edc:	afb30028 	sw	s3,40(sp)
    2ee0:	afb20024 	sw	s2,36(sp)
    2ee4:	afb10020 	sw	s1,32(sp)
    2ee8:	afb0001c 	sw	s0,28(sp)
    2eec:	00808021 	move	s0,a0
    2ef0:	0c000048 	jal	120 <get_tid>
    2ef4:	00200825 	move	at,at
    2ef8:	24420040 	addiu	v0,v0,64
    2efc:	0002a380 	sll	s4,v0,0xe
    2f00:	8e930000 	lw	s3,0(s4)
    2f04:	26920080 	addiu	s2,s4,128
    2f08:	82020000 	lb	v0,0(s0)
    2f0c:	00200825 	move	at,at
    2f10:	1040001c 	beqz	v0,2f84 <printstr+0xb8>
    2f14:	00200825 	move	at,at
    2f18:	00008821 	move	s1,zero
    2f1c:	02331821 	addu	v1,s1,s3
    2f20:	30630fff 	andi	v1,v1,0xfff
    2f24:	02431821 	addu	v1,s2,v1
    2f28:	a0620000 	sb	v0,0(v1)
    2f2c:	26310001 	addiu	s1,s1,1
    2f30:	26100001 	addiu	s0,s0,1
    2f34:	82020000 	lb	v0,0(s0)
    2f38:	00200825 	move	at,at
    2f3c:	1440fff7 	bnez	v0,2f1c <printstr+0x50>
    2f40:	00200825 	move	at,at
    2f44:	0220a821 	move	s5,s1
    2f48:	12200012 	beqz	s1,2f94 <printstr+0xc8>
    2f4c:	00200825 	move	at,at
    2f50:	00008021 	move	s0,zero
    2f54:	00531021 	addu	v0,v0,s3
    2f58:	30440fff 	andi	a0,v0,0xfff
    2f5c:	02442021 	addu	a0,s2,a0
    2f60:	0c000040 	jal	100 <clean_dcache>
    2f64:	00200825 	move	at,at
    2f68:	26100040 	addiu	s0,s0,64
    2f6c:	02001021 	move	v0,s0
    2f70:	0215182b 	sltu	v1,s0,s5
    2f74:	1460fff7 	bnez	v1,2f54 <printstr+0x88>
    2f78:	00200825 	move	at,at
    2f7c:	08000be6 	j	2f98 <printstr+0xcc>
    2f80:	00200825 	move	at,at
    2f84:	00008821 	move	s1,zero
    2f88:	00001021 	move	v0,zero
    2f8c:	08000be6 	j	2f98 <printstr+0xcc>
    2f90:	00200825 	move	at,at
    2f94:	00001021 	move	v0,zero
    2f98:	02338821 	addu	s1,s1,s3
    2f9c:	32310fff 	andi	s1,s1,0xfff
    2fa0:	02512021 	addu	a0,s2,s1
    2fa4:	2673ffc0 	addiu	s3,s3,-64
    2fa8:	02621021 	addu	v0,s3,v0
    2fac:	30420fff 	andi	v0,v0,0xfff
    2fb0:	02429021 	addu	s2,s2,v0
    2fb4:	00129182 	srl	s2,s2,0x6
    2fb8:	00041182 	srl	v0,a0,0x6
    2fbc:	12420003 	beq	s2,v0,2fcc <printstr+0x100>
    2fc0:	00200825 	move	at,at
    2fc4:	0c000040 	jal	100 <clean_dcache>
    2fc8:	00200825 	move	at,at
    2fcc:	ae910000 	sw	s1,0(s4)
    2fd0:	02802021 	move	a0,s4
    2fd4:	0c000040 	jal	100 <clean_dcache>
    2fd8:	00200825 	move	at,at
    2fdc:	8fbf0034 	lw	ra,52(sp)
    2fe0:	8fb50030 	lw	s5,48(sp)
    2fe4:	8fb4002c 	lw	s4,44(sp)
    2fe8:	8fb30028 	lw	s3,40(sp)
    2fec:	8fb20024 	lw	s2,36(sp)
    2ff0:	8fb10020 	lw	s1,32(sp)
    2ff4:	8fb0001c 	lw	s0,28(sp)
    2ff8:	27bd0038 	addiu	sp,sp,56
    2ffc:	03e00008 	jr	ra
    3000:	00200825 	move	at,at
    3004:	00200825 	move	at,at
    3008:	00200825 	move	at,at
    300c:	00200825 	move	at,at

00003010 <Proc_2>:
    3010:	8c850000 	lw	a1,0(a0)
    3014:	3c020001 	lui	v0,0x1
    3018:	804383fc 	lb	v1,-31748(v0)
    301c:	24020041 	li	v0,65
    3020:	14620007 	bne	v1,v0,3040 <Proc_2+0x30>
    3024:	00200825 	move	at,at
    3028:	24a50009 	addiu	a1,a1,9
    302c:	3c020001 	lui	v0,0x1
    3030:	8c4283f8 	lw	v0,-31752(v0)
    3034:	00200825 	move	at,at
    3038:	00a22823 	subu	a1,a1,v0
    303c:	ac850000 	sw	a1,0(a0)
    3040:	03e00008 	jr	ra
    3044:	00200825 	move	at,at

00003048 <Proc_3>:
    3048:	27bdffe0 	addiu	sp,sp,-32
    304c:	afbf001c 	sw	ra,28(sp)
    3050:	3c020001 	lui	v0,0x1
    3054:	8c428400 	lw	v0,-31744(v0)
    3058:	00200825 	move	at,at
    305c:	10400004 	beqz	v0,3070 <Proc_3+0x28>
    3060:	00200825 	move	at,at
    3064:	8c420000 	lw	v0,0(v0)
    3068:	00200825 	move	at,at
    306c:	ac820000 	sw	v0,0(a0)
    3070:	3c020001 	lui	v0,0x1
    3074:	8c468400 	lw	a2,-31744(v0)
    3078:	2404000a 	li	a0,10
    307c:	3c020001 	lui	v0,0x1
    3080:	8c4583f8 	lw	a1,-31752(v0)
    3084:	24c6000c 	addiu	a2,a2,12
    3088:	0c000e48 	jal	3920 <Proc_7>
    308c:	00200825 	move	at,at
    3090:	8fbf001c 	lw	ra,28(sp)
    3094:	27bd0020 	addiu	sp,sp,32
    3098:	03e00008 	jr	ra
    309c:	00200825 	move	at,at

000030a0 <Proc_1>:
    30a0:	27bdffd8 	addiu	sp,sp,-40
    30a4:	afbf0024 	sw	ra,36(sp)
    30a8:	afb10020 	sw	s1,32(sp)
    30ac:	afb0001c 	sw	s0,28(sp)
    30b0:	00808021 	move	s0,a0
    30b4:	8c910000 	lw	s1,0(a0)
    30b8:	3c020001 	lui	v0,0x1
    30bc:	8c428400 	lw	v0,-31744(v0)
    30c0:	02201821 	move	v1,s1
    30c4:	24440030 	addiu	a0,v0,48
    30c8:	8c480000 	lw	t0,0(v0)
    30cc:	8c470004 	lw	a3,4(v0)
    30d0:	8c460008 	lw	a2,8(v0)
    30d4:	8c45000c 	lw	a1,12(v0)
    30d8:	ac680000 	sw	t0,0(v1)
    30dc:	ac670004 	sw	a3,4(v1)
    30e0:	ac660008 	sw	a2,8(v1)
    30e4:	ac65000c 	sw	a1,12(v1)
    30e8:	24420010 	addiu	v0,v0,16
    30ec:	24630010 	addiu	v1,v1,16
    30f0:	1444fff5 	bne	v0,a0,30c8 <Proc_1+0x28>
    30f4:	00200825 	move	at,at
    30f8:	24020005 	li	v0,5
    30fc:	ae02000c 	sw	v0,12(s0)
    3100:	ae22000c 	sw	v0,12(s1)
    3104:	8e020000 	lw	v0,0(s0)
    3108:	00200825 	move	at,at
    310c:	ae220000 	sw	v0,0(s1)
    3110:	02202021 	move	a0,s1
    3114:	0c000c12 	jal	3048 <Proc_3>
    3118:	00200825 	move	at,at
    311c:	8e220004 	lw	v0,4(s1)
    3120:	00200825 	move	at,at
    3124:	14400014 	bnez	v0,3178 <Proc_1+0xd8>
    3128:	00200825 	move	at,at
    312c:	24020006 	li	v0,6
    3130:	ae22000c 	sw	v0,12(s1)
    3134:	8e040008 	lw	a0,8(s0)
    3138:	26250008 	addiu	a1,s1,8
    313c:	0c000ebc 	jal	3af0 <Proc_6>
    3140:	00200825 	move	at,at
    3144:	3c020001 	lui	v0,0x1
    3148:	8c428400 	lw	v0,-31744(v0)
    314c:	00200825 	move	at,at
    3150:	8c420000 	lw	v0,0(v0)
    3154:	00200825 	move	at,at
    3158:	ae220000 	sw	v0,0(s1)
    315c:	8e24000c 	lw	a0,12(s1)
    3160:	2405000a 	li	a1,10
    3164:	2626000c 	addiu	a2,s1,12
    3168:	0c000e48 	jal	3920 <Proc_7>
    316c:	00200825 	move	at,at
    3170:	08000c6d 	j	31b4 <Proc_1+0x114>
    3174:	00200825 	move	at,at
    3178:	8e020000 	lw	v0,0(s0)
    317c:	02002021 	move	a0,s0
    3180:	24430030 	addiu	v1,v0,48
    3184:	8c480000 	lw	t0,0(v0)
    3188:	8c470004 	lw	a3,4(v0)
    318c:	8c460008 	lw	a2,8(v0)
    3190:	8c45000c 	lw	a1,12(v0)
    3194:	ac880000 	sw	t0,0(a0)
    3198:	ac870004 	sw	a3,4(a0)
    319c:	ac860008 	sw	a2,8(a0)
    31a0:	ac85000c 	sw	a1,12(a0)
    31a4:	24420010 	addiu	v0,v0,16
    31a8:	24840010 	addiu	a0,a0,16
    31ac:	1443fff5 	bne	v0,v1,3184 <Proc_1+0xe4>
    31b0:	00200825 	move	at,at
    31b4:	8fbf0024 	lw	ra,36(sp)
    31b8:	8fb10020 	lw	s1,32(sp)
    31bc:	8fb0001c 	lw	s0,28(sp)
    31c0:	27bd0028 	addiu	sp,sp,40
    31c4:	03e00008 	jr	ra
    31c8:	00200825 	move	at,at

000031cc <Proc_4>:
    31cc:	3c020001 	lui	v0,0x1
    31d0:	3c030001 	lui	v1,0x1
    31d4:	806383fc 	lb	v1,-31748(v1)
    31d8:	00200825 	move	at,at
    31dc:	38630041 	xori	v1,v1,0x41
    31e0:	2c630001 	sltiu	v1,v1,1
    31e4:	8c448404 	lw	a0,-31740(v0)
    31e8:	00200825 	move	at,at
    31ec:	00641825 	or	v1,v1,a0
    31f0:	ac438404 	sw	v1,-31740(v0)
    31f4:	24030042 	li	v1,66
    31f8:	3c020001 	lui	v0,0x1
    31fc:	a04383fd 	sb	v1,-31747(v0)
    3200:	03e00008 	jr	ra
    3204:	00200825 	move	at,at

00003208 <Proc_5>:
    3208:	24030041 	li	v1,65
    320c:	3c020001 	lui	v0,0x1
    3210:	a04383fc 	sb	v1,-31748(v0)
    3214:	3c020001 	lui	v0,0x1
    3218:	ac408404 	sw	zero,-31740(v0)
    321c:	03e00008 	jr	ra
    3220:	00200825 	move	at,at

00003224 <dhry>:
    3224:	27bdff68 	addiu	sp,sp,-152
    3228:	afbf0094 	sw	ra,148(sp)
    322c:	afbe0090 	sw	s8,144(sp)
    3230:	afb7008c 	sw	s7,140(sp)
    3234:	afb60088 	sw	s6,136(sp)
    3238:	afb50084 	sw	s5,132(sp)
    323c:	afb40080 	sw	s4,128(sp)
    3240:	afb3007c 	sw	s3,124(sp)
    3244:	afb20078 	sw	s2,120(sp)
    3248:	afb10074 	sw	s1,116(sp)
    324c:	afb00070 	sw	s0,112(sp)
    3250:	0080b021 	move	s6,a0
    3254:	3c040001 	lui	a0,0x1
    3258:	2484ab60 	addiu	a0,a0,-21664
    325c:	3c020001 	lui	v0,0x1
    3260:	ac4483f4 	sw	a0,-31756(v0)
    3264:	3c030001 	lui	v1,0x1
    3268:	2462ab30 	addiu	v0,v1,-21712
    326c:	3c050001 	lui	a1,0x1
    3270:	aca28400 	sw	v0,-31744(a1)
    3274:	ac64ab30 	sw	a0,-21712(v1)
    3278:	ac400004 	sw	zero,4(v0)
    327c:	24030002 	li	v1,2
    3280:	ac430008 	sw	v1,8(v0)
    3284:	24030028 	li	v1,40
    3288:	ac43000c 	sw	v1,12(v0)
    328c:	3c040001 	lui	a0,0x1
    3290:	2484ab40 	addiu	a0,a0,-21696
    3294:	3c050000 	lui	a1,0x0
    3298:	24a53e20 	addiu	a1,a1,15904
    329c:	0c000b85 	jal	2e14 <strcopy>
    32a0:	00200825 	move	at,at
    32a4:	27a40024 	addiu	a0,sp,36
    32a8:	3c050000 	lui	a1,0x0
    32ac:	24a53e40 	addiu	a1,a1,15936
    32b0:	0c000b85 	jal	2e14 <strcopy>
    32b4:	00200825 	move	at,at
    32b8:	2403000a 	li	v1,10
    32bc:	3c020001 	lui	v0,0x1
    32c0:	ac438a7c 	sw	v1,-30084(v0)
    32c4:	3c100000 	lui	s0,0x0
    32c8:	260440ac 	addiu	a0,s0,16556
    32cc:	0c000594 	jal	1650 <my_printf>
    32d0:	00200825 	move	at,at
    32d4:	3c040000 	lui	a0,0x0
    32d8:	24843e60 	addiu	a0,a0,15968
    32dc:	0c000594 	jal	1650 <my_printf>
    32e0:	00200825 	move	at,at
    32e4:	260440ac 	addiu	a0,s0,16556
    32e8:	0c000594 	jal	1650 <my_printf>
    32ec:	00200825 	move	at,at
    32f0:	3c020001 	lui	v0,0x1
    32f4:	8c428410 	lw	v0,-31728(v0)
    32f8:	00200825 	move	at,at
    32fc:	1040000a 	beqz	v0,3328 <dhry+0x104>
    3300:	00200825 	move	at,at
    3304:	3c040000 	lui	a0,0x0
    3308:	24843e90 	addiu	a0,a0,16016
    330c:	0c000594 	jal	1650 <my_printf>
    3310:	00200825 	move	at,at
    3314:	260440ac 	addiu	a0,s0,16556
    3318:	0c000594 	jal	1650 <my_printf>
    331c:	00200825 	move	at,at
    3320:	08000cd2 	j	3348 <dhry+0x124>
    3324:	00200825 	move	at,at
    3328:	3c040000 	lui	a0,0x0
    332c:	24843ebc 	addiu	a0,a0,16060
    3330:	0c000594 	jal	1650 <my_printf>
    3334:	00200825 	move	at,at
    3338:	3c040000 	lui	a0,0x0
    333c:	248440ac 	addiu	a0,a0,16556
    3340:	0c000594 	jal	1650 <my_printf>
    3344:	00200825 	move	at,at
    3348:	3c040000 	lui	a0,0x0
    334c:	24843eec 	addiu	a0,a0,16108
    3350:	02c02821 	move	a1,s6
    3354:	0c000594 	jal	1650 <my_printf>
    3358:	00200825 	move	at,at
    335c:	1ac00075 	blez	s6,3534 <dhry+0x310>
    3360:	00200825 	move	at,at
    3364:	24120001 	li	s2,1
    3368:	3c1e0000 	lui	s8,0x0
    336c:	27de3f1c 	addiu	s8,s8,16156
    3370:	3c170001 	lui	s7,0x1
    3374:	3c110001 	lui	s1,0x1
    3378:	3c150000 	lui	s5,0x0
    337c:	26b53f3c 	addiu	s5,s5,16188
    3380:	0c000c82 	jal	3208 <Proc_5>
    3384:	00200825 	move	at,at
    3388:	0c000c73 	jal	31cc <Proc_4>
    338c:	00200825 	move	at,at
    3390:	24020002 	li	v0,2
    3394:	afa20018 	sw	v0,24(sp)
    3398:	27a40044 	addiu	a0,sp,68
    339c:	03c02821 	move	a1,s8
    33a0:	0c000b85 	jal	2e14 <strcopy>
    33a4:	00200825 	move	at,at
    33a8:	24020001 	li	v0,1
    33ac:	afa20020 	sw	v0,32(sp)
    33b0:	27a40024 	addiu	a0,sp,36
    33b4:	27a50044 	addiu	a1,sp,68
    33b8:	0c000e90 	jal	3a40 <Func_2>
    33bc:	00200825 	move	at,at
    33c0:	2c420001 	sltiu	v0,v0,1
    33c4:	aee28404 	sw	v0,-31740(s7)
    33c8:	8fa60018 	lw	a2,24(sp)
    33cc:	00200825 	move	at,at
    33d0:	28c20003 	slti	v0,a2,3
    33d4:	10400011 	beqz	v0,341c <dhry+0x1f8>
    33d8:	00200825 	move	at,at
    33dc:	00061080 	sll	v0,a2,0x2
    33e0:	00463021 	addu	a2,v0,a2
    33e4:	24c6fffd 	addiu	a2,a2,-3
    33e8:	afa6001c 	sw	a2,28(sp)
    33ec:	8fa40018 	lw	a0,24(sp)
    33f0:	24050003 	li	a1,3
    33f4:	27a6001c 	addiu	a2,sp,28
    33f8:	0c000e48 	jal	3920 <Proc_7>
    33fc:	00200825 	move	at,at
    3400:	8fa60018 	lw	a2,24(sp)
    3404:	00200825 	move	at,at
    3408:	24c60001 	addiu	a2,a2,1
    340c:	afa60018 	sw	a2,24(sp)
    3410:	28c20003 	slti	v0,a2,3
    3414:	1440fff1 	bnez	v0,33dc <dhry+0x1b8>
    3418:	00200825 	move	at,at
    341c:	3c040001 	lui	a0,0x1
    3420:	2484ab90 	addiu	a0,a0,-21616
    3424:	3c050001 	lui	a1,0x1
    3428:	24a58420 	addiu	a1,a1,-31712
    342c:	8fa7001c 	lw	a3,28(sp)
    3430:	0c000e4d 	jal	3934 <Proc_8>
    3434:	00200825 	move	at,at
    3438:	3c020001 	lui	v0,0x1
    343c:	8c448400 	lw	a0,-31744(v0)
    3440:	0c000c28 	jal	30a0 <Proc_1>
    3444:	00200825 	move	at,at
    3448:	822283fd 	lb	v0,-31747(s1)
    344c:	00200825 	move	at,at
    3450:	28420041 	slti	v0,v0,65
    3454:	14400020 	bnez	v0,34d8 <dhry+0x2b4>
    3458:	00200825 	move	at,at
    345c:	24100041 	li	s0,65
    3460:	24130003 	li	s3,3
    3464:	3c140001 	lui	s4,0x1
    3468:	02002021 	move	a0,s0
    346c:	24050043 	li	a1,67
    3470:	0c000e82 	jal	3a08 <Func_1>
    3474:	00200825 	move	at,at
    3478:	8fa30020 	lw	v1,32(sp)
    347c:	00200825 	move	at,at
    3480:	1443000b 	bne	v0,v1,34b0 <dhry+0x28c>
    3484:	00200825 	move	at,at
    3488:	00002021 	move	a0,zero
    348c:	27a50020 	addiu	a1,sp,32
    3490:	0c000ebc 	jal	3af0 <Proc_6>
    3494:	00200825 	move	at,at
    3498:	27a40044 	addiu	a0,sp,68
    349c:	02a02821 	move	a1,s5
    34a0:	0c000b85 	jal	2e14 <strcopy>
    34a4:	00200825 	move	at,at
    34a8:	ae9283f8 	sw	s2,-31752(s4)
    34ac:	02409821 	move	s3,s2
    34b0:	26100001 	addiu	s0,s0,1
    34b4:	00108600 	sll	s0,s0,0x18
    34b8:	00108603 	sra	s0,s0,0x18
    34bc:	822283fd 	lb	v0,-31747(s1)
    34c0:	00200825 	move	at,at
    34c4:	0050102a 	slt	v0,v0,s0
    34c8:	1040ffe7 	beqz	v0,3468 <dhry+0x244>
    34cc:	00200825 	move	at,at
    34d0:	08000d37 	j	34dc <dhry+0x2b8>
    34d4:	00200825 	move	at,at
    34d8:	24130003 	li	s3,3
    34dc:	8fb00018 	lw	s0,24(sp)
    34e0:	00200825 	move	at,at
    34e4:	02700018 	mult	s3,s0
    34e8:	00009812 	mflo	s3
    34ec:	8fb0001c 	lw	s0,28(sp)
    34f0:	00200825 	move	at,at
    34f4:	0270001a 	div	zero,s3,s0
    34f8:	00001012 	mflo	v0
    34fc:	0000a012 	mflo	s4
    3500:	afa20018 	sw	v0,24(sp)
    3504:	27a40018 	addiu	a0,sp,24
    3508:	0c000c04 	jal	3010 <Proc_2>
    350c:	00200825 	move	at,at
    3510:	26520001 	addiu	s2,s2,1
    3514:	02d2102a 	slt	v0,s6,s2
    3518:	1040ff99 	beqz	v0,3380 <dhry+0x15c>
    351c:	00200825 	move	at,at
    3520:	02708023 	subu	s0,s3,s0
    3524:	001010c0 	sll	v0,s0,0x3
    3528:	00508023 	subu	s0,v0,s0
    352c:	02148023 	subu	s0,s0,s4
    3530:	afb00068 	sw	s0,104(sp)
    3534:	3c040000 	lui	a0,0x0
    3538:	24843f5c 	addiu	a0,a0,16220
    353c:	0c000594 	jal	1650 <my_printf>
    3540:	00200825 	move	at,at
    3544:	3c120000 	lui	s2,0x0
    3548:	264440ac 	addiu	a0,s2,16556
    354c:	0c000594 	jal	1650 <my_printf>
    3550:	00200825 	move	at,at
    3554:	3c040000 	lui	a0,0x0
    3558:	24843f6c 	addiu	a0,a0,16236
    355c:	0c000594 	jal	1650 <my_printf>
    3560:	00200825 	move	at,at
    3564:	264440ac 	addiu	a0,s2,16556
    3568:	0c000594 	jal	1650 <my_printf>
    356c:	00200825 	move	at,at
    3570:	3c040000 	lui	a0,0x0
    3574:	24843fa4 	addiu	a0,a0,16292
    3578:	3c020001 	lui	v0,0x1
    357c:	8c4583f8 	lw	a1,-31752(v0)
    3580:	0c000594 	jal	1650 <my_printf>
    3584:	00200825 	move	at,at
    3588:	3c100000 	lui	s0,0x0
    358c:	26043fc0 	addiu	a0,s0,16320
    3590:	24050005 	li	a1,5
    3594:	0c000594 	jal	1650 <my_printf>
    3598:	00200825 	move	at,at
    359c:	3c040000 	lui	a0,0x0
    35a0:	24843fdc 	addiu	a0,a0,16348
    35a4:	3c020001 	lui	v0,0x1
    35a8:	8c458404 	lw	a1,-31740(v0)
    35ac:	0c000594 	jal	1650 <my_printf>
    35b0:	00200825 	move	at,at
    35b4:	26043fc0 	addiu	a0,s0,16320
    35b8:	24050001 	li	a1,1
    35bc:	0c000594 	jal	1650 <my_printf>
    35c0:	00200825 	move	at,at
    35c4:	3c040000 	lui	a0,0x0
    35c8:	24843ff8 	addiu	a0,a0,16376
    35cc:	3c020001 	lui	v0,0x1
    35d0:	804583fc 	lb	a1,-31748(v0)
    35d4:	0c000594 	jal	1650 <my_printf>
    35d8:	00200825 	move	at,at
    35dc:	3c110000 	lui	s1,0x0
    35e0:	26244014 	addiu	a0,s1,16404
    35e4:	24050041 	li	a1,65
    35e8:	0c000594 	jal	1650 <my_printf>
    35ec:	00200825 	move	at,at
    35f0:	3c040000 	lui	a0,0x0
    35f4:	24844030 	addiu	a0,a0,16432
    35f8:	3c020001 	lui	v0,0x1
    35fc:	804583fd 	lb	a1,-31747(v0)
    3600:	0c000594 	jal	1650 <my_printf>
    3604:	00200825 	move	at,at
    3608:	26244014 	addiu	a0,s1,16404
    360c:	24050042 	li	a1,66
    3610:	0c000594 	jal	1650 <my_printf>
    3614:	00200825 	move	at,at
    3618:	3c040000 	lui	a0,0x0
    361c:	2484404c 	addiu	a0,a0,16460
    3620:	3c020001 	lui	v0,0x1
    3624:	8c45abb0 	lw	a1,-21584(v0)
    3628:	0c000594 	jal	1650 <my_printf>
    362c:	00200825 	move	at,at
    3630:	26043fc0 	addiu	a0,s0,16320
    3634:	24050007 	li	a1,7
    3638:	0c000594 	jal	1650 <my_printf>
    363c:	00200825 	move	at,at
    3640:	3c040000 	lui	a0,0x0
    3644:	24844068 	addiu	a0,a0,16488
    3648:	3c020001 	lui	v0,0x1
    364c:	8c458a7c 	lw	a1,-30084(v0)
    3650:	0c000594 	jal	1650 <my_printf>
    3654:	00200825 	move	at,at
    3658:	3c040000 	lui	a0,0x0
    365c:	24844084 	addiu	a0,a0,16516
    3660:	0c000594 	jal	1650 <my_printf>
    3664:	00200825 	move	at,at
    3668:	3c040000 	lui	a0,0x0
    366c:	248440b0 	addiu	a0,a0,16560
    3670:	0c000594 	jal	1650 <my_printf>
    3674:	00200825 	move	at,at
    3678:	3c110001 	lui	s1,0x1
    367c:	8e228400 	lw	v0,-31744(s1)
    3680:	3c1e0000 	lui	s8,0x0
    3684:	27c440bc 	addiu	a0,s8,16572
    3688:	8c450000 	lw	a1,0(v0)
    368c:	0c000594 	jal	1650 <my_printf>
    3690:	00200825 	move	at,at
    3694:	3c040000 	lui	a0,0x0
    3698:	248440d8 	addiu	a0,a0,16600
    369c:	0c000594 	jal	1650 <my_printf>
    36a0:	00200825 	move	at,at
    36a4:	8e228400 	lw	v0,-31744(s1)
    36a8:	3c170000 	lui	s7,0x0
    36ac:	26e4410c 	addiu	a0,s7,16652
    36b0:	8c450004 	lw	a1,4(v0)
    36b4:	0c000594 	jal	1650 <my_printf>
    36b8:	00200825 	move	at,at
    36bc:	26043fc0 	addiu	a0,s0,16320
    36c0:	00002821 	move	a1,zero
    36c4:	0c000594 	jal	1650 <my_printf>
    36c8:	00200825 	move	at,at
    36cc:	8e228400 	lw	v0,-31744(s1)
    36d0:	3c160000 	lui	s6,0x0
    36d4:	26c44128 	addiu	a0,s6,16680
    36d8:	8c450008 	lw	a1,8(v0)
    36dc:	0c000594 	jal	1650 <my_printf>
    36e0:	00200825 	move	at,at
    36e4:	26043fc0 	addiu	a0,s0,16320
    36e8:	24050002 	li	a1,2
    36ec:	0c000594 	jal	1650 <my_printf>
    36f0:	00200825 	move	at,at
    36f4:	8e228400 	lw	v0,-31744(s1)
    36f8:	3c150000 	lui	s5,0x0
    36fc:	26a44144 	addiu	a0,s5,16708
    3700:	8c45000c 	lw	a1,12(v0)
    3704:	0c000594 	jal	1650 <my_printf>
    3708:	00200825 	move	at,at
    370c:	26043fc0 	addiu	a0,s0,16320
    3710:	24050011 	li	a1,17
    3714:	0c000594 	jal	1650 <my_printf>
    3718:	00200825 	move	at,at
    371c:	8e258400 	lw	a1,-31744(s1)
    3720:	3c140000 	lui	s4,0x0
    3724:	26844160 	addiu	a0,s4,16736
    3728:	24a50010 	addiu	a1,a1,16
    372c:	0c000594 	jal	1650 <my_printf>
    3730:	00200825 	move	at,at
    3734:	3c130000 	lui	s3,0x0
    3738:	2664417c 	addiu	a0,s3,16764
    373c:	0c000594 	jal	1650 <my_printf>
    3740:	00200825 	move	at,at
    3744:	3c040000 	lui	a0,0x0
    3748:	248441b4 	addiu	a0,a0,16820
    374c:	0c000594 	jal	1650 <my_printf>
    3750:	00200825 	move	at,at
    3754:	3c110001 	lui	s1,0x1
    3758:	8e2283f4 	lw	v0,-31756(s1)
    375c:	27c440bc 	addiu	a0,s8,16572
    3760:	8c450000 	lw	a1,0(v0)
    3764:	0c000594 	jal	1650 <my_printf>
    3768:	00200825 	move	at,at
    376c:	3c040000 	lui	a0,0x0
    3770:	248441c8 	addiu	a0,a0,16840
    3774:	0c000594 	jal	1650 <my_printf>
    3778:	00200825 	move	at,at
    377c:	8e2283f4 	lw	v0,-31756(s1)
    3780:	26e4410c 	addiu	a0,s7,16652
    3784:	8c450004 	lw	a1,4(v0)
    3788:	0c000594 	jal	1650 <my_printf>
    378c:	00200825 	move	at,at
    3790:	26043fc0 	addiu	a0,s0,16320
    3794:	00002821 	move	a1,zero
    3798:	0c000594 	jal	1650 <my_printf>
    379c:	00200825 	move	at,at
    37a0:	8e2283f4 	lw	v0,-31756(s1)
    37a4:	26c44128 	addiu	a0,s6,16680
    37a8:	8c450008 	lw	a1,8(v0)
    37ac:	0c000594 	jal	1650 <my_printf>
    37b0:	00200825 	move	at,at
    37b4:	26043fc0 	addiu	a0,s0,16320
    37b8:	24050001 	li	a1,1
    37bc:	0c000594 	jal	1650 <my_printf>
    37c0:	00200825 	move	at,at
    37c4:	8e2283f4 	lw	v0,-31756(s1)
    37c8:	26a44144 	addiu	a0,s5,16708
    37cc:	8c45000c 	lw	a1,12(v0)
    37d0:	0c000594 	jal	1650 <my_printf>
    37d4:	00200825 	move	at,at
    37d8:	26043fc0 	addiu	a0,s0,16320
    37dc:	24050012 	li	a1,18
    37e0:	0c000594 	jal	1650 <my_printf>
    37e4:	00200825 	move	at,at
    37e8:	8e2583f4 	lw	a1,-31756(s1)
    37ec:	26844160 	addiu	a0,s4,16736
    37f0:	24a50010 	addiu	a1,a1,16
    37f4:	0c000594 	jal	1650 <my_printf>
    37f8:	00200825 	move	at,at
    37fc:	2664417c 	addiu	a0,s3,16764
    3800:	0c000594 	jal	1650 <my_printf>
    3804:	00200825 	move	at,at
    3808:	3c040000 	lui	a0,0x0
    380c:	24844208 	addiu	a0,a0,16904
    3810:	8fa50018 	lw	a1,24(sp)
    3814:	0c000594 	jal	1650 <my_printf>
    3818:	00200825 	move	at,at
    381c:	26043fc0 	addiu	a0,s0,16320
    3820:	24050005 	li	a1,5
    3824:	0c000594 	jal	1650 <my_printf>
    3828:	00200825 	move	at,at
    382c:	3c040000 	lui	a0,0x0
    3830:	24844224 	addiu	a0,a0,16932
    3834:	8fa50068 	lw	a1,104(sp)
    3838:	0c000594 	jal	1650 <my_printf>
    383c:	00200825 	move	at,at
    3840:	26043fc0 	addiu	a0,s0,16320
    3844:	2405000d 	li	a1,13
    3848:	0c000594 	jal	1650 <my_printf>
    384c:	00200825 	move	at,at
    3850:	3c040000 	lui	a0,0x0
    3854:	24844240 	addiu	a0,a0,16960
    3858:	8fa5001c 	lw	a1,28(sp)
    385c:	0c000594 	jal	1650 <my_printf>
    3860:	00200825 	move	at,at
    3864:	26043fc0 	addiu	a0,s0,16320
    3868:	24050007 	li	a1,7
    386c:	0c000594 	jal	1650 <my_printf>
    3870:	00200825 	move	at,at
    3874:	3c040000 	lui	a0,0x0
    3878:	2484425c 	addiu	a0,a0,16988
    387c:	8fa50020 	lw	a1,32(sp)
    3880:	0c000594 	jal	1650 <my_printf>
    3884:	00200825 	move	at,at
    3888:	26043fc0 	addiu	a0,s0,16320
    388c:	24050001 	li	a1,1
    3890:	0c000594 	jal	1650 <my_printf>
    3894:	00200825 	move	at,at
    3898:	3c040000 	lui	a0,0x0
    389c:	24844278 	addiu	a0,a0,17016
    38a0:	27a50024 	addiu	a1,sp,36
    38a4:	0c000594 	jal	1650 <my_printf>
    38a8:	00200825 	move	at,at
    38ac:	3c040000 	lui	a0,0x0
    38b0:	24844294 	addiu	a0,a0,17044
    38b4:	0c000594 	jal	1650 <my_printf>
    38b8:	00200825 	move	at,at
    38bc:	3c040000 	lui	a0,0x0
    38c0:	248442cc 	addiu	a0,a0,17100
    38c4:	27a50044 	addiu	a1,sp,68
    38c8:	0c000594 	jal	1650 <my_printf>
    38cc:	00200825 	move	at,at
    38d0:	3c040000 	lui	a0,0x0
    38d4:	248442e8 	addiu	a0,a0,17128
    38d8:	0c000594 	jal	1650 <my_printf>
    38dc:	00200825 	move	at,at
    38e0:	264440ac 	addiu	a0,s2,16556
    38e4:	0c000594 	jal	1650 <my_printf>
    38e8:	00200825 	move	at,at
    38ec:	8fbf0094 	lw	ra,148(sp)
    38f0:	8fbe0090 	lw	s8,144(sp)
    38f4:	8fb7008c 	lw	s7,140(sp)
    38f8:	8fb60088 	lw	s6,136(sp)
    38fc:	8fb50084 	lw	s5,132(sp)
    3900:	8fb40080 	lw	s4,128(sp)
    3904:	8fb3007c 	lw	s3,124(sp)
    3908:	8fb20078 	lw	s2,120(sp)
    390c:	8fb10074 	lw	s1,116(sp)
    3910:	8fb00070 	lw	s0,112(sp)
    3914:	27bd0098 	addiu	sp,sp,152
    3918:	03e00008 	jr	ra
    391c:	00200825 	move	at,at

00003920 <Proc_7>:
    3920:	24840002 	addiu	a0,a0,2
    3924:	00a42821 	addu	a1,a1,a0
    3928:	acc50000 	sw	a1,0(a2)
    392c:	03e00008 	jr	ra
    3930:	00200825 	move	at,at

00003934 <Proc_8>:
    3934:	24c80005 	addiu	t0,a2,5
    3938:	00084880 	sll	t1,t0,0x2
    393c:	00894821 	addu	t1,a0,t1
    3940:	ad270000 	sw	a3,0(t1)
    3944:	24c20006 	addiu	v0,a2,6
    3948:	00021880 	sll	v1,v0,0x2
    394c:	00831821 	addu	v1,a0,v1
    3950:	ac670000 	sw	a3,0(v1)
    3954:	24c30023 	addiu	v1,a2,35
    3958:	00031880 	sll	v1,v1,0x2
    395c:	00832021 	addu	a0,a0,v1
    3960:	ac880000 	sw	t0,0(a0)
    3964:	00403821 	move	a3,v0
    3968:	0048102a 	slt	v0,v0,t0
    396c:	14400010 	bnez	v0,39b0 <Proc_8+0x7c>
    3970:	00200825 	move	at,at
    3974:	000818c0 	sll	v1,t0,0x3
    3978:	00081140 	sll	v0,t0,0x5
    397c:	00621021 	addu	v0,v1,v0
    3980:	00021880 	sll	v1,v0,0x2
    3984:	00431021 	addu	v0,v0,v1
    3988:	00a21021 	addu	v0,a1,v0
    398c:	00081880 	sll	v1,t0,0x2
    3990:	00431821 	addu	v1,v0,v1
    3994:	01001021 	move	v0,t0
    3998:	ac680000 	sw	t0,0(v1)
    399c:	24420001 	addiu	v0,v0,1
    39a0:	24630004 	addiu	v1,v1,4
    39a4:	00e2202a 	slt	a0,a3,v0
    39a8:	1080fffb 	beqz	a0,3998 <Proc_8+0x64>
    39ac:	00200825 	move	at,at
    39b0:	000818c0 	sll	v1,t0,0x3
    39b4:	00081140 	sll	v0,t0,0x5
    39b8:	00621021 	addu	v0,v1,v0
    39bc:	00021880 	sll	v1,v0,0x2
    39c0:	00431021 	addu	v0,v0,v1
    39c4:	00a22821 	addu	a1,a1,v0
    39c8:	24c20004 	addiu	v0,a2,4
    39cc:	00021080 	sll	v0,v0,0x2
    39d0:	00a21021 	addu	v0,a1,v0
    39d4:	8c430000 	lw	v1,0(v0)
    39d8:	00200825 	move	at,at
    39dc:	24630001 	addiu	v1,v1,1
    39e0:	ac430000 	sw	v1,0(v0)
    39e4:	8d220000 	lw	v0,0(t1)
    39e8:	00084080 	sll	t0,t0,0x2
    39ec:	00a82821 	addu	a1,a1,t0
    39f0:	aca20fa0 	sw	v0,4000(a1)
    39f4:	24030005 	li	v1,5
    39f8:	3c020001 	lui	v0,0x1
    39fc:	ac4383f8 	sw	v1,-31752(v0)
    3a00:	03e00008 	jr	ra
    3a04:	00200825 	move	at,at

00003a08 <Func_1>:
    3a08:	00042600 	sll	a0,a0,0x18
    3a0c:	00042603 	sra	a0,a0,0x18
    3a10:	00052e00 	sll	a1,a1,0x18
    3a14:	00052e03 	sra	a1,a1,0x18
    3a18:	14850006 	bne	a0,a1,3a34 <Func_1+0x2c>
    3a1c:	00200825 	move	at,at
    3a20:	3c020001 	lui	v0,0x1
    3a24:	a04483fc 	sb	a0,-31748(v0)
    3a28:	24020001 	li	v0,1
    3a2c:	03e00008 	jr	ra
    3a30:	00200825 	move	at,at
    3a34:	00001021 	move	v0,zero
    3a38:	03e00008 	jr	ra
    3a3c:	00200825 	move	at,at

00003a40 <Func_2>:
    3a40:	27bdffd8 	addiu	sp,sp,-40
    3a44:	afbf0024 	sw	ra,36(sp)
    3a48:	afb20020 	sw	s2,32(sp)
    3a4c:	afb1001c 	sw	s1,28(sp)
    3a50:	afb00018 	sw	s0,24(sp)
    3a54:	00809021 	move	s2,a0
    3a58:	00a08821 	move	s1,a1
    3a5c:	24100002 	li	s0,2
    3a60:	02501821 	addu	v1,s2,s0
    3a64:	02301021 	addu	v0,s1,s0
    3a68:	80640000 	lb	a0,0(v1)
    3a6c:	80450001 	lb	a1,1(v0)
    3a70:	0c000e82 	jal	3a08 <Func_1>
    3a74:	00200825 	move	at,at
    3a78:	14400002 	bnez	v0,3a84 <Func_2+0x44>
    3a7c:	00200825 	move	at,at
    3a80:	26100001 	addiu	s0,s0,1
    3a84:	2a020003 	slti	v0,s0,3
    3a88:	1440fff5 	bnez	v0,3a60 <Func_2+0x20>
    3a8c:	00200825 	move	at,at
    3a90:	02402021 	move	a0,s2
    3a94:	02202821 	move	a1,s1
    3a98:	0c000b65 	jal	2d94 <strcomp>
    3a9c:	00200825 	move	at,at
    3aa0:	18400007 	blez	v0,3ac0 <Func_2+0x80>
    3aa4:	00200825 	move	at,at
    3aa8:	26100007 	addiu	s0,s0,7
    3aac:	3c020001 	lui	v0,0x1
    3ab0:	ac5083f8 	sw	s0,-31752(v0)
    3ab4:	24020001 	li	v0,1
    3ab8:	08000eb1 	j	3ac4 <Func_2+0x84>
    3abc:	00200825 	move	at,at
    3ac0:	00001021 	move	v0,zero
    3ac4:	8fbf0024 	lw	ra,36(sp)
    3ac8:	8fb20020 	lw	s2,32(sp)
    3acc:	8fb1001c 	lw	s1,28(sp)
    3ad0:	8fb00018 	lw	s0,24(sp)
    3ad4:	27bd0028 	addiu	sp,sp,40
    3ad8:	03e00008 	jr	ra
    3adc:	00200825 	move	at,at

00003ae0 <Func_3>:
    3ae0:	38820002 	xori	v0,a0,0x2
    3ae4:	2c420001 	sltiu	v0,v0,1
    3ae8:	03e00008 	jr	ra
    3aec:	00200825 	move	at,at

00003af0 <Proc_6>:
    3af0:	27bdffd8 	addiu	sp,sp,-40
    3af4:	afbf0024 	sw	ra,36(sp)
    3af8:	afb10020 	sw	s1,32(sp)
    3afc:	afb0001c 	sw	s0,28(sp)
    3b00:	00808021 	move	s0,a0
    3b04:	00a08821 	move	s1,a1
    3b08:	0c000eb8 	jal	3ae0 <Func_3>
    3b0c:	00200825 	move	at,at
    3b10:	14400004 	bnez	v0,3b24 <Proc_6+0x34>
    3b14:	00200825 	move	at,at
    3b18:	24020003 	li	v0,3
    3b1c:	08000eca 	j	3b28 <Proc_6+0x38>
    3b20:	00200825 	move	at,at
    3b24:	02001021 	move	v0,s0
    3b28:	ae220000 	sw	v0,0(s1)
    3b2c:	24020001 	li	v0,1
    3b30:	1202000e 	beq	s0,v0,3b6c <Proc_6+0x7c>
    3b34:	00200825 	move	at,at
    3b38:	12000009 	beqz	s0,3b60 <Proc_6+0x70>
    3b3c:	00200825 	move	at,at
    3b40:	24020002 	li	v0,2
    3b44:	12020016 	beq	s0,v0,3ba0 <Proc_6+0xb0>
    3b48:	00200825 	move	at,at
    3b4c:	24020004 	li	v0,4
    3b50:	16020019 	bne	s0,v0,3bb8 <Proc_6+0xc8>
    3b54:	00200825 	move	at,at
    3b58:	08000eec 	j	3bb0 <Proc_6+0xc0>
    3b5c:	00200825 	move	at,at
    3b60:	ae200000 	sw	zero,0(s1)
    3b64:	08000eee 	j	3bb8 <Proc_6+0xc8>
    3b68:	00200825 	move	at,at
    3b6c:	3c020001 	lui	v0,0x1
    3b70:	8c4283f8 	lw	v0,-31752(v0)
    3b74:	00200825 	move	at,at
    3b78:	28420065 	slti	v0,v0,101
    3b7c:	14400004 	bnez	v0,3b90 <Proc_6+0xa0>
    3b80:	00200825 	move	at,at
    3b84:	ae200000 	sw	zero,0(s1)
    3b88:	08000eee 	j	3bb8 <Proc_6+0xc8>
    3b8c:	00200825 	move	at,at
    3b90:	24020003 	li	v0,3
    3b94:	ae220000 	sw	v0,0(s1)
    3b98:	08000eee 	j	3bb8 <Proc_6+0xc8>
    3b9c:	00200825 	move	at,at
    3ba0:	24020001 	li	v0,1
    3ba4:	ae220000 	sw	v0,0(s1)
    3ba8:	08000eee 	j	3bb8 <Proc_6+0xc8>
    3bac:	00200825 	move	at,at
    3bb0:	24020002 	li	v0,2
    3bb4:	ae220000 	sw	v0,0(s1)
    3bb8:	8fbf0024 	lw	ra,36(sp)
    3bbc:	8fb10020 	lw	s1,32(sp)
    3bc0:	8fb0001c 	lw	s0,28(sp)
    3bc4:	27bd0028 	addiu	sp,sp,40
    3bc8:	03e00008 	jr	ra
    3bcc:	00200825 	move	at,at

Disassembly of section .rodata:

00003bd0 <hex2ascii_data-0x220>:
    3bd0:	6c6c6548 	0x6c6c6548
    3bd4:	7266206f 	0x7266206f
    3bd8:	4f206d6f 	c3	0x1206d6f
    3bdc:	67617463 	0x67617463
    3be0:	0a216e6f 	j	885b9bc <_gp+0x884b5ec>
    3be4:	00000000 	nop
    3be8:	3a444954 	xori	a0,s2,0x4954
    3bec:	2c642520 	sltiu	a0,v1,9504
    3bf0:	6f6f4220 	0x6f6f4220
    3bf4:	206e6974 	addi	t6,v1,26996
    3bf8:	20726527 	addi	s2,v1,25895
    3bfc:	0a2e7055 	j	8b9c154 <_gp+0x8b8bd84>
    3c00:	00000000 	nop
    3c04:	72707041 	0x72707041
    3c08:	6d69786f 	0x6d69786f
    3c0c:	20657461 	addi	a1,v1,29793
    3c10:	63617453 	0x63617453
    3c14:	30203a6b 	andi	zero,at,0x3a6b
    3c18:	2e382578 	sltiu	t8,s1,9592
    3c1c:	000a5838 	0xa5838
    3c20:	3a6f6f66 	xori	t7,s3,0x6f66
    3c24:	20642520 	addi	a0,v1,9504
    3c28:	202c6425 	addi	t4,at,25637
    3c2c:	58257830 	0x58257830
    3c30:	25783020 	addiu	t8,t3,12320
    3c34:	00000a58 	0xa58
    3c38:	20782032 	addi	t8,v1,8242
    3c3c:	73692036 	0x73692036
    3c40:	0a642520 	j	9909480 <_gp+0x98f90b0>
    3c44:	00000000 	nop
    3c48:	2f203331 	sltiu	zero,t9,13105
    3c4c:	69203220 	0x69203220
    3c50:	64252073 	0x64252073
    3c54:	0000000a 	movz	zero,zero,zero
    3c58:	68736148 	0x68736148
    3c5c:	73657420 	0x73657420
    3c60:	65722074 	0x65722074
    3c64:	746c7573 	jalx	1b1d5cc <_gp+0x1b0d1fc>
    3c68:	7830203a 	0x7830203a
    3c6c:	000a5825 	or	t3,zero,t2
    3c70:	746d6628 	jalx	1b598a0 <_gp+0x1b494d0>
    3c74:	6c756e20 	0x6c756e20
    3c78:	000a296c 	0xa296c
    3c7c:	6c756e28 	0x6c756e28
    3c80:	0000296c 	0x296c
	...
    3c90:	00001a90 	0x1a90
    3c94:	00001b48 	0x1b48
    3c98:	00001b88 	0x1b88
    3c9c:	00001b48 	0x1b48
    3ca0:	00001b48 	0x1b48
    3ca4:	00001b48 	0x1b48
    3ca8:	00001b48 	0x1b48
    3cac:	00001bc4 	0x1bc4
    3cb0:	00001b6c 	0x1b6c
    3cb4:	00001b48 	0x1b48
    3cb8:	00001b78 	0x1b78
    3cbc:	00001a84 	0x1a84
    3cc0:	00001b48 	0x1b48
    3cc4:	00001c2c 	0x1c2c
    3cc8:	00001b24 	0x1b24
    3ccc:	00001b24 	0x1b24
    3cd0:	00001b24 	0x1b24
    3cd4:	00001b24 	0x1b24
    3cd8:	00001b24 	0x1b24
    3cdc:	00001b24 	0x1b24
    3ce0:	00001b24 	0x1b24
    3ce4:	00001b24 	0x1b24
    3ce8:	00001b24 	0x1b24
    3cec:	00001b48 	0x1b48
    3cf0:	00001b48 	0x1b48
    3cf4:	00001b48 	0x1b48
    3cf8:	00001b48 	0x1b48
    3cfc:	00001b48 	0x1b48
    3d00:	00001b48 	0x1b48
    3d04:	00001b48 	0x1b48
    3d08:	00001b48 	0x1b48
    3d0c:	00001b48 	0x1b48
    3d10:	00001b48 	0x1b48
    3d14:	00001f00 	sll	v1,zero,0x1c
    3d18:	00001b48 	0x1b48
    3d1c:	00001b48 	0x1b48
    3d20:	00001b48 	0x1b48
    3d24:	00001b48 	0x1b48
    3d28:	00001b48 	0x1b48
    3d2c:	00001b48 	0x1b48
    3d30:	00001b48 	0x1b48
    3d34:	00001b48 	0x1b48
    3d38:	00001b48 	0x1b48
    3d3c:	00001b48 	0x1b48
    3d40:	00001b48 	0x1b48
    3d44:	00001b48 	0x1b48
    3d48:	00001b48 	0x1b48
    3d4c:	00001b48 	0x1b48
    3d50:	00001b48 	0x1b48
    3d54:	00001b48 	0x1b48
    3d58:	00001b48 	0x1b48
    3d5c:	00001b48 	0x1b48
    3d60:	00001b48 	0x1b48
    3d64:	000024e8 	0x24e8
    3d68:	00001b48 	0x1b48
    3d6c:	00001b48 	0x1b48
    3d70:	00001b48 	0x1b48
    3d74:	00001b48 	0x1b48
    3d78:	00001b48 	0x1b48
    3d7c:	00001b48 	0x1b48
    3d80:	00001b48 	0x1b48
    3d84:	00001b48 	0x1b48
    3d88:	00001b48 	0x1b48
    3d8c:	00001c80 	sll	v1,zero,0x12
    3d90:	00001eb0 	tge	zero,zero,0x7a
    3d94:	0000264c 	syscall	0x99
    3d98:	00001b48 	0x1b48
    3d9c:	00001b48 	0x1b48
    3da0:	00001b48 	0x1b48
    3da4:	00002074 	teq	zero,zero,0x81
    3da8:	0000264c 	syscall	0x99
    3dac:	0000208c 	syscall	0x82
    3db0:	00001b48 	0x1b48
    3db4:	00002098 	0x2098
    3db8:	00001b48 	0x1b48
    3dbc:	000020b0 	tge	zero,zero,0x82
    3dc0:	00002508 	0x2508
    3dc4:	0000221c 	0x221c
    3dc8:	00002254 	0x2254
    3dcc:	00002260 	0x2260
    3dd0:	00002280 	sll	a0,zero,0xa
    3dd4:	000024c8 	0x24c8
    3dd8:	000024d4 	0x24d4
    3ddc:	00001b48 	0x1b48
    3de0:	00001b48 	0x1b48
    3de4:	0000251c 	0x251c
    3de8:	00002660 	0x2660
    3dec:	000024fc 	0x24fc

00003df0 <hex2ascii_data>:
    3df0:	33323130 	andi	s2,t9,0x3130
    3df4:	37363534 	ori	s6,t9,0x3534
    3df8:	62613938 	0x62613938
    3dfc:	66656463 	0x66656463
    3e00:	6a696867 	0x6a696867
    3e04:	6e6d6c6b 	0x6e6d6c6b
    3e08:	7271706f 	0x7271706f
    3e0c:	76757473 	jalx	9d5d1cc <_gp+0x9d4cdfc>
    3e10:	7a797877 	0x7a797877
	...
    3e20:	59524844 	0x59524844
    3e24:	4e4f5453 	c3	0x4f5453
    3e28:	52502045 	beql	s2,s0,bf40 <_end+0x12e8>
    3e2c:	4152474f 	0x4152474f
    3e30:	53202c4d 	beqzl	t9,ef68 <_end+0x4310>
    3e34:	20454d4f 	addi	a1,v0,19791
    3e38:	49525453 	0x49525453
    3e3c:	0000474e 	0x474e
    3e40:	59524844 	0x59524844
    3e44:	4e4f5453 	c3	0x4f5453
    3e48:	52502045 	beql	s2,s0,bf60 <_end+0x1308>
    3e4c:	4152474f 	0x4152474f
    3e50:	31202c4d 	andi	zero,t1,0x2c4d
    3e54:	20545327 	addi	s4,v0,21287
    3e58:	49525453 	0x49525453
    3e5c:	0000474e 	0x474e
    3e60:	79726844 	0x79726844
    3e64:	6e6f7473 	0x6e6f7473
    3e68:	65422065 	0x65422065
    3e6c:	6d68636e 	0x6d68636e
    3e70:	2c6b7261 	sltiu	t3,v1,29281
    3e74:	72655620 	0x72655620
    3e78:	6e6f6973 	0x6e6f6973
    3e7c:	312e3220 	andi	t6,t1,0x3220
    3e80:	614c2820 	0x614c2820
    3e84:	6175676e 	0x6175676e
    3e88:	203a6567 	addi	k0,at,25959
    3e8c:	000a2943 	sra	a1,t2,0x5
    3e90:	676f7250 	0x676f7250
    3e94:	206d6172 	addi	t5,v1,24946
    3e98:	706d6f63 	0x706d6f63
    3e9c:	64656c69 	0x64656c69
    3ea0:	74697720 	jalx	1a5dc80 <_gp+0x1a4d8b0>
    3ea4:	72272068 	0x72272068
    3ea8:	73696765 	0x73696765
    3eac:	27726574 	addiu	s2,k1,25972
    3eb0:	74746120 	jalx	1d18480 <_gp+0x1d080b0>
    3eb4:	75626972 	jalx	589a5c8 <_gp+0x588a1f8>
    3eb8:	000a6574 	teq	zero,t2,0x195
    3ebc:	676f7250 	0x676f7250
    3ec0:	206d6172 	addi	t5,v1,24946
    3ec4:	706d6f63 	0x706d6f63
    3ec8:	64656c69 	0x64656c69
    3ecc:	74697720 	jalx	1a5dc80 <_gp+0x1a4d8b0>
    3ed0:	74756f68 	jalx	1d5bda0 <_gp+0x1d4b9d0>
    3ed4:	65722720 	0x65722720
    3ed8:	74736967 	jalx	1cda59c <_gp+0x1cca1cc>
    3edc:	20277265 	addi	a3,at,29285
    3ee0:	72747461 	0x72747461
    3ee4:	74756269 	jalx	1d589a4 <_gp+0x1d485d4>
    3ee8:	00000a65 	0xa65
    3eec:	63657845 	0x63657845
    3ef0:	6f697475 	0x6f697475
    3ef4:	7473206e 	jalx	1cc81b8 <_gp+0x1cb7de8>
    3ef8:	73747261 	0x73747261
    3efc:	6425202c 	0x6425202c
    3f00:	6e757220 	0x6e757220
    3f04:	68742073 	0x68742073
    3f08:	67756f72 	0x67756f72
    3f0c:	68442068 	0x68442068
    3f10:	74737972 	jalx	1cde5c8 <_gp+0x1cce1f8>
    3f14:	0a656e6f 	j	995b9bc <_gp+0x994b5ec>
    3f18:	00000000 	nop
    3f1c:	59524844 	0x59524844
    3f20:	4e4f5453 	c3	0x4f5453
    3f24:	52502045 	beql	s2,s0,c03c <_end+0x13e4>
    3f28:	4152474f 	0x4152474f
    3f2c:	32202c4d 	andi	zero,s1,0x2c4d
    3f30:	20444e27 	addi	a0,v0,20007
    3f34:	49525453 	0x49525453
    3f38:	0000474e 	0x474e
    3f3c:	59524844 	0x59524844
    3f40:	4e4f5453 	c3	0x4f5453
    3f44:	52502045 	beql	s2,s0,c05c <_end+0x1404>
    3f48:	4152474f 	0x4152474f
    3f4c:	33202c4d 	andi	zero,t9,0x2c4d
    3f50:	20445227 	addi	a0,v0,21031
    3f54:	49525453 	0x49525453
    3f58:	0000474e 	0x474e
    3f5c:	63657845 	0x63657845
    3f60:	6f697475 	0x6f697475
    3f64:	6e65206e 	0x6e65206e
    3f68:	000a7364 	0xa7364
    3f6c:	616e6946 	0x616e6946
    3f70:	6176206c 	0x6176206c
    3f74:	7365756c 	0x7365756c
    3f78:	20666f20 	addi	a2,v1,28448
    3f7c:	20656874 	addi	a1,v1,26740
    3f80:	69726176 	0x69726176
    3f84:	656c6261 	0x656c6261
    3f88:	73752073 	0x73752073
    3f8c:	69206465 	0x69206465
    3f90:	6874206e 	0x6874206e
    3f94:	65622065 	0x65622065
    3f98:	6d68636e 	0x6d68636e
    3f9c:	3a6b7261 	xori	t3,s3,0x7261
    3fa0:	0000000a 	movz	zero,zero,zero
    3fa4:	5f746e49 	0x5f746e49
    3fa8:	626f6c47 	0x626f6c47
    3fac:	2020203a 	addi	zero,at,8250
    3fb0:	20202020 	addi	zero,at,8224
    3fb4:	20202020 	addi	zero,at,8224
    3fb8:	0a642520 	j	9909480 <_gp+0x98f90b0>
    3fbc:	00000000 	nop
    3fc0:	20202020 	addi	zero,at,8224
    3fc4:	20202020 	addi	zero,at,8224
    3fc8:	756f6873 	jalx	5bda1cc <_gp+0x5bc9dfc>
    3fcc:	6220646c 	0x6220646c
    3fd0:	20203a65 	addi	zero,at,14949
    3fd4:	0a642520 	j	9909480 <_gp+0x98f90b0>
    3fd8:	00000000 	nop
    3fdc:	6c6f6f42 	0x6c6f6f42
    3fe0:	6f6c475f 	0x6f6c475f
    3fe4:	20203a62 	addi	zero,at,14946
    3fe8:	20202020 	addi	zero,at,8224
    3fec:	20202020 	addi	zero,at,8224
    3ff0:	0a642520 	j	9909480 <_gp+0x98f90b0>
    3ff4:	00000000 	nop
    3ff8:	315f6843 	andi	ra,t2,0x6843
    3ffc:	6f6c475f 	0x6f6c475f
    4000:	20203a62 	addi	zero,at,14946
    4004:	20202020 	addi	zero,at,8224
    4008:	20202020 	addi	zero,at,8224
    400c:	0a632520 	j	98c9480 <_gp+0x98b90b0>
    4010:	00000000 	nop
    4014:	20202020 	addi	zero,at,8224
    4018:	20202020 	addi	zero,at,8224
    401c:	756f6873 	jalx	5bda1cc <_gp+0x5bc9dfc>
    4020:	6220646c 	0x6220646c
    4024:	20203a65 	addi	zero,at,14949
    4028:	0a632520 	j	98c9480 <_gp+0x98b90b0>
    402c:	00000000 	nop
    4030:	325f6843 	andi	ra,s2,0x6843
    4034:	6f6c475f 	0x6f6c475f
    4038:	20203a62 	addi	zero,at,14946
    403c:	20202020 	addi	zero,at,8224
    4040:	20202020 	addi	zero,at,8224
    4044:	0a632520 	j	98c9480 <_gp+0x98b90b0>
    4048:	00000000 	nop
    404c:	5f727241 	0x5f727241
    4050:	6c475f31 	0x6c475f31
    4054:	385b626f 	xori	k1,v0,0x626f
    4058:	20203a5d 	addi	zero,at,14941
    405c:	20202020 	addi	zero,at,8224
    4060:	0a642520 	j	9909480 <_gp+0x98f90b0>
    4064:	00000000 	nop
    4068:	5f727241 	0x5f727241
    406c:	6c475f32 	0x6c475f32
    4070:	385b626f 	xori	k1,v0,0x626f
    4074:	5d375b5d 	0x5d375b5d
    4078:	2020203a 	addi	zero,at,8250
    407c:	0a642520 	j	9909480 <_gp+0x98f90b0>
    4080:	00000000 	nop
    4084:	20202020 	addi	zero,at,8224
    4088:	20202020 	addi	zero,at,8224
    408c:	756f6873 	jalx	5bda1cc <_gp+0x5bc9dfc>
    4090:	6220646c 	0x6220646c
    4094:	20203a65 	addi	zero,at,14949
    4098:	6d754e20 	0x6d754e20
    409c:	5f726562 	0x5f726562
    40a0:	525f664f 	beql	s2,ra,1d9e0 <_gp+0xd610>
    40a4:	20736e75 	addi	s3,v1,28277
    40a8:	3031202b 	andi	s1,at,0x202b
    40ac:	0000000a 	movz	zero,zero,zero
    40b0:	5f727450 	0x5f727450
    40b4:	626f6c47 	0x626f6c47
    40b8:	000a3e2d 	0xa3e2d
    40bc:	74502020 	jalx	1408080 <_gp+0x13f7cb0>
    40c0:	6f435f72 	0x6f435f72
    40c4:	203a706d 	addi	k0,at,28781
    40c8:	20202020 	addi	zero,at,8224
    40cc:	20202020 	addi	zero,at,8224
    40d0:	0a642520 	j	9909480 <_gp+0x98f90b0>
    40d4:	00000000 	nop
    40d8:	20202020 	addi	zero,at,8224
    40dc:	20202020 	addi	zero,at,8224
    40e0:	756f6873 	jalx	5bda1cc <_gp+0x5bc9dfc>
    40e4:	6220646c 	0x6220646c
    40e8:	20203a65 	addi	zero,at,14949
    40ec:	6d692820 	0x6d692820
    40f0:	6d656c70 	0x6d656c70
    40f4:	61746e65 	0x61746e65
    40f8:	6e6f6974 	0x6e6f6974
    40fc:	7065642d 	0x7065642d
    4100:	65646e65 	0x65646e65
    4104:	0a29746e 	j	8a5d1b8 <_gp+0x8a4cde8>
    4108:	00000000 	nop
    410c:	69442020 	0x69442020
    4110:	3a726373 	xori	s2,s3,0x6373
    4114:	20202020 	addi	zero,at,8224
    4118:	20202020 	addi	zero,at,8224
    411c:	20202020 	addi	zero,at,8224
    4120:	0a642520 	j	9909480 <_gp+0x98f90b0>
    4124:	00000000 	nop
    4128:	6e452020 	0x6e452020
    412c:	435f6d75 	c0	0x15f6d75
    4130:	3a706d6f 	xori	s0,s3,0x6d6f
    4134:	20202020 	addi	zero,at,8224
    4138:	20202020 	addi	zero,at,8224
    413c:	0a642520 	j	9909480 <_gp+0x98f90b0>
    4140:	00000000 	nop
    4144:	6e492020 	0x6e492020
    4148:	6f435f74 	0x6f435f74
    414c:	203a706d 	addi	k0,at,28781
    4150:	20202020 	addi	zero,at,8224
    4154:	20202020 	addi	zero,at,8224
    4158:	0a642520 	j	9909480 <_gp+0x98f90b0>
    415c:	00000000 	nop
    4160:	74532020 	jalx	14c8080 <_gp+0x14b7cb0>
    4164:	6f435f72 	0x6f435f72
    4168:	203a706d 	addi	k0,at,28781
    416c:	20202020 	addi	zero,at,8224
    4170:	20202020 	addi	zero,at,8224
    4174:	0a732520 	j	9cc9480 <_gp+0x9cb90b0>
    4178:	00000000 	nop
    417c:	20202020 	addi	zero,at,8224
    4180:	20202020 	addi	zero,at,8224
    4184:	756f6873 	jalx	5bda1cc <_gp+0x5bc9dfc>
    4188:	6220646c 	0x6220646c
    418c:	20203a65 	addi	zero,at,14949
    4190:	52484420 	beql	s2,t0,15214 <_gp+0x4e44>
    4194:	4f545359 	c3	0x1545359
    4198:	5020454e 	beqzl	at,156d4 <_gp+0x5304>
    419c:	52474f52 	beql	s2,a3,17ee8 <_gp+0x7b18>
    41a0:	202c4d41 	addi	t4,at,19777
    41a4:	454d4f53 	0x454d4f53
    41a8:	52545320 	beql	s2,s4,18e2c <_gp+0x8a5c>
    41ac:	0a474e49 	j	91d3924 <_gp+0x91c3554>
    41b0:	00000000 	nop
    41b4:	7478654e 	jalx	1e19538 <_gp+0x1e09168>
    41b8:	7274505f 	0x7274505f
    41bc:	6f6c475f 	0x6f6c475f
    41c0:	0a3e2d62 	j	8f8b588 <_gp+0x8f7b1b8>
    41c4:	00000000 	nop
    41c8:	20202020 	addi	zero,at,8224
    41cc:	20202020 	addi	zero,at,8224
    41d0:	756f6873 	jalx	5bda1cc <_gp+0x5bc9dfc>
    41d4:	6220646c 	0x6220646c
    41d8:	20203a65 	addi	zero,at,14949
    41dc:	6d692820 	0x6d692820
    41e0:	6d656c70 	0x6d656c70
    41e4:	61746e65 	0x61746e65
    41e8:	6e6f6974 	0x6e6f6974
    41ec:	7065642d 	0x7065642d
    41f0:	65646e65 	0x65646e65
    41f4:	2c29746e 	sltiu	t1,at,29806
    41f8:	6d617320 	0x6d617320
    41fc:	73612065 	0x73612065
    4200:	6f626120 	0x6f626120
    4204:	000a6576 	tne	zero,t2,0x195
    4208:	5f746e49 	0x5f746e49
    420c:	6f4c5f31 	0x6f4c5f31
    4210:	20203a63 	addi	zero,at,14947
    4214:	20202020 	addi	zero,at,8224
    4218:	20202020 	addi	zero,at,8224
    421c:	0a642520 	j	9909480 <_gp+0x98f90b0>
    4220:	00000000 	nop
    4224:	5f746e49 	0x5f746e49
    4228:	6f4c5f32 	0x6f4c5f32
    422c:	20203a63 	addi	zero,at,14947
    4230:	20202020 	addi	zero,at,8224
    4234:	20202020 	addi	zero,at,8224
    4238:	0a642520 	j	9909480 <_gp+0x98f90b0>
    423c:	00000000 	nop
    4240:	5f746e49 	0x5f746e49
    4244:	6f4c5f33 	0x6f4c5f33
    4248:	20203a63 	addi	zero,at,14947
    424c:	20202020 	addi	zero,at,8224
    4250:	20202020 	addi	zero,at,8224
    4254:	0a642520 	j	9909480 <_gp+0x98f90b0>
    4258:	00000000 	nop
    425c:	6d756e45 	0x6d756e45
    4260:	636f4c5f 	0x636f4c5f
    4264:	2020203a 	addi	zero,at,8250
    4268:	20202020 	addi	zero,at,8224
    426c:	20202020 	addi	zero,at,8224
    4270:	0a642520 	j	9909480 <_gp+0x98f90b0>
    4274:	00000000 	nop
    4278:	5f727453 	0x5f727453
    427c:	6f4c5f31 	0x6f4c5f31
    4280:	20203a63 	addi	zero,at,14947
    4284:	20202020 	addi	zero,at,8224
    4288:	20202020 	addi	zero,at,8224
    428c:	0a732520 	j	9cc9480 <_gp+0x9cb90b0>
    4290:	00000000 	nop
    4294:	20202020 	addi	zero,at,8224
    4298:	20202020 	addi	zero,at,8224
    429c:	756f6873 	jalx	5bda1cc <_gp+0x5bc9dfc>
    42a0:	6220646c 	0x6220646c
    42a4:	20203a65 	addi	zero,at,14949
    42a8:	52484420 	beql	s2,t0,1532c <_gp+0x4f5c>
    42ac:	4f545359 	c3	0x1545359
    42b0:	5020454e 	beqzl	at,157ec <_gp+0x541c>
    42b4:	52474f52 	beql	s2,a3,18000 <_gp+0x7c30>
    42b8:	202c4d41 	addi	t4,at,19777
    42bc:	54532731 	bnel	v0,s3,df84 <_end+0x332c>
    42c0:	52545320 	beql	s2,s4,18f44 <_gp+0x8b74>
    42c4:	0a474e49 	j	91d3924 <_gp+0x91c3554>
    42c8:	00000000 	nop
    42cc:	5f727453 	0x5f727453
    42d0:	6f4c5f32 	0x6f4c5f32
    42d4:	20203a63 	addi	zero,at,14947
    42d8:	20202020 	addi	zero,at,8224
    42dc:	20202020 	addi	zero,at,8224
    42e0:	0a732520 	j	9cc9480 <_gp+0x9cb90b0>
    42e4:	00000000 	nop
    42e8:	20202020 	addi	zero,at,8224
    42ec:	20202020 	addi	zero,at,8224
    42f0:	756f6873 	jalx	5bda1cc <_gp+0x5bc9dfc>
    42f4:	6220646c 	0x6220646c
    42f8:	20203a65 	addi	zero,at,14949
    42fc:	52484420 	beql	s2,t0,15380 <_gp+0x4fb0>
    4300:	4f545359 	c3	0x1545359
    4304:	5020454e 	beqzl	at,15840 <_gp+0x5470>
    4308:	52474f52 	beql	s2,a3,18054 <_gp+0x7c84>
    430c:	202c4d41 	addi	t4,at,19777
    4310:	444e2732 	0x444e2732
    4314:	52545320 	beql	s2,s4,18f98 <_gp+0x8bc8>
    4318:	0a474e49 	j	91d3924 <_gp+0x91c3554>
    431c:	00000000 	nop

Disassembly of section .reginfo:

00004320 <.reginfo>:
    4320:	fffffffe 	sdc3	$31,-2(ra)
	...
    4334:	000103d0 	0x103d0

Disassembly of section .data:

00004340 <_fdata>:
	...

00006340 <int_stack>:
	...

00008340 <helloop>:
    8340:	316c6568 	andi	t4,t3,0x6568
    8344:	7266206f 	0x7266206f
    8348:	6f206d6f 	0x6f206d6f
    834c:	646f6370 	0x646f6370
    8350:	00000065 	0x65

00008354 <helloint>:
    8354:	316c6568 	andi	t4,t3,0x6568
    8358:	7266206f 	0x7266206f
    835c:	69206d6f 	0x69206d6f
    8360:	7265746e 	0x7265746e
    8364:	74707572 	jalx	1c1d5c8 <_gp+0x1c0d1f8>
    8368:	00000000 	nop

0000836c <hello>:
    836c:	316c6568 	andi	t4,t3,0x6568
    8370:	6f77206f 	0x6f77206f
    8374:	21646c72 	addi	a0,t3,27762
    8378:	2069202c 	addi	t1,v1,8236
    837c:	646e6f77 	0x646e6f77
    8380:	69207265 	0x69207265
    8384:	68742066 	0x68742066
    8388:	63642065 	0x63642065
    838c:	65686361 	0x65686361
    8390:	6e616320 	0x6e616320
    8394:	68207427 	0x68207427
    8398:	6c646e61 	0x6c646e61
    839c:	77732065 	jalx	dcc8194 <_gp+0xdcb7dc4>
    83a0:	68637469 	0x68637469
    83a4:	20676e69 	addi	a3,v1,28265
    83a8:	73796177 	0x73796177
    83ac:	726f202c 	0x726f202c
    83b0:	61687720 	0x61687720
    83b4:	68742074 	0x68742074
    83b8:	72702065 	0x72702065
    83bc:	656c626f 	0x656c626f
    83c0:	6f63206d 	0x6f63206d
    83c4:	20646c75 	addi	a0,v1,27765
    83c8:	73736f70 	0x73736f70
    83cc:	796c6269 	0x796c6269
    83d0:	00656220 	0x656220
	...

Disassembly of section .sbss:

000083e0 <Microseconds>:
    83e0:	00000000 	nop

000083e4 <Dhrystones_Per_Second>:
    83e4:	00000000 	nop

000083e8 <User_Time>:
    83e8:	00000000 	nop

000083ec <Begin_Time>:
    83ec:	00000000 	nop

000083f0 <End_Time>:
    83f0:	00000000 	nop

000083f4 <Next_Ptr_Glob>:
    83f4:	00000000 	nop

000083f8 <Int_Glob>:
    83f8:	00000000 	nop

000083fc <Ch_1_Glob>:
	...

000083fd <Ch_2_Glob>:
    83fd:	0000      	addiu	s0,sp,0
	...

00008400 <Ptr_Glob>:
    8400:	00000000 	nop

00008404 <Bool_Glob>:
    8404:	00000000 	nop

Disassembly of section .bss:

00008410 <Reg>:
	...

00008420 <Arr_2_Glob>:
	...

0000ab30 <Glob>:
	...

0000ab60 <Next_Glob>:
	...

0000ab90 <Arr_1_Glob>:
	...

Disassembly of section .pdr:

00000000 <.pdr>:
   0:	00001500 	sll	v0,zero,0x14
	...
  18:	0000001d 	0x1d
  1c:	0000001f 	0x1f
  20:	00001524 	0x1524
	...
  38:	0000001d 	0x1d
  3c:	0000001f 	0x1f
  40:	00001538 	0x1538
  44:	80030000 	lb	v1,0(zero)
  48:	fffffffc 	sdc3	$31,-4(ra)
	...
  54:	00000028 	0x28
  58:	0000001d 	0x1d
  5c:	0000001f 	0x1f
  60:	00001580 	sll	v0,zero,0x16
	...
  78:	0000001d 	0x1d
  7c:	0000001f 	0x1f
  80:	000015bc 	0x15bc
	...
  98:	0000001d 	0x1d
  9c:	0000001f 	0x1f
  a0:	00001600 	sll	v0,zero,0x18
	...
  b8:	0000001d 	0x1d
  bc:	0000001f 	0x1f
  c0:	00001630 	tge	zero,zero,0x58
	...
  d8:	0000001d 	0x1d
  dc:	0000001f 	0x1f
  e0:	00001640 	sll	v0,zero,0x19
	...
  f8:	0000001d 	0x1d
  fc:	0000001f 	0x1f
 100:	00001650 	0x1650
 104:	80000000 	lb	zero,0(zero)
 108:	fffffffc 	sdc3	$31,-4(ra)
	...
 114:	000000a8 	0xa8
 118:	0000001d 	0x1d
 11c:	0000001f 	0x1f
 120:	00001698 	0x1698
 124:	80030000 	lb	v1,0(zero)
 128:	fffffffc 	sdc3	$31,-4(ra)
	...
 134:	00000038 	0x38
 138:	0000001d 	0x1d
 13c:	0000001f 	0x1f
 140:	000017e8 	0x17e8
	...
 158:	0000001d 	0x1d
 15c:	0000001f 	0x1f
 160:	00001824 	and	v1,zero,zero
	...
 178:	0000001d 	0x1d
 17c:	0000001f 	0x1f
 180:	00001870 	tge	zero,zero,0x61
	...
 198:	0000001d 	0x1d
 19c:	0000001f 	0x1f
 1a0:	000018f0 	tge	zero,zero,0x63
	...
 1b8:	0000001d 	0x1d
 1bc:	0000001f 	0x1f
 1c0:	00001914 	0x1914
 1c4:	c0ff0000 	ll	ra,0(a3)
 1c8:	fffffffc 	sdc3	$31,-4(ra)
	...
 1d4:	00000098 	0x98
 1d8:	0000001d 	0x1d
 1dc:	0000001f 	0x1f
 1e0:	00002c74 	teq	zero,zero,0xb1
 1e4:	80010000 	lb	at,0(zero)
 1e8:	fffffffc 	sdc3	$31,-4(ra)
	...
 1f4:	00000038 	0x38
 1f8:	0000001d 	0x1d
 1fc:	0000001f 	0x1f
 200:	00002ce0 	0x2ce0
 204:	80010000 	lb	at,0(zero)
 208:	fffffffc 	sdc3	$31,-4(ra)
	...
 214:	00000030 	tge	zero,zero
 218:	0000001d 	0x1d
 21c:	0000001f 	0x1f
 220:	00002d40 	sll	a1,zero,0x15
	...
 238:	0000001d 	0x1d
 23c:	0000001f 	0x1f
 240:	00002d94 	0x2d94
	...
 258:	0000001d 	0x1d
 25c:	0000001f 	0x1f
 260:	00002e14 	0x2e14
	...
 278:	0000001d 	0x1d
 27c:	0000001f 	0x1f
 280:	00002e40 	sll	a1,zero,0x19
 284:	80010000 	lb	at,0(zero)
 288:	fffffffc 	sdc3	$31,-4(ra)
	...
 294:	00000020 	add	zero,zero,zero
 298:	0000001d 	0x1d
 29c:	0000001f 	0x1f
 2a0:	00002e80 	sll	a1,zero,0x1a
 2a4:	80010000 	lb	at,0(zero)
 2a8:	fffffffc 	sdc3	$31,-4(ra)
	...
 2b4:	00000020 	add	zero,zero,zero
 2b8:	0000001d 	0x1d
 2bc:	0000001f 	0x1f
 2c0:	00002ecc 	syscall	0xbb
 2c4:	803f0000 	lb	ra,0(at)
 2c8:	fffffffc 	sdc3	$31,-4(ra)
	...
 2d4:	00000038 	0x38
 2d8:	0000001d 	0x1d
 2dc:	0000001f 	0x1f
 2e0:	00003010 	mfhi	a2
	...
 2f8:	0000001d 	0x1d
 2fc:	0000001f 	0x1f
 300:	00003048 	0x3048
 304:	80000000 	lb	zero,0(zero)
 308:	fffffffc 	sdc3	$31,-4(ra)
	...
 314:	00000020 	add	zero,zero,zero
 318:	0000001d 	0x1d
 31c:	0000001f 	0x1f
 320:	000030a0 	0x30a0
 324:	80030000 	lb	v1,0(zero)
 328:	fffffffc 	sdc3	$31,-4(ra)
	...
 334:	00000028 	0x28
 338:	0000001d 	0x1d
 33c:	0000001f 	0x1f
 340:	000031cc 	syscall	0xc7
	...
 358:	0000001d 	0x1d
 35c:	0000001f 	0x1f
 360:	00003208 	0x3208
	...
 378:	0000001d 	0x1d
 37c:	0000001f 	0x1f
 380:	00003224 	0x3224
 384:	c0ff0000 	ll	ra,0(a3)
 388:	fffffffc 	sdc3	$31,-4(ra)
	...
 394:	00000098 	0x98
 398:	0000001d 	0x1d
 39c:	0000001f 	0x1f
 3a0:	00003920 	0x3920
	...
 3b8:	0000001d 	0x1d
 3bc:	0000001f 	0x1f
 3c0:	00003934 	teq	zero,zero,0xe4
	...
 3d8:	0000001d 	0x1d
 3dc:	0000001f 	0x1f
 3e0:	00003a08 	0x3a08
	...
 3f8:	0000001d 	0x1d
 3fc:	0000001f 	0x1f
 400:	00003a40 	sll	a3,zero,0x9
 404:	80070000 	lb	a3,0(zero)
 408:	fffffffc 	sdc3	$31,-4(ra)
	...
 414:	00000028 	0x28
 418:	0000001d 	0x1d
 41c:	0000001f 	0x1f
 420:	00003ae0 	0x3ae0
	...
 438:	0000001d 	0x1d
 43c:	0000001f 	0x1f
 440:	00003af0 	tge	zero,zero,0xeb
 444:	80030000 	lb	v1,0(zero)
 448:	fffffffc 	sdc3	$31,-4(ra)
	...
 454:	00000028 	0x28
 458:	0000001d 	0x1d
 45c:	0000001f 	0x1f

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	xori	v1,s2,0x4347
   4:	65442820 	0x65442820
   8:	6e616962 	0x6e616962
   c:	372e3420 	ori	t6,t9,0x3420
  10:	342d322e 	ori	t5,at,0x322e
  14:	2e342029 	sltiu	s4,s1,8233
  18:	00322e37 	0x322e37

Disassembly of section .gnu.attributes:

00000000 <.gnu.attributes>:
   0:	00000f41 	0xf41
   4:	756e6700 	jalx	5b99c00 <_gp+0x5b89830>
   8:	00070100 	sll	zero,a3,0x4
   c:	03040000 	0x3040000
