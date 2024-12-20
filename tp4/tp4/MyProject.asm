
_int_to_str:

;MyProject.c,57 :: 		void int_to_str(unsigned int value, char* str) {
;MyProject.c,59 :: 		i = 0, j = 0;
	CLRF       _i+0
	CLRF       _j+0
;MyProject.c,60 :: 		if (value == 0) {
	MOVLW      0
	XORWF      FARG_int_to_str_value+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__int_to_str51
	MOVLW      0
	XORWF      FARG_int_to_str_value+0, 0
L__int_to_str51:
	BTFSS      STATUS+0, 2
	GOTO       L_int_to_str0
;MyProject.c,61 :: 		str[i++] = '0';
	MOVF       _i+0, 0
	ADDWF      FARG_int_to_str_str+0, 0
	MOVWF      FSR
	MOVLW      48
	MOVWF      INDF+0
	INCF       _i+0, 1
;MyProject.c,62 :: 		str[i] = '\0';
	MOVF       _i+0, 0
	ADDWF      FARG_int_to_str_str+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;MyProject.c,63 :: 		return;
	GOTO       L_end_int_to_str
;MyProject.c,64 :: 		}
L_int_to_str0:
;MyProject.c,65 :: 		while (value > 0) {
L_int_to_str1:
	MOVF       FARG_int_to_str_value+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__int_to_str52
	MOVF       FARG_int_to_str_value+0, 0
	SUBLW      0
L__int_to_str52:
	BTFSC      STATUS+0, 0
	GOTO       L_int_to_str2
;MyProject.c,66 :: 		temp[i++] = (value % 10) + '0';
	MOVF       _i+0, 0
	ADDLW      int_to_str_temp_L0+0
	MOVWF      FLOC__int_to_str+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_int_to_str_value+0, 0
	MOVWF      R0+0
	MOVF       FARG_int_to_str_value+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__int_to_str+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       _i+0, 1
;MyProject.c,67 :: 		value /= 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_int_to_str_value+0, 0
	MOVWF      R0+0
	MOVF       FARG_int_to_str_value+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_int_to_str_value+0
	MOVF       R0+1, 0
	MOVWF      FARG_int_to_str_value+1
;MyProject.c,68 :: 		}
	GOTO       L_int_to_str1
L_int_to_str2:
;MyProject.c,69 :: 		i--;
	DECF       _i+0, 1
;MyProject.c,70 :: 		while (i >= 0) {
L_int_to_str3:
	MOVLW      0
	SUBWF      _i+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_int_to_str4
;MyProject.c,71 :: 		str[j++] = temp[i--];
	MOVF       _j+0, 0
	ADDWF      FARG_int_to_str_str+0, 0
	MOVWF      R1+0
	MOVF       _i+0, 0
	ADDLW      int_to_str_temp_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       _j+0, 1
	DECF       _i+0, 1
;MyProject.c,72 :: 		}
	GOTO       L_int_to_str3
L_int_to_str4:
;MyProject.c,73 :: 		str[j] = '\0';
	MOVF       _j+0, 0
	ADDWF      FARG_int_to_str_str+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;MyProject.c,74 :: 		}
L_end_int_to_str:
	RETURN
; end of _int_to_str

_update_vehicle_count:

;MyProject.c,76 :: 		void update_vehicle_count() {
;MyProject.c,77 :: 		unsigned char count = EEPROM_Read(EEPROM_ADDRESS);  // Lire le compteur actuel
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
;MyProject.c,78 :: 		count++;                                            // Incrémenter le compteur
	INCF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
;MyProject.c,79 :: 		EEPROM_Write(EEPROM_ADDRESS, count);               // Écrire le nouveau compteur
	CLRF       FARG_EEPROM_Write_Address+0
	CALL       _EEPROM_Write+0
;MyProject.c,80 :: 		while (WR);                                        // Attendre que l'écriture soit terminée
L_update_vehicle_count5:
	GOTO       L_update_vehicle_count5
;MyProject.c,81 :: 		}
L_end_update_vehicle_count:
	RETURN
; end of _update_vehicle_count

_display_vehicle_count:

