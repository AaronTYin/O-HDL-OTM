//6->16->32
module BFI(output [12:0]result,
	inout [6:0]x,
	inout [6:0]y,
	input clk);

wire [8:0]xtmp;
assign xtmp[6:0]=x;
assign xtmp[7]=x[6];
assign xtmp[8]=x[6];
wire [8:0]prtmp[3:0];
wire [5:0]ytmp[3:0];
wire ctmp[3:0];
wire [14:0]restmp;

assign x=7'b0_10_0111;
assign y=7'b0_10_0111;

assign prtmp[0]=0;
assign ytmp[0]=y[5:0];
assign ctmp[0]=0;


cho c1(prtmp[1],ytmp[1],ctmp[1],ctmp[0],prtmp[0],xtmp,ytmp[0],clk);
cho c2(prtmp[2],ytmp[2],ctmp[2],ctmp[1],prtmp[1],xtmp,ytmp[1],clk);
cho c3(prtmp[3],ytmp[3],ctmp[3],ctmp[2],prtmp[2],xtmp,ytmp[2],clk);
resch rc(result,ytmp[3],prtmp[3],ctmp[3],clk);

endmodule


module resch(output reg [12:0]result,
				input [5:0]yt,
				input [8:0]prt,
				input ct,
				input clk);

reg [14:0]restmp;

always @(posedge clk)
begin
	restmp[5:0]=yt;
	restmp[14:6]=prt;
	result=restmp[12:0];
end
endmodule


module cho(output reg [8:0]prout,
			output reg [5:0]yout,
			output reg cout,
			input cin,
			input [8:0]prin,
			input [8:0]x,
			input [5:0]yin,
			input clk);

reg [8:0]prtmp;
reg [14:0]pry;
reg [8:0]opx;


always @(posedge clk)
begin
	opx[0]=~x[0];
	opx[1]=~x[1];
	opx[2]=~x[2];
	opx[3]=~x[3];
	opx[4]=~x[4];
	opx[5]=~x[5];
	opx=opx+6'b00_0001;
	opx[6]=~x[6];
	opx[7]=~x[6];
	opx[8]=~x[6];

	if(!yin[1])
	begin
		if(!yin[0])
		begin
			if(!cin)
			begin
				prtmp=prin;	//suanfa
				cout=0;
				pry[5:0]=yin;
				pry[14:6]=prtmp;
				pry=pry>>2;
				pry[14]=cout;
				pry[13]=cout;
				yout=pry[5:0];
				prout=pry[14:6];
			end
			if(cin)
			begin
				prtmp=prin+x;
				cout=0;
				pry[5:0]=yin;
				pry[14:6]=prtmp;
				pry=pry>>2;
				pry[14]=cout;
				pry[13]=cout;
				yout=pry[5:0];
				prout=pry[14:6];
			end
		end
		if(yin[0])
		begin
			if(!cin)
			begin
				prtmp=prin+x;
				cout=0;
				pry[5:0]=yin;
				pry[14:6]=prtmp;
				pry=pry>>2;
				pry[14]=cout;
				pry[13]=cout;
				yout=pry[5:0];
				prout=pry[14:6];
			end
			if(cin)
			begin
				prtmp=prin+(2*x);
				cout=0;
				pry[5:0]=yin;
				pry[14:6]=prtmp;
				pry=pry>>2;
				pry[14]=cout;
				pry[13]=cout;
				yout=pry[5:0];
				prout=pry[14:6];
			end
		end
	end
	if(yin[1])
	begin
		if(!yin[0])
		begin
			if(!cin)
			begin
				prtmp=prin+(2*x);
				cout=0;
				pry[5:0]=yin;
				pry[14:6]=prtmp;
				pry=pry>>2;
				pry[14]=cout;
				pry[13]=cout;
				yout=pry[5:0];
				prout=pry[14:6];
			end
			if(cin)
			begin
				prtmp=prin+opx;
				cout=1;
				pry[5:0]=yin;
				pry[14:6]=prtmp;
				pry=pry>>2;
				pry[14]=cout;
				pry[13]=cout;
				yout=pry[5:0];
				prout=pry[14:6];
			end
		end
		if(yin[0])
		begin
			if(!cin)
			begin
				prtmp=prin+opx;
				cout=1;
				pry[5:0]=yin;
				pry[14:6]=prtmp;
				pry=pry>>2;
				pry[14]=cout;
				pry[13]=cout;
				yout=pry[5:0];
				prout=pry[14:6];
			end
			if(cin)
			begin
				prtmp=prin;
				cout=1;
				pry[5:0]=yin;
				pry[14:6]=prtmp;
				pry=pry>>2;
				pry[14]=cout;
				pry[13]=cout;
				yout=pry[5:0];
				prout=pry[14:6];
			end
		end
	end
end
endmodule