module lab2 (clock, 
				//key
				iClear, iRecord, iZero, iTiming,
				//lcd
				LCD_DATA, LCD_RW, LCD_EN, LCD_RS, LCD_ON,
				bcd_out
				);
				
				input clock, iClear, iRecord, iZero, iTiming;
				
				output[55:0] bcd_out;
				output LCD_RW, LCD_EN, LCD_RS, LCD_ON;
				output [7:0] LCD_DATA;
				wire[7:0] iminute;
				wire[7:0] isecond;
				wire[7:0] ics;
				wire[7:0] ihour;
				wire[7:0] bcd_1;
				wire[7:0] bcd_2;
				wire[7:0] bcd_3;
				wire[7:0] bcd_4;
				wire[55:0] bcd_temp;
				
				reg [23:0] temp_ms;
				reg [43:0] count;
				reg [1:0] run_con;
				reg [1:0] zero_con;
				
				wire sig_zero;
				wire sig_run;
				
				reg Tcondition;
				initial 
					begin 
						temp_ms = 0;
						count = 0;
						Tcondition = 0;
					end
				
				assign ics = temp_ms % 100;
				assign isecond = (temp_ms % 6000) / 100;
				assign iminute = (temp_ms % 360000) / 6000;
				assign ihour = (temp_ms % 8640000) / 360000;
				assign sig_zero = (zero_con == 2'b10);
				assign sig_run = (run_con == 2'b10);
				
				lcddisplay lcd(clock, iClear, iRecord, ihour, iminute, isecond, ics, LCD_DATA, LCD_RW, LCD_EN, LCD_RS, LCD_ON);
				
				s7bittobcd to_ms(bcd_1, ics[6:0]);
				s7bittobcd to_second(bcd_2, isecond[6:0]);
				s7bittobcd to_minute(bcd_3, iminute[6:0]);
				s7bittobcd to_hour(bcd_4, ihour[6:0]);
				
				bcd ms_1(bcd_temp[6:0], bcd_1[3:0]);
				bcd ms_2(bcd_temp[13:7], bcd_1[7:4]);
				bcd s_1(bcd_temp[20:14], bcd_2[3:0]);
				bcd s_2(bcd_temp[27:21], bcd_2[7:4]);
				bcd mi_1(bcd_temp[34:28], bcd_3[3:0]);
				bcd mi_2(bcd_temp[41:35], bcd_3[7:4]);
				bcd h_1(bcd_temp[48:42], bcd_4[3:0]);
				bcd h_2(bcd_temp[55:49], bcd_4[7:4]);
				
				assign bcd_out[55:0] = ~bcd_temp[55:0];
				
					
					
				always @(posedge clock) 
					begin
						run_con <= {run_con[0], iTiming};
						zero_con <= {zero_con[0], iZero};
						if(sig_zero)
							begin
								Tcondition = 0;
								count <= 0;
								temp_ms <= 0;
							end
						else if(sig_run)
							begin
								if(Tcondition)
									Tcondition = 0;
								else 
									Tcondition = 1;
							end
						if(Tcondition)
							begin
								count <= count + 1;
								if(count % 500000 == 1)
									temp_ms <= temp_ms + 1;
							end
					end
endmodule
				
				