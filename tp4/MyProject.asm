
_update_vehicle_count:

;MyProject.c,55 :: 		void update_vehicle_count() {
;MyProject.c,56 :: 		unsigned char count = EEPROM_Read(EEPROM_ADDRESS);  // Lire le compteur actuel
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
;MyProject.c,57 :: 		count++;                                            // Incrémenter le compteur
	INCF       R0+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
;MyProject.c,58 :: 		EEPROM_Write(EEPROM_ADDRESS, count);               // Écrire le nouveau compteur
	CLRF       FARG_EEPROM_Write_Address+0
	CALL       _EEPROM_Write+0
;MyProject.c,59 :: 		while (WR);                                        // Attendre que l'écriture soit terminée
L_update_vehicle_count0:
	GOTO       L_update_vehicle_count0
;MyProject.c,60 :: 		}
L_end_update_vehicle_count:
	RETURN
; end of _update_vehicle_count

_display_vehicle_count:

;MyProject.c,62 :: 		void display_vehicle_count() {
;MyProject.c,63 :: 		if (CONSULTER_BUTTON == 0) {  // Si le bouton est pressé (niveau bas)
	BTFSC      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_display_vehicle_count2
;MyProject.c,64 :: 		Delay_ms(50);           // Anti-rebond
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_display_vehicle_count3:
	DECFSZ     R13+0, 1
	GOTO       L_display_vehicle_count3
	DECFSZ     R12+0, 1
	GOTO       L_display_vehicle_count3
	NOP
	NOP
;MyProject.c,65 :: 		if (CONSULTER_BUTTON == 0) {
	BTFSC      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_display_vehicle_count4
;MyProject.c,66 :: 		unsigned char count = EEPROM_Read(EEPROM_ADDRESS);  // Lire le compteur
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
;MyProject.c,70 :: 		Lcd_Cmd(_LCD_CLEAR);                                // Effacer l'écran LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,71 :: 		Lcd_Out(1, 1, "Voitures rechargees");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,72 :: 		Lcd_Out(2, 1, buffer);                             // Afficher le compteur
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      display_vehicle_count_buffer_L2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,74 :: 		while (CONSULTER_BUTTON == 0);  // Attendre que le bouton soit relâché
L_display_vehicle_count5:
	BTFSC      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_display_vehicle_count6
	GOTO       L_display_vehicle_count5
L_display_vehicle_count6:
;MyProject.c,75 :: 		}
L_display_vehicle_count4:
;MyProject.c,76 :: 		}
L_display_vehicle_count2:
;MyProject.c,77 :: 		}
L_end_display_vehicle_count:
	RETURN
; end of _display_vehicle_count

_main:

