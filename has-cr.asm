%define CR 13                   ; carriage return, '\r'

    global has_cr               ; define function for export

has_cr:
    ;; Use SCAS instruction to check if this set of bytes contains '\r'.
    ;;
    ;; Function signature:
    ;;    bool has_cr(char *s, int len)
    ;;
    ;; *s will be passed in via rdx, while len will be in rsi. Note
    ;; that SCASB uses rdx directly, so we do not need to MOV it in
    ;; the code below.
    ;;
    ;; Returns 1 for found or 0 otherwise.
    ;;
    mov al,CR                   ; SCASB requires one-byte string to be in AL
    mov rcx,rsi                 ; Size of string to search within
    cld                         ; Clear direction flag -- forward string data
    repne scasb                 ; Run SCASB instruction
    je found                    ; Found a '\r', so, handle

    mov rax,0                   ; No '\r', so return 0
    ret                         ; Return rax

found:
    mov rax,1                   ; Found '\r', return 1
    ret                         ; Return rax
