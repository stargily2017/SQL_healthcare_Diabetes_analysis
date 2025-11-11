USE patient;
SELECT * FROM health;


#1. What medical specialties are doing the most procedures on average? 
#The hospital is reviewing its laboratory procedures to identify the average processing times and common patterns.
#I used the Distinct keyword to retrieve unique values from the data; it also eliminates duplicates.
#The top average lab procedure 3.5 is in surgery-thoracic. Depending o the patient count, the top average is in Cardiology procedures. 
#The patient spent more than 5 days in the hospital for cardiovascular-thoracic surgery.


SELECT distinct(medical_specialty), 
round(avg(num_procedures),1)AS avg_procedures,
round(avg(time_in_hospital),2) AS avg_time_in_days,
count(*) AS count
FROM health
GROUP BY medical_specialty
HAVING count >50
and avg(num_procedures) >2.5
order by avg_procedures DESC;

---------------------------------------------

#2.Hyperglycemia has a significant role in hospital admissions.
#I found out which common medications patients use —are they the popular ones? 
#Also, which age group uses the top-ranked medication?
#I used CTEs to break the querries into small.
#Insulin, Metformin, Glypizide, and Glyburide are the most commonly used diabetes medications.


WITH long_health_cte AS (
SELECT patient_nbr, 'metformin' AS medication, metformin AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'repaglinide' AS medication, repaglinide AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'nateglinide' AS medication, nateglinide AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'chlorpropamide' AS medication, chlorpropamide AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'glimepiride' AS medication, glimepiride AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'acetohexamide' AS medication, acetohexamide AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'glyburide' AS medication, glyburide AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'tolbutamide' AS medication, tolbutamide AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'pioglitazone' AS medication, pioglitazone AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'rosiglitazone' AS medication, rosiglitazone AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'acarbose' AS medication, acarbose AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'miglitol' AS medication, miglitol AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'troglitazone' AS medication, troglitazone AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'tolazamide' AS medication, tolazamide AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'examide' AS medication, examide AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'citoglipton' AS medication, citoglipton AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'glipizide' AS medication, glipizide AS med_usage FROM patient.health
UNION
SELECT patient_nbr, 'insulin' AS medication, insulin AS med_usage FROM patient.health
)
SELECT
age,
medication,
COUNT(*) AS total_uses,
RANK() OVER (PARTITION BY age ORDER BY COUNT(*) DESC) AS medication_rank
FROM long_health_cte
JOIN patient.demographics ON long_health_cte.patient_nbr = demographics.patient_nbr
WHERE med_usage NOT IN ('No')
GROUP BY medication, age
ORDER BY total_uses DESC, medication_rank;
--------------------------------------------------------------------------------------

#3.Potential strategies to cut readmission costs for diabetes.
#Based on race: Hospitals could benefit from more personalized diabetes management plans, 
#especially by emphasizing regular hyperglycemia monitoring to predict potential readmissions.
#I used the CASE function to allow if-then-else logic within a query.
#Caucasian race is readmitted within 30 days more than the other races around 8603.alter
#african american is the second one.

SELECT d.race, round(avg(h.num_lab_procedures)) AS avg_labprocedures,
SUM(CASE when readmitted = '<30' then 1 else 0 end)
AS readmitted_within30_days
FROM health AS h
JOIN demographics AS d ON h.patient_nbr = d.patient_nbr
GROUP BY d.race
ORDER BY readmitted_within30_days DESC;
---------------------------------------------

#Based on age: Age is a crucial factor in hospital readmission rates for patients with diabetes.
#[0-30], [30-60], and [60-100]. Average lab procedures were similar across all ages.


SELECT d.age, round(avg(h.num_lab_procedures)) AS avg_labprocedures,
SUM(CASE when readmitted = '<30' then 1 else 0 end)
AS readmitted_within30_days
FROM health AS h
JOIN demographics AS d ON h.patient_nbr = d.patient_nbr
GROUP BY d.age
ORDER BY readmitted_within30_days DESC;
-------------------------------------------------------------------


#Based on gender: (Female has higher readmission rates despite receiving fewer medications than males.)
#Females were readmitted within 30 days than the males, 

SELECT d.gender AS gender,
max(num_medications) AS medications,
round(avg(time_in_hospital),2) AS avg_time_in_days,
SUM(CASE when readmitted = '<30' then 1 else 0 end)
AS readmitted_within30_days,
count(*) AS total_patients
FROM
health AS h
JOIN 
demographics AS d ON h.patient_nbr = d.patient_nbr
GROUP BY d.gender;
------------------------------------------------------------


#4. Patients spent 1 to 14 days in the hospital during their treatment 
#Time is an essential factor for hospitalization.
#I noticed the bar chart shows the length of stay ranged from 1 to 14 days. Here, 
#I introduce the CAST function in SQL, which converts one data type to another.

SELECT round(CAST(time_in_hospital AS Decimal), 1) AS Time_in_days,
count(*) AS patients_count,
rpad('', count(*)/200,'*') AS bar
FROM health
group by Time_in_days
order by Time_in_days Desc;
----------------------------------------------------------

#5. Find the patient's data from the medical records at any time
# I used the CONCAT function in this query. It's a string function 
 #that combines two or more string values into a single string.

 
   SELECT 
    CONCAT('Patient ',
            health.patient_nbr,
            ' was ',
            demographics.race,
            ' and ',
            (CASE
                WHEN readmitted = 'NO' THEN ' was not readmitted. They had '
                ELSE ' was readmitted. They had '
            END),
            num_medications,
            ' medications and ',
            num_lab_procedures,
            ' lab procedures.') AS summary
FROM
    patient.health
        INNER JOIN
    patient.demographics ON demographics.patient_nbr = health.patient_nbr
ORDER BY num_lab_procedures DESC,num_medications DESC 
LIMIT 50;
----------------------------------------------------------------------------------

# WHo get a lot of procedures and stay long time in the hospital.
---------------------------------------------
select round(avg(time_in_hospital),2) AS avg_time_in_days,
CASE when num_lab_procedures >=0
	and num_lab_procedures <25
	then '<25 procedures -few'
    when num_lab_procedures > 25
    and num_lab_procedures <55
    then '25-55 -avg'
    else '>55 -many'
    end AS procedure_frequency
    FROM health
    GROUP BY procedure_frequency
    ORDER BY avg_time_in_days DESC;
    
    --------------------------------------
 # who is african american has metmorphin 'up'
  # I used Where clause to find the the specific data
    ----------------------------------------
    
SELECT patient_nbr FROM patient.demographics 
where race = 'Indian'
UNION
SELECT patient_nbr FROM patient.health
where metformin = 'up';
--------------------------------------
# Number of procedures cahmged to INT.   
SELECT avg(CAST(num_medications AS float)) FROM health;
ALTER TABLE health
MODIFY COLUMN num_procedures INT;

 ----- To find the specific data like admission ID =1.    
SELECT * FROM health 
WHERE admission_type_id = 1 
AND time_in_hospital < (SELECT AVG(time_in_hospital) FROM health);
---------------------------------------------------------------------------
