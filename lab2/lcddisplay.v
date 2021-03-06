module	lcddisplay (
                    //	Host Side
                    iCLK,iRST_N,iRecord,
                    iHour, iMinute, iSecond, iCS,
                    //	LCD Side
                    LCD_DATA,LCD_RW,LCD_EN,LCD_RS,LCD_ON);
   //	Host Side
   input			iCLK,iRST_N,iRecord;
   input [7:0] iHour,iMinute,iSecond, iCS;

   //	LCD Side
   output [7:0] LCD_DATA;
   output       LCD_RW,LCD_EN,LCD_RS,LCD_ON;
   //	Internal Wires/Registers
   reg [5:0]    LUT_INDEX;
   reg [8:0]    LUT_DATA;
   reg [8:0]    Record1[7:0], Record2[7:0]; // hh mm ss pp
   reg [8:0]    colon1, colon2, quotation1, quotation2;

   reg [5:0]    mLCD_ST;
   reg [17:0]   mDLY;
   reg          mLCD_Start;
   reg [7:0]    mLCD_DATA;
   reg          mLCD_RS;
   wire         mLCD_Done;

   reg [1:0]    det_rcd_edge;
   wire         sig_rcd_edge;
   assign sig_rcd_edge = (det_rcd_edge == 2'b10);

   reg [1:0]    det_rst_edge;
   wire         sig_rst_edge;
   assign sig_rst_edge = (det_rst_edge == 2'b10);

   parameter	LCD_INTIAL	=	0;
   parameter	LCD_LINE1	=	5;
   parameter	LCD_CH_LINE	=	LCD_LINE1+16;
   parameter	LCD_LINE2	=	LCD_LINE1+16+1;
   parameter	LUT_SIZE	=	LCD_LINE1+32+1;

   integer  index;

   initial
     begin
        for (index = 0; index < 8; index = index+1)
          begin
             Record1[index] <= 9'h120;
             Record2[index] <= 9'h120;
          end
        colon1 <= 9'h120;
        colon2 <= 9'h120;
        quotation1 <= 9'h120;
        quotation2 <= 9'h120;
     end

   assign LCD_ON = 1'b1;

   always@(posedge iCLK)
     begin
        det_rcd_edge <= {det_rcd_edge[0], iRecord};
        det_rst_edge <= {det_rst_edge[0], iRST_N};
        if (sig_rcd_edge)
          begin
             for (index = 0; index < 8; index = index+1)
               begin
                  Record1[index] <= Record2[index];
               end
             colon1 <= colon2;
             quotation1 <= quotation2;

             Record2[7] <= 9'h130 + iHour / 10;
             Record2[6] <= 9'h130 + iHour % 10;
             Record2[5] <= 9'h130 + iMinute / 10;
             Record2[4] <= 9'h130 + iMinute % 10;
             Record2[3] <= 9'h130 + iSecond / 10;
             Record2[2] <= 9'h130 + iSecond % 10;
             Record2[1] <= 9'h130 + iCS / 10;
             Record2[0] <= 9'h130 + iCS % 10;
             colon2 <= 9'h13A;
             quotation2 <= 9'h127;

             LUT_INDEX	<=	0;
             mLCD_ST		<=	0;
             mDLY		<=	0;
             mLCD_Start	<=	0;
             mLCD_DATA	<=	0;
             mLCD_RS		<=	0;
          end
        else if (sig_rst_edge)
          begin
             for (index = 0; index < 8; index = index+1)
               begin
                  Record1[index] <= 9'h120;
                  Record2[index] <= 9'h120;
               end
             colon1 <= 9'h120;
             colon2 <= 9'h120;
             quotation1 <= 9'h120;
             quotation2 <= 9'h120;

             LUT_INDEX	<=	0;
             mLCD_ST		<=	0;
             mDLY		<=	0;
             mLCD_Start	<=	0;
             mLCD_DATA	<=	0;
             mLCD_RS		<=	0;
          end
        else
           begin
             if(LUT_INDEX<LUT_SIZE)
               begin
                  case(mLCD_ST)
                    0:	begin
                       mLCD_DATA	<=	LUT_DATA[7:0];
                       mLCD_RS		<=	LUT_DATA[8];
                       mLCD_Start	<=	1;
                       mLCD_ST		<=	1;
                    end
                    1:	begin
                       if(mLCD_Done)
                         begin
                            mLCD_Start	<=	0;
                            mLCD_ST		<=	2;
                         end
                    end
                    2:	begin
                       if(mDLY<18'h3FFFE)
                         mDLY	<=	mDLY+1;
                       else
                         begin
                            mDLY	<=	0;
                            mLCD_ST	<=	3;
                         end
                    end
                    3:	begin
                       LUT_INDEX	<=	LUT_INDEX+1;
                       mLCD_ST	<=	0;
                    end
                  endcase
               end
          end
     end

   always
     begin
        #1
        case(LUT_INDEX)
          //	Initial
          LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
          LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
          LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
          LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
          LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
          //	Line 1
          LCD_LINE1+0:	LUT_DATA	<=	Record1[7];	//	hh:mm:ss'pp
          LCD_LINE1+1:	LUT_DATA	<=	Record1[6];
          LCD_LINE1+2:	LUT_DATA	<=	colon1;
          LCD_LINE1+3:	LUT_DATA	<=	Record1[5];
          LCD_LINE1+4:	LUT_DATA	<=	Record1[4];
          LCD_LINE1+5:	LUT_DATA	<=	colon1;
          LCD_LINE1+6:	LUT_DATA	<=	Record1[3];
          LCD_LINE1+7:	LUT_DATA	<=	Record1[2];
          LCD_LINE1+8:	LUT_DATA	<=	quotation1;
          LCD_LINE1+9:	LUT_DATA	<=	Record1[1];
          LCD_LINE1+10:	LUT_DATA	<=	Record1[0];
          LCD_LINE1+11:	LUT_DATA	<=	9'h120;
          LCD_LINE1+12:	LUT_DATA	<=	9'h120;
          LCD_LINE1+13:	LUT_DATA	<=	9'h120;
          LCD_LINE1+14:	LUT_DATA	<=	9'h120;
          LCD_LINE1+15:	LUT_DATA	<=	9'h120;
          //	Change Line
          LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
          //	Line 2
          LCD_LINE2+0:	LUT_DATA	<=	Record2[7]; //  hh:mm:ss'pp
          LCD_LINE2+1:	LUT_DATA	<=	Record2[6];
          LCD_LINE2+2:	LUT_DATA	<=	colon2;
          LCD_LINE2+3:	LUT_DATA	<=	Record2[5];
          LCD_LINE2+4:	LUT_DATA	<=	Record2[4];
          LCD_LINE2+5:	LUT_DATA	<=	colon2;
          LCD_LINE2+6:	LUT_DATA	<=	Record2[3];
          LCD_LINE2+7:	LUT_DATA	<=	Record2[2];
          LCD_LINE2+8:	LUT_DATA	<=	quotation2;
          LCD_LINE2+9:	LUT_DATA	<=	Record2[1];
          LCD_LINE2+10:	LUT_DATA	<=	Record2[0];
          LCD_LINE2+11:	LUT_DATA	<=	9'h120;
          LCD_LINE2+12:	LUT_DATA	<=	9'h120;
          LCD_LINE2+13:	LUT_DATA	<=	9'h120;
          LCD_LINE2+14:	LUT_DATA	<=	9'h120;
          LCD_LINE2+15:	LUT_DATA	<=	9'h120;
          default:		LUT_DATA	<=	9'h120;
        endcase
     end

   LCD_Controller    u0	(	//	Host Side
                          .iDATA(mLCD_DATA),
                          .iRS(mLCD_RS),
                          .iStart(mLCD_Start),
                          .oDone(mLCD_Done),
                          .iCLK(iCLK),
                          .iRST_N(iRST_N),
                          //	LCD Interface
                          .LCD_DATA(LCD_DATA),
                          .LCD_RW(LCD_RW),
                          .LCD_EN(LCD_EN),
                          .LCD_RS(LCD_RS)	);

endmodule
