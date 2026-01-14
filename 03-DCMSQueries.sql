-- Për tabelën APPOINTMENTS
ALTER TABLE APPOINTMENTS DROP CONSTRAINT IF EXISTS appointments_patientid_fkey; 
ALTER TABLE APPOINTMENTS ADD CONSTRAINT fk_patient_cascade 
FOREIGN KEY (PatientID) REFERENCES PATIENTS(PatientID) ON DELETE CASCADE;

-- Për tabelën TREATMENT_DETAILS
ALTER TABLE TREATMENT_DETAILS DROP CONSTRAINT IF EXISTS treatment_details_appid_fkey;
ALTER TABLE TREATMENT_DETAILS ADD CONSTRAINT fk_app_cascade 
FOREIGN KEY (AppID) REFERENCES APPOINTMENTS(AppID) ON DELETE CASCADE;

-- Për tabelën INVOICES
ALTER TABLE INVOICES DROP CONSTRAINT IF EXISTS invoices_appid_fkey;
ALTER TABLE INVOICES ADD CONSTRAINT fk_invoice_app_cascade 
FOREIGN KEY (AppID) REFERENCES APPOINTMENTS(AppID) ON DELETE CASCADE;

-- QuantityUsed të pranojë edhe numra me presje (psh. 0.5 ml)
ALTER TABLE INVENTORY 
    ALTER COLUMN StockLevel TYPE DECIMAL(10, 2);

ALTER TABLE TREATMENT_DETAILS 
    ALTER COLUMN QuantityUsed TYPE DECIMAL(10, 2);

--Trigger--
-- 1. Krijimi i funksionit
CREATE OR REPLACE FUNCTION update_inventory_stock()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE INVENTORY 
    SET StockLevel = StockLevel - NEW.QuantityUsed
    WHERE ItemID = NEW.ItemID;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2. Krijimi i trigger-it
CREATE TRIGGER trg_update_stock
AFTER INSERT ON TREATMENT_DETAILS
FOR EACH ROW
EXECUTE FUNCTION update_inventory_stock();


--QUERIES--

-- 1 -Numri total i pacienteve te klinikes
SELECT COUNT(PatientID) AS Total_Pacientet FROM PATIENTS;

--2 Detajet e plota të trajtimit
--Pacienti, Mjeku, Shërbimi dhe Materiali i përdorur 
SELECT P.Name as Pacienti, D.Name as Mjeku, T.ServiceName, INV.ItemName
FROM APPOINTMENTS A
JOIN PATIENTS P ON A.PatientID = P.PatientID
JOIN DENTISTS D ON A.DentistID = D.DentistID
JOIN TREATMENT_DETAILS TD ON A.AppID = TD.AppID
JOIN TREATMENTS T ON TD.TreatmentID = T.TreatmentID
JOIN INVENTORY INV ON TD.ItemID = INV.ItemID;

-- 3 Ky query ndihmon stafin të shohë menjëherë listën e plotë të mjekëve të disponueshëm
--Informacion kyç për organizimin e punës në klinikë
SELECT Name, Specialization FROM DENTISTS;

-- 4 Gjetja e trajtimit më të shtrenjtë në klinikë
 SELECT MAX(Price) AS Cmimi_Maksimal FROM TREATMENTS;
 
-- 5 Renditja e inventarit sipas sasisë në depo (nga më e pakta)
SELECT ItemName, StockLevel FROM INVENTORY ORDER BY StockLevel ASC;

--6 Ky query liston pacientët që kanë vizituar klinikën më shumë se 3 herë,
--duke treguar se cilët janë klientët më besnikë (ose që kërkojnë trajtime të gjata)--
SELECT 
    p.Name AS Pacienti, 
    COUNT(a.AppID) AS Gjithsej_Vizita
FROM PATIENTS p
JOIN APPOINTMENTS a ON p.PatientID = a.PatientID
GROUP BY p.Name
HAVING COUNT(a.AppID) > 3
ORDER BY Gjithsej_Vizita DESC;

