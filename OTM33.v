//6->16->32
module BFI(output [64:0]result,
	inout [32:0]x,
	inout [32:0]y,
	input clk);

wire [34:0]xtmp;
assign xtmp[32:0]=x;
assign xtmp[33]=x[32];
assign xtmp[34]=x[32];
wire [34:0]prtmp[16:0];
wire [31:0]ytmp[16:0];
wire ctmp[16:0];
wire [66:0]restmp;

assign x=33'b0_0010_0111_0010_0111_0010_0111_0010_0111;
assign y=33'b0_0010_0111_0010_0111_0010_0111_0010_0111;

assign prtmp[0]=0;
assign ytmp[0]=y[31:0];
assign ctmp[0]=0;


cho c1(prtmp[1],ytmp[1],ctmp[1],ctmp[0],prtmp[0],xtmp,ytmp[0],clk);
cho c2(prtmp[2],ytmp[2],ctmp[2],ctmp[1],prtmp[1],xtmp,ytmp[1],clk);
cho c3(prtmp[3],ytmp[3],ctmp[3],ctmp[2],prtmp[2],xtmp,ytmp[2],clk);
cho c4(prtmp[4],ytmp[4],ctmp[4],ctmp[3],prtmp[3],xtmp,ytmp[3],clk);
cho c5(prtmp[5],ytmp[5],ctmp[5],ctmp[4],prtmp[4],xtmp,ytmp[4],clk);
cho c6(prtmp[6],ytmp[6],ctmp[6],ctmp[5],prtmp[5],xtmp,ytmp[5],clk);
cho c7(prtmp[7],ytmp[7],ctmp[7],ctmp[6],prtmp[6],xtmp,ytmp[6],clk);
cho c8(prtmp[8],ytmp[8],ctmp[8],ctmp[7],prtmp[7],xtmp,ytmp[7],clk);
cho c9(prtmp[9],ytmp[9],ctmp[9],ctmp[8],prtmp[8],xtmp,ytmp[8],clk);
cho c10(prtmp[10],ytmp[10],ctmp[10],ctmp[9],prtmp[9],xtmp,ytmp[9],clk);
cho c11(prtmp[11],ytmp[11],ctmp[11],ctmp[10],prtmp[10],xtmp,ytmp[10],clk);
cho c12(prtmp[12],ytmp[12],ctmp[12],ctmp[11],prtmp[11],xtmp,ytmp[11],clk);
cho c13(prtmp[13],ytmp[13],ctmp[13],ctmp[12],prtmp[12],xtmp,ytmp[12],clk);
cho c14(prtmp[14],ytmp[14],ctmp[14],ctmp[13],prtmp[13],xtmp,ytmp[13],clk);
cho c15(prtmp[15],ytmp[15],ctmp[15],ctmp[14],prtmp[14],xtmp,ytmp[14],clk);
cho c16(prtmp[16],ytmp[16],ctmp[16],ctmp[15],prtmp[15],xtmp,ytmp[15],clk);

resch rc(result,ytmp[16],prtmp[16],ctmp[16],clk);

endmodule


module resch(output reg [64:0]result,
				input [31:0]yt,
				input [34:0]prt,
				input ct,
				input clk);

reg [66:0]restmp;

always @(posedge clk)
begin
	restmp[31:0]=yt;
	restmp[66:32]=prt;
	result=restmp[64:0];
end
endmodule


module cho(output reg [34:0]prout,
			output reg [31:0]yout,
			output reg cout,
			input cin,
			input [34:0]prin,
			input [34:0]x,
			input [31:0]yin,
			input clk);

reg [34:0]prtmp;
reg [66:0]pry;
reg [34:0]opx;


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
	opx[16]=~x[16];
	opx[17]=~x[17];
	opx[18]=~x[18];
	opx[19]=~x[19];
	opx[20]=~x[20];
	opx[21]=~x[21];
	opx[22]=~x[22];
	opx[23]=~x[23];
	opx[24]=~x[24];
	opx[25]=~x[25];
	opx[26]=~x[26];
	opx[27]=~x[27];
	opx[28]=~x[28];
	opx[29]=~x[29];
	opx[30]=~x[30];
	opx[31]=~x[31];
	opx=opx+32'b1;
	opx[32]=~x[32];
	opx[33]=~x[32];
	opx[34]=~x[32];

	if(!yin[1])
	begin
		if(!yin[0])
		begin
			if(!cin)
			begin
				prtmp=prin;	//suanfa
				cout=0;
				pry[31:0]=yin;
				pry[66:32]=prtmp;
				pry=pry>>2;
				pry[66]=cout;
				pry[65]=cout;
				yout=pry[31:0];
				prout=pry[66:32];
			end
			if(cin)
			begin
				prtmp=prin+x;
				cout=0;
				pry[31:0]=yin;
				pry[66:32]=prtmp;
				pry=pry>>2;
				pry[66]=cout;
				pry[65]=cout;
				yout=pry[31:0];
				prout=pry[66:32];
			end
		end
		if(yin[0])
		begin
			if(!cin)
			begin
				prtmp=prin+x;
				cout=0;
				pry[31:0]=yin;
				pry[66:32]=prtmp;
				pry=pry>>2;
				pry[66]=cout;
				pry[65]=cout;
				yout=pry[31:0];
				prout=pry[66:32];
			end
			if(cin)
			begin
				prtmp=prin+(2*x);
				cout=0;
				pry[31:0]=yin;
				pry[66:32]=prtmp;
				pry=pry>>2;
				pry[66]=cout;
				pry[65]=cout;
				yout=pry[31:0];
				prout=pry[66:32];
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
				pry[31:0]=yin;
				pry[66:32]=prtmp;
				pry=pry>>2;
				pry[66]=cout;
				pry[65]=cout;
				yout=pry[31:0];
				prout=pry[66:32];
			end
			if(cin)
			begin
				prtmp=prin+opx;
				cout=1;
				pry[31:0]=yin;
				pry[66:32]=prtmp;
				pry=pry>>2;
				pry[66]=cout;
				pry[65]=cout;
				yout=pry[31:0];
				prout=pry[66:32];
			end
		end
		if(yin[0])
		begin
			if(!cin)
			begin
				prtmp=prin+opx;
				cout=1;
				pry[31:0]=yin;
				pry[66:32]=prtmp;
				pry=pry>>2;
				pry[66]=cout;
				pry[65]=cout;
				yout=pry[31:0];
				prout=pry[66:32];
			end
			if(cin)
			begin
				prtmp=prin;
				cout=1;
				pry[31:0]=yin;
				pry[66:32]=prtmp;
				pry=pry>>2;
				pry[66]=cout;
				pry[65]=cout;
				yout=pry[31:0];
				prout=pry[66:32];
			end
		end
	end
end
endmodule