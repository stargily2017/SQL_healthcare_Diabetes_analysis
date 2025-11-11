# "Diagnostic analysis in diabetes healthcare"
Executive Summary
Using SQL, I pulled 10 years of 70,000 unique patient diabetes data from the database to get a clear picture of their medications, hemoglobin levels, hospital stays, and readmission rates. Imagine working alongside colleagues who frequently need time off for diabetes-related hospital visits. It’s a familiar scene at my workplace, and it sparked my curiosity about how diabetes care is managed in hospitals. This analysis of an extensive clinical database examines the historical pattern of diabetes care among patients admitted to a US hospital and provides future directions to improve patient safety. I recommend that hospitals offer better diabetes management plans and reduce the readmission rates. 

### Why I Chose This Project
Watching my colleagues deal with the challenges of managing diabetes—like balancing their medical appointments with work—really got me thinking. It was clear how much this affected their daily lives. This personal experience, along with my love of digging into data, led me to explore how hospitals can better care for patients with diabetes.

### Key Takeaways
To identify the average processing times and standard procedures in medical specialties.
Hyperglycemia has a significant role in hospital admissions.
Potential strategies to cut readmission costs for diabetes.
Patients spent 1 to 14 days in the hospital during their treatment.
Female has higher readmission rates despite receiving fewer medications than males.
Find the patient's data from the medical records at any time.

### Methodolgy
SQL query that extracts, cleans, and transforms the data from the database.
Conduct a detailed diagnostic analysis of patients' data based on their demographics and medications.

### Skills:
SQL: DISTINCT, CTES, CASE, JOINS, CAST, AGGREGATIONS, BAR CHART, WHERE, UNION, HAVING, CONCAT

### Dataset Details
I used the Health Facts Database, which includes data from 1999 to 2008 (10 years) and covers over 70,000 unique patient records. This resource-rich dataset was ideal for examining long-term trends and patterns in diabetes care. The database consists of 41 tables in a fact-dimension schema, totaling 117 features. The database includes encounter data (emergency, outpatient, and inpatient), provider specialty, demographics (age, sex, race), diagnoses, medications, and readmissions. I delved into this project using a treasure trove of 70,000 unique patient records from across 130 U.S hospitals (Cerner Corporation, Kansas City, MO).

The origin of this data set comes from here: The origin of this data set come from here: https://www.kaggle.com/code/iabhishekofficial/prediction-on-hospital-readmission/data?select=diabetic_data.csv 

You can learn more about this data set here. 

### Descriptive and diagnostic analysis 
### Results and Personal Reflections:
Created SQL queries to extract patients' historical data. The challenge of uncovering gender disparities in treatment was eye-opening. Females have a higher readmission rate despite receiving fewer medications than males. Analysis shows that Insulin, Metformin, Glypizide, and Glyburide are the most popular diabetes medications. Hospitals could provide awareness about diabetes, including their diet and daily routine. It helps to decrease the diabetes rate and improve health. Moving forward, I aim to leverage these insights to drive actionable improvements in diabetes care.

### Next Steps:
Hospitals could benefit from more personalized diabetes management plans, particularly focusing on regular hyperglycemia monitoring to forecast potential readmissions.




