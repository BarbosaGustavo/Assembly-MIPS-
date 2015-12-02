######################################################################################
###### Código feito em Assembly utilizando o simulador MARS do MIPS ##################
######################################################################################
###### Trata-se de um contador de uma cadeia de bits, ou seja, dado uma string com ###
###### 0s e 1s é retornado a quantidade total de bits, a quantidade de 0s e a quan ###
###### tidade de 1s. #################################################################
######################################################################################
###### Autor: Gustavo Barbosa Barreto ########################################################
######################################################################################
.data 
vet: .space 20 # Tamanho da String
print: .asciiz "Entre com a cadeia de bits:" 
Pqtdn: .asciiz "i) Quantidade total de bits = "
Pqtd1: .asciiz "ii) Quantidade de bits 1 = "
Pqtd0: .asciiz "iii) Quantidade de bits 0 = "
Pline: .asciiz "\n"   

.text
main:  
  #IMPRIME A MENSAGEM INICIAL PARA ENTRADA DA CADEIA DE BITS
    la $a0,print  #Carrega a0 com a mensagem de print  
    li $v0,4    #carrega v0 com o codigo de impressao de string (4)
    syscall	# dispara a impressao

  #FAZ A LEITURA DA CADEIA DE BITS 
    la $a0,vet  # carrega a0 com o endereço da string  
    li $a1,20   # carrega a1 com o tamanho da string
    li $v0,8    # carrega v0 com o codigo de leitura de string (8)
    syscall	# dispara a leitura
    beq $a0,0,Exit #TESTA SE FOI DIGITADO ALGO   
       
#######  A PARTIR DE AGORA SÃO FEITOS OS SEGUINTES TESTES: ####### 	   	
  	#TAMANHO DA CADEIA DE BITS
  	jal tamanho #tamanho da cadeia de bits será salvo em $t0
  	
  	li $s0,0 #contador de 0
  	li $s1,0 #contador de 1
  	
  	add $t3,$zero,$t0 #Copia o tamanho da cadeia para $t3
  	la $t4,vet #carrega $t4 com o endereço da string

#### Este loop é executado até que $t3 seja 0, ou seja, até que termine a cadeia de bits. ###
loop: 	beq $t3,0,impressao #Testa se o tamanho da string é 0
	lb $t1,0($t4)	#Carrega $t1 com o primeiro caractere
			
	beq $t1,49,Soma1 # Testa se o caractere é 1
	beq $t1,48,Soma0 #Testa se o caractere é 0

Soma1:
	addi $s1,$s1,1 #Soma 1 no contador
	j continua #Pula para continua

Soma0:
	addi $s0,$s0,1 #]Soma 1 no contador 
	j continua #Pula para continua
	
continua:
	addi $t4,$t4,1 #Soma 1 em $t4 (Pula para o proximo Byte que contem o proximo caractere)
	addi $t3,$t3,-1	#Subtrai um em $t3

j loop # inicia novamente o loop

### Aqui é feita a contagem da cadeia de bits ###	  	
tamanho:
	la $a0,vet # SALVA O ENDEREÇO DO VETOR EM $a0
	li $t0, 0 # INICIALIZA O CONTADOR COM 0
	
	loop2:
	lb $t1, 0($a0) # CARREGA O PRIMEIRO CARACTERE EM $t1
	beq $t1,10,exit #  TESTA SE O CARACTERE É UMA QUEBRA DE LINHA
	addi $a0, $a0, 1 # INCREMENTA UMA POSIÇÃO EM $a0
	addi $t0, $t0, 1 # INCREMENTA O CONTADOR
	j loop2 # RETORNA AO LOOP2
	exit:
	jr $ra
#################################################

 ####### IMPRIME OS DADOS COLETADOS #######   
impressao:

##### IMPRIME O TAMANHO DA CADEIA DE BITS DIGITADA #####	
    	la $a0,Pqtdn # Carrega $a0 com a String Pqtdn
    	li $v0,4
    	syscall
    	la $a0,($t0) # arrega $a0 com a quantidade de bits
    	li $v0,1
    	syscall
    	la $a0,Pline #Carrega $ao com a quebra de linha
    	li $v0,4
    	syscall    

##### IMPRIME A QUANTIDADE DE BITS 1 #####   
    	la $a0,Pqtd1 # Carrega $a0 com a String Pqtd1
    	li $v0,4
    	syscall
    	la $a0,($s1) # arrega $a0 com a quantidade de bits 1
    	li $v0,1
    	syscall 
    	la $a0,Pline #Carrega $ao com a quebra de linha
    	li $v0,4
    	syscall  

##### IMPRIME A QUANTIDADE DE BITS 0 #####   	 
      	la $a0,Pqtd0 # Carrega $a0 com a String Pqtd0
    	li $v0,4
    	syscall
    	la $a0,($s0) # arrega $a0 com a quantidade de bits 0
    	li $v0,1
    	syscall
    	la $a0,Pline #Carrega $ao com a quebra de linha
    	li $v0,4
    	syscall 
    	
j Exit #PULA PARA O FIM DO PROGRAMA    
	
Exit: # finaliza o programa
        li $v0,10   # finaliza o programa com o codigo 10
        syscall
