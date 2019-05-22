;1:数据寄存器,一般称之为通用寄存器组 
    ;8086 有8个8位数据寄存器， 
    ;这些8位寄存器可分别组成16位寄存器： 
    ;AH&AL＝AX：累加寄存器，常用于运算； 
    ;BH&BL＝BX：基址寄存器，常用于地址索引； 
    ;CH&CL＝CX：计数寄存器，常用于计数； 
    ;DH&DL＝DX：数据寄存器，常用于数据传递。 
;2:地址寄存器/段地址寄存器 
    ;为了运用所有的内存空间，8086设定了四个段寄存器，专门用来保存段地址： 
    ;CS（Code Segment）：代码段寄存器； 
    ;DS（Data Segment）：数据段寄存器； 
    ;SS（Stack Segment）：堆栈段寄存器； 
    ;ES（Extra Segment）：附加段寄存器。 
;3：特殊功能的寄存器 
    ;IP（Instruction Pointer）：指令指针寄存器，与CS配合使用，可跟踪程序的执行过程； 
    ;SP（Stack Pointer）：堆栈指针，与SS配合使用，可指向目前的堆栈位置。 
    ;BP（Base Pointer）：基址指针寄存器，可用作SS的一个相对基址位置； 
    ;SI（Source Index）：源变址寄存器可用来存放相对于DS段之源变址指针； 
    ;DI（Destination Index）：目的变址寄存器，可用来存放相对于 ES 段之目的变址指针。 


ife 1
CODE  SEGMENT 
            ASSUME  CS:CODE
            ORG 0108H
        BEGIN: 
            MOV AL,40H
            MOV cl,2
            SHR AL,CL  
            MOV  AH,4CH 
            INT  21H 
    CODE  ENDS 
    END  BEGIN
endif
ife 1
DATA SEGMENT
    BUF  DB  'ABCDEF'
DATA ENDS
CODE  SEGMENT 
            ASSUME  CS:CODE,DS:DATA
            ORG 0108H
        BEGIN: 
            LEA DX,BUF
            MOV AH,9 
            INT 21H
            MOV  AH,4CH 
            INT  21H 
    CODE  ENDS 
    END  BEGIN
endif
;*********************************************************************
;第一小题   
ife 1
    ;移位-----------------------------------------1
        MOV	AX,BX
        MOV	CL,3
        SHL AX,CL   ;就是把bx移位后的值加上bx
        ADD BX,AX  ;bx=2d --> bx=18d=12h

        MOV  AX,BX    
        MOV    CL,2  
        SHL    AX,CL  
        ADD  BX,AX   ;bx=2d --> bx=10d=ah

    ;数字，字符输出--------------------------------3
        ASD  DB 3 
        MOV  DL,ASD 
        ADD DL,30H 
        MOV  AH,2 
        INT 21H

        MOV DL,'X'  
        MOV AH,3  
        INT  21H

    ;输出字符串------------------------------------5
        MESS  DB ’ABCDEF’ 
        LEA  DX,MESS ;=== MOV DX,OFFSET MESS
        MOV AH,9  
        INT  21H 

        BUF  DB  ‘ABCDEF’ 
        MOV AH,9 
        INT 21H
endif

;*********************************************************************
;找出最小值
ife 1
    
    DATA  SEGMENT 
        BUF  DB  7,9,6,4,12,35,4 
    DATA  ENDS 

    CODE  SEGMENT 
            ASSUME  CS:CODE,DS:DATA 
            ORG 0108H
        BEGIN: 
            MOV  AX,DATA 
            MOV  DS,AX 
        ;比较开始
            MOV  CX,6               ;LOOP循环的次数=总数-1
            MOV  BX,OFFSET  BUF     ;bx存buf地址
            MOV  SI,1               ;SI源变址寄存器，DI目地变址寄存器，既然是变址寄存器，那么他们肯定是在某个地址的基础上进行偏移变化，由此我们就得出了需要基址寄存器。 
            MOV  AL,BUF             ;buf第一个数给al
        a: 
            CMP  AL,[BX+SI]         ;[BX+SI]---bx地址si后的地址
            JL  NEXT                ;小于跳转，有符号数比----al小->跳
            MOV  AL,[BX+SI] 
        NEXT:
            INC  SI                 ;+1
            LOOP   a
            MOV  DL,AL              ;最小值存放位置al

            ADD  DL,30H 
            MOV  AH,2 
            INT  21H

            MOV  AH,4CH 
            INT  21H 
    CODE  ENDS 
    END  BEGIN
endif

;*********************************************************************
;AL中的值为：10H  (即64/2/2=16)
ife 1
    MOV  AL,40H 
    MOV  CL,2 
    SHR  AL,CL                  ;右移除2，左移乘2
endif

