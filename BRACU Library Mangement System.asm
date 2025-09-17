.MODEL SMALL
.STACK 100H

.DATA 

; Header
header_title db 10, 13, "$"
store_name db 10, 13,10, 13, "      BRACU LIBRARY MANAGEMENT SYSTEM      $"
location db 10, 13, "           BRAC University,DHAKA          $"
address db 10, 13, "        Merul Badda,Bir Uttam Rafiqul Islam Road,Dhaka-1212 $"

header_line db 10, 13,10, 13, "$"

welcome_msg db 10, 13, "Welcome to the Library Management System!  $" 

; User/Admin Selection
user_admin_prompt db 10, 13, "Are you a User or Admin?", 10, 13, "1. User", 10, 13, "2. Admin", 10, 13, "3. Exit", 10, 13, "Choose: $"
user_type db 0  ; 1 = User, 2 = Admin

; Authentication system
user_passwords db "22$", "11$", "33$", 10 dup(0)  ; User passwords
admin_passwords db "admin$", 10 dup(0)           ; Admin password
password_count db 3          
max_passwords db 5            
pass_prompt db 10, 13,10, 13, "Enter password: $" 
correct_msg db 10, 13, "Access granted!", 10, 13, "$"
incorrect_msg db 10, 13, "Incorrect password. Try again. $" 
attempts_left db 10,13,"Attempts left: $"
max_attempts db 3
current_attempt db 0
input_buffer db 25 dup('$')
authenticated db 0

; Book Information
book1 db 10, 13, "1. To Kill a Mockingbird   - Code: 1  Qty: ($"
book2 db 10, 13, "2. 1984                    - Code: 2  Qty: ($"
book3 db 10, 13, "3. Pride and Prejudice     - Code: 3  Qty: ($"
book4 db 10, 13, "4. The Great Gatsby        - Code: 4  Qty: ($"
book5 db 10, 13, "5. Moby Dick               - Code: 5  Qty: ($"
book6 db 10, 13, "6. War and Peace           - Code: 6  Qty: ($"
book7 db 10, 13, "7. The Catcher in the Rye  - Code: 7  Qty: ($"
book8 db 10, 13, "8. The Hobbit              - Code: 8  Qty: ($"
book9 db 10, 13, "9. Fahrenheit 451          - Code: 9  Qty: ($"
book10 db 10,13, "10. Jane Eyre              - Code: 10 Qty: ($"
qty_end db ")$"

book_quantities db 5,5,5,5,5,5,5,5,5,5,0,0 
borrow_counts db 10 dup(0) 
book_names db "To Kill a Mockingbird $"     
           db "1984                  $"       
           db "Pride and Prejudice   $"     
           db "The Great Gatsby      $"     
           db "Moby Dick             $"     
           db "War and Peace         $"     
           db "The Catcher in the Rye$"     
           db "The Hobbit            $"     
           db "Fahrenheit 451        $"     
           db "Jane Eyre             $"     
           
          
; Book Request System
book_requests db 15 dup(25 dup('$'))    
request_count db 0                      
max_requests db 15                       
current_request db 25 dup('$') 
books_to_request db 0                    
books_requested_count db 0               
ask_how_many db 10,13,"How many books do you want to request (1-3)? $"
ask_another db 10,13,"Enter next book name: $"
        
        

; User Menu Options
main_menu db 10,13,10,13,"===== USER MENU =====",10,13
          db "1. View Available Books",10,13
          db "2. Borrow Book",10,13
          db "3. Return Book",10,13
          db "4. Request New Book",10,13
          db "5. Most Borrowed Books",10,13
          db "6. Log Out",10,13
          db "Choose option: $"

; Admin Menu Options
admin_menu db 10,13,10,13,"===== ADMIN MENU =====",10,13
           db "1. View Book Requests",10,13
           db "2.  Log Out",10,13
           db "Choose option: $"

