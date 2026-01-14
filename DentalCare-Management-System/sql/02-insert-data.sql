-- 1. TABELA PATIENTS (15 rreshta) 
INSERT INTO PATIENTS (PatientID, Name, Phone, DateOfBirth) VALUES 
(1, 'Artiola Qollaku', '044111222', '2000-01-01'), 
(2, 'Enis Hetemi', '049333444', '1995-05-15'), 
(3, 'Blerina Gashi', '044555666', '1988-10-20'), 
(4, 'Dardan Krasniqi', '045777888', '1992-03-12'), 
(5, 'Edona Shala', '044999000', '2001-07-25'), 
(6, 'Faton Hoxha', '049111333', '1985-12-30'), 
(7, 'Genta Rama', '045222444', '1998-02-14'), 
(8, 'Hekuran Zeqiri', '044666888', '1975-06-18'), 
(9, 'Iliriana Morina', '049555111', '1990-09-05'), 
(10, 'Jeton Luma', '044222333', '1982-11-11'), 
(11, 'Kujtim Bytyqi', '045888999', '1994-04-22'), 
(12, 'Luljeta Selimi', '044123456', '1987-08-08'), 
(13, 'Mirlinda Kelmendi', '049789456', '1999-01-19'), 
(14, 'Naim Kastrati', '045654321', '1980-05-25'), 
(15, 'Olti Rugova', '044000111', '2003-03-03');

 -- 2.TABELA DENTISTS (5 rreshta) 
INSERT INTO DENTISTS (DentistID, Name, Specialization) VALUES 
(1, 'Dr. Dren Loshi', 'Orthodontist'), 
(2, 'Dr. Hana Shala', 'General Dentist'), 
(3, 'Dr. Arben Vita', 'Oral Surgeon'), 
(4, 'Dr. Sara Meqa', 'Periodontist'), 
(5, 'Dr. Valon Murati', 'Endodontist');

 -- 3. TABELA TREATMENTS (10 rreshta) 
INSERT INTO TREATMENTS (TreatmentID, ServiceName, Price) VALUES 
(1, 'Mbushje Kompozit', 30.00), 
(2, 'Pastrim Gurzish', 20.00), 
(3, 'Nxjerrje Dhembi', 25.00), 
(4, 'Implant Dentar', 600.00), 
(5, 'Zbardhje Dhembesh', 150.00), 
(6, 'Rregullim Proteze', 100.00), 
(7, 'Terapi Kanali', 45.00), 
(8, 'Kurore Porcelani', 120.00), 
(9, 'Kontroll Rutine', 10.00), 
(10, 'Rentgen Dentar', 15.00);

 -- 4. TABELA INVENTORY (10 rreshta) 
INSERT INTO INVENTORY (ItemID, ItemName, StockLevel) VALUES 
(1, 'Doreza Latexi', 500), 
(2, 'Material Mbushje A1', 50), 
(3, 'Anestezion Lokal', 100), 
(4, 'Gjilpera Sterile', 200), 
(5, 'Pambuk Dentar', 1000), 
(6, 'Seringa', 300), 
(7, 'Zbardhues Gjel', 20), 
(8, 'Vida Implanti', 15), 
(9, 'Maske Kirurgjike', 400), 
(10, 'Alkool 70%', 30);

 -- 5. TABELA APPOINTMENTS (20 rreshta) 
