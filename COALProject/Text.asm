INCLUDE Irvine32.inc

.data
menuDisplay BYTE "WELCOME TO EMARA", 0
menuOptions1 BYTE "1. Starters", 0
menuOptions2 BYTE "2. Main Course", 0
menuOptions3 BYTE "3. Desserts", 0
menuOptions4 BYTE "4. Drinks", 0
menuOptions5 BYTE "5. Exit - Choose an option: ", 0

menuOptions DWORD OFFSET menuOptions1, OFFSET menuOptions2, OFFSET menuOptions3, OFFSET menuOptions4, OFFSET menuOptions5

starterItems1 BYTE "1. Chicken Tenders", 0
starterItems2 BYTE "2. Caesar Salad", 0
starterItems3 BYTE "3. French Fries", 0
starterItems4 BYTE "4. Crispy Shrimp", 0
starterItems5 BYTE "5. Buffalo Wings", 0
starterItems6 BYTE "6. Exit - Choose an option: ", 0

starterItems DWORD OFFSET starterItems1, OFFSET starterItems2, OFFSET starterItems3, OFFSET starterItems4, OFFSET starterItems5, OFFSET starterItems6

mainCourseItems1 BYTE "1. Margarita Pizza", 0
mainCourseItems2 BYTE "2. Red Sauce Pasta", 0
mainCourseItems3 BYTE "3. Chicken Club Sandwich", 0
mainCourseItems4 BYTE "4. Chicken Cheeseburger", 0
mainCourseItems5 BYTE "5. Biryani", 0
mainCourseItems6 BYTE "6. Exit - Choose an option: ", 0

mainCourseItems DWORD OFFSET mainCourseItems1, OFFSET mainCourseItems2, OFFSET mainCourseItems3, OFFSET mainCourseItems4, OFFSET mainCourseItems5, OFFSET mainCourseItems6

dessertItems1 BYTE "1. Vanilla Gelato", 0
dessertItems2 BYTE "2. Tiramisu", 0
dessertItems3 BYTE "3. Kunafa", 0
dessertItems4 BYTE "4. Gulab Jamun", 0
dessertItems5 BYTE "5. Cheesecake", 0
dessertItems6 BYTE "6. Exit - Choose an option: ", 0

dessertItems DWORD OFFSET dessertItems1, OFFSET dessertItems2, OFFSET dessertItems3, OFFSET dessertItems4, OFFSET dessertItems5, OFFSET dessertItems6

drinkItems1 BYTE "1. Chai", 0
drinkItems2 BYTE "2. Pepsi", 0
drinkItems3 BYTE "3. Lime Mojito", 0
drinkItems4 BYTE "4. Coffee Latte", 0
drinkItems5 BYTE "5. Citrus Juice", 0
drinkItems6 BYTE "6. Exit - Choose an option: ", 0

drinkItems DWORD OFFSET drinkItems1, OFFSET drinkItems2, OFFSET drinkItems3, OFFSET drinkItems4, OFFSET drinkItems5, OFFSET drinkItems6

starterQuantities DWORD 5 DUP(0)
mainQuantities DWORD 5 DUP(0)
dessertQuantities DWORD 5 DUP(0)
drinkQuantities DWORD 5 DUP(0)

exitMessage BYTE "Hope You Had A Great Time :)", 0
invalidChoice BYTE "Invalid Option. Try Again.", 0
quantityPrompt BYTE "Enter the quantity: ", 0
summaryHeader BYTE "Order Summary:", 0
StarterHeader BYTE "Starters:", 0
MainHeader BYTE "Main Course:", 0
DessertHeader BYTE "Desserts:", 0
DrinkHeader BYTE "Drinks:", 0
space BYTE " : ", 0

pricesStarters DWORD 350, 325, 300, 450, 250
pricesMainCourse DWORD 950, 850, 550, 650, 250
pricesDesserts DWORD 650, 625, 800, 450, 750
pricesDrinks DWORD 100, 125, 350, 250, 50
billState BYTE "Your total bill: Rs. ", 0

totalBill DWORD 0
categoryTotal DWORD 0
catPrice BYTE "Category Total: Rs. ", 0