;*********************************************************************
;输入加2，再输出
ife 1
    CODE  SEGMENT 
            ASSUME  CS:CODE 
            ORG 0108H
        MAIN:
            MOV  AX,CODE 
            MOV  DS,AX 
            
            MOV  AH,1           ;功能号----输入
            INT  21H            

            ADD  AL,2           ;输入加2，再输出----低位
            MOV  DL,AL

            ;ADD  DL,30H
                ;***************打印‘-’
                PUSH DX
                MOV DL,'-'
                MOV  AH,2            
                INT  21H
                POP DX 

            MOV  AH,2           ;功能号----打印dl 
            INT  21H 

            MOV  AH,4CH 
            INT  21H 
    CODE  ENDS 
    END  MAIN
endif

;*********************************************************************
;两个字节数X和Y的平均数放到Z单元中
ife 1
    DATA SEGMENT 
        X DB 7 
        Y DB 8
        Z DB ?  ;商
        W DB ?  ;余数
    DATA ENDS 

    CODE SEGMENT 
    ASSUME  CS:CODE,DS:DATA 
    ORG 0108H
        START: 
            MOV AX,DATA 
            MOV DS,AX 

            MOV BL,X 
            MOV CL,Y 
            ADD BL,CL   ;bl是和
            CBW         ;CBW 字节转换为字指令:8位扩展到16位，扩展前后两数的真值不变
            MOV AX,BX   ;改变值给ax
            MOV CL,2 
            DIV CL      ;除法 ax除以cl 商给al----余数给ah  ax=余数+商
            MOV Z,AL 
            MOV W,AH

            MOV DL,Z 
            ADD DL,30H 
            MOV AH,02H 
            INT 21H
                    ;***************打印‘-’
                    PUSH DX
                    MOV DL,'-'
                    MOV  AH,2            
                    INT  21H
                    POP DX 
            MOV DL,W 
            ADD DL,30H 
            MOV AH,02H 
            INT 21H

            MOV AH,4CH 
            INT 21H 
    CODE ENDS 
    END START
endif

;*********************************************************************
;大写字母转换成相应的小写字母----(ASCII码值相差20H)
ife 1
    
    PROGNAM  SEGMENT 
    MAIN PROC FAR 
            ASSUME CS:PROGNAM
            ORG 0108H
        ;与mov ds,数据段 mov ax,ds 一样 
        START: 
                PUSH  DS 
                SUB AX,AX 
                PUSH AX 
        NEXT: 
            MOV  AH,1 
            INT 21H

            CMP  AL,'A' 
            JB  EXIT        ;大A小B
            CMP  AL,'Z' 
            JA  EXIT        ;前者 > 后者 --> 跳； 大于Z就是小写

            ADD  AL ,20H 
            MOV DL,AL 
            MOV AH,2 
            INT 21H

            MOV DL,0AH      ;换行
            MOV AH,2 
            INT 21H 
            JMP NEXT 
        EXIT: 
            RET 
    MAIN  ENDP 
    PROGNAM  ENDS 
    END  START
endif

;*********************************************************************
;已知数组X包含有8个无符号整数，编写对其中的每个__偶数__计算1+2+…+N，
;并把它们计算结果顺序存入内存字单元SUM开始的存储区中，要求1+2+…+N用子程序实现。不考虑溢出。
ife 0
    DATA   SEGMENT 
        X    DW   2,3,4,5,6,7,8,9 
        SUM  DW 8 DUP(?) 
    DATA   ENDS 
    CODE   SEGMENT 
        ASSUME CS:CODE,DS:DATA 
        ORG 0108H
        MAIN:  
            MOV   AX,DATA    
            MOV   DS,AX 

            LEA   BX,X     
            LEA   DI,SUM     ;目的变址寄存器，可用来存放相对于 ES 段之目的变址指针
            MOV   CX,8       ;LOOP循环的次数,数组元素的个数
        NEXT:  
            MOV   DX,[BX]    ;数组给DX
            MOV   AX,DX      ;AX抽数

            ;判断奇偶数，奇数右移  NY --> CY
            SHR   AX,1     
            JC   N1          ;J 表示转移 C表示转移到条件 （当进位标志C=1 即有进位时 转移 否则不转移）-- 与jnc相反
            CALL  SUB1    

            MOV   [DI],AX     ;给sum，两个字节存一个，要+2
            ADD   DI,2 
        N1:   
            ADD   BX,2      ;数组指向下一个
            LOOP  NEXT      ;重复8次
            MOV   AH,4CH     
            INT   21H

    SUB1   PROC  NEAR     
            PUSH  CX     
            XOR   AX,AX     ;异或----0 == MOV AX,0
            MOV   CX,DX     ;数值就是循环次数，
        AGAIN:  
            ADD   AX,CX     ;累加结果给ax
            LOOP  AGAIN     ;每次cx减一
            POP    CX     
            RET 
    SUB1   ENDP 

    CODE   ENDS             
    END  MAIN
    ;*********************************************************************
endif

