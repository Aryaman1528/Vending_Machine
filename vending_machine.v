module vending_machine_20(in,clk,rst,out,change);
  input [1:0]in; // 00-Rs0, 01-Rs5, 10-Rs10, 11-RS15
  input clk,rst;
  output reg [1:0]change; 
  output reg out;
  
  parameter s0=2'b00;  
  parameter s1=2'b01;  
  parameter s2=2'b10; 
  parameter s3=2'b11;
  
  reg [1:0] c_state,n_state;
  
  // we are considering that the vending machine has only one product and the user has currencies of denominations Rs5, Rs10 and Rs15
  
  always @(posedge clk)
    begin
      if(rst==1)
        begin
          c_state=0;
          n_state=0;
          change=2'b00;
        end
      else
        c_state=n_state;
      
      case(c_state)
        s0:        // state s0 -> Rs0
          if(in==0)
            begin
              n_state=s0;
              out=0;
              change=2'b00;
            end
        else if(in==2'b01)
          begin
            n_state=s1;
            out=0;
            change=3'b000;
          end
        else if(in==2'b10)
          begin
            n_state=s2;
            out=0;
            change=2'b00;
          end
        else if(in==2'b11)
          begin
            n_state=s3;
            out=0;
            change=2'b00;
          end
        
        s1:  // state s1 -> Rs5
          if(in==0)
            begin
              n_state=s0;
              out=0;
              change=2'b01; //change returned Rs5
            end
        else if(in==2'b01)
          begin
            n_state=s2;
            out=0;
            change=2'b00;
          end
        else if(in==2'b10)
          begin
            n_state=s3;
            out=0;
            change=2'b00;
          end
        else if(in==2'b11)
          begin
            n_state=s0;
            out=1;  //out=1, as recieved Rs20
            change=2'b00;
          end
        
        s2:     //state s2 -> Rs10
          if(in==0)
            begin
              n_state=s0;
              out=0;
              change=2'b10;  // change returned Rs10
			end
        else if(in==2'b01)
          begin
            n_state=s3;
            out=0;
            change=2'b00;
          end
        else if(in==2'b10)
          begin
            n_state=s0;
            out=1;	//out=1, as recieved Rs20
            change=2'b00;
          end
        else if(in==2'b11)
          begin
            n_state=s0;
            out=1;	//out=1, as recieved Rs20
            change=2'b01;//change of Rs5 is returned
          end
              
              
          s3:  // state s3 -> Rs15
             if(in==0)
            begin
              n_state=s0;
              out=0;
              change=2'b11;  // change returned 15rs
            end
        else if(in==2'b01)
          begin
            n_state=s0;
            out=1;	//out=1, as recieved Rs20
            change=2'b00;
          end
        else if(in==2'b10)
          begin
            n_state=s0;
            out=1; //ouput =1 got 20rs
            change=2'b01;// change returned Rs5
          end
        else if(in==2'b11)
          begin
            n_state=s0;
            out=1; //ouput =1 got 20rs
            change=2'b10;// change returned Rs10
          end
        endcase
              
    end
 endmodule