;MyProject.c,83 :: 		void display_vehicle_count() {
;MyProject.c,84 :: 		if (CONSULTER_BUTTON == 0) {  // Si le bouton est pressé (niveau bas)
	BTFSC      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_display_vehicle_count7
;MyProject.c,85 :: 		Delay_ms(50);           // Anti-rebond
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_display_vehicle_count8:
	DECFSZ     R13+0, 1
	GOTO       L_display_vehicle_count8
	DECFSZ     R12+0, 1
	GOTO       L_display_vehicle_count8
	NOP
	NOP
;MyProject.c,86 :: 		if (CONSULTER_BUTTON == 0) {
	BTFSC      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_display_vehicle_count9
;MyProject.c,87 :: 		unsigned char count = EEPROM_Read(EEPROM_ADDRESS);  // Lire le compteur
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
;MyProject.c,90 :: 		int_to_str(count,buffer);
	MOVF       R0+0, 0
	MOVWF      FARG_int_to_str_value+0
	CLRF       FARG_int_to_str_value+1
	MOVLW      display_vehicle_count_buffer_L2+0
	MOVWF      FARG_int_to_str_str+0
	CALL       _int_to_str+0
;MyProject.c,91 :: 		Lcd_Cmd(_LCD_CLEAR);                                // Effacer l'écran LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,92 :: 		Lcd_Out(1, 1, "Voitures rechargees");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,93 :: 		Lcd_Out(2, 1, buffer);                             // Afficher le compteur
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      display_vehicle_count_buffer_L2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,95 :: 		while (CONSULTER_BUTTON == 0);  // Attendre que le bouton soit relâché
L_display_vehicle_count10:
	BTFSC      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_display_vehicle_count11
	GOTO       L_display_vehicle_count10
L_display_vehicle_count11:
;MyProject.c,96 :: 		}
L_display_vehicle_count9:
;MyProject.c,97 :: 		}
L_display_vehicle_count7:
;MyProject.c,98 :: 		}
L_end_display_vehicle_count:
	RETURN
; end of _display_vehicle_count

_main:

