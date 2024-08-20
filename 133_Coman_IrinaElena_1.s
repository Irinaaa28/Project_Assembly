.data
	m: .space 4
	n: .space 4
	p: .space 4
	mbord: .space 4
	nbord: .space 4
	mbnb: .space 4
	count: .space 4
	matrix: .space 1600
	lineIndex: .space 4
	columnIndex:.space 4
	x: .space 4
	y: .space 4
	k: .space 4
	countk: .space 4
	matrixk: .space 1600
	sumvec: .space 4
	const: .space 4
	test: .space 4
	mesaj: .space 10
	codmat: .space 1600
	i: .space 4
	pozm : .space 4
	aux: .space 40
	cnt: .space 4
	poz: .space 4
	zero: .long 0
	codmesaj: .space 1600
	cript: .space 1600
	sum: .space 4
	cod: .space 400
	coddecriptat: .space 400
	lencoddec: .long 0
	nr: .long 0
	mesaj2: .space 400
	pozmf: .long 0
	nr_ascii: .space 4
	formatScanf: .asciz "%ld"
	formatScanf2: .asciz "%ld %ld"
	formatScanf3: .asciz "%ld %ld %ld"
	formatScanfstr: .asciz "%s"
	formatPrintf: .asciz "%ld"
	formatPrintfstr: .asciz "%c"
	newline: .asciz "\n"
	
.text
.global main

main:
	pusha
	pushl $p
	pushl $n
	pushl $m
	pushl $formatScanf3
	call scanf
	popl %ebx
	popl %ebx
	popl %ebx
	popl %ebx
	popa
	
	movl m, %eax
	addl $2, %eax
	movl %eax, mbord
	movl n, %eax
	addl $2, %eax
	movl %eax, nbord
	
	movl mbord, %eax
	movl $0, %edx
	mull nbord
	movl %eax, mbnb
	
	movl $0, lineIndex
	movl $0, count
	lea matrix, %edi
	
for_lines:
	movl lineIndex, %ecx
	cmp %ecx, mbord
	je citire_matrice
	movl $0, columnIndex
	for_columns:
		movl columnIndex, %ecx
		cmp %ecx, nbord
		je cont_for_lines
		
		movl lineIndex, %eax
		movl $0, %edx
		mull nbord
		addl columnIndex, %eax
		movl $0, (%edi, %eax, 4)
		movl (%edi, %eax, 4), %ebx
		
		incl columnIndex
		jmp for_columns

cont_for_lines:
	
	addl $1, lineIndex
	jmp for_lines
	
citire_matrice:
	movl count, %ecx
	cmp %ecx, p
	je cont_main1
	
	pusha
	pushl $y
	pushl $x
	pushl $formatScanf2
	call scanf
	popl %ebx
	popl %ebx
	popl %ebx
	popa
	
	movl x, %eax
	addl $1, %eax
	movl $0, %edx
	mull nbord
	addl y, %eax
	add $1, %eax
	movl $1, (%edi, %eax, 4)
	
	add $1, count
	jmp citire_matrice
	
cont_main1:
	pusha
	pushl $k
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	popa
	
	movl $0, countk
	movl $0, lineIndex
	lea matrixk, %esi
	
for_lines_k:
	movl lineIndex, %ecx
	cmp %ecx, mbord
	je k_evolutii
	movl $0, columnIndex
	for_columns_k:
		movl columnIndex, %ecx
		cmp %ecx, nbord
		je cont_for_lines_k
		
		movl lineIndex, %eax
		movl $0, %edx
		mull nbord
		addl columnIndex, %eax
		movl $0, (%esi, %eax, 4)
		
		incl columnIndex
		jmp for_columns_k

cont_for_lines_k:
	addl $1, lineIndex
	jmp for_lines_k
	
