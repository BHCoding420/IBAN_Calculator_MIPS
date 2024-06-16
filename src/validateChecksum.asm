.data
		buffer: .space 24
	.globl validate_checksum
	.text

# -- validate_checksum --
# Arguments:
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# v0 : the checksum of the IBAN
validate_checksum:
	
	
	# TODO 
	la $t0 4($a0) # skip DE68 
	
	la $t1 buffer # pointer to buffer
	
	li $t3 0 #counter for the loop																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													
	
	
	loop_after4:
	lb $s1 ($t0) #extract digit  from the IBAN
	
	sb $s1 ($t1) # store current digit in  =buffer
	addiu $t0 $t0 1 # increment to next digit
	addiu $t1 $t1 1 # increment to next index in target  buffer 
	addiu $t3 $t3 1 # inc to next counter 
	
	bne $t3 18 loop_after4
	
	
	li $t3 2 #reinitialize counter for 2nd loop (OBLY DE)
	la $t0 ($a0) #reload the IBAN FROM start to access the DE68 thingy 
	
	loopfirst2elements:
	lb $s0 ($t0) #extract D,E 
	move $t4 $s0 #put D,E in temp
	addiu $t4 $t4 -55 #convertion from ascii letter to integers 
	
	rem $s0 $t4 10 # calculating the remainder (lsb) 
	div $s1 $t4 10 #get next digit (msb)
	
	addi $s1 $s1 48
	sb $s1 ($t1)
	addi $t1 $t1 1
	
	addi $s0 $s0 48
	sb $s0 ($t1)
	addi $t1 $t1 1
	
	addi $t0 $t0 1 #get to next char of IBAN (from D to E)
	
	addi $t3 $t3 -1
	bnez $t3 loopfirst2elements
	
	
	la $t5 2($a0) #access 2nd index in IBAN,the lement after DE
	
	lb $s0 ($t5) # load the digit at 2nd index into s0
	sb $s0 ($t1) #store that digit in the buffer
	
	addi $t1 $t1 1 #buffer++
	addi $t5 $t5 1 #next digit for extractinmg
	 
	
	lb $s0 ($t5) #same logic
	sb $s0 ($t1)
	
 
	
	
	#load the arguments to be used for modulo_str
	la $a0 buffer
	li $a1 24
	li $a2 97  
	
	#store ra in memory to return to it
	addi $sp $sp -4
	sw  $ra 0($sp) 
	
	jal modulo_str

	#load back the return address
	lw $ra 0($sp) 
	addi $sp $sp 4
	
	
	
	
	jr	$ra