; Messages for Books
enter_code db 10,13, "Enter book code (1-10): $"
invalid_code_msg db 10, 13, "Invalid book code! Please enter 1-10.$"
out_of_stock_msg db 10, 13, "Sorry, this book is not available!$"
book_borrowed_msg db 10, 13, "Book borrowed successfully!$"
book_returned_msg db 10,13, "Book Returned, Thank You!$"
borrowing_msg db 10, 13, "Borrowing Book number: $"

; Receipt header 
receipt_header db 10,13, "===== RETURN RECEIPT =====", 10, 13, "$"

; Request Messages
request_msg db 10,13, "Enter book name (max 23 chars): $"
request_taken_msg db 10,13, "Request taken, Thank you!$"
no_requests_msg db 10,13, "No book requests available.$"
view_requests_header db 10,13, "===== BOOK REQUESTS =====", 10, 13, "$"
request_number db "Request #$"
colon_space db ": $"
enter_request_num db 10,13, "Enter request number to approve/reject: $"
request_approved_msg db 10,13, "Request approved and added to library!$"
request_rejected_msg db 10,13, "Request rejected and removed!$"
invalid_request_msg db 10,13, "Invalid request number!$"
requests_full_msg db 10,13, "Cannot approve - library is full!$"

; Most Borrowed Messages
most_borrowed_msg db 10,13,"===== MOST BORROWED BOOKS =====",10,13,"$"
no_borrows_msg db 10,13,"No books have been borrowed yet.$"
borrows_text db " borrows)$"

; Debug messages 
debug_msg db "Index: $"
debug_count db " Count: $"

; General Messages
press_any_key db 10,13,10,13,"Press any key to continue...$"
dotted_line db 10, 13, "------------------------------------$" 
farewell_msg db 10,13, 10, 13,10, 13, "Thank you for using the library! Please visit again.$"   
logged_out_msg db 10,13, "Logged out successfully!$"


; Fine system messages 
days_prompt db 10,13, "How many days have you had this book? $"
fine_policy_msg db 10,13, "Fine Policy: 5 Taka per day after 7 days$"
fine_calculation_msg db 10,13, "Extra days: $"
fine_rate_msg db " x 5 Taka = $"
fine_msg db 10,13, "Total Fine: $"
taka_msg db " Taka$"
no_fine_msg db 10,13, "No fine - returned within 7 days!$"
fine_per_day db 5           ; 5 Taka per day fine
days_input db 0
total_fine dw 0
extra_days db 0  

book_not_borrowed_msg db 10,13, "Error: This book was not borrowed! Current quantity is full.$"

.CODE

;----------------------------------------------------------
; MACROS
;----------------------------------------------------------
PRINT_STRING MACRO msg
    MOV AH, 9
    LEA DX, msg
    INT 21h
ENDM

READ_CHAR MACRO
    MOV AH, 1
    INT 21h
ENDM

DISPLAY_NUMBER MACRO num
    MOV AL, num
    MOV AH, 0
    MOV BL, 10
    DIV BL      
    MOV BX, AX  
    MOV DL, AL
    ADD DL, 48
    MOV AH, 2
    INT 21h     
    MOV DL, BH
    ADD DL, 48
    INT 21h     
ENDM

NEW_LINE MACRO
    MOV AH, 2
    MOV DL, 10
    INT 21h
    MOV DL, 13
    INT 21h
ENDM

;----------------------------------------------------------
; PROCEDURES
;----------------------------------------------------------
show_header PROC
    PRINT_STRING header_title
    PRINT_STRING store_name
    PRINT_STRING location
    PRINT_STRING address
    PRINT_STRING header_line
    RET
show_header ENDP  

;----------------------------------------------------------
; AUTHENTICATION PROCEDURES // USER LOGIN 
;----------------------------------------------------------
READ_PASSWORD PROC
    LEA SI, input_buffer
    MOV CX, 20
    
READ_LOOP:
    READ_CHAR
    CMP AL, 13
    JE DONE_READ
    MOV [SI], AL
    INC SI
    LOOP READ_LOOP
    
DONE_READ:
    MOV [SI], '$'
    RET
READ_PASSWORD ENDP

CHECK_PASSWORD PROC
    CMP user_type, 1
    JE check_user_passwords
    CMP user_type, 2
    JE check_admin_passwords
    JMP no_match
    