INSERT INTO APPOINTMENTS (AppID, PatientID, DentistID, Date, Status) VALUES 
(101, 1, 1, '2025-12-20', 'Completed'), 
(102, 2, 2, '2025-12-21', 'Completed'), 
(103, 3, 3, '2025-12-22', 'Completed'), 
(104, 4, 4, '2025-12-22', 'Completed'), 
(105, 5, 5, '2025-12-23', 'Completed'), 
(106, 6, 1, '2025-12-24', 'Completed'), 
(107, 7, 2, '2025-12-24', 'Completed'), 
(108, 8, 3, '2025-12-25', 'Cancelled'), 
(109, 9, 4, '2025-12-26', 'Completed'), 
(110, 10, 5, '2025-12-27', 'Completed'), 
(111, 11, 1, '2025-12-28', 'Scheduled'), 
(112, 12, 2, '2025-12-28', 'Scheduled'), 
(113, 1, 3, '2026-01-05', 'Scheduled'), 
(114, 2, 4, '2026-01-06', 'Scheduled'), 
(115, 13, 5, '2025-12-29', 'Completed'), 
(116, 14, 1, '2025-12-30', 'Completed'), 
(117, 15, 2, '2025-12-30', 'Completed'), 
(118, 5, 3, '2025-12-31', 'Completed'), 
(119, 7, 4, '2026-01-02', 'Scheduled'), 
(120, 9, 5, '2026-01-03', 'Scheduled');

 -- 6. TABELA TREATMENT_DETAILS (25 rreshta) 
INSERT INTO TREATMENT_DETAILS (DetailID, AppID, TreatmentID, ItemID, ToothNumber, 
QuantityUsed) VALUES 
(1, 101, 1, 2, 11, 1), (2, 101, 2, 5, NULL, 5), (3, 102, 3, 3, 46, 2), 
(4, 103, 4, 8, 24, 1), (5, 103, 10, 9, NULL, 1), (6, 104, 5, 7, NULL, 1), 
(7, 105, 7, 3, 36, 1), (8, 105, 1, 2, 36, 1), (9, 106, 8, 5, 12, 2), 
(10, 107, 9, 1, NULL, 2), (11, 109, 2, 5, NULL, 10), (12, 110, 1, 2, 44, 1), 
(13, 115, 3, 3, 18, 1), (14, 115, 9, 1, NULL, 1), (15, 116, 5, 7, NULL, 1), 
(16, 117, 1, 2, 22, 1), (17, 117, 2, 5, NULL, 4), (18, 118, 10, 9, NULL, 2), 
(19, 101, 9, 1, NULL, 2), (20, 102, 10, 4, NULL, 1), (21, 103, 7, 3, 24, 1), 
(22, 105, 10, 6, NULL, 1), (23, 110, 9, 1, NULL, 2), (24, 116, 1, 2, 15, 1), 
(25, 118, 2, 5, NULL, 6);


 -- 7. TABELA INVOICES (15 rreshta) -- Vetëm për takimet e përfunduara (Completed) 
INSERT INTO INVOICES (InvoiceID, AppID, TotalAmount, IssuedDate) VALUES 
(201, 101, 50.00, '2025-12-20'), 
(202, 102, 25.00, '2025-12-21'), 
(203, 103, 615.00, '2025-12-22'), 
(204, 104, 150.00, '2025-12-22'), 
(205, 105, 75.00, '2025-12-23'), 
(206, 106, 120.00, '2025-12-24'), 
(207, 107, 10.00, '2025-12-24'), 
(208, 109, 20.00, '2025-12-26'), 
(209, 110, 30.00, '2025-12-27'), 
(210, 115, 35.00, '2025-12-29'), 
(211, 116, 180.00, '2025-12-30'), 
(212, 117, 50.00, '2025-12-30'), 
(213, 118, 35.00, '2025-12-31'); 

-- 8. TABELA PAYMENTS (15 rreshta) 
INSERT INTO PAYMENTS (PaymentID, InvoiceID, Amount, Method) VALUES 
(301, 201, 50.00, 'Cash'), 
(302, 202, 25.00, 'Card'), 
(303, 203, 300.00, 'Transfer'),  
(304, 203, 315.00, 'Transfer'),  
(305, 204, 150.00, 'Card'), 
(306, 205, 75.00, 'Cash'), 
(307, 206, 120.00, 'Card'), 
(308, 207, 10.00, 'Cash'), 
(309, 208, 20.00, 'Cash'), 
(310, 209, 30.00, 'Card'), 
(311, 210, 35.00, 'Cash'), 
(312, 211, 180.00, 'Card'), 
(313, 212, 50.00, 'Transfer'), 
(314, 213, 35.00, 'Cash'), 
(315, 201, 0.00, 'Cash');