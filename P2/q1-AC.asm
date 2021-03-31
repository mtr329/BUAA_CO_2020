.data
	m1:	.space 260
	m2:	.space 260
	m3: .space 260
	jumpline: .asciiz "\n"
	space: .asciiz " "
.macro get(%which, %i, %j, %ans)
	sll %ans, %i, 3
	add %ans, %ans, %j
	sll %ans, %ans, 2
	lw %ans, %which(%ans)
.end_macro
.macro set(%which, %i, %j, %num, %t)
	sll %t, %i, 3
	add %t, %t, %j
	sll %t, %t, 2
	sw %num, %which(%t)
.end_macro
.text
	li $v0, 5
	syscall
	move $s0, $v0	#s0 = n
	
	li $t0, 0		#load the first matrix
	loop1:			
		bge $t0, $s0, loop1_end 
		li $t1, 0
		loop2:
			bge $t1, $s0, loop2_end
			li $v0, 5
			syscall
			set(m1, $t0, $t1, $v0, $t2)
			addi $t1, $t1, 1
			j loop2
		loop2_end:
		addi $t0, $t0, 1
		j loop1
	loop1_end:
	
	li $t0, 0		#load the second matrix
	loop3:			
		bge $t0, $s0, loop3_end 
		li $t1, 0
		loop4:
			bge $t1, $s0, loop4_end
			li $v0, 5
			syscall
			set(m2, $t0, $t1, $v0, $t2)
			addi $t1, $t1, 1
			j loop4
		loop4_end:
		addi $t0, $t0, 1
		j loop3
	loop3_end:
	
	li $t0, 0
	loop_cal1:			#calculate
		bge $t0, $s0, loop_cal1_end
		li $t1, 0
		loop_cal2:
			bge $t1, $s0, loop_cal2_end
				li $t3, 0
				li $t2, 0
				loop_cal3:
					bge $t2, $s0, loop_cal3_end
						get(m1, $t0, $t2, $t4)
						get(m2, $t2, $t1, $t5)
						mul $t6, $t4, $t5
						add $t3, $t3, $t6
					addi $t2, $t2, 1
					j loop_cal3
				loop_cal3_end:
				set(m3, $t0, $t1, $t3, $t9)
			addi $t1, $t1, 1
			j loop_cal2
		loop_cal2_end:
		addi $t0, $t0, 1
		j loop_cal1
	loop_cal1_end:
	
	li $t0, 0			#print
	loop_print:
		bge $t0, $s0, loop_print_end
		li $t1, 0
		loop_print2:
			bge $t1, $s0, loop_print2_end
			li $v0, 1
			get(m3, $t0, $t1, $a0)
			syscall
			la $a0, space
			li $v0, 4
			syscall
			addi $t1, $t1, 1
			j loop_print2
		loop_print2_end:
		la $a0, jumpline
		li $v0, 4
		syscall
		addi $t0, $t0, 1
		j loop_print
	loop_print_end:
	li $v0, 10
	syscall