check_user_passwords:
    LEA DI, user_passwords
    JMP do_check
    
check_admin_passwords:
    LEA DI, admin_passwords
    JMP do_check
    
do_check:
    MOV CL, password_count
    MOV CH, 0
    
CHECK_LOOP:
    LEA SI, input_buffer
    MOV BX, DI
    
COMPARE:
    MOV AL, [SI]
    MOV AH, [BX]
    CMP AL, AH
    JNE NEXT_PASS
    CMP AL, '$'
    JE MATCH
    INC SI
    INC BX
    JMP COMPARE
    
NEXT_PASS:
    MOV AL, [DI]
    INC DI
    CMP AL, '$'
    JNE NEXT_PASS
    LOOP CHECK_LOOP
    
no_match:
    MOV AL, 0
    RET
    
MATCH:
    MOV AL, 1
    RET
CHECK_PASSWORD ENDP

userAuth PROC    
    PRINT_STRING welcome_msg
    NEW_LINE
    
    ; Set password 
    CMP user_type, 1
    JE set_user_auth
    CMP user_type, 2
    JE set_admin_auth
    JMP EXIT_AUTH
    
set_user_auth:
    MOV password_count, 3
    MOV max_attempts, 3
    JMP LOGIN
    
set_admin_auth:
    MOV password_count, 1
    MOV max_attempts, 2
    JMP LOGIN
    
LOGIN:
    MOV current_attempt, 0
    
LOGIN_ATTEMPT:
    PRINT_STRING attempts_left
    MOV AL, max_attempts
    SUB AL, current_attempt
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 2
    INT 21h 
    NEW_LINE
    
    PRINT_STRING pass_prompt
    
    CALL READ_PASSWORD
    
    CALL CHECK_PASSWORD
    CMP AL, 1
    JE ACCESS_GRANTED
    
    INC current_attempt
    PRINT_STRING incorrect_msg
    
    MOV AL, current_attempt
    CMP AL, max_attempts
    JL LOGIN_ATTEMPT
    
    JMP EXIT_AUTH

ACCESS_GRANTED:
    PRINT_STRING correct_msg
    
    MOV authenticated, 1
   
    RET    

EXIT_AUTH:
    MOV AX, 4C00H
    INT 21H
userAuth ENDP
                       
                       


;----------------------------------------------------------
; VIEW AVAILABLE BOOK
;----------------------------------------------------------
show_books PROC   
    MOV SI, 0  
    
    PRINT_STRING book1
    MOV BL, book_quantities[SI]
    CALL display_quantity
    INC SI
    
    PRINT_STRING book2
    MOV BL, book_quantities[SI]
    CALL display_quantity
    INC SI
    
    PRINT_STRING book3
    MOV BL, book_quantities[SI]
    CALL display_quantity
    INC SI
    
    PRINT_STRING book4
    MOV BL, book_quantities[SI]
    CALL display_quantity
    INC SI
    
    PRINT_STRING book5
    MOV BL, book_quantities[SI]
    CALL display_quantity
    INC SI
    
    PRINT_STRING book6
    MOV BL, book_quantities[SI]
    CALL display_quantity
    INC SI
    
    PRINT_STRING book7
    MOV BL, book_quantities[SI]
    CALL display_quantity
    INC SI
    
    PRINT_STRING book8
    MOV BL, book_quantities[SI]
    CALL display_quantity
    INC SI
    
    PRINT_STRING book9
    MOV BL, book_quantities[SI]
    CALL display_quantity
    INC SI
    
    PRINT_STRING book10
    MOV BL, book_quantities[SI]
    CALL display_quantity
    INC SI
    
    RET 
show_books ENDP

display_quantity PROC
    MOV AL, BL          
    MOV AH, 0           
    MOV BL, 10          
    DIV BL              
    MOV BX, AX          
    MOV DL, AL         
    ADD DL, 48          
    MOV AH, 2
    INT 21h            
    MOV DL, BH          
    ADD DL, 48          
    INT 21h             
    PRINT_STRING qty_end
    RET    
display_quantity ENDP  

