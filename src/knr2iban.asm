.data
	.globl knr2iban
	.text
# -- knr2iban
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
knr2iban:
	# TODO
	
	move $t0 $a0 #move the buffer to t0 to allow incrementing 
	
	li $t5 68 #load 'D'
	sb $t5 ($t0)  #store in buffer
	addi $t0 $t0 1   #to store in next soace
	
	li $t5 69 # 'E'
	sb $t5 ($t0)  
	addi $t0 $t0 1 
	
	li $t5 48 #'0'
	sb $t5 ($t0)   
	addi $t0 $t0 1 
	
	li $t5 48 #'0'
	sb $t5 ($t0)  
	addi $t0 $t0 1 
	
	li $t2 0 # counter for the loop of the blz and knr 

	#store blz and knr in temp registers
	move $t7 $a1 
	move $t8 $a2 
	
	
	loop_BLZ_filling:
	lb $s1 ($t7) #loading the byte from the BLZ buffer into IBAN buffer
	sb $s1 ($t0) #store it
	
	addiu $t0 $t0 1 #increment the address
	
	addiu $t2 $t2 1 # increment the counter
	
	addiu $t7 $t7 1 #increment BLZ 
	bne $t2 8 loop_BLZ_filling
	
	
	#same logic for t8 (KNR)
	loop_KNR_filling:
	lb $s2 ($t8)
	sb $s2 ($t0)
	
	addiu $t0 $t0 1
	
	addiu $t2 $t2 1
	
	addiu $t8 $t8 1 #increment KN
	bne $t2 22 loop_KNR_filling  
	
	  
	
	#make space in stack pointer to store return address and arguments
	add $sp $sp -24
	
	  

	
	sw $ra 0($sp) 
	sw $a0 4($sp)
	sw $a1 8($sp) 
	sw $a2 12($sp) 
	
	
	jal validate_checksum  
	
	#reload everything
	 
	lw $ra 0($sp) 
	lw $a0 4($sp)
	lw $a1 8($sp) 
	lw $a2 12($sp) 
	
	
	addiu $sp $sp 24 #retrievce space
	
	
	
	
	
	
	
	li $t2 98
	sub $t2 $t2 $v0   #sub the result of validateChecksum from 98 
	
	
	
	
	
	 
		addi $t5, $a0, 2 # get 2nd index
		addi $t6, $a0, 3 # get 3rd index
		
		#get msb and lsb
		div $t8 $t2 10   
		rem $t9 $t2 10  
		
		#convert to char
		addiu $t8 $t8 48  
		
		#store char in target buffer
	 	sb $t8 ($t5) 
	
		#smae logic for lsb
		addiu $t9 $t9 48 
		
		
	 	sb $t9 ($t6)
	
	 	
	 	
		
	jr	$ra 
	
	
	
	