;MyProject.c,101 :: 		void main() {
;MyProject.c,103 :: 		LCD_RS_Direction = 0;
	BCF        TRISD4_bit+0, BitPos(TRISD4_bit+0)
;MyProject.c,104 :: 		LCD_EN_Direction = 0;
	BCF        TRISD5_bit+0, BitPos(TRISD5_bit+0)
;MyProject.c,105 :: 		LCD_D4_Direction = 0;
	BCF        TRISD0_bit+0, BitPos(TRISD0_bit+0)
;MyProject.c,106 :: 		LCD_D5_Direction = 0;
	BCF        TRISD1_bit+0, BitPos(TRISD1_bit+0)
;MyProject.c,107 :: 		LCD_D6_Direction = 0;
	BCF        TRISD2_bit+0, BitPos(TRISD2_bit+0)
;MyProject.c,108 :: 		LCD_D7_Direction = 0;
	BCF        TRISD3_bit+0, BitPos(TRISD3_bit+0)
;MyProject.c,110 :: 		GREEN_Direction = 0;
	BCF        TRISC0_bit+0, BitPos(TRISC0_bit+0)
;MyProject.c,111 :: 		RED_Direction = 0;
	BCF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
;MyProject.c,112 :: 		BLUE_Direction = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;MyProject.c,113 :: 		BUZZER_Direction = 0;
	BCF        TRISC6_bit+0, BitPos(TRISC6_bit+0)
;MyProject.c,114 :: 		YELLOW_Direction = 0;
	BCF        TRISC1_bit+0, BitPos(TRISC1_bit+0)
;MyProject.c,115 :: 		motorentry_Direction = 0;
	BCF        TRISC5_bit+0, BitPos(TRISC5_bit+0)
;MyProject.c,116 :: 		motorsortie_Direction = 0;
	BCF        TRISC5_bit+0, BitPos(TRISC5_bit+0)
;MyProject.c,118 :: 		RED = 0;
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;MyProject.c,119 :: 		BLUE = 0;
	BCF        RC2_bit+0, BitPos(RC2_bit+0)
;MyProject.c,120 :: 		BUZZER = 0;
	BCF        RC6_bit+0, BitPos(RC6_bit+0)
;MyProject.c,121 :: 		YELLOW = 0;
	BCF        RC1_bit+0, BitPos(RC1_bit+0)
;MyProject.c,122 :: 		GREEN = 0;
	BCF        RC0_bit+0, BitPos(RC0_bit+0)
;MyProject.c,123 :: 		motorentry = 0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;MyProject.c,124 :: 		motorsortie = 0;
	BCF        RC5_bit+0, BitPos(RC5_bit+0)
;MyProject.c,126 :: 		Lcd_Init(); // Initialiser le LCD
	CALL       _Lcd_Init+0
;MyProject.c,127 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,128 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,131 :: 		YELLOW = 1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;MyProject.c,132 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
	NOP
	NOP
;MyProject.c,133 :: 		YELLOW = 0;
	BCF        RC1_bit+0, BitPos(RC1_bit+0)
;MyProject.c,134 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	DECFSZ     R11+0, 1
	GOTO       L_main13
	NOP
	NOP
;MyProject.c,136 :: 		Lcd_Out(1, 1, "BIENVENUE");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,137 :: 		Lcd_Out(2, 1, "AU KIOSQUE");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,138 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	DECFSZ     R11+0, 1
	GOTO       L_main14
	NOP
	NOP
;MyProject.c,140 :: 		while (1) {
L_main15:
;MyProject.c,141 :: 		unsigned int debit = ADC_Read(0); // Lire la valeur analogique de AN0 (RA0)
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;MyProject.c,142 :: 		unsigned int pourcentage = (debit * 100) / 1023; // Calculer le pourcentage
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      main_pourcentage_L1+0
	MOVF       R0+1, 0
	MOVWF      main_pourcentage_L1+1
;MyProject.c,144 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,145 :: 		Lcd_Out(1, 1, "Debit: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,147 :: 		if (pourcentage <= 25) {  // 0 à 25 % : en cours de chargement
	MOVF       main_pourcentage_L1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVF       main_pourcentage_L1+0, 0
	SUBLW      25
L__main56:
	BTFSS      STATUS+0, 0
	GOTO       L_main17
;MyProject.c,148 :: 		Lcd_Out(2, 1, txt_loading);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_loading+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,149 :: 		RED = 1;
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;MyProject.c,150 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	DECFSZ     R11+0, 1
	GOTO       L_main18
	NOP
	NOP
;MyProject.c,151 :: 		RED = 0;
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;MyProject.c,152 :: 		} else if (pourcentage >= 45 && pourcentage <= 55) {  // 50 % : voiture chargée
	GOTO       L_main19
L_main17:
	MOVLW      0
	SUBWF      main_pourcentage_L1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVLW      45
	SUBWF      main_pourcentage_L1+0, 0
L__main57:
	BTFSS      STATUS+0, 0
	GOTO       L_main22
	MOVF       main_pourcentage_L1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	MOVF       main_pourcentage_L1+0, 0
	SUBLW      55
L__main58:
	BTFSS      STATUS+0, 0
	GOTO       L_main22
L__main49:
;MyProject.c,153 :: 		Lcd_Out(2, 1, txt_charged);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_charged+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,154 :: 		BLUE = 1;
	BSF        RC2_bit+0, BitPos(RC2_bit+0)
;MyProject.c,155 :: 		BUZZER = 1;
	BSF        RC6_bit+0, BitPos(RC6_bit+0)
;MyProject.c,156 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main23:
	DECFSZ     R13+0, 1
	GOTO       L_main23
	DECFSZ     R12+0, 1
	GOTO       L_main23
	DECFSZ     R11+0, 1
	GOTO       L_main23
	NOP
	NOP
;MyProject.c,157 :: 		BLUE = 0;
	BCF        RC2_bit+0, BitPos(RC2_bit+0)
;MyProject.c,158 :: 		BUZZER = 0;
	BCF        RC6_bit+0, BitPos(RC6_bit+0)
;MyProject.c,159 :: 		} else {  // Si le débit n'est ni entre 0 et 25, ni égal à 50, afficher "Erreur"
	GOTO       L_main24
L_main22:
;MyProject.c,160 :: 		Lcd_Out(2, 1, txt_error);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_error+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,161 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	DECFSZ     R11+0, 1
	GOTO       L_main25
;MyProject.c,162 :: 		}
L_main24:
L_main19:
;MyProject.c,165 :: 		if (RESERVER_BUTTON == 1  && reservation_state == 0) {
	BTFSS      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_main28
	MOVLW      0
	XORWF      _reservation_state+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVLW      0
	XORWF      _reservation_state+0, 0
L__main59:
	BTFSS      STATUS+0, 2
	GOTO       L_main28
L__main48:
;MyProject.c,166 :: 		Lcd_Out(1, 1, txt_reservation_confirm);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_reservation_confirm+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,167 :: 		reservation_state = 1; // Aller à l'état de confirmation de la réservation
	MOVLW      1
	MOVWF      _reservation_state+0
	MOVLW      0
	MOVWF      _reservation_state+1
;MyProject.c,168 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main29:
	DECFSZ     R13+0, 1
	GOTO       L_main29
	DECFSZ     R12+0, 1
	GOTO       L_main29
	DECFSZ     R11+0, 1
	GOTO       L_main29
;MyProject.c,169 :: 		} else if (RESERVER_BUTTON == 1 && reservation_state == 1) {
	GOTO       L_main30
L_main28:
	BTFSS      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_main33
	MOVLW      0
	XORWF      _reservation_state+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVLW      1
	XORWF      _reservation_state+0, 0
L__main60:
	BTFSS      STATUS+0, 2
	GOTO       L_main33
L__main47:
;MyProject.c,170 :: 		Lcd_Out(1, 1, txt_reservation_confirmed);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_reservation_confirmed+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,171 :: 		reservation_state = 2; // Réservation confirmée
	MOVLW      2
	MOVWF      _reservation_state+0
	MOVLW      0
	MOVWF      _reservation_state+1
;MyProject.c,172 :: 		available_borne = 0;  // La borne n'est plus disponible
	CLRF       _available_borne+0
	CLRF       _available_borne+1
;MyProject.c,173 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	DECFSZ     R12+0, 1
	GOTO       L_main34
	DECFSZ     R11+0, 1
	GOTO       L_main34
;MyProject.c,174 :: 		}
L_main33:
L_main30:
;MyProject.c,175 :: 		if (RESERVE_BUTTON == 1 ) {
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_main35
;MyProject.c,176 :: 		if (available_borne) {
	MOVF       _available_borne+0, 0
	IORWF      _available_borne+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main36
;MyProject.c,177 :: 		Lcd_Out(1, 1, txt_borne_dispo);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_borne_dispo+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,178 :: 		}
L_main36:
;MyProject.c,179 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main37:
	DECFSZ     R13+0, 1
	GOTO       L_main37
	DECFSZ     R12+0, 1
	GOTO       L_main37
	DECFSZ     R11+0, 1
	GOTO       L_main37
;MyProject.c,180 :: 		}
L_main35:
;MyProject.c,183 :: 		if (ENTER_BUTTON == 1 && available_borne) {
	BTFSS      RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L_main40
	MOVF       _available_borne+0, 0
	IORWF      _available_borne+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main40
L__main46:
;MyProject.c,184 :: 		Lcd_Out(1, 1, txt_entrez);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_entrez+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,185 :: 		motorentry = 1;
	BSF        RC4_bit+0, BitPos(RC4_bit+0)
;MyProject.c,186 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
	DECFSZ     R11+0, 1
	GOTO       L_main41
;MyProject.c,187 :: 		GREEN = 1;
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
;MyProject.c,188 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main42:
	DECFSZ     R13+0, 1
	GOTO       L_main42
	DECFSZ     R12+0, 1
	GOTO       L_main42
	DECFSZ     R11+0, 1
	GOTO       L_main42
	NOP
	NOP
;MyProject.c,189 :: 		GREEN = 0;
	BCF        RC0_bit+0, BitPos(RC0_bit+0)
;MyProject.c,190 :: 		}
L_main40:
;MyProject.c,193 :: 		if (EXIT_BUTTON == 1 ) {
	BTFSS      RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L_main43
;MyProject.c,194 :: 		available_borne = 1;
	MOVLW      1
	MOVWF      _available_borne+0
	MOVLW      0
	MOVWF      _available_borne+1
;MyProject.c,195 :: 		Lcd_Out(1, 1, "Au revoir");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,196 :: 		Lcd_Out(2, 1, "Borne liberee");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,197 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main44:
	DECFSZ     R13+0, 1
	GOTO       L_main44
	DECFSZ     R12+0, 1
	GOTO       L_main44
	DECFSZ     R11+0, 1
	GOTO       L_main44
;MyProject.c,198 :: 		motorsortie = 1;
	BSF        RC5_bit+0, BitPos(RC5_bit+0)
;MyProject.c,199 :: 		}
L_main43:
;MyProject.c,203 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main45:
	DECFSZ     R13+0, 1
	GOTO       L_main45
	DECFSZ     R12+0, 1
	GOTO       L_main45
	DECFSZ     R11+0, 1
	GOTO       L_main45
	NOP
	NOP
;MyProject.c,204 :: 		}
	GOTO       L_main15
;MyProject.c,205 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
