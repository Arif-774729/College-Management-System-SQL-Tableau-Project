import pandas as pd
import random


courses_df = pd.read_csv('courses.csv')
professors_df = pd.read_csv('professors.csv')

course_prof_map = []

for _, course in courses_df.iterrows():
    dept_id = course['department_id']
    
    
    profs_in_dept = professors_df[professors_df['department_id'] == dept_id]
    
    
    selected_prof = profs_in_dept.sample(1).iloc[0]
    
    course_prof_map.append({
        'course_id': course['course_id'],
        'professor_id': selected_prof['professor_id']
    })

course_prof_df = pd.DataFrame(course_prof_map)
course_prof_df.to_csv('course_professor.csv', index=False)
print("✅ course_professor.csv created")
