import pandas as pd
import random


dept_short_names = {
    1: 'CSE',
    2: 'EEE',
    3: 'BIO',
    4: 'META',
    5: 'MECH',
    6: 'CIVIL',
    7: 'BSC'
}

courses = []
course_id = 1

for dept_id in range(1, 8): 
    for i in range(1, 21):   
        course_name = f"{dept_short_names[dept_id]}_Course_{i}"
        courses.append({
            'course_id': course_id,
            'course_name': course_name,
            'credits': random.choice([2, 3, 4]),
            'department_id': dept_id
        })
        course_id += 1

courses_df = pd.DataFrame(courses)
courses_df.to_csv('courses.csv', index=False)
print("✅ courses.csv created with 140 courses")