k_evolutii:
	movl countk, %ecx
	cmp %ecx, k
	je codulmatricii
	movl $1, lineIndex
	for_lkev:
		mov lineIndex, %ecx
		cmp %ecx, m
		jl cont_k_evolutii
		movl $1, columnIndex
		for_ckev:
			movl columnIndex, %ecx
			cmp %ecx, n
			jl cont_for_lkev
			movl $0, sumvec
			
			movl lineIndex, %eax
			subl $1, %eax
			movl $0, %edx
			movl $0, %ebx
			mull nbord
			addl columnIndex, %eax
			subl $1, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sumvec
			addl $1, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sumvec
			addl $1, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sumvec
			
			movl lineIndex, %eax
			movl $0, %edx
			mull nbord
			add columnIndex, %eax
			sub $1, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sumvec
			addl $2, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sumvec
			
			movl lineIndex, %eax
			addl $1, %eax
			movl $0, %edx
			mull nbord
			addl columnIndex, %eax
			subl $1, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sumvec
			addl $1, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sumvec
			addl $1, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sumvec
			
			movl lineIndex, %eax
			movl $0, %edx
			mull nbord
			addl columnIndex, %eax
			movl (%edi, %eax, 4), %ebx
			movl $1, const
			cmp %ebx, const
			je caz123
			movl $1, const
			cmp %ebx, const
			jne caz45
			
		cont_for_ckev:	
			movl $0, %edx
			addl $1, columnIndex
			jmp for_ckev
			
	cont_for_lkev:
		addl $1, lineIndex
		jmp for_lkev
		
	cont_k_evolutii:
		movl $1, lineIndex
		for_mutarel:
			movl lineIndex, %ecx
			cmp %ecx, m
			jl cont_k_evolutii1
			movl $1, columnIndex
			for_mutarec:
				movl columnIndex, %ecx
				cmp %ecx, n
				jl cont_for_mutarel
				movl lineIndex, %eax
				movl $0, %edx
				mull nbord
				addl columnIndex, %eax
				movl (%esi, %eax, 4), %ebx
				movl %ebx, (%edi, %eax, 4)
				
				addl $1, columnIndex
				jmp for_mutarec
			
		cont_for_mutarel:
			add $1, lineIndex
			jmp for_mutarel		

caz123:
	movl $2, const
	movl sumvec, %edx
	cmp %edx, const
	jg pun0
	
	cmp %edx, const
	je pun1
	
	movl $3, const
	cmp %edx, const
	je pun1
	
	cmp %edx, const
	jl pun0
	
caz45:
	movl $3, const
	movl sumvec, %edx
	cmp %edx, const
	je pun1
	
	cmp %edx, const
	jne pun0
	
pun0:
	movl $0, (%esi, %eax, 4)
	jmp cont_for_ckev
	
pun1:
	movl $1, (%esi, %eax, 4)
	jmp cont_for_ckev
			
cont_k_evolutii1:
	addl $1, countk
	jmp k_evolutii	
	
codulmatricii:
	lea codmat, %esi
	movl $1, count
	for_codmat:
		movl count, %ecx
		cmp %ecx, mbnb
		jl cont_main2
		subl $1, %ecx
		movl (%edi, %ecx, 4), %ebx
		addl $1, %ecx
		movl %ebx, (%esi, %ecx, 4)
		
		addl $1, count
		jmp for_codmat

cont_main2:	
	pusha
	pushl $test
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	popa
	
	movl $0, %eax
	cmp %eax, test
	je criptare
	
	movl $0, %eax
	cmp %eax, test
	jne decriptare
	
