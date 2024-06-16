	.data
	.globl main
numberstr:
	.asciiz "65539" 
numberstr2:
	.asciiz "34123" 
numberstr3:
	.asciiz "725753" 
numberstr4:
	.asciiz "413746471724057190131442"
	.text 

	
	
main: 
	la	$a0 numberstr
	li	$a1 5
	la	$a2 8
	jal	modulo_str
	move	$a0 $v0
	li	$v0 1
	syscall 
	
	
	# Print a line break
li $v0, 11         # Load the service code for printing a character
li $a0, 0x0A       # Load the ASCII value for a line feed character
syscall            # Call the operating system to print the character

	
	
	
	la	$a0 numberstr2
	li	$a1 5
	la	$a2 5
	jal	modulo_str
	move	$a0 $v0
	li	$v0 1
	syscall
	
		# Print a line break
li $v0, 11         # Load the service code for printing a character
li $a0, 0x0A       # Load the ASCII value for a line feed character
syscall            # Call the operating system to print the character 

	la	$a0 numberstr3
	li	$a1 6
	la	$a2 13
	jal	modulo_str
	move	$a0 $v0
	li	$v0 1
	syscall
	
	li $v0, 11         # Load the service code for printing a character
li $a0, 0x0A       # Load the ASCII value for a line feed character
syscall            # Call the operating system to print the character 

	la	$a0 numberstr4
	li	$a1 24
	la	$a2 97
	jal	modulo_str
	move	$a0 $v0
	li	$v0 1
	syscall
	
	
	li	$v0 10
	syscall
