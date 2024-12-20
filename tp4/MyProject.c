#include <built_in.h>
// LCD module connections
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

sbit RED at RC3_bit;          // LED rouge
sbit RED_Direction at TRISC3_bit;

sbit BLUE at RC2_bit;         // LED bleue
sbit BLUE_Direction at TRISC2_bit;

sbit BUZZER at RC6_bit;       // Buzzer
sbit BUZZER_Direction at TRISC6_bit;

sbit YELLOW at RC1_bit;       // LED jaune
sbit YELLOW_Direction at TRISC1_bit;

sbit GREEN at RC0_bit;        // LED GREEN
sbit GREEN_Direction at TRISC0_bit;

sbit motorentry at RC4_bit;
sbit motorentry_Direction at TRISC5_bit;

sbit motorsortie at RC5_bit;
sbit motorsortie_Direction at TRISC5_bit;

sbit RESERVER_BUTTON at RA4_bit; // Nouveau bouton de réservation
sbit RESERVE_BUTTON at RB0_bit; // Bouton de réservation
sbit ENTER_BUTTON at RB4_bit;   // Bouton "Entrer"
sbit EXIT_BUTTON at RB5_bit;    // Bouton de sortie
sbit CONSULTER_BUTTON at RA4_bit; // Nouveau bouton de réservation
#define EEPROM_ADDRESS 0x00
char txt_loading[] = "En cours de chargement";
char txt_charged[] = "Voiture chargee";
char txt_error[] = "Debit incorrect";
char txt_borne_dispo[] = "Borne X dispo";
char txt_non_dispo[] = "Non disponibles";
char txt_entrez[] = "Entrez";
char txt_reservation_confirm[] = "Confirmer reservation";
char txt_reservation_confirmed[] = "Reservation confirmee";
int available_borne = 1; // Variable pour suivre les bornes disponibles
int reservation_state = 0;

void update_vehicle_count() {
    unsigned char count = EEPROM_Read(EEPROM_ADDRESS);  // Lire le compteur actuel
    count++;                                            // Incrémenter le compteur
    EEPROM_Write(EEPROM_ADDRESS, count);               // Écrire le nouveau compteur
    while (WR);                                        // Attendre que l'écriture soit terminée
}

void display_vehicle_count() {
    if (CONSULTER_BUTTON == 0) {  // Si le bouton est pressé (niveau bas)
        Delay_ms(50);           // Anti-rebond
        if (CONSULTER_BUTTON == 0) {
            unsigned char count = EEPROM_Read(EEPROM_ADDRESS);  // Lire le compteur
            char buffer[16];
            //sprintf(buffer, "Total: %u", count);                // Convertir en texte

            Lcd_Cmd(_LCD_CLEAR);                                // Effacer l'écran LCD
            Lcd_Out(1, 1, "Voitures rechargees");
            Lcd_Out(2, 1, buffer);                             // Afficher le compteur

            while (CONSULTER_BUTTON == 0);  // Attendre que le bouton soit relâché
        }
    }
}
void main() {
    // Configurer les directions des broches
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

    Lcd_Init(); // Initialiser le LCD
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Cmd(_LCD_CURSOR_OFF);

    // Clignotement de la LED jaune
    YELLOW = 1;
    delay_ms(500);
    YELLOW = 0;
    delay_ms(500);

    Lcd_Out(1, 1, "BIENVENUE");
    Lcd_Out(2, 1, "AU KIOSQUE");
    delay_ms(500);

    while (1) {
        unsigned int debit = ADC_Read(0); // Lire la valeur analogique de AN0 (RA0)
        unsigned int pourcentage = (debit * 100) / 1023; // Calculer le pourcentage

        Lcd_Cmd(_LCD_CLEAR);
        Lcd_Out(1, 1, "Debit: ");
        // Afficher le pourcentage sur l'écran LCD
        if (pourcentage <= 25) {  // 0 à 25 % : en cours de chargement
            Lcd_Out(2, 1, txt_loading);
            RED = 1;
            delay_ms(500);
            RED = 0;
        } else if (pourcentage >= 45 && pourcentage <= 55) {  // 50 % : voiture chargée
            Lcd_Out(2, 1, txt_charged);
            BLUE = 1;
            BUZZER = 1;
            delay_ms(500);
            BLUE = 0;
            BUZZER = 0;
        } else {  // Si le débit n'est ni entre 0 et 25, ni égal à 50, afficher "Erreur"
            Lcd_Out(2, 1, txt_error);
            delay_ms(200);
        }

        // Réservation de la borne
        if (RESERVER_BUTTON == 1  && reservation_state == 0) {
            Lcd_Out(1, 1, txt_reservation_confirm);
            reservation_state = 1; // Aller à l'état de confirmation de la réservation
            delay_ms(200);
        } else if (RESERVER_BUTTON == 1 && reservation_state == 1) {
            Lcd_Out(1, 1, txt_reservation_confirmed);
            reservation_state = 2; // Réservation confirmée
            available_borne = 0;  // La borne n'est plus disponible
            delay_ms(200);
        }
        if (RESERVE_BUTTON == 1 ) {
            if (available_borne) {
                Lcd_Out(1, 1, txt_borne_dispo);
            }
            delay_ms(200);
        }

        // Accès à la borne
        if (ENTER_BUTTON == 1 && available_borne) {
            Lcd_Out(1, 1, txt_entrez);
            motorentry = 1;
            delay_ms(200);
            GREEN = 1;
            delay_ms(500);
            GREEN = 0;
        }

        // Sortie de la borne
        if (EXIT_BUTTON == 1 ) {
            available_borne = 1;
            Lcd_Out(1, 1, "Au revoir");
            Lcd_Out(2, 1, "Borne liberee");
            delay_ms(200);
            motorsortie = 1;
        }
         //update_vehicle_count();
         //display_vehicle_count();
        // Clear display and reinitialization delay to avoid blocking the code
        delay_ms(500);
    }
}