ReserveTable DWORD 3,4,6,5,2,6,-1,-1,1,-1
askNumberOfSeats BYTE "how many seats do you want to reserve:",0
notFound BYTE "Sorry, Table's not Available ",0
freeTables BYTE "The following tables are free",0
reservedTables BYTE "The following table are reserved: ",0
freeTableDisplay BYTE "Table is Available",0
anotherPrompt BYTE "Choose another.",0
seatsReserveTableDisplay BYTE "number of seats that are reserved for this table: ",0

myDiscount REAL4 0.2
DiscountCode DWORD 2442
DiscountMsg BYTE "enter discount code for discount:",0
discount DWORD 699
discountYes BYTE "WOHOO !! You got 20% discount ",0
discountNo  BYTE "Sorry!! You entered wrong code ",0
tableChosen DWORD ?

adminPortal BYTE "PRESS 1: DINE-IN. ",0
waiterPortal BYTE "PRESS 2: TAKE AWAY.   ",0
wrongPortal BYTE "Sorry ,You entered wrong number ",0
beforeDiscount BYTE "Your Bill before discount: Rs. ",0
billDisplayPrompt BYTE "Your total Bill: Rs. ",0
chooseTable BYTE "Choose a table number: ",0
notFREE BYTE "Sorry this table is not free. ",0
reservedDisaply BYTE "Your table is Succesfully reserved.",0

.code
processSubmenu PROTO items:PTR DWORD, quantities:PTR DWORD, price: PTR DWORD
calculateAndDisplayTotal PROTO  quantities:PTR DWORD, items:PTR DWORD, prices:PTR DWORD
displaySummary PROTO

MAIN PROC
lea edx, menuDisplay
    call WriteString
    call crlf
    lea edx,adminPortal
    call WriteString
    call crlf
    lea edx,waiterPortal
    call WriteString

    optionDecision:
call crlf
    call ReadInt
call crlf
    cmp eax,1
    JE admin
    JNE Again
    Again:
    cmp eax,2
    JE waiter
    JNE GetOut

admin:
lea edx, chooseTable
call WriteString
call Readint
mov tableChosen, eax
dec eax
    mov ecx,lengthof ReserveTable
cmp reserveTable[eax*4],-1
je isAvailableorNot

lea edx, notFREE
call WriteString
call crlf
    lea edx ,freeTables
    call writestring
    call crlf
mov esi, 0

AdminFreeTable:
    cmp reserveTable[esi*4],-1
    Je freeTableFound
    jne freeTableNotFound
    freeTableFound:
    mov eax,esi
    inc eax
    call WriteDec
    lea edx,freeTableDisplay
    call WriteString
    call crlf
    freeTableNotFound:
    inc esi
loop AdminFreeTable

lea edx, anotherPrompt
call writeString
call crlf
jmp admin

isAvailableorNot:
lea edx, freeTableDisplay
call writeString
call crlf
mov ReserveTable[eax*4], 3
mov ebx, eax
lea edx, reservedDisaply
call writeString
call crlf
mov edx,offset askNumberOfSeats
    call WriteString
    call ReadInt
mov ReserveTable[ebx*4], eax
call crlf
waiter:

menuLoop:
    mov ecx, 5
    mov esi, 0
displayMainMenu:
    mov edx, menuOptions[esi * 4]
    call WriteString
    call crlf
    inc esi
    loop displayMainMenu

    call ReadInt
    cmp eax, 1
    je startersMenu
    cmp eax, 2
    je mainCourseMenu
    cmp eax, 3
    je dessertsMenu
    cmp eax, 4
    je drinksMenu
    cmp eax, 5
    je exitProgram

    lea edx, invalidChoice
    call WriteString
    call crlf
    jmp menuLoop

startersMenu:
    INVOKE processSubmenu, ADDR starterItems, ADDR starterQuantities, ADDR pricesStarters
    jmp menuLoop

mainCourseMenu:
    INVOKE processSubmenu, ADDR mainCourseItems, ADDR mainQuantities, ADDR pricesMainCourse
    jmp menuLoop

dessertsMenu:
    INVOKE processSubmenu, ADDR dessertItems, ADDR dessertQuantities, ADDR pricesDesserts
    jmp menuLoop

drinksMenu:
    INVOKE processSubmenu, ADDR drinkItems, ADDR drinkQuantities, ADDR pricesDrinks
    jmp menuLoop

exitProgram:
   
    INVOKE displaySummary
    call crlf
    lea edx, exitMessage
    call WriteString
    call crlf
    jmp endOfProgram

