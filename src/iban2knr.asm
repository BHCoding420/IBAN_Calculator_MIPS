	.data
	.globl iban2knr
	.text
# -- iban2knr
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
iban2knr:
    # save the arguments in temporary variables
    la $t0, 4($a0)    # start at 4th character so we satrt at BLZ
    
    # create a temporary counter
    li   $t3, 8      # initialize the counter to 8
    li 	 $t4, 10	#initialize counter to 10 for knr

    iban2blz_loop:
        
        lb $s0, ($t0) # extract the character pointed at by t0 
        sb $s0, ($a1) # store the char into BLZ buffer a1
        
        addi $t0, $t0, 1 #increment the buffer so we retrieve the next element in next iter 
        addi $a1 $a1 1 #increment the result BLZ index so we add the next element at the next index
        
        
        # increment counter
        addi $t3, $t3, -1

        # check if counter has reached 0
        bnez $t3 iban2blz_loop

    # end of loop 
    
    
    la $t5, 12($a0)
    
    iban2knr_loop:
        
        lb $s1, ($t5) # extract the character pointed at by t0 
        sb $s1, ($a2) # store the char into BLZ buffer a
        
        addi $t5 $t5 1 #increment the buffer so we retrieve the next element in next iter 
        addi $a2 $a2 1 #increment the result BLZ index so we add the next element at the next index
        
        
        # increment counter
        addi $t4, $t4, -1

        # check if counter has reached 0
        bnez $t4 iban2knr_loop

    # end of loop


    
    jr   $ra                # return to caller 
    
    
    
    
    
    