criptare:
	pusha 
	push $mesaj
	push $formatScanfstr
	call scanf
	popl %ebx
	popl %ebx
	popa
	
	lea mesaj, %esi
	movl $0, i
	movl $1, pozm
	for_mesaj:
		lea mesaj, %esi
		movl i, %ecx
		movl $0, %ebx
		mov (%esi, %ecx, 1), %bl 
		cmp %bl, zero
		je cont_criptare
		lea aux, %edi
		movl $8, k
		mov %bl, poz
		for_aux:
			movl poz, %ecx
			cmp %ecx, zero
			je cont_for_aux
			movl poz, %eax
			movl $0, %edx
			movl $2, %ebx
			divl %ebx
			movl %eax, poz
			movl k, %eax
			movl %edx, (%edi, %eax, 4)
			sub $1, k
			jmp for_aux
			
		cont_for_aux:
			movl k, %ecx
			cmp %ecx, zero
			je cont_for_mesaj
			movl $0, (%edi, %ecx, 4)
			subl $1, k
			jmp cont_for_aux
			
	cont_for_mesaj:
		movl $1, k
		cont_for_aux2:
			movl k, %ecx
			cmp $8, %ecx
			jg cont_for_mesaj2
			lea codmesaj, %esi
			movl pozm, %eax
			movl (%edi, %ecx, 4), %ebx
			movl %ebx, (%esi, %eax, 4)
			
			addl $1, pozm
			addl $1, k
			jmp cont_for_aux2
	
	cont_for_mesaj2:
		addl $1, i
		jmp for_mesaj
cont_criptare:
	subl $1, pozm
	movl mbnb, %ecx
	movl $1, i
	cmp %ecx, pozm
	jg completare
	jmp cont_criptare2
	
completare:
	movl i, %ecx
	movl pozm, %eax
	subl mbnb, %eax
	cmp %ecx, %eax
	jl cont_criptare2
	lea codmat, %esi
	movl (%esi, %ecx, 4), %ebx
	addl mbnb, %ecx
	movl %ebx, (%esi, %ecx, 4)
	
	addl $1, i
	jmp completare
	
cont_criptare2:
	movl $1, i
	lea codmat, %esi
	for_afis:
		lea codmesaj, %edi
		movl i, %ecx
		cmp %ecx, pozm
		jl afisare1
		movl (%esi, %ecx, 4), %eax
		movl (%edi, %ecx, 4), %ebx
		xorl %ebx, %eax
		lea cript, %edi
		movl %eax, (%edi, %ecx, 4)
	
		addl $1, i
		jmp for_afis
		
afisare1:
	movl $48, %eax
	pushl %eax
	pushl $formatPrintfstr
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	movl $120, %eax
	pushl %eax
	pushl $formatPrintfstr
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	movl $1, i
	lea cript, %edi
	for_afis1:
		movl i, %ecx
		cmp %ecx, pozm
		jle etexit
		movl $0, sum
		movl (%edi, %ecx, 4), %eax
		movl $8, %ebx
		movl $0, %edx
		mull %ebx
		addl %eax, sum
		addl $1, %ecx
		movl (%edi, %ecx, 4), %eax
		movl $4, %ebx
		movl $0, %edx
		mull %ebx
		addl %eax, sum
		addl $1, %ecx
		movl (%edi, %ecx, 4), %eax
		movl $2, %ebx
		movl $0, %edx
		mull %ebx
		addl %eax, sum
		addl $1, %ecx
		movl (%edi, %ecx, 4), %eax
		addl %eax, sum
		
		movl $9, %ecx
		cmp %ecx, sum
		jle cifra
		movl $9, %ecx
		cmp %ecx, sum
		jg litera
		
cifra:
	movl sum, %eax
	addl $48, %eax
	pushl %eax
	pushl $formatPrintfstr
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	jmp cont_afisare1
	
litera:
	movl sum, %eax
	addl $55, %eax
	pushl %eax
	pushl $formatPrintfstr
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	jmp cont_afisare1
	
cont_afisare1:
	addl $4, i
	jmp for_afis1	
	
