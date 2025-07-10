import pandas as pd
from faker import Faker
import random

fake = Faker()
Faker.seed(42)
random.seed(42)


departments = [
    {'department_id': 1, 'department_name': 'Computer Science & Engineering', 'hod': fake.name()},
    {'department_id': 2, 'department_name': 'Electrical & Electronics Engineering', 'hod': fake.name()},
    {'department_id': 3, 'department_name': 'Biotechnology', 'hod': fake.name()},
    {'department_id': 4, 'department_name': 'Metallurgical Engineering', 'hod': fake.name()},
    {'department_id': 5, 'department_name': 'Mechanical Engineering', 'hod': fake.name()},
    {'department_id': 6, 'department_name': 'Civil Engineering', 'hod': fake.name()},
    {'department_id': 7, 'department_name': 'B.Sc. (Science)', 'hod': fake.name()},
]

departments_df = pd.DataFrame(departments)
departments_df.to_csv('departments.csv', index=False)
print("✅ departments.csv created")


professors = []
professor_id = 1


for dept_id in range(1, 8):
    num_professors = 14 if dept_id < 7 else 16  
    for _ in range(num_professors):
        professors.append({
            'professor_id': professor_id,
            'prof_name': fake.name(),
            'email': fake.unique.email(),
            'department_id': dept_id
        })
        professor_id += 1

professors_df = pd.DataFrame(professors)
professors_df.to_csv('professors.csv', index=False)
print("✅ professors.csv created")