--7 Ky query identifikon shërbimet që kanë gjeneruar një fitim total prej mbi 1000 euro,
--duke i renditur sipas vlerës monetare. Kjo ndihmon në identifikimin e shërbimeve kyçe të klinikës.
SELECT 
    t.ServiceName AS Sherbimi, 
    SUM(i.TotalAmount) AS Fitimi_Total
FROM TREATMENTS t
JOIN TREATMENT_DETAILS td ON t.TreatmentID = td.TreatmentID
JOIN INVOICES i ON td.AppID = i.AppID
GROUP BY t.ServiceName
HAVING SUM(i.TotalAmount) > 1000
ORDER BY Fitimi_Total DESC;

--8-Ky query tregon cilët stomatologë janë më të angazhuar, duke listuar vetëm ata që kanë kryer
--më shumë se 5 takime, të renditur nga më i angazhuari te ai më pak.
SELECT 
    d.Name AS Stomatologu, 
    COUNT(a.AppID) AS Numri_Takimeve
FROM DENTISTS d
JOIN APPOINTMENTS a ON d.DentistID = a.DentistID
GROUP BY d.Name
HAVING COUNT(a.AppID) > 5
ORDER BY Numri_Takimeve DESC;

-- 9. Lista e takimeve të ardhshme (Scheduled)
-- Shfaq të gjitha takimet e planifikuara së bashku me emrin e pacientit dhe mjekut
-- Përdoret nga recepsioni për planifikimin ditor

SELECT 
    a.AppID,
    p.Name AS Patient,
    d.Name AS Dentist,
    a.Date
FROM APPOINTMENTS a
JOIN PATIENTS p ON a.PatientID = p.PatientID
JOIN DENTISTS d ON a.DentistID = d.DentistID
WHERE a.Status = 'Scheduled'
ORDER BY a.Date;

-- 10. Historiku i trajtimeve për një pacient specifik
-- Jep të gjitha trajtimet që i janë kryer një pacienti të caktuar
-- Përfshin datën, llojin e trajtimit dhe numrin e dhëmbit

SELECT 
    p.Name AS Patient,
    a.Date,
    t.ServiceName,
    td.ToothNumber
FROM PATIENTS p
JOIN APPOINTMENTS a ON p.PatientID = a.PatientID
JOIN TREATMENT_DETAILS td ON a.AppID = td.AppID
JOIN TREATMENTS t ON td.TreatmentID = t.TreatmentID
WHERE p.Name = 'Artiola Qollaku'
ORDER BY a.Date;

-- 11. Të ardhurat totale të gjeneruara nga secili mjek
-- Llogarit shumën e faturave për çdo dentist
-- Përdoret për analiza financiare dhe performancë të stafit

SELECT 
    d.Name AS Dentist,
    SUM(i.TotalAmount) AS TotalRevenue
FROM DENTISTS d
JOIN APPOINTMENTS a ON d.DentistID = a.DentistID
JOIN INVOICES i ON a.AppID = i.AppID
GROUP BY d.Name
ORDER BY TotalRevenue DESC;

-- 12. Trajtimet më të shpeshta
-- Numëron sa herë është kryer secili trajtim
-- Ndihmon në analizën e shërbimeve më të kërkuara

SELECT 
    t.ServiceName,
    COUNT(*) AS TimesPerformed
FROM TREATMENT_DETAILS td
JOIN TREATMENTS t ON td.TreatmentID = t.TreatmentID
GROUP BY t.ServiceName
ORDER BY TimesPerformed DESC;

-- 13. Materialet më të përdorura nga inventari
-- Llogarit sasinë totale të përdorur për çdo material
-- Përdoret për menaxhim dhe furnizim të inventarit

SELECT 
    i.ItemName,
    SUM(td.QuantityUsed) AS TotalUsed