;----------------------------------------------------------
; BORROW BOOK by CODE
;----------------------------------------------------------

borrow_book PROC
    PRINT_STRING enter_code
    
    
    READ_CHAR
    MOV BL, AL          
    SUB BL, '0'         
    
    
    MOV AH, 8          
    INT 21h
    
    CMP AL, 13          
    JE single_digit_input
    
    
    CMP BL, 1           
    JNE invalid_book_code
    
    
    MOV DL, AL
    MOV AH, 2
    INT 21h
    
    CMP AL, '0'         
    JE book_ten
    CMP AL, '1'         
    JE book_eleven
    CMP AL, '2'         
    JE book_twelve
    JMP invalid_book_code

book_ten:
    MOV BL, 10
    JMP read_enter
book_eleven:
    MOV BL, 11
    JMP read_enter
book_twelve:
    MOV BL, 12
    JMP read_enter
    
read_enter:
    
    READ_CHAR
    JMP validate_code

single_digit_input:
   
    
validate_code:
    
    CMP BL, 1
    JL invalid_book_code
    CMP BL, 10
    JG invalid_book_code
    
   
    MOV CL, BL         
    
    
    DEC BL
    
    
    MOV AL, BL         
    MOV AH, 0           
    MOV SI, AX          
    
    
    MOV AL, book_quantities[SI]
    CMP AL, 0
    JE book_not_available
    
    
    DEC AL                          
    MOV book_quantities[SI], AL     
    
    
    MOV AL, borrow_counts[SI]
    INC AL
    MOV borrow_counts[SI], AL
    
    NEW_LINE
    PRINT_STRING borrowing_msg
    
   
    MOV AL, CL          
    CMP AL, 10          
    JGE display_two_digits
    
   
    ADD AL, '0'         
    MOV DL, AL
    MOV AH, 2
    INT 21H
    JMP show_borrowed_book_name
    
display_two_digits:
    
    MOV AH, 0
    MOV BL, 10
    DIV BL              
    PUSH AX            
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 2
    INT 21H
   
    POP AX              
    MOV DL, AH         
    ADD DL, '0'
    MOV AH, 2           
    INT 21H

show_borrowed_book_name:
   
    MOV DL, ' '
    MOV AH, 2
    INT 21H
    MOV DL, '-'
    INT 21H
    MOV DL, ' '
    INT 21H
    

    PUSH AX             
    PUSH DX             
    MOV AX, SI          
    MOV BX, 23         
    MUL BX              
    LEA DX, book_names  
    ADD DX, AX         
    MOV AH, 9           
    INT 21H
    POP DX              
    POP AX              

borrowing_done:
    NEW_LINE
    PRINT_STRING book_borrowed_msg
    NEW_LINE
    PRINT_STRING press_any_key
    READ_CHAR
    RET

book_not_available:
    PRINT_STRING out_of_stock_msg
    NEW_LINE
    PRINT_STRING press_any_key
    read_CHAR
    RET

invalid_book_code:
    PRINT_STRING invalid_code_msg
    NEW_LINE
    PRINT_STRING press_any_key
    read_CHAR
    RET
borrow_book ENDP
;----------------------------------------------------------
; RETURN BOOK +FINE CALCULATION
;----------------------------------------------------------
return_book PROC
    PRINT_STRING enter_code
    
   
    READ_CHAR
    MOV BL, AL          
    SUB BL, '0'        
    
    
    MOV AH, 8           
    INT 21h
    
    CMP AL, 13         
    JE single_digit_return
    
  
    CMP BL, 1           
    JNE invalid_return_code
    
  
    MOV DL, AL
    MOV AH, 2
    INT 21h
    
    CMP AL, '0'         
    JE return_ten
    JMP invalid_return_code

return_ten:
    MOV BL, 10
    JMP return_read_enter
    
return_read_enter:
   
    READ_CHAR
    JMP return_validate

