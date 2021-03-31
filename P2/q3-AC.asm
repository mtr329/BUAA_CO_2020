.data
	m1:	.space 500
	m2:	.space 500
	m3:	.space 500
	space: .asciiz " "
	jumpline: .asciiz "\n"
#
.macro set(%which, %i, %j, %ans, %t)
	mul %t, %i, 11
	add %t, %t, %j
	sll %t, %t, 2
	sw %ans, %which(%t)
.end_macro
#
.macro get(%which, %i, %j, %ans)
	mul %ans, %i, 11
	add %ans, %ans, %j
	sll %ans, %ans, 2
	lw %ans, %which(%ans)
.end_macro
#
.macro readInt(%ans)
	li $v0, 5
	syscall
	move %ans, $v0
.end_macro
#
.macro printInt(%ans)
	li $v0, 1
	move $a0, %ans
	syscall
.end_macro
#
.macro printSpace()
	li $v0, 4
	la $a0, space
	syscall
.end_macro
#
.macro printJL()
	li $v0, 4
	la $a0, jumpline
	syscall
.end_macro
#
.text
	readInt($s0)			#s0 = m1
	readInt($s1)			#s1 = n1
	readInt($s2)			#s2 = m2
	readInt($s3)			#s3 = n2
	##clear
	li $t0, 0
	loop_1:
		bge $t0, $s0, loop_1_end
		li $t1, 0
		loop_2:
			bge $t1, $s1, loop_2_end
				readInt($t2)
				set(m1, $t0, $t1, $t2, $t3)
			addi $t1, $t1, 1
			j loop_2
		loop_2_end:
		addi $t0, $t0, 1
		j loop_1
	loop_1_end:
	
	li $t0, 0
	loop_3:
		bge $t0, $s2, loop_3_end
		li $t1, 0
		loop_4:
			bge $t1, $s3, loop_4_end
				readInt($t2)
				set(m2, $t0, $t1, $t2, $t3)
			addi $t1, $t1, 1
			j loop_4
		loop_4_end:
		addi $t0, $t0, 1
		j loop_3
	loop_3_end:
	#
	#cal
	sub $s4, $s0, $s2
	addi $s4, $s4, 1
	sub $s5, $s1, $s3
	addi $s5, $s5, 1
	#s0 = m1
	#s1 = n1
	#s2 = m2
	#s3 = n2
	#s4 = m1 - m2 + 1
	#s5 = n1 - n2 + 1
	
	li $t0, 0
	cal_1:
		bge $t0, $s4, cal_1_end
		li $t1, 0
		cal_2:
			bge $t1, $s5, cal_2_end
			li $t2, 0		#m3[t0][t1] = t2
			#
			li $t3, 0
			cal_3:
				bge $t3, $s2, cal_3_end
				li $t4, 0
				cal_4:
					bge $t4, $s3, cal_4_end
					#m2[t3][t4]
					add $t5, $t0, $t3
					add $t6, $t1, $t4
					#m1[t5][t6]
					get(m2, $t3, $t4, $t7)
					get(m1, $t5, $t6, $t8)
					
					mul $t7, $t7, $t8
					add $t2, $t2, $t7
					
					addi $t4, $t4, 1
					j cal_4
				cal_4_end:
				addi $t3, $t3, 1
				j cal_3
			cal_3_end:
			#
			set(m3, $t0, $t1, $t2, $t9)
			addi $t1, $t1, 1
			j cal_2
		cal_2_end:
		addi $t0, $t0, 1
		j cal_1
	cal_1_end:
	#
	#print
	li $t0, 0
	print_1:
		bge $t0, $s4, print_1_end
		li $t1, 0
		print_2:
			bge $t1, $s5, print_2_end
			get(m3, $t0, $t1, $t2)
			printInt($t2)
			printSpace()
			addi $t1, $t1, 1
			j print_2
		print_2_end:
		printJL()
		addi $t0, $t0, 1
		j print_1
	print_1_end:
	
	li $v0, 10
	syscall
	
	
	