FROM INVENTORY i
JOIN TREATMENT_DETAILS td ON i.ItemID = td.ItemID
GROUP BY i.ItemName
ORDER BY TotalUsed DESC;

-- 14. Pacientët që kanë shpenzuar më së shumti
-- Llogarit shumën totale të faturave për çdo pacient
-- Ndihmon në identifikimin e klientëve me vlerë të lartë

SELECT 
    p.Name,
    SUM(i.TotalAmount) AS TotalSpent
FROM PATIENTS p
JOIN APPOINTMENTS a ON p.PatientID = a.PatientID
JOIN INVOICES i ON a.AppID = i.AppID
GROUP BY p.Name
ORDER BY TotalSpent DESC;

-- 15. Balanca e çdo fature (sa ka mbetur pa u paguar)
-- Llogarit shumën e paguar dhe shumën e mbetur për çdo faturë
-- Query shumë i rëndësishëm për menaxhim financiar

SELECT 
    i.InvoiceID,
    i.TotalAmount,
    COALESCE(SUM(p.Amount), 0) AS PaidAmount,
    i.TotalAmount - COALESCE(SUM(p.Amount), 0) AS RemainingAmount
FROM INVOICES i
LEFT JOIN PAYMENTS p ON i.InvoiceID = p.InvoiceID
GROUP BY i.InvoiceID, i.TotalAmount;

--VIEWS--

CREATE VIEW View_Low_Stock_Alert AS
SELECT ItemName, StockLevel FROM INVENTORY WHERE StockLevel < 5;

SELECT * FROM View_Low_Stock_Alert;


CREATE OR REPLACE VIEW View_Raporti_Operacional AS
SELECT 
    p.Name AS Pacienti, 
    t.ServiceName AS Sherbimi, 
    i.TotalAmount AS Cmimi,
    a.Status AS Statusi_Takimit 
FROM PATIENTS p
JOIN APPOINTMENTS a ON p.PatientID = a.PatientID
JOIN INVOICES i ON a.AppID = i.AppID
JOIN TREATMENT_DETAILS td ON a.AppID = td.AppID
JOIN TREATMENTS t ON td.TreatmentID = t.TreatmentID
ORDER BY i.TotalAmount DESC;

select * from View_Raporti_Operacional;

--view per query 2
CREATE OR REPLACE VIEW View_Detajet_Plota_Trajtimit AS
SELECT 
    P.Name as Pacienti, 
    D.Name as Mjeku, 
    T.ServiceName AS Sherbimi, 
    INV.ItemName AS Materiali_i_Perdorur
FROM APPOINTMENTS A
JOIN PATIENTS P ON A.PatientID = P.PatientID
JOIN DENTISTS D ON A.DentistID = D.DentistID
JOIN TREATMENT_DETAILS TD ON A.AppID = TD.AppID
JOIN TREATMENTS T ON TD.TreatmentID = T.TreatmentID
JOIN INVENTORY INV ON TD.ItemID = INV.ItemID;

select * from View_Detajet_Plota_Trajtimit;

/* Ky funksion parandalon që një mjek të ketë më shumë se 1 takim në të njëjtën datë */
CREATE OR REPLACE FUNCTION checkif_dentist_availabble()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM APPOINTMENTS 
        WHERE DentistID = NEW.DentistID 
        AND Date = NEW.Date 
        AND AppID != NEW.AppID
    ) THEN
        RAISE EXCEPTION 'Mjeku është i zënë në këtë datë!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_double_booking
BEFORE INSERT OR UPDATE ON APPOINTMENTS
FOR EACH ROW
EXECUTE FUNCTION checkif_dentist_availabble();

INSERT INTO APPOINTMENTS (AppID, PatientID, DentistID, Date, Status) 
VALUES (500, 1, 1, '2026-05-10', 'Scheduled');

INSERT INTO APPOINTMENTS (AppID, PatientID, DentistID, Date, Status) 
VALUES (501, 2, 1, '2026-05-10', 'Scheduled');