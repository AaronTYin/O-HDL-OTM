//6->16->32
module BFI(output [32:0]result,
	inout [16:0]x,
	inout [16:0]y,
	input clk);

wire [18:0]xtmp;
assign xtmp[16:0]=x;
assign xtmp[17]=x[16];
assign xtmp[18]=x[16];
wire [18:0]prtmp[8:0];
wire [15:0]ytmp[8:0];
wire ctmp[8:0];
wire [34:0]restmp;

assign x=17'b0_0010_0111_0010_0111;
assign y=17'b0_0010_0111_0010_0111;

assign prtmp[0]=0;
assign ytmp[0]=y[15:0];
assign ctmp[0]=0;


cho c1(prtmp[1],ytmp[1],ctmp[1],ctmp[0],prtmp[0],xtmp,ytmp[0],clk);
cho c2(prtmp[2],ytmp[2],ctmp[2],ctmp[1],prtmp[1],xtmp,ytmp[1],clk);
cho c3(prtmp[3],ytmp[3],ctmp[3],ctmp[2],prtmp[2],xtmp,ytmp[2],clk);
cho c4(prtmp[4],ytmp[4],ctmp[4],ctmp[3],prtmp[3],xtmp,ytmp[3],clk);
cho c5(prtmp[5],ytmp[5],ctmp[5],ctmp[4],prtmp[4],xtmp,ytmp[4],clk);
cho c6(prtmp[6],ytmp[6],ctmp[6],ctmp[5],prtmp[5],xtmp,ytmp[5],clk);
cho c7(prtmp[7],ytmp[7],ctmp[7],ctmp[6],prtmp[6],xtmp,ytmp[6],clk);
cho c8(prtmp[8],ytmp[8],ctmp[8],ctmp[7],prtmp[7],xtmp,ytmp[7],clk);

resch rc(result,ytmp[8],prtmp[8],ctmp[8],clk);

endmodule


module resch(output reg [32:0]result,
				input [15:0]yt,
				input [18:0]prt,
				input ct,
				input clk);

reg [34:0]restmp;

always @(posedge clk)
begin
	restmp[15:0]=yt;
	restmp[34:16]=prt;
	result=restmp[32:0];
end
endmodule


module cho(output reg [18:0]prout,
			output reg [15:0]yout,
			output reg cout,
			input cin,
			input [18:0]prin,
			input [18:0]x,
			input [15:0]yin,
			input clk);

reg [18:0]prtmp;
reg [34:0]pry;
reg [18:0]opx;


always @(posedge clk)
begin
	opx[0]=~x[0];
	opx[1]=~x[1];
	opx[2]=~x[2];
	opx[3]=~x[3];
	opx[4]=~x[4];
	opx[5]=~x[5];
	opx[6]=~x[6];
	opx[7]=~x[7];
	opx[8]=~x[8];
	opx[9]=~x[9];
	opx[10]=~x[10];
	opx[11]=~x[11];
	opx[12]=~x[12];
	opx[13]=~x[13];
	opx[14]=~x[14];
	opx[15]=~x[15];
	opx=opx+16'b1;
	opx[16]=~x[16];
	opx[17]=~x[16];
	opx[18]=~x[16];

	if(!yin[1])
	begin
		if(!yin[0])
		begin
			if(!cin)
			begin
				prtmp=prin;	//suanfa
				cout=0;
				pry[15:0]=yin;
				pry[34:16]=prtmp;
				pry=pry>>2;
				pry[34]=cout;
				pry[33]=cout;
				yout=pry[15:0];
				prout=pry[34:16];
			end
			if(cin)
			begin
				prtmp=prin+x;
				cout=0;
				pry[15:0]=yin;
				pry[34:16]=prtmp;
				pry=pry>>2;
				pry[34]=cout;
				pry[33]=cout;
				yout=pry[15:0];
				prout=pry[34:16];
			end
		end
		if(yin[0])
		begin
			if(!cin)
			begin
				prtmp=prin+x;
				cout=0;
				pry[15:0]=yin;
				pry[34:16]=prtmp;
				pry=pry>>2;
				pry[34]=cout;
				pry[33]=cout;
				yout=pry[15:0];
				prout=pry[34:16];
			end
			if(cin)
			begin
				prtmp=prin+(2*x);
				cout=0;
				pry[15:0]=yin;
				pry[34:16]=prtmp;
				pry=pry>>2;
				pry[34]=cout;
				pry[33]=cout;
				yout=pry[15:0];
				prout=pry[34:16];
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
				pry[15:0]=yin;
				pry[34:16]=prtmp;
				pry=pry>>2;
				pry[34]=cout;
				pry[33]=cout;
				yout=pry[15:0];
				prout=pry[34:16];
			end
			if(cin)
			begin
				prtmp=prin+opx;
				cout=1;
				pry[15:0]=yin;
				pry[34:16]=prtmp;
				pry=pry>>2;
				pry[34]=cout;
				pry[33]=cout;
				yout=pry[15:0];
				prout=pry[34:16];
			end
		end
		if(yin[0])
		begin
			if(!cin)
			begin
				prtmp=prin+opx;
				cout=1;
				pry[15:0]=yin;
				pry[34:16]=prtmp;
				pry=pry>>2;
				pry[34]=cout;
				pry[33]=cout;
				yout=pry[15:0];
				prout=pry[34:16];
			end
			if(cin)
			begin
				prtmp=prin;
				cout=1;
				pry[15:0]=yin;
				pry[34:16]=prtmp;
				pry=pry>>2;
				pry[34]=cout;
				pry[33]=cout;
				yout=pry[15:0];
				prout=pry[34:16];
			end
		end
	end
end
endmodule