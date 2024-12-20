#line 1 "C:/Users/touai/Downloads/tp4/tp4/MyProject.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 3 "C:/Users/touai/Downloads/tp4/tp4/MyProject.c"
sbit LCD_RS at RD4_bit;
sbit LCD_EN at RD5_bit;
sbit LCD_D4 at RD0_bit;
sbit LCD_D5 at RD1_bit;
sbit LCD_D6 at RD2_bit;
sbit LCD_D7 at RD3_bit;

sbit LCD_RS_Direction at TRISD4_bit;
sbit LCD_EN_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD0_bit;
sbit LCD_D5_Direction at TRISD1_bit;
sbit LCD_D6_Direction at TRISD2_bit;
sbit LCD_D7_Direction at TRISD3_bit;

sbit RED at RC3_bit;
sbit RED_Direction at TRISC3_bit;

sbit BLUE at RC2_bit;
sbit BLUE_Direction at TRISC2_bit;

sbit BUZZER at RC6_bit;
sbit BUZZER_Direction at TRISC6_bit;

sbit YELLOW at RC1_bit;
sbit YELLOW_Direction at TRISC1_bit;

sbit GREEN at RC0_bit;
sbit GREEN_Direction at TRISC0_bit;

sbit motorentry at RC4_bit;
sbit motorentry_Direction at TRISC5_bit;

sbit motorsortie at RC5_bit;
sbit motorsortie_Direction at TRISC5_bit;

sbit RESERVER_BUTTON at RA4_bit;
sbit RESERVE_BUTTON at RB0_bit;
sbit ENTER_BUTTON at RB4_bit;
sbit EXIT_BUTTON at RB5_bit;
sbit CONSULTER_BUTTON at RA4_bit;

char txt_loading[] = "En cours de chargement";
char txt_charged[] = "Voiture chargee";
char txt_error[] = "Debit incorrect";
char txt_borne_dispo[] = "Borne X dispo";
char txt_non_dispo[] = "Non disponibles";
char txt_entrez[] = "Entrez";
char txt_reservation_confirm[] = "Confirmer reservation";
char txt_reservation_confirmed[] = "Reservation confirmee";
int available_borne = 1;
int reservation_state = 0;
unsigned char i, j;


void int_to_str(unsigned int value, char* str) {
 char temp[6];
 i = 0, j = 0;
 if (value == 0) {
 str[i++] = '0';
 str[i] = '\0';
 return;
 }
 while (value > 0) {
 temp[i++] = (value % 10) + '0';
 value /= 10;
 }
 i--;
 while (i >= 0) {
 str[j++] = temp[i--];
 }
 str[j] = '\0';
}

void update_vehicle_count() {
 unsigned char count = EEPROM_Read( 0x00 );
 count++;
 EEPROM_Write( 0x00 , count);
 while (WR);
}

void display_vehicle_count() {
 if (CONSULTER_BUTTON == 0) {
 Delay_ms(50);
 if (CONSULTER_BUTTON == 0) {
 unsigned char count = EEPROM_Read( 0x00 );
 char buffer[16];

 int_to_str(count,buffer);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Voitures rechargees");
 Lcd_Out(2, 1, buffer);

 while (CONSULTER_BUTTON == 0);
 }
 }
}


void main() {

 LCD_RS_Direction = 0;
 LCD_EN_Direction = 0;
 LCD_D4_Direction = 0;
 LCD_D5_Direction = 0;
 LCD_D6_Direction = 0;
 LCD_D7_Direction = 0;

 GREEN_Direction = 0;
 RED_Direction = 0;
 BLUE_Direction = 0;
 BUZZER_Direction = 0;
 YELLOW_Direction = 0;
 motorentry_Direction = 0;
 motorsortie_Direction = 0;

 RED = 0;
 BLUE = 0;
 BUZZER = 0;
 YELLOW = 0;
 GREEN = 0;
 motorentry = 0;
 motorsortie = 0;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 YELLOW = 1;
 delay_ms(500);
 YELLOW = 0;
 delay_ms(500);

 Lcd_Out(1, 1, "BIENVENUE");
 Lcd_Out(2, 1, "AU KIOSQUE");
 delay_ms(500);

 while (1) {
 unsigned int debit = ADC_Read(0);
 unsigned int pourcentage = (debit * 100) / 1023;

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Debit: ");

 if (pourcentage <= 25) {
 Lcd_Out(2, 1, txt_loading);
 RED = 1;
 delay_ms(500);
 RED = 0;
 } else if (pourcentage >= 45 && pourcentage <= 55) {
 Lcd_Out(2, 1, txt_charged);
 BLUE = 1;
 BUZZER = 1;
 delay_ms(500);
 BLUE = 0;
 BUZZER = 0;
 } else {
 Lcd_Out(2, 1, txt_error);
 delay_ms(200);
 }


 if (RESERVER_BUTTON == 1 && reservation_state == 0) {
 Lcd_Out(1, 1, txt_reservation_confirm);
 reservation_state = 1;
 delay_ms(200);
 } else if (RESERVER_BUTTON == 1 && reservation_state == 1) {
 Lcd_Out(1, 1, txt_reservation_confirmed);
 reservation_state = 2;
 available_borne = 0;
 delay_ms(200);
 }
 if (RESERVE_BUTTON == 1 ) {
 if (available_borne) {
 Lcd_Out(1, 1, txt_borne_dispo);
 }
 delay_ms(200);
 }


 if (ENTER_BUTTON == 1 && available_borne) {
 Lcd_Out(1, 1, txt_entrez);
 motorentry = 1;
 delay_ms(200);
 GREEN = 1;
 delay_ms(500);
 GREEN = 0;
 }


 if (EXIT_BUTTON == 1 ) {
 available_borne = 1;
 Lcd_Out(1, 1, "Au revoir");
 Lcd_Out(2, 1, "Borne liberee");
 delay_ms(200);
 motorsortie = 1;
 }



 delay_ms(500);
 }
}
