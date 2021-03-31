.data
	string: .space 100
	space: .asciiz " "
.macro print(%ans)
	li $v0, 1
	move $a0, %ans
	syscall
.end_macro
.macro printSpace()
	li $v0, 4
	la $a0, space
	syscall
.end_macro
.text
	li $v0, 5
	syscall
	move $s0, $v0	#s0 = length
	li $t0, 0
	loop_0:
		bge $t0, $s0, loop_0_end
		li $v0, 12
		syscall
		sb $v0, string($t0)
		addi $t0, $t0, 1
		j loop_0
	loop_0_end:
	
	la $s1, string	#s1 = string[0]
	
	li $s2, 1		#s2 = ans
	li $t0, 0
	loop_1:
		bge $t0, $s0, loop_1_end
		lb $t1, 0($t0)
		sub $t2, $s0, $t0
		addi $t2, $t2, -1
		#sll $t2, $t2, 2
		add $t2, $s1, $t2
		lb $t2, 0($t2)
		#
		#print($t1)
		#print($t2)
		#printSpace()
		#
		beq $t1, $t2, if_1_end
		if_1:
			li $s2, 0
		if_1_end:
		addi $t0, $t0, 1
		j loop_1
	loop_1_end:
	li $v0, 1
	move $a0, $s2
	syscall
	li $v0, 10
	syscall