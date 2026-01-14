# 🦷 DentalCare Management System (DCMS)

**DCMS** është një sistem i menaxhimit të bazës së të dhënave i projektuar posaçërisht për klinikat stomatologjike. Ky projekt tregon zbatimin e parimeve të avancuara të SQL, duke filluar nga strukturimi i të dhënave (3NF) e deri te automatizimi i proceseve dhe optimizimi i kërkimeve.

## 🚀 Karakteristikat Kryesore
- **Menaxhimi i Pacientëve dhe Takimeve:** Ndjekja e historikut mjekësor dhe orareve.
- **Automatizimi i Inventarit:** Përdorimi i SQL Triggers për përditësimin automatik të stokut pas çdo trajtimi.
- **Raportimi Financiar:** Pamje (Views) të gatshme për analizën e fitimeve dhe borxheve.
- **Integriteti i të Dhënave:** Zbatimi i "Cascading Actions" për të siguruar konsistencën e të dhënave.

## 📊 Struktura e Databazës
Databaza është e ndërtuar në **PostgreSQL** dhe përfshin tabelat:
* `PATIENTS` - Të dhënat demografike.
* `DENTISTS` - Stafi mjekësor dhe specializimet.
* `APPOINTMENTS` - Takimet e planifikuara.
* `TREATMENTS` & `TREATMENT_DETAILS` - Shërbimet dhe materialet e përdorura.
* `INVENTORY` - Menaxhimi i materialeve.
* `INVOICES` & `PAYMENTS` - Sistemi financiar.

## 🔍 Queries & Optimization
Në këtë projekt janë implementuar mbi 20 query funksionale, duke përfshirë:
- **Analizën e Performancës:** Përdorimi i `GROUP BY`, `HAVING` dhe `ORDER BY` për të gjetur mjekët më aktivë.
- **Lidhje Komplekse (Joins):** Bashkimi i deri në 6 tabelave për raporte të detajuara mjekësore-financiare.
- **Optimizimi:** Analizimi i performancës përmes `EXPLAIN ANALYZE` dhe përdorimi i indekseve.

