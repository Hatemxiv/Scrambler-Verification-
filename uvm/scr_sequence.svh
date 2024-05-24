

class scr_Input_sequence extends uvm_sequence;

    `uvm_object_utils(scr_Input_sequence)
    scr_sequence_item sequence_item_h;
    logic In_vect [1:1504*50];
    task read();
        $readmemb("Input.txt", In_vect); /// READ
    endtask


    function new(string name = "scr_Input_sequence");
        super.new(name);
        `uvm_info("scr_Input_sequence", "constructor", UVM_HIGH)
    endfunction: new

    task pre_body;
        `uvm_info("scr_Input_sequence", "pre_body", UVM_HIGH)
        sequence_item_h = scr_sequence_item::type_id::create("sequence_item_h");
        read(); // READ
    endtask: pre_body

    task body;
        `uvm_info("scr_Input_sequence", "body", UVM_HIGH)
            
            start_item(sequence_item_h);
            sequence_item_h.reset_n = 0;
            sequence_item_h.display_in("scr_Input_sequence");
            finish_item(sequence_item_h);

    for (int j=1; j<=50;j++) begin
            
        for (int i = 1; i <= 1506; i++) begin
            if(i>2) begin
            $display("###############################----########################################");
            $display("Starting Test Number %0d, In the Frame number: %d", i-2, j);
            $display("###############################----########################################");
            end
            start_item(sequence_item_h);
            sequence_item_h.reset_n = 1; sequence_item_h.en=1; sequence_item_h.initial_state= 15'b1001010_10000000; 
            sequence_item_h.in_bit= In_vect[i+1504*(j-1)];
            sequence_item_h.display_in("scr_Input_sequence");
            finish_item(sequence_item_h);
             
            end 
            start_item(sequence_item_h);
            sequence_item_h.reset_n = 0; sequence_item_h.en = 0;
            sequence_item_h.display_in("scr_Input_sequence");
            finish_item(sequence_item_h);
  


        end
    endtask: body

endclass: scr_Input_sequence