decriptare:

	pushl $cod
	pushl $formatScanfstr
	call scanf
	popl %ebx
	popl %ebx
	
	movl $2, i
	for_decriptare:
		lea cod, %edi
		movl i, %ecx
		movl $0, %ebx
		mov (%edi, %ecx, 1), %bl
		cmp %ebx, zero
		je cont_decriptare
		
		movl $0, nr
		movl $57, %eax
		cmp %eax, %ebx
		jle adaug_cifra
		
		movl $57, %eax
		cmp %eax, %ebx
		jg adaug_litera
		
	adaug_cifra:
		movl %ebx, %eax
		subl $48, %eax
		movl %eax, nr
		jmp cont_for_decriptare	
		
	adaug_litera:
		movl %ebx, %eax
		subl $55, %eax
		movl %eax, nr
		jmp cont_for_decriptare
	
	
	
	cont_for_decriptare:
		movl $4, k
		for_aux1:
			lea aux, %esi
			movl k, %ecx
			cmp %ecx, zero
			je cont_for_decriptare2
			movl nr, %eax
			movl $2, %ebx
			movl $0, %edx
			divl %ebx
			movl %edx, (%esi, %ecx, 4)
			movl (%esi, %ecx, 4), %ebx
			
			movl %eax, nr
			subl $1, k
			jmp for_aux1
			
	cont_for_decriptare2:
		movl $1, k
		for_cfd:
			movl k, %ecx
			movl $5, %eax
			cmp %ecx, %eax
			je cont_for_decriptare3
			lea aux, %esi
			movl (%esi, %ecx, 4), %eax
			lea coddecriptat, %edi
			addl $1, lencoddec
			movl lencoddec, %ecx
			movl %eax, (%edi, %ecx, 4)
			
			addl $1, k
			jmp for_cfd	
	
	cont_for_decriptare3:
	addl $1, i
	jmp for_decriptare
	
cont_decriptare:
	movl mbnb, %ecx
	movl $1, i
	cmp %ecx, lencoddec
	jg completare_cheie
	jmp cont_decriptare2
	
completare_cheie:
	movl i, %ecx
	movl lencoddec, %eax
	subl mbnb, %eax
	cmp %ecx, %eax
	jl cont_decriptare2
	lea codmat, %esi
	movl (%esi, %ecx, 4), %ebx
	addl mbnb, %ecx
	movl %ebx, (%esi, %ecx, 4)
	
	addl $1, i
	jmp completare_cheie

cont_decriptare2:
	movl $1, i
	lea codmat, %esi
	for_xor2:
		lea coddecriptat, %edi
		movl i, %ecx
		cmp %ecx, lencoddec
		jl afisare2
		movl (%esi, %ecx, 4), %eax
		movl (%edi, %ecx, 4), %ebx
		xorl %ebx, %eax
		lea mesaj2, %edi
		movl %eax, (%edi, %ecx, 4)
	
		addl $1, i
		jmp for_xor2

afisare2:
	lea mesaj2, %edi
	movl $1, i
	for_afisare2:
		movl i, %ecx
		cmp %ecx, lencoddec
		jle etexit
		movl $0, nr_ascii
		movl (%edi, %ecx, 4), %eax
		movl $128, %ebx
		movl $0, %edx
		mull %ebx
		addl %eax, nr_ascii
		addl $1, %ecx
		movl (%edi, %ecx, 4), %eax
		movl $64, %ebx
		movl $0, %edx
		mull %ebx
		addl %eax, nr_ascii
		addl $1, %ecx
		movl (%edi, %ecx, 4), %eax
		movl $32, %ebx
		movl $0, %edx
		mull %ebx
		addl %eax, nr_ascii
		addl $1, %ecx
		movl (%edi, %ecx, 4), %eax
		movl $16, %ebx
		movl $0, %edx
		mull %ebx
		addl %eax, nr_ascii
		addl $1, %ecx
		movl (%edi, %ecx, 4), %eax
		movl $8, %ebx
		movl $0, %edx
		mull %ebx
		addl %eax, nr_ascii
		addl $1, %ecx
		movl (%edi, %ecx, 4), %eax
		movl $4, %ebx
		movl $0, %edx
		mull %ebx
		addl %eax, nr_ascii
		addl $1, %ecx
		movl (%edi, %ecx, 4), %eax
		movl $2, %ebx
		movl $0, %edx
		mull %ebx
		addl %eax, nr_ascii
		addl $1, %ecx
		movl (%edi, %ecx, 4), %eax
		addl %eax, nr_ascii
		
		movl nr_ascii, %ebx
		pushl %ebx
		pushl $formatPrintfstr
		call printf
		popl %ebx
		popl %ebx
		
		pushl $0
		call fflush
		popl %ebx
		
		addl $8, i
		jmp for_afisare2
etexit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
