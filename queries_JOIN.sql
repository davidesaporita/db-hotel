/*

Sempre utilizzando phpMyAdmin, come fatto per l’esercizio di ieri eseguire le seguenti queries:
•	Come si chiamano gli ospiti che hanno fatto più di due prenotazioni?
•	Stampare tutti gli ospiti per ogni prenotazione
•	Stampare Nome, Cognome, Prezzo e Pagante per tutte le prenotazioni fatte a Maggio 2018
•	Fai la somma di tutti i prezzi delle prenotazioni per le stanze del primo piano
•	Le stanze sono state tutte prenotate almeno una volta? (Visualizzare le stanze non ancora prenotate)
Salvare le query che ritenete corrette (una per ogni punto elencato sopra) in un file da versionare sempre nella repo usata anche per l’esercizio di ieri (db-hotel). Create un nuovo file per tenere separate le queries di ieri a quelle che farete oggi.
Bonus: Group by
•	Conta gli ospiti raggruppandoli per anno di nascita
•	Somma i prezzi dei pagamenti raggruppandoli per status
•	Quante prenotazioni ha fatto l’ospite che ha fatto più prenotazioni?
Come sempre buon lavoro e buon divertimento :thumbsup:

*/

-- Come si chiamano gli ospiti che hanno fatto più di due prenotazioni?
SELECT 
	COUNT(`prenotazioni_has_ospiti`.`ospite_id`) AS `tot_prenotazioni`,
    `ospiti`.`lastname`,
    `ospiti`.`name`
FROM `prenotazioni_has_ospiti`
INNER JOIN `ospiti`
ON `prenotazioni_has_ospiti`.`ospite_id` = `ospiti`.`id`
GROUP BY `prenotazioni_has_ospiti`.`ospite_id`
HAVING COUNT(`prenotazioni_has_ospiti`.`ospite_id`) > 2
ORDER BY `ospiti`.`lastname`;

-- Stampare tutti gli ospiti per ogni prenotazione
SELECT
	`prenotazioni_has_ospiti`.`prenotazione_id`,
    `ospiti`.`lastname`,
    `ospiti`.`name`
FROM `prenotazioni_has_ospiti`
INNER JOIN `ospiti`
ON `prenotazioni_has_ospiti`.`ospite_id` = `ospiti`.`id`
ORDER BY `prenotazioni_has_ospiti`.`created_at`;

-- Stampare Nome, Cognome, Prezzo e Pagante per tutte le prenotazioni fatte a Maggio 2018 (query da ricontrollare)
SELECT 
	`prenotazioni_has_ospiti`.`created_at` AS `Data_Prenotazione`,
	`prenotazioni_has_ospiti`.`prenotazione_id` AS `Prenotazione_ID`, 
    `ospiti`.`id` AS `Ospiti_ID`, 
	`ospiti`.`name` AS `Ospiti_Nomi`, 
    `ospiti`.`lastname` AS `Ospiti_Cognomi`,
    `paganti`.`id` AS `paganti_ID`, 
    `paganti`.`name` AS `Paganti_Nomi`, 
    `paganti`.`lastname` AS `Paganti_Cognomi`
FROM `prenotazioni_has_ospiti`
INNER JOIN `ospiti`
ON `prenotazioni_has_ospiti`.`ospite_id` = `ospiti`.`id`
LEFT JOIN `paganti`
ON `ospiti`.`id` = `paganti`.`ospite_id`
WHERE YEAR(`prenotazioni_has_ospiti`.`created_at`) = '2018'
AND MONTH(`prenotazioni_has_ospiti`.`created_at`) = '05';

-- Fai la somma di tutti i prezzi delle prenotazioni per le stanze del primo piano
SELECT SUM(`pagamenti`.`price`) AS `Totale_Incassi`
FROM `prenotazioni`
INNER JOIN `stanze`
ON `stanze`.`id` = `prenotazioni`.`stanza_id` 
AND  `stanze`.`floor` = 1
INNER JOIN `pagamenti`
ON `pagamenti`.`prenotazione_id` = `prenotazioni`.`id`;

-- Le stanze sono state tutte prenotate almeno una volta? (Visualizzare le stanze non ancora prenotate)
SELECT `stanze`.`room_number` AS `stanze_inutilizzate` 
FROM `stanze`
LEFT JOIN `prenotazioni`
ON `stanze`.`id`= `prenotazioni`.`stanza_id`
WHERE `prenotazioni`.`stanza_id` IS NULL;

-- Conta gli ospiti raggruppandoli per anno di nascita
SELECT 
    YEAR(`date_of_birth`) AS `Anno_Nascita`, 
    COUNT(`id`) AS `Ospiti`
FROM `ospiti`
GROUP BY YEAR(`date_of_birth`);

-- Somma i prezzi dei pagamenti raggruppandoli per status
SELECT 
	`status`,
    SUM(`price`) AS `Incassi`
FROM `pagamenti`
GROUP BY `status`;

-- Quante prenotazioni ha fatto l’ospite che ha fatto più prenotazioni?
SELECT 
	`ospite_id` AS `ID_Ospite`,
	COUNT(`prenotazione_id`) AS `Totale_Prenotazioni`
FROM `prenotazioni_has_ospiti`
GROUP BY `ospite_id`
ORDER BY COUNT(`prenotazione_id`) DESC
LIMIT 1;