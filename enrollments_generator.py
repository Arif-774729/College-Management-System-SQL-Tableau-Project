import pandas as pd
import random


students_df = pd.read_csv('students.csv')
courses_df = pd.read_csv('courses.csv')

enrollments = []
enrollment_id = 1
grades = ['A', 'B', 'C', 'D', 'F']
semesters = [f'S{i}' for i in range(1, 9)]  

for _, student in students_df.iterrows():
    num_courses = random.randint(3, 5)
    sampled_courses = courses_df.sample(n=num_courses)

    for _, course in sampled_courses.iterrows():
        enrollments.append({
            'enrollment_id': enrollment_id,
            'student_id': student['student_id'],
            'course_id': course['course_id'],
            'semester': random.choice(semesters),
            'grade': random.choice(grades)
        })
        enrollment_id += 1

enrollments_df = pd.DataFrame(enrollments)
enrollments_df.to_csv('enrollments.csv', index=False)
print(f"✅ enrollments.csv created with {len(enrollments)} rows")
