# Verilog编程

### 代码的特点

门级：数电实验中用到的，用一些逻辑门去写一个中规模的器件。

数据流（RTL）级：在数字电路中，信号经过组合逻辑时会类似于数据流动，即信号从输入流向输出，并不会在其中存储。当输入发生变化时，总会在一定时间以后体现在输出端。

行为级：不考虑具体实现，只描述行为，比较类似普通的编程语言，但是最终会通过综合翻译成硬件电路，所以还是会有一些区别，需要理解硬件电路的逻辑。

1. 区分线网类型（wire）和寄存器类型（reg），线网类型的变量会被翻译成一根信号线或者一个引脚，它的值由驱动（输出）元件决定，没有驱动就是高阻态，所以缺省值是z，用assign赋值；寄存器类型的变量会被翻译成寄存器，缺省值是x，只能在过程（always和initial）语句中用=（阻塞型）和<=（非阻塞）赋值。
2. 要理解和区分组合逻辑操作和时序逻辑操作的区别，组合逻辑操作使用**wire类型**的变量，**驱动信号改变后直接改变**，时序逻辑操作使用**reg类型**变量（记忆元件），有存储功能，**在时钟边沿更新**，取指令部件中的PC就是一个用于计数的寄存器，PC一定要先初始化为0否则就会一直是无效值x。
3. 封装和例化，是代码的结构和层次更清晰。[Verilog 模块例化 | 菜鸟教程](https://www.runoob.com/w3cnote/verilog-generate.html)

### 仿真

激励文件，写一个测试模块，在该模块中调用被测的模块，并给它的输入输出赋值。

由于需要人为控制时序，一定要注意某些信号驱动的先后顺序，哪些是时序控制，那些是组合逻辑控制。

### 硬件测试

需要封装成一个测试模块，这个模块从开发板读取输入，将输出显示在开发板上，输入输出的变量都和开发板上的部件对应（建立约束）

```verilog
module BTN_Anti_Jitter( input Clock, input BTN_IN, output reg BTN_Out );
    reg [3:0] cnt; 
    reg BTN_Old;
    always @ (posedge Clock) 
        begin 
            if(BTN_IN != BTN_Old) 
                begin cnt <= 4'b0000; 
                    BTN_Out <= BTN_Old;
                    BTN_Old <= BTN_IN;
                end
            else
                begin
                    if( cnt == 4'b1111) begin
                        cnt <= 4'b0000; BTN_Out <= BTN_IN; 
                    end 
                    else cnt <= cnt + 1'b1; 
                end 
        end 
endmodule
```



```verilog
module Hex7seg_decode( input wire [23:0] disp_num, input wire[2:0] Scanning, output wire [7:0] SEGMENT, output reg [5:0] AN ); 
    reg [3:0] digit; 
    reg [7:0] digit_seg; 
    assign SEGMENT = digit_seg; 
    always @ (*) 
        begin AN = 6'b000000; 
            case (Scanning)
                3'h0: begin digit[3:0] = disp_num[3:0]; AN = 6'b000001; end 
                3'h1: begin digit[3:0] = disp_num[7:4]; AN = 6'b100000; end 
                3'h2: begin digit[3:0] = disp_num[11:8]; AN =6'b010000; end 
                3'h3: begin digit[3:0] = disp_num[15:12]; AN = 6'b001000; end 
                3'h4: begin digit[3:0] = disp_num[19:16]; AN = 6'b000100; end 
                3'h5: begin digit[3:0] = disp_num[23:20]; AN = 6'b000010; end 
            endcase 
        end 
    
    always @ (*) 
        begin 
            case (digit) 
            	4'h0: digit_seg = 8'b00111111; 
                4'h1: digit_seg = 8'b00000110; 
                4'h2: digit_seg = 8'b01011011; 
                4'h3: digit_seg = 8'b01001111; 
                4'h4: digit_seg = 8'b01100110; 
                4'h5: digit_seg = 8'b01101101; 
                4'h6: digit_seg = 8'b01111101; 
                4'h7: digit_seg = 8'b00000111; 
                4'h8: digit_seg = 8'b01111111;                 
                4'h9: digit_seg = 8'b01101111; 
                4'hA: digit_seg = 8'b01110111; 
                4'hB: digit_seg = 8'b01111100; 
                4'hC: digit_seg = 8'b00111001; 
                4'hD: digit_seg = 8'b01011110; 
                4'hE: digit_seg = 8'b01111001; 
                4'hF: digit_seg = 8'b01110001; 
            endcase 
        end 
endmodule
```



```verilog
`timescale 1ns / 1ps

module Board_CPU( input sw, input Clock, input Reset, input BTN_IN, output AN_SEL, output seg );
    input  Clock , Reset, BTN_IN;  //Clock是系统时钟，BTN_IN是按键输入的时钟
    input  [2:0] sw;		 // 控制显示内容的开关
    output [7:0] seg;        // 数码管显示数字
	output [5:0] AN_SEL;     // 数码管扫描信号

	  
    wire [31:0] PC , Inst , AluResult, B_data;
	wire BTN_Out;
	   
    BTN_Anti_Jitter U1( .Clock(Clock) ,
                       .BTN_IN(BTN_IN),
                       .BTN_Out(BTN_Out)); //按键开关去抖
	
    // 调用Mainboard模块执行指令，指令输出的结果作为待显示的信息
    Mainboard U2( .Reset(Reset) , 
                 .Clock(BTN_Out) , 
                 .inst(Inst),
                 .pc(PC),
                 .data_addr(AluResult),
                 .datain(B_data));
	
    // 通过开关选择要显示的信息
    // 开关Switch[1:0]：输出内容选择，00 – 显示执行指令，01 – 显示pc，10 – 显示ALU运算结果，11 – 显示数据存储器输入,开关Switch[2]：0 – 显示输出内容的低24位，1 – 显示输出内容的高24位
    wire [23:0] disp;
    always@(*)
        begin
            case(sw)
                3'b000: disp = Inst[23:0];3'b100: disp = Inst[31:8];
                3'b001: disp = PC[23:0];3'b101: disp = PC[31:8];
                3'b010: disp = AluResult[23:0];3'b110: disp = AluResult[31:8];
                3'b011: disp = B_data[23:0];
3'b111: disp = B_data[31:8];
            endcase
        end
                    
    // 使用数码管显示被选中的信息
    reg [2:0] scan;//扫描信号的时钟应该很快，在视觉效果上是同时显示
    wire [2:0] scan_in;
    assign scan_in=scan
    initial scan=0;
    always@(posege Clock)
        begin
            if( scan == 3'b111) begin
                        scan = 3'b000; 
                    end 
            else
                scan=scan+1;            
    		Hex7seg_decode U3( .disp_num(disp), 
                               .Scanning(scan_in), 
                      			.SEGMENT(seg), 
                      			.AN(AN_SEL));
        end	  
endmodule

```

```ucf
NET Clock  LOC = D11;

Net "Clock" TNM_NET = sys_clk_pin;

#Buttons
Net "BTN_IN" CLOCK_DEDICATED_ROUTE = FALSE;
NET BTN_IN LOC = E6;  //btn(0)

NET Reset LOC = D5;  //btn(1)

#switches
NET SW<0> LOC= V5;
NET SW<1> LOC= U4;
NET SW<2> LOC= V3;

#Leds
NET LED<0> LOC=W3;
NET LED<1> LOC=Y4;
NET LED<2> LOC=Y1;

NET AN_SEL(0) LOC = M17; # 7-seg AN1
NET AN_SEL(1) LOC = AA20; # 7-seg AN4
NET AN_SEL(2) LOC = AB21; # 7-seg AN5
NET AN_SEL(3) LOC = N16; # 7-seg AN2
NET AN_SEL(4) LOC = P19; # 7-seg AN3
NET AN_SEL(5) LOC = P16; # 7-seg AN0

NET seg(0) LOC=AA21; 
NET seg(1) LOC=AA22;  
NET seg(2) LOC=Y22; 
NET seg(3) LOC=N15;  
NET seg(4) LOC=AB19; 
NET seg(5) LOC=P20; 
NET seg(6) LOC=Y21;  
NET seg(7) LOC=P15; 
```

