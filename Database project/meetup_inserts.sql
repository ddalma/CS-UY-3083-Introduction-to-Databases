INSERT into member (username, password, first_name, last_name, zipcode) VALUES ('alextan', 'password', 'alex', 'tan', '12345')
INSERT into groups (g_id, name, description, creator) VALUES ('123', 'database', 'Having fun with mysql', 'alextan')
INSERT into interest (intr_name) VALUES ('learningmysql') 
INSERT into belong (username, g_id) VALUES ('alextan', '123')
INSERT into interest_in(username, intr_name) VALUES ('alextan', 'learningmysql')
INSERT into about(intr_name, g_id) VALUES ('learningmysql', '123')
INSERT into location(lname, zip, street, city, latitude, longitude, description) VALUES ('poly', '22222', '1' , 'NYC', '1' , '1' , 'NYU poly')
INSERT into event(e_id, title, description, start_time, end_time, e_date, lname, zip, g_id) VALUES ('111', 'testevent', 'testing event', '1100', '1200', '11915', 'poly', '22222', '123')
INSERT into attend(username, e_id) VALUES ('alextan', '111')