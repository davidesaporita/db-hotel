-- Tutti gli ospiti identificati con la carta di identità
SELECT * 
FROM `ospiti`
WHERE `document_type` = 'CI';

-- Tutti gli ospiti nati dopo il 1988
SELECT * 
FROM `ospiti`
WHERE `date_of_birth` > '1988-01-01';

-- Tutti gli ospiti nati dopo il 1988
SELECT * 
FROM `ospiti`
WHERE `date_of_birth` < CURRENT_DATE() - DATE('0020-00-00');

-- Tutti gli ospiti il cui nome inizia con la D
SELECT * 
FROM `ospiti`
WHERE `name` LIKE 'D%';

-- Totale degli ordini accepted
SELECT SUM(`price`)
FROM `pagamenti` 
WHERE `status` = 'accepted';

-- Prezzo massimo pagato
SELECT MAX(`price`)
FROM `pagamenti` 
WHERE `status` = 'accepted';

-- Ospiti riconosciuti con patente e nati nel 1975
SELECT * 
FROM `ospiti`
WHERE `document_type` = 'Driver License' 
AND YEAR(`date_of_birth`) = '1975';

-- Quanti posti letto ha l’hotel in totale?
SELECT SUM(`beds`) 
FROM `stanze`;