single_digit_return:
   
    
return_validate:
    ; Validate range (1-10)
    CMP BL, 1
    JL invalid_return_code
    CMP BL, 10
    JG invalid_return_code
    
   
    DEC BL
    MOV AL, BL
    MOV AH, 0
    MOV SI, AX
    
     ;Checking if book was actually borrowed (quantity < 5)
    MOV AL, book_quantities[SI]
    CMP AL, 5                   ; Compare with original quantity
    JGE book_not_borrowed       ; If >= 5, book wasn't borrowed
    
   
    MOV BL, book_quantities[SI]
    INC BL
    MOV book_quantities[SI], BL 
    
    CALL calculate_fine
    
   
    PRINT_STRING receipt_header
    NEW_LINE
    PRINT_STRING dotted_line
    
  
    MOV AX, SI
    MOV BX, 23
    MUL BX
    LEA DX, book_names
    ADD DX, AX
    PRINT_STRING DX
    
    ; Show days borrowed
    NEW_LINE
    MOV DL, 'D'
    MOV AH, 2
    INT 21h
    MOV DL, 'a'
    INT 21h
    MOV DL, 'y'
    INT 21h
    MOV DL, 's'
    INT 21h
    MOV DL, ' '
    INT 21h
    MOV DL, 'b'
    INT 21h
    MOV DL, 'o'
    INT 21h
    MOV DL, 'r'
    INT 21h
    MOV DL, 'r'
    INT 21h
    MOV DL, 'o'
    INT 21h
    MOV DL, 'w'
    INT 21h
    MOV DL, 'e'
    INT 21h
    MOV DL, 'd'
    INT 21h
    MOV DL, ':'
    INT 21h
    MOV DL, ' '
    INT 21h
    
  
    MOV AL, days_input
    CALL display_single_number
    
   
    MOV Ax, total_fine
    CMP AL, 0
    JE no_fine_display
    
   
    PRINT_STRING fine_policy_msg
    NEW_LINE
    
    ; Show calculation
    PRINT_STRING fine_calculation_msg
    MOV AL, extra_days
    CALL display_single_number
    PRINT_STRING fine_rate_msg
    MOV Ax, total_fine
    CALL display_word_number
    PRINT_STRING taka_msg
    
    ; Display total fine
    PRINT_STRING fine_msg
    MOV Ax, total_fine
    CALL display_word_number
    PRINT_STRING taka_msg
    JMP continue_receipt
    
no_fine_display:
    PRINT_STRING fine_policy_msg
    NEW_LINE
    PRINT_STRING no_fine_msg
    
continue_receipt:
    NEW_LINE
    PRINT_STRING book_returned_msg
    PRINT_STRING dotted_line
    NEW_LINE
    PRINT_STRING press_any_key
    READ_CHAR
    
    RET
            
book_not_borrowed:
    PRINT_STRING book_not_borrowed_msg
    NEW_LINE
    PRINT_STRING press_any_key
    read_CHAR
    RET            

invalid_return_code:
    PRINT_STRING invalid_code_msg
    NEW_LINE
    PRINT_STRING press_any_key
    read_CHAR
    RET
return_book ENDP

;-----------------------------
; FINE CALCULATION Part |
;-----------------------------

calculate_fine PROC
    ; Ask for number of days
    PRINT_STRING days_prompt
    
   
    READ_CHAR
    SUB AL, '0'
    MOV BL, AL          
    
  
    MOV AH, 8           
    INT 21h
    CMP AL, 13          
    JE single_digit_days
    
  
    MOV DL, AL
    MOV AH, 2
    INT 21h             
    SUB AL, '0'
    MOV AH, AL          
    MOV AL, BL          
    MOV BL, 10
    MUL BL              
    ADD AL, AH          
    MOV days_input, AL
    
    ; Read Enter
    READ_CHAR
    JMP calculate_fine_amount
    
single_digit_days:
    MOV days_input, BL
    
calculate_fine_amount:
    MOV total_fine, 0   ; Initialize fine
    MOV extra_days, 0   ; Initialize extra days
    MOV AL, days_input
    CMP AL, 7           ; > 7 days
    JLE no_fine_calc    ; No fine if <= 7 days
    
    ; Calculate fine: (days - 7) * fine_per_day
    SUB AL, 7          
    MOV extra_days, AL  
    MOV BL, fine_per_day
    MUL BL              
    MOV total_fine, AX  
    
