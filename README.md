# 🦷 DentalCare Management System (DCMS)

DCMS është një sistem i menaxhimit të bazës së të dhënave i projektuar posaçërisht për klinikat stomatologjike. Projekti demonstron zbatimin e **parimeve të avancuara të SQL** në **PostgreSQL**, duke filluar nga strukturimi korrekt i të dhënave (**Normalizimi – 3NF**) e deri te automatizimi i proceseve dhe optimizimi i performancës.

---

## 🚀 Karakteristikat Kryesore

* **Menaxhimi i Pacientëve dhe Takimeve**
  Administrimi i pacientëve, dentistëve dhe orareve përmes një strukture të centralizuar dhe të normalizuar.

* **Automatizimi i Inventarit**
  Përdorimi i **SQL Triggers** për përditësimin automatik të stokut pas çdo trajtimi të kryer.

* **Raportimi Financiar**
  Krijimi i **Views analitike** për analizimin e faturave, pagesave dhe gjendjes financiare të klinikës.

* **Integriteti i të Dhënave**
  Zbatimi i **constraints**, **validation triggers** dhe **Cascading Actions** për të garantuar konsistencën dhe besueshmërinë e të dhënave.

---

## 📊 Struktura e Databazës

Databaza është ndërtuar në **PostgreSQL** dhe ndjek rregullat e **Normalizimit (3NF)** për të eliminuar redundancën dhe për të ruajtur integritetin e të dhënave.

Tabelat kryesore përfshijnë:

* **PATIENTS** – të dhëna demografike dhe informacion bazë i pacientëve.
* **DENTISTS** – stafi mjekësor dhe specializimet përkatëse.
* **APPOINTMENTS** – takimet e planifikuara midis pacientëve dhe dentistëve.
* **TREATMENTS** & **TREATMENT_DETAILS** – shërbimet mjekësore dhe materialet e përdorura.
* **INVENTORY** – menaxhimi i materialeve dhe stokut mjekësor.
* **INVOICES** & **PAYMENTS** – sistemi i faturimit dhe pagesave.

---

## 🔍 Queries & Optimization

Në kuadër të këtij projekti janë implementuar **mbi 20 query funksionale**, të dizajnuara për analiza operative dhe financiare.

* **Analiza e Performancës**
  Përdorimi i `GROUP BY`, `HAVING` dhe `ORDER BY` për të identifikuar dentistët më aktivë dhe shërbimet më të përdorura.

* **Lidhje Komplekse (JOINS)**
  Bashkimi i deri në **6 tabela** për gjenerimin e raporteve të detajuara mjekësore dhe financiare.

* **Optimizimi i Kërkimeve**
  Analizimi i performancës përmes `EXPLAIN ANALYZE` dhe përdorimi i **indekseve strategjike** për rritjen e shpejtësisë së ekzekutimit.

---

## 🧪 Teknologjitë e Përdorura

* PostgreSQL
* SQL (DDL, DML, Views, Triggers, Indexes)
* ER Modeling (Crow’s Foot Notation)

---

## 👩‍💻 Autorja

**Artiola Qollaku**
Fakulteti i Shkencave Kompjuterike
Projekti: *Database Implementation – DentalCare Management System (DCMS)*

---