;MyProject.c,78 :: 		void main() {
;MyProject.c,80 :: 		LCD_RS_Direction = 0;
	BCF        TRISD4_bit+0, BitPos(TRISD4_bit+0)
;MyProject.c,81 :: 		LCD_EN_Direction = 0;
	BCF        TRISD5_bit+0, BitPos(TRISD5_bit+0)
;MyProject.c,82 :: 		LCD_D4_Direction = 0;
	BCF        TRISD0_bit+0, BitPos(TRISD0_bit+0)
;MyProject.c,83 :: 		LCD_D5_Direction = 0;
	BCF        TRISD1_bit+0, BitPos(TRISD1_bit+0)
;MyProject.c,84 :: 		LCD_D6_Direction = 0;
	BCF        TRISD2_bit+0, BitPos(TRISD2_bit+0)
;MyProject.c,85 :: 		LCD_D7_Direction = 0;
	BCF        TRISD3_bit+0, BitPos(TRISD3_bit+0)
;MyProject.c,87 :: 		GREEN_Direction = 0;
	BCF        TRISC0_bit+0, BitPos(TRISC0_bit+0)
;MyProject.c,88 :: 		RED_Direction = 0;
	BCF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
;MyProject.c,89 :: 		BLUE_Direction = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;MyProject.c,90 :: 		BUZZER_Direction = 0;
	BCF        TRISC6_bit+0, BitPos(TRISC6_bit+0)
;MyProject.c,91 :: 		YELLOW_Direction = 0;
	BCF        TRISC1_bit+0, BitPos(TRISC1_bit+0)
;MyProject.c,92 :: 		motorentry_Direction = 0;
	BCF        TRISC5_bit+0, BitPos(TRISC5_bit+0)
;MyProject.c,93 :: 		motorsortie_Direction = 0;
	BCF        TRISC5_bit+0, BitPos(TRISC5_bit+0)
;MyProject.c,95 :: 		RED = 0;
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;MyProject.c,96 :: 		BLUE = 0;
	BCF        RC2_bit+0, BitPos(RC2_bit+0)
;MyProject.c,97 :: 		BUZZER = 0;
	BCF        RC6_bit+0, BitPos(RC6_bit+0)
;MyProject.c,98 :: 		YELLOW = 0;
	BCF        RC1_bit+0, BitPos(RC1_bit+0)
;MyProject.c,99 :: 		GREEN = 0;
	BCF        RC0_bit+0, BitPos(RC0_bit+0)
;MyProject.c,100 :: 		motorentry = 0;
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;MyProject.c,101 :: 		motorsortie = 0;
	BCF        RC5_bit+0, BitPos(RC5_bit+0)
;MyProject.c,103 :: 		Lcd_Init(); // Initialiser le LCD
	CALL       _Lcd_Init+0
;MyProject.c,104 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,105 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,108 :: 		YELLOW = 1;
	BSF        RC1_bit+0, BitPos(RC1_bit+0)
;MyProject.c,109 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
	NOP
;MyProject.c,110 :: 		YELLOW = 0;
	BCF        RC1_bit+0, BitPos(RC1_bit+0)
;MyProject.c,111 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
	NOP
;MyProject.c,113 :: 		Lcd_Out(1, 1, "BIENVENUE");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,114 :: 		Lcd_Out(2, 1, "AU KIOSQUE");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,115 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	DECFSZ     R11+0, 1
	GOTO       L_main9
	NOP
	NOP
;MyProject.c,117 :: 		while (1) {
L_main10:
;MyProject.c,118 :: 		unsigned int debit = ADC_Read(0); // Lire la valeur analogique de AN0 (RA0)
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;MyProject.c,119 :: 		unsigned int pourcentage = (debit * 100) / 1023; // Calculer le pourcentage
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
;MyProject.c,121 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,122 :: 		Lcd_Out(1, 1, "Debit: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,124 :: 		if (pourcentage <= 25) {  // 0 à 25 % : en cours de chargement
	MOVF       main_pourcentage_L1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main48
	MOVF       main_pourcentage_L1+0, 0
	SUBLW      25
L__main48:
	BTFSS      STATUS+0, 0
	GOTO       L_main12
;MyProject.c,125 :: 		Lcd_Out(2, 1, txt_loading);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_loading+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,126 :: 		RED = 1;
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;MyProject.c,127 :: 		delay_ms(500);
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
;MyProject.c,128 :: 		RED = 0;
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;MyProject.c,129 :: 		} else if (pourcentage >= 45 && pourcentage <= 55) {  // 50 % : voiture chargée
	GOTO       L_main14
L_main12:
	MOVLW      0
	SUBWF      main_pourcentage_L1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVLW      45
	SUBWF      main_pourcentage_L1+0, 0
L__main49:
	BTFSS      STATUS+0, 0
	GOTO       L_main17
	MOVF       main_pourcentage_L1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVF       main_pourcentage_L1+0, 0
	SUBLW      55
L__main50:
	BTFSS      STATUS+0, 0
	GOTO       L_main17
L__main44:
;MyProject.c,130 :: 		Lcd_Out(2, 1, txt_charged);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_charged+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,131 :: 		BLUE = 1;
	BSF        RC2_bit+0, BitPos(RC2_bit+0)
;MyProject.c,132 :: 		BUZZER = 1;
	BSF        RC6_bit+0, BitPos(RC6_bit+0)
;MyProject.c,133 :: 		delay_ms(500);
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
;MyProject.c,134 :: 		BLUE = 0;
	BCF        RC2_bit+0, BitPos(RC2_bit+0)
;MyProject.c,135 :: 		BUZZER = 0;
	BCF        RC6_bit+0, BitPos(RC6_bit+0)
;MyProject.c,136 :: 		} else {  // Si le débit n'est ni entre 0 et 25, ni égal à 50, afficher "Erreur"
	GOTO       L_main19
L_main17:
;MyProject.c,137 :: 		Lcd_Out(2, 1, txt_error);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_error+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,138 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	DECFSZ     R11+0, 1
	GOTO       L_main20
;MyProject.c,139 :: 		}
L_main19:
L_main14:
;MyProject.c,142 :: 		if (RESERVER_BUTTON == 1  && reservation_state == 0) {
	BTFSS      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_main23
	MOVLW      0
	XORWF      _reservation_state+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVLW      0
	XORWF      _reservation_state+0, 0
L__main51:
	BTFSS      STATUS+0, 2
	GOTO       L_main23
L__main43:
;MyProject.c,143 :: 		Lcd_Out(1, 1, txt_reservation_confirm);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_reservation_confirm+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,144 :: 		reservation_state = 1; // Aller à l'état de confirmation de la réservation
	MOVLW      1
	MOVWF      _reservation_state+0
	MOVLW      0
	MOVWF      _reservation_state+1
;MyProject.c,145 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main24:
	DECFSZ     R13+0, 1
	GOTO       L_main24
	DECFSZ     R12+0, 1
	GOTO       L_main24
	DECFSZ     R11+0, 1
	GOTO       L_main24
;MyProject.c,146 :: 		} else if (RESERVER_BUTTON == 1 && reservation_state == 1) {
	GOTO       L_main25
L_main23:
	BTFSS      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_main28
	MOVLW      0
	XORWF      _reservation_state+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVLW      1
	XORWF      _reservation_state+0, 0
L__main52:
	BTFSS      STATUS+0, 2
	GOTO       L_main28
L__main42:
;MyProject.c,147 :: 		Lcd_Out(1, 1, txt_reservation_confirmed);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_reservation_confirmed+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,148 :: 		reservation_state = 2; // Réservation confirmée
	MOVLW      2
	MOVWF      _reservation_state+0
	MOVLW      0
	MOVWF      _reservation_state+1
;MyProject.c,149 :: 		available_borne = 0;  // La borne n'est plus disponible
	CLRF       _available_borne+0
	CLRF       _available_borne+1
;MyProject.c,150 :: 		delay_ms(200);
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
;MyProject.c,151 :: 		}
L_main28:
L_main25:
;MyProject.c,152 :: 		if (RESERVE_BUTTON == 1 ) {
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_main30
;MyProject.c,153 :: 		if (available_borne) {
	MOVF       _available_borne+0, 0
	IORWF      _available_borne+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main31
;MyProject.c,154 :: 		Lcd_Out(1, 1, txt_borne_dispo);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_borne_dispo+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,155 :: 		}
L_main31:
;MyProject.c,156 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main32:
	DECFSZ     R13+0, 1
	GOTO       L_main32
	DECFSZ     R12+0, 1
	GOTO       L_main32
	DECFSZ     R11+0, 1
	GOTO       L_main32
;MyProject.c,157 :: 		}
L_main30:
;MyProject.c,160 :: 		if (ENTER_BUTTON == 1 && available_borne) {
	BTFSS      RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L_main35
	MOVF       _available_borne+0, 0
	IORWF      _available_borne+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main35
L__main41:
;MyProject.c,161 :: 		Lcd_Out(1, 1, txt_entrez);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_entrez+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,162 :: 		motorentry = 1;
	BSF        RC4_bit+0, BitPos(RC4_bit+0)
;MyProject.c,163 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main36:
	DECFSZ     R13+0, 1
	GOTO       L_main36
	DECFSZ     R12+0, 1
	GOTO       L_main36
	DECFSZ     R11+0, 1
	GOTO       L_main36
;MyProject.c,164 :: 		GREEN = 1;
	BSF        RC0_bit+0, BitPos(RC0_bit+0)
;MyProject.c,165 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main37:
	DECFSZ     R13+0, 1
	GOTO       L_main37
	DECFSZ     R12+0, 1
	GOTO       L_main37
	DECFSZ     R11+0, 1
	GOTO       L_main37
	NOP
	NOP
;MyProject.c,166 :: 		GREEN = 0;
	BCF        RC0_bit+0, BitPos(RC0_bit+0)
;MyProject.c,167 :: 		}
L_main35:
;MyProject.c,170 :: 		if (EXIT_BUTTON == 1 ) {
	BTFSS      RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L_main38
;MyProject.c,171 :: 		available_borne = 1;
	MOVLW      1
	MOVWF      _available_borne+0
	MOVLW      0
	MOVWF      _available_borne+1
;MyProject.c,172 :: 		Lcd_Out(1, 1, "Au revoir");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,173 :: 		Lcd_Out(2, 1, "Borne liberee");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,174 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main39:
	DECFSZ     R13+0, 1
	GOTO       L_main39
	DECFSZ     R12+0, 1
	GOTO       L_main39
	DECFSZ     R11+0, 1
	GOTO       L_main39
;MyProject.c,175 :: 		motorsortie = 1;
	BSF        RC5_bit+0, BitPos(RC5_bit+0)
;MyProject.c,176 :: 		}
L_main38:
;MyProject.c,180 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main40:
	DECFSZ     R13+0, 1
	GOTO       L_main40
	DECFSZ     R12+0, 1
	GOTO       L_main40
	DECFSZ     R11+0, 1
	GOTO       L_main40
	NOP
	NOP
;MyProject.c,181 :: 		}
	GOTO       L_main10
;MyProject.c,182 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