no_fine_calc:
    RET
calculate_fine ENDP

;----------------------------------------------------------
; NEW SINGLE NUMBER DISPLAY PROCEDURE
;----------------------------------------------------------
display_single_number PROC
    MOV AH, 0          
    CMP AL, 10          
    JL single_digit_only
    
   
    MOV BL, 10
    DIV BL             
    PUSH AX
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 2
    INT 21h
    POP AX
    MOV DL, AH
    ADD DL, '0'
    MOV AH, 2
    INT 21h
    RET
    
single_digit_only:
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 2
    INT 21h
    RET
display_single_number ENDP 




display_word_number PROC
    ; Input: AX contains the number to display
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV CX, 0           ; Digit counter
    MOV BX, 10          ; Divisor
    
    ; Handle special case of 0
    CMP AX, 0
    JNE extract_digits
    MOV DL, '0'
    MOV AH, 2
    INT 21h
    JMP done_display
    
extract_digits:
    ; Extract digits by repeatedly dividing by 10
    MOV DX, 0           ; Clear DX for division
    DIV BX              ; AX = quotient, DX = remainder
    PUSH DX             ; Save remainder (digit) on stack
    INC CX              ; Increment digit count
    CMP AX, 0           ; Check if quotient is 0
    JNE extract_digits  ; Continue if more digits
    
display_digits:
    ; Pop and display digits in correct order
    POP DX              ; Get digit from stack
    ADD DL, '0'         ; Convert to ASCII
    MOV AH, 2           ; Display character
    INT 21h
    LOOP display_digits ; Repeat for all digits
    
done_display:
    POP DX
    POP CX
    POP BX
    RET
display_word_number ENDP
;----------------------------------------------------------
; REQUEST NEW BOOK
;---------------------------------------------------------- 

request_new_book PROC
    
    MOV AL, request_count
    CMP AL, max_requests
    JGE request_storage_full
    
   
    PRINT_STRING ask_how_many
    READ_CHAR
    SUB AL, '0'
    
    ; Validate input (1-3)
    CMP AL, 1
    JL request_new_book        
    CMP AL, 3
    JG request_new_book        
    
   
    MOV BL, AL
    ADD BL, request_count
    CMP BL, max_requests
    JG request_storage_full
    
    MOV books_to_request, AL
    MOV books_requested_count, 0
    
request_next_book:
   
    MOV AL, books_requested_count
    CMP AL, books_to_request
    JGE all_books_requested
    
   
    CMP AL, 0
    JE first_book_msg
    PRINT_STRING ask_another
    JMP get_book_name
    
first_book_msg:
    PRINT_STRING request_msg
    
get_book_name:
    
    LEA DI, current_request
    MOV CX, 25
clear_request_buffer:
    MOV [DI], '$'
    INC DI
    LOOP clear_request_buffer
    
    ; Read book request
    LEA DI, current_request
    MOV CX, 23              
    
read_request_loop:
    READ_CHAR
    CMP AL, 13              
    JE request_input_done
    
    MOV [DI], AL
    INC DI
    DEC CX
    CMP CX, 0
    JG read_request_loop
    
request_input_done:
    MOV [DI], '$'
    
    ; Store the request
    CALL store_request
    
  
    MOV AL, books_requested_count
    INC AL
    MOV books_requested_count, AL
    JMP request_next_book
    
all_books_requested:
    PRINT_STRING request_taken_msg
    NEW_LINE
    PRINT_STRING press_any_key
    READ_CHAR
    RET

request_storage_full:
    PRINT_STRING no_requests_msg
    NEW_LINE
    PRINT_STRING press_any_key
    read_CHAR
    RET
request_new_book ENDP


store_request PROC
    MOV AL, request_count
    MOV BL, 25              
    MUL BL                  
    LEA SI, book_requests
    ADD SI, AX              
    
    LEA DI, current_request
    MOV CX, 25
    
copy_request_loop:
    MOV AL, [DI]
    MOV [SI], AL
    INC SI
    INC DI
    CMP AL, '$'
    JE copy_done
    LOOP copy_request_loop
    
