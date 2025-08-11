-- creating database
create database Hospital;
use Hospital;

-- creating tables
create table Patients(
Patient_id int auto_increment primary key,
First_name varchar(50),
Last_name varchar(50),
Gender varchar(50),
Age smallint,
DOB date,
Phone bigint,
Address varchar(100)
);

create table Doctors(
Doctor_id int primary key,
First_name varchar(50),
Last_name varchar(50),
Specialization varchar(50),
Phone bigint
);

create table Appointments(
Appointment_id int primary key,
Patient_id int,
Doctor_id int,
Appointment_date date,
Reason varchar(100),
Status varchar(20),
foreign key(Patient_id) references Patients(Patient_id),
foreign key(Doctor_id) references Doctors(Doctor_id)
);

create table Treatments(
Treatment_id int primary key,
Appointment_id int,
Treatment_description varchar(200),
Cost decimal(10,2),
foreign key (Appointment_id) references Appointments(Appointment_id)
);

create table Billing(
Bill_id int primary key,
patient_id int,
Total_amount decimal(10,2),
Payment_status varchar(20),
Payment_date date,
foreign key (Patient_id) references Patients(Patient_id)
);

-- inserting values 
insert into Patients(First_name, Last_name, Gender, Age, Dob, Phone, Address) values
('Amit', 'Sharma', 'Male', 45,'1990-05-14', '9876543210', 'Delhi'),
('Priya', 'Mehta', 'Female', 35,'1995-11-20', '9876501234', 'Mumbai'),
('Rohan', 'Kapoor', 'Male', 30,'1988-03-10', '9123456780', 'Pune'),
('Sneha', 'Patil', 'Female', 32,'1992-08-05', '9988776655', 'Bangalore'),
('Arjun', 'Verma', 'Male', 48,'1993-06-18', '9812345678', 'Chennai'),
('Neha', 'Singh', 'Female', 34,'1991-09-25', '9845123456', 'Delhi'),
('Kunal', 'Desai', 'Male', 55,'1996-04-12', '9823456712', 'Ahmedabad'),
('Simran', 'Kaur', 'Female', 46,'1994-12-30', '9811122233', 'Chandigarh'),
('Rahul', 'Yadav', 'Male', 37,'1990-02-22', '9844001122', 'Lucknow'),
('Meera', 'Nair', 'Female', 49,'1997-07-15', '9865432109', 'Kochi');

insert into Doctors (Doctor_id, First_name, Last_name, Specialization, Phone) values
(1,'Rajesh', 'Kumar', 'Cardiologist', '9898989898'),
(2,'Sonal', 'Deshmukh', 'Dermatologist', '9765432198'),
(3,'Vikram', 'Joshi', 'Orthopedic', '9834567812'),
(4,'Pooja', 'Shah', 'Pediatrician', '9823456701'),
(5,'Aakash', 'Rao', 'Neurologist', '9845671230'),
(6,'Anjali', 'Kapoor', 'ENT Specialist', '9812340987'),
(7,'Suresh', 'Patel', 'Dentist', '9876543001'),
(8,'Manisha', 'Iyer', 'Gynecologist', '9890012345'),
(9,'Ravi', 'Chopra', 'Psychiatrist', '9823001122'),
(10,'Deepa', 'Menon', 'General Physician', '9845098765');

insert into Appointments(Appointment_id, Patient_id, Doctor_id, Appointment_date, Reason, Status) values
(101, 1, 1, '2025-08-01', 'Chest Pain', 'Completed'),
(102, 2, 2, '2025-08-02', 'Skin Rash', 'Completed'),
(103, 3, 3, '2025-08-03', 'Knee Pain', 'Scheduled'),
(104, 4, 4, '2025-08-04', 'Fever', 'Completed'),
(105, 5, 5, '2025-08-05', 'Headache', 'Completed'),
(106, 6, 6, '2025-08-06', 'Ear Pain', 'Cancelled'),
(107, 7, 7, '2025-08-07', 'Toothache', 'Completed'),
(108, 8, 8, '2025-08-08', 'Pregnancy Checkup', 'Scheduled'),
(109, 9, 9, '2025-08-09', 'Anxiety', 'Completed'),
(110, 10, 10, '2025-08-10', 'Routine Checkup', 'Completed');

insert into Treatments(Treatment_id, Appointment_id, Treatment_description, Cost) values
(1, 101, 'ECG & Consultation', 1500.00),
(2, 102, 'Skin Cream Prescription', 800.00),
(4, 104, 'Flu Medication', 500.00),
(5, 105, 'MRI Scan', 3000.00),
(7, 107, 'Tooth Extraction', 1200.00),
(9, 109, 'Therapy Session', 2000.00),
(10, 110, 'Blood Test', 600.00);

insert into Billing(Bill_id, Patient_id, Total_amount, Payment_status, Payment_date) values
(1, 1, 1500.00, 'Paid', '2025-08-01'),
(2, 2, 800.00, 'Paid', '2025-08-02'),
(3, 4, 500.00, 'Paid', '2025-08-04'),
(4, 5, 3000.00, 'Unpaid', NULL),
(5, 7, 1200.00, 'Paid', '2025-08-07'),
(6, 9, 2000.00, 'Paid', '2025-08-09'),
(7, 10, 600.00, 'Paid', '2025-08-10');

-- displaying tables
select * from Patients;
select * from Doctors;
select * from Appointments;
select * from Treatments;
select * from Billing;

-- basic queries
-- 1. List all doctors in 'Cardiologist' specialization
select * from Doctors where Specialization = 'Cardiologist';

-- 2. Find all patients with upcoming scheduled appointments
select p.First_name, p.Last_name, a.Appointment_date from Patients p
join Appointments a on p.Patient_id = a.Patient_id 
where a.Status = 'Scheduled';

-- 3. Calculate total revenue
select sum(Total_amount) as Total_revenue from Billing where Payment_status = 'Paid'; 

-- 4. Top 3 most expensive treatments
select Treatment_description, Cost from Treatments
order by cost desc
limit 3;

-- 5. Doctors with most completed appointments
select d.First_name, d.Last_name, count(*) as Total_completed from Doctors d
join Appointments a on d.Doctor_id = a.Doctor_id
where a.Status = 'Completed'
group by d.Doctor_id
order by Total_completed desc;

-- 6. Patients who haven't paid their bills
select p.First_name, p.Last_name, b.Total_amount, b.Payment_status from Patients p
join Billing b on p.Patient_id = b.Patient_id
where b.Payment_status = 'Unpaid';

-- 7. Total patients each doctor has treated
select d.First_name, d.Last_name, count(distinct a.Patient_id) as Patient_count
from Doctors d
join Appointments a on d.Doctor_id = a.Doctor_id
where a.Status = 'Completed'
group by d.Doctor_id;

-- 8. Average treatment cost
select avg(Cost) as Avg_treatment_cost from Treatments;

-- 9. Patient's full medical history
select p.First_name, p.Last_name, a.Appointment_date, a.Reason, t.Treatment_description, t.Cost from Patients p
join Appointments a on p.Patient_id = a.Patient_id
left join Treatments t on a.Appointment_id = t.Appointment_id
where p.Patient_id = 2;

-- 10. Monthly revenue report
select month(Payment_date) as Month, sum(Total_amount) as Monthly_revenue from Billing
where Payment_status = 'paid'
group by month(Payment_date)
order by Month; 



