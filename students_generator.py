import pandas as pd
from faker import Faker
import random

fake = Faker()
Faker.seed(42)
random.seed(42)

students = []
student_id = 1

for dept_id in range(1, 8): 
    for _ in range(120):     
        gender = random.choice(['Male', 'Female'])
        students.append({
            'student_id': student_id,
            'first_name': fake.first_name_male() if gender == 'Male' else fake.first_name_female(),
            'last_name': fake.last_name(),
            'email': fake.unique.email(),
            'dob': fake.date_of_birth(minimum_age=18, maximum_age=25),
            'gender': gender,
            'department_id': dept_id
        })
        student_id += 1

students_df = pd.DataFrame(students)
students_df.to_csv('students.csv', index=False)
print("✅ students.csv created with 840 records")