copy_done:
    MOV AL, request_count
    INC AL
    MOV request_count, AL
    RET
store_request ENDP

;----------------------------------------------------------
; MOST BORROWED BOOKS
;----------------------------------------------------------
show_most_borrowed PROC
    NEW_LINE
    PRINT_STRING most_borrowed_msg
    
    
    MOV CX, 10          
    MOV SI, 0           
    MOV BL, 0           
    
check_any_borrowed:
    MOV AL, book_quantities[SI]
    CMP AL, 5           
    JL books_exist      
    INC SI
    LOOP check_any_borrowed
    
    ; No books borrowed
    PRINT_STRING no_borrows_msg
    NEW_LINE
    PRINT_STRING press_any_key
    READ_CHAR
    RET
    
books_exist:
    
    CALL display_books_with_qty_0
  
    CALL display_books_with_qty_1
   
    CALL display_books_with_qty_2
  
    CALL display_books_with_qty_3
   
    CALL display_books_with_qty_4
    
    NEW_LINE
    PRINT_STRING press_any_key
    read_CHAR
    RET
show_most_borrowed ENDP



;-------------------------



; Helper procedures for each quantity level
display_books_with_qty_0 PROC
    MOV CX, 10
    MOV SI, 0
    MOV BL, 1           
    
loop_qty_0:
    MOV AL, book_quantities[SI]
    CMP AL, 0
    JNE skip_qty_0
    
   
    NEW_LINE
    CALL display_book_info
    
skip_qty_0:
    INC SI
    INC BL
    LOOP loop_qty_0
    RET
display_books_with_qty_0 ENDP

display_books_with_qty_1 PROC
    MOV CX, 10
    MOV SI, 0
    MOV BL, 1
    
loop_qty_1:
    MOV AL, book_quantities[SI]
    CMP AL, 1
    JNE skip_qty_1
    
    NEW_LINE
    CALL display_book_info
    
skip_qty_1:
    INC SI
    INC BL
    LOOP loop_qty_1
    RET
display_books_with_qty_1 ENDP

display_books_with_qty_2 PROC
    MOV CX, 10
    MOV SI, 0
    MOV BL, 1
    
loop_qty_2:
    MOV AL, book_quantities[SI]
    CMP AL, 2
    JNE skip_qty_2
    
    NEW_LINE
    CALL display_book_info
    
skip_qty_2:
    INC SI
    INC BL
    LOOP loop_qty_2
    RET
display_books_with_qty_2 ENDP

display_books_with_qty_3 PROC
    MOV CX, 10
    MOV SI, 0
    MOV BL, 1
    
loop_qty_3:
    MOV AL, book_quantities[SI]
    CMP AL, 3
    JNE skip_qty_3
    
    NEW_LINE
    CALL display_book_info
    
skip_qty_3:
    INC SI
    INC BL
    LOOP loop_qty_3
    RET
display_books_with_qty_3 ENDP

display_books_with_qty_4 PROC
    MOV CX, 10
    MOV SI, 0
    MOV BL, 1
    
loop_qty_4:
    MOV AL, book_quantities[SI]
    CMP AL, 4
    JNE skip_qty_4
    
    NEW_LINE
    CALL display_book_info
    
skip_qty_4:
    INC SI
    INC BL
    LOOP loop_qty_4
    RET
display_books_with_qty_4 ENDP


display_book_info PROC
   
    PUSH BX             
    
  
    MOV AL, BL
    CMP AL, 10
    JGE display_two_digit_book
    
   
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 2
    INT 21h
    JMP display_book_name
    
display_two_digit_book:
    MOV AH, 0
    MOV CL, 10
    DIV CL              
    PUSH AX             
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 2
    INT 21h
 
    POP AX              
    MOV DL, AH          
    ADD DL, '0'
    MOV AH, 2           
    INT 21h