notFoundLabel:
    lea edx, notFound
    call writeString
    call crlf
    jmp endOfProgram

GetOut:
    lea edx,wrongPortal
    call  writeString
    call crlf
lea edx, anotherPrompt
call writeString
jmp optionDecision
endOfProgram:
    exit
MAIN ENDP

processSubmenu PROC items:PTR DWORD, quantities:PTR DWORD, price:PTR DWORD
    push esi
    push edi
    push ebx

    mov esi, items          
    mov edi, quantities    
    mov ebx, price          

submenuLoop:
    mov ecx, 6    
    mov esi, items          
    mov ebx, price          

displayItems:
    mov edx, [esi]          
    call WriteString        
    cmp ecx, 1              
    je skipPriceDisplay    
    lea edx, space          
    call WriteString
    mov eax, [ebx]          
    call WriteDec          
skipPriceDisplay:
    call crlf              
    add ebx, 4              
    add esi, 4              
    loop displayItems

    add ebx, 4
    call ReadInt
    dec eax
    cmp eax, 5
    je submenuEnd
    ja submenuInvalid
    cmp eax, 0
    jl submenuInvalid

    mov ebx, eax
    mov esi, items
    lea edx, quantityPrompt
    call WriteString
    call ReadInt
    mov [edi + ebx * 4], eax
    jmp submenuLoop

submenuInvalid:
    lea edx, invalidChoice
    call WriteString
    call crlf
    jmp submenuLoop

submenuEnd:
    pop ebx
    pop edi
    pop esi
    ret
processSubmenu ENDP

displaySummary PROC
    lea edx, summaryHeader
    call WriteString
    call crlf
    mov totalBill, 0
    lea edx, StarterHeader
    call writeString
    call crlf
    INVOKE calculateAndDisplayTotal, ADDR starterQuantities, ADDR starterItems, ADDR pricesStarters
    lea edx, MainHeader
    call writeString
    call crlf
    INVOKE calculateAndDisplayTotal, ADDR mainQuantities, ADDR mainCourseItems, ADDR pricesMainCourse
    lea edx, DessertHeader
    call writeString
    call crlf
    INVOKE calculateAndDisplayTotal, ADDR dessertQuantities, ADDR dessertItems, ADDR pricesDesserts
    lea edx, DrinkHeader
    call writeString
    call crlf
    INVOKE calculateAndDisplayTotal, ADDR drinkQuantities, ADDR drinkItems, ADDR pricesDrinks
    lea edx, beforeDiscount
    call WriteString
    mov eax, totalBill
    call WriteDec
    call crlf

    lea edx ,DiscountMsg
    call WriteString
    call Readdec
call crlf
    cmp eax,DiscountCode
    jne noBillReduction
   
    mov eax,totalBill
    mov ebx,myDiscount
    mul bx
    sub totalBill ,eax

    lea edx,discountYes
    call WriteString
    call crlf
call crlf
    jmp getOutOfProcedure
    noBillReduction:
    lea edx,discountNo
    call WriteString
    call crlf
call crlf
    getOutOfProcedure:
    lea edx, billDisplayPrompt
    call writeString
    mov eax, totalBill
    call writeDec
    ret
displaySummary ENDP

calculateAndDisplayTotal PROC quantities:PTR DWORD, items:PTR DWORD, prices:PTR DWORD
    push esi
    push edi
    push ebx

    mov esi, items
    mov edi, quantities
    mov ebx, prices
    mov ecx, 5
    mov categoryTotal, 0

categoryLoop:
    mov eax, [edi]            
    cmp eax, 0                
    je skipItem
    mov edx, [esi]            
    call WriteString
    lea edx, space
    call WriteString
    mov edx, eax              
    call WriteDec
    lea edx, space
    call WriteString
    mov eax, [edi]            
    mov edx, [ebx]            
    mul edx            
    add categoryTotal, eax    
    call WriteDec            
    call crlf

skipItem:
    add esi, 4                
    add edi, 4                
    add ebx, 4                
    loop categoryLoop

    lea edx, catPrice        
    call WriteString
    mov eax, categoryTotal
    call WriteDec
    call crlf
    call crlf
    mov eax, totalBill
    add eax, categoryTotal
    mov totalBill, eax
   
    pop ebx
    pop edi
    pop esi
    ret
calculateAndDisplayTotal ENDP

END MAIN
