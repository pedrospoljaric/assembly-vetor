.data
	print1: .asciiz "Digite o tamanho do array X : "
	print2: .asciiz "Digite os valores inteiros para o array: "
	print3: .asciiz " O valor mínimo é: "
	print4: .asciiz " O valor máximo é: "
.text
	li 	$v0, 4		# Digite o tamanho do array X :
	la 	$a0, print1
	syscall
		
	li 	$v0, 5		# read
	syscall
	
	move	$t0, $v0
	beqz	$t0, END2		
	mul 	$s0, $t0, 4
	move  	$a0, $s0	# a0 = s0 = 4*t0 (4 bytes = int)
	
	li	$v0, 9		# alocar a0 bytes em v0
	syscall
	
	move	$s1, $v0	# s1 = v0[0]
	
	li 	$v0, 4		# Digite os valores inteiros para o array: 
	la 	$a0, print2
	syscall
	
	li	$t1, 0
	
	FOR: # preencher vetor
		
		slt	$t2, $t1, $s0		# for t1 = 0; t1 < s0, t1 += 4
		beqz	$t2, END
		
		li	$v0, 5			# read
		syscall
		
		add	$t3, $s1, $t1		# t3 = &s + t1 (t1 = 4 * i)
		sb	$v0, 0($t3)		# *t3 = read
		
		addi	$t1, $t1, 4		# t1 = t1 + 4
		j    	FOR
	END:
	
	lb	$s2, 0($s1)		# s2 = X[0]
	move	$s3, $s2		# s3 = s2
	li	$t1, 4			# t1 = 4
	
	FOR2: # percorrer vetor
		slt	$t2, $t1, $s0		# for t1 = 0; t1 < s0, t1 += 4
		beqz	$t2, END2
		
		add	$t3, $s1, $t1		# t3 = &s + t1 (t1 = 4 * i)
		lb	$t4, 0($t3)		# t4 = *t3
		
		IF:
			slt	$t5, $s2, $t4
			beqz	$t5, ELSEIF		# if t4 > s2
			move  	$s2, $t4		# s2 = t4
		ELSEIF:
			slt	$t5, $t4, $s3
			beqz	$t5, ELSE		# else if t4 < s3
			move  	$s3, $t4		# s3 = t4
		ELSE: 
				
		addi	$t1, $t1, 4		# t1 = t1 + 4
		j     FOR2			# goto FOR
	END2:
	
	li 	$v0, 4			# O valor mínimo é:
	la 	$a0, print3
	syscall
	li	$v0, 1			# print s3 (min)
	move	$a0, $s3
	syscall
	
	li 	$v0, 4			# O valor máximo é:
	la 	$a0, print4
	syscall
	li	$v0, 1			# print s2 (max)
	move	$a0, $s2
	syscall