display_book_name:
  
    MOV DL, '.'
    MOV AH, 2
    INT 21h
    MOV DL, ' '
    INT 21h
    
    
    PUSH AX             
    PUSH DX             
    MOV AX, SI
    MOV BX, 23
    MUL BX
    LEA DX, book_names
    ADD DX, AX
    MOV AH, 9
    INT 21h
    POP DX                
    POP AX              
    
   
    MOV DL, ' '
    MOV AH, 2
    INT 21h
    MOV DL, '('
    INT 21h
    
    MOV AL, 5                   
    SUB AL, book_quantities[SI] 
    ADD AL, '0'
    MOV DL, AL
    INT 21h
    
    MOV DL, ')'
    INT 21h
    
    POP BX              
    RET
display_book_info ENDP

;--------------------------------------------------------------------
; ADMIN PROCEDURES to SEE THE BOOK REQ
;--------------------------------------------------------------------
view_requests PROC
    MOV AL, request_count
    CMP AL, 0
    JE no_requests_found
    
    PRINT_STRING view_requests_header
    
    MOV CL, request_count   
    MOV CH, 0               
    MOV BL, 1               
    LEA SI, book_requests   
    
display_requests_loop:
    NEW_LINE
    PRINT_STRING request_number
    MOV AL, BL
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 2
    INT 21h
    PRINT_STRING colon_space
    
    ; Print request
    MOV DX, SI
    PRINT_STRING DX
    
    ADD SI, 25             
    INC BL                  
    LOOP display_requests_loop
    
    NEW_LINE
    PRINT_STRING press_any_key
    READ_CHAR
    RET

no_requests_found:
    PRINT_STRING no_requests_msg
    NEW_LINE
    PRINT_STRING press_any_key
    READ_CHAR
    RET
view_requests ENDP

; Admin Menu Handler
admin_menu_start PROC
admin_loop:
    PRINT_STRING admin_menu
    
    READ_CHAR
    SUB AL, '0'
    
    CMP AL, 1
    JE view_requests_option
    CMP AL, 2
    JE logout_option
    JMP admin_loop

view_requests_option:
    CALL view_requests
    JMP admin_loop

logout_option:
    MOV authenticated, 0
    PRINT_STRING logged_out_msg
    NEW_LINE
    PRINT_STRING press_any_key
    READ_CHAR
    RET
admin_menu_start ENDP

;----------------------------------------------------------
; MAIN PROCEDURE
;----------------------------------------------------------
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL show_header

start_selection:
   
    PRINT_STRING user_admin_prompt
    READ_CHAR
    SUB AL, '0'
    MOV user_type, AL
    
    CMP AL, 1
    JE user_selected
    CMP AL, 2
    JE admin_selected
    CMP AL, 3
    JE exit_program
    JMP start_selection  

user_selected:
    CALL userAuth
    CMP authenticated, 1
    JNE start_selection  
    JMP main_menu_start

admin_selected:
    CALL userAuth
    CMP authenticated, 1
    JNE start_selection  
    JMP admin_panel_start

admin_panel_start:
    CALL admin_menu_start
    JMP start_selection  

main_menu_start:
    PRINT_STRING main_menu
    
    READ_CHAR
    SUB AL, '0'
    
    CMP AL, 1
    JE view_books
    CMP AL, 2
    JE borrow_option
    CMP AL, 3
    JE return_option
    CMP AL, 4
    JE request_option
    CMP AL, 5
    JE most_borrowed_option
    CMP AL, 6
    JE user_logout
    JMP main_menu_start

view_books:
    CALL show_books
    NEW_LINE
    PRINT_STRING press_any_key
    READ_CHAR
    JMP main_menu_start

borrow_option:
    CALL borrow_book
    JMP main_menu_start

return_option:
    CALL return_book
    JMP main_menu_start

request_option:
    CALL request_new_book
    JMP main_menu_start

most_borrowed_option:
    CALL show_most_borrowed
    JMP main_menu_start 

user_logout:
    PRINT_STRING logged_out_msg
    NEW_LINE
    PRINT_STRING press_any_key
    READ_CHAR
    JMP start_selection

exit_program:
    PRINT_STRING farewell_msg
    MOV AX, 4C00H
    INT 21H
MAIN ENDP  

END MAIN
