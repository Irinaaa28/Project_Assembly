.data
	m: .space 4
	n: .space 4
	p: .space 4
	mbord: .space 4
	nbord: .space 4
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
	formatScanf: .asciz "%d"
	formatScanf2: .asciz "%d %d"
	formatScanf3: .asciz "%d %d %d"
	formatPrintf: .asciz "%d "
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
	je afisare2
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
	
afisare2:
	movl $1, lineIndex	
	for_lines2:
		movl lineIndex, %ecx
		cmp %ecx, m
		jl etexit
		movl $1, columnIndex
		for_columns2:
			movl columnIndex, %ecx
			cmp %ecx, n
			jl cont_for_lines2
		
			movl lineIndex, %eax
			movl $0, %edx
			mull nbord
			addl columnIndex, %eax
			movl (%edi, %eax, 4), %ebx
		
			pusha
			pushl %ebx
			pushl $formatPrintf
			call printf
			popl %ebx
			popl %ebx
			popa
		
			pushl $0
			call fflush
			popl %ebx
		
			incl columnIndex
			jmp for_columns2
		
cont_for_lines2:
	mov $4, %eax
	mov $1, %ebx
	mov $newline, %ecx
	mov $2, %edx
	int $0x80
	
	addl $1, lineIndex
	jmp for_lines2
	
etexit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
