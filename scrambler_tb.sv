module scrambler_tb ();
reg clk;
reg reset_n;
reg [1:15] initial_state;
reg in_bit;
reg en;
wire out_bit;
wire scmb_en;
reg test_in [1:1504*50];
reg test_out [1:1504*50];
reg out_exp;
int pck;
int i;
bit ch;
BB_scrambler dut(
    .clk(clk),
    .reset_n(reset_n),
    .in_bit(in_bit),
    .initial_state(initial_state),
    .en(en),
    .out_bit(out_bit),
    .scmb_en(scmb_en)
);
initial clk=0;

always begin
   #5; clk=~clk; // clock period 10
end
task  reset();
    reset_n= 0;
    #10;
    reset_n=1;
endtask 

// read from file
task read();
    // let's read the vectors (I called it input)
    $readmemb("Input.txt",test_in);
    $readmemb("Output.txt",test_out);
endtask

task check (bit x, bit y, int pck, int j);
    if(x==y) begin
        $display("Right one :) exp= %b, true= %b, packet number %d, bit number %d",y,x,pck,j);
        ch=1;
    end
    else begin 
        $display("Wrong one!! exp= %b, true= %b, packet number %d, bit number %d",y,x,pck,j);
        ch=0;
    end
endtask     

initial begin //run time
    // reset();
    read();
    initial_state= 15'b100101010000000;
    // en=1;
  // we would read now bro
  for (pck=1;pck<51;pck++) begin
        if (pck>1) begin
        reset();
        en=0;
        #25
        en=1;
        end
        else begin
            reset();
        en=0;
        #20
        en=1;
        end
        
    for (i =1 ;i<=1506; i++) begin
        @ (negedge clk) begin 
            in_bit= test_in[1504*(pck-1)+i];
            if (i>2)
            begin
            check(out_bit,out_exp,pck,i-2);
            end
        end
        @ (posedge clk) begin
        out_exp=test_out[(pck-1)*1504+i-1]; // -1 here is cause it works after en by 1 cyclez
        end 
    end
  end
    $finish;
end


endmodule