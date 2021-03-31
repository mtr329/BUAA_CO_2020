.data
	stack: .space 1024
	array: .space 32
	check: .space 32
	space: .asciiz " "
	jumpline: .asciiz "\n"
#
.macro print(%last, %t1, %t2)
	li %t1, 0
	print_loop:
		bgt %t1, %last, print_loop_end
		sll %t2, %t1, 2
		li $v0, 1
		lw $a0, array(%t2)
		syscall
		li $v0, 4
		la $a0, space
		syscall
		addi %t1, %t1, 1
		j print_loop
	print_loop_end:
	li $v0, 4
	la $a0, jumpline
	syscall
.end_macro
#
.macro set(%which, %ans, %i, %t)
	sll %t, %i, 2
	sw %ans, %which(%t)
.end_macro
#
.macro get(%which, %ans, %i)
	sll %ans, %i, 2
	lw %ans, %which(%ans)
.end_macro
#
.text
	main:
		li $v0, 5
		syscall
		move $s0, $v0	#n = s0
		li $t0, 0
		main_1:
			bge $t0, $s0, main_1_end
			addi $t1, $t0, 1
			set(array, $t1, $t0, $t2)
			set(check, $0, $t0, $t2)
			addi $t0, $t0, 1
			j main_1
		main_1_end:
		addi $s1, $s0, -1
		move $a0, $0
		move $a1, $s1
		jal fp
		
		li $v0, 10
		syscall
	main_end:
#
	fp:
		addi $sp, $sp, -36
		sw $a0, 32($sp)
		sw $a1, 28($sp)
		sw $s0, 24($sp)
		sw $s1, 20($sp)
		sw $t0, 16($sp)
		sw $t1, 12($sp)
		sw $t2, 8($sp)
		sw $t3, 4($sp)
		sw $ra, 0($sp)
		#sw
		move $s0, $a0
		move $s1, $a1
		fp_if_1:
			ble $s0, $s1, fp_if_1_end
			print($s1, $t4, $t5)
			j fp_end
		fp_if_1_end:
		#[s0,s1]
		li $t0, 0
		fp_for:
			bgt $t0, $s1, fp_for_end
			get(check, $t1, $t0)
			fp_if_2:
				bnez $t1, fp_if_2_end
				addi $t1, $t0, 1
				set(array, $t1, $s0, $t2)
				li $t2, 1
				set(check, $t2, $t0, $t3)
				addi $a0, $s0, 1
				move $a1, $s1
				jal fp
				set(check, $0, $t0, $t3)
			fp_if_2_end:
			addi $t0, $t0, 1
			j fp_for
		fp_for_end:
	fp_end:	
	lw $ra, 0($sp)
	lw $t3, 4($sp)
	lw $t2, 8($sp)
	lw $t1, 12($sp)
	lw $t0, 16($sp)
	lw $s1, 20($sp)
	lw $s0, 24($sp)
	lw $a1, 28($sp)
	lw $a0, 32($sp)
	addi $sp, $sp, 36
	jr $ra
	
	
