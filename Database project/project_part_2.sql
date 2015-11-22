create table member(
	username	varchar(20) NOT NULL,
	password	char(32),
	first_name	varchar(20),
	last_name   varchar(20),
	zipcode     int(5),
	
	primary key (username)
);

create table groups (
	g_id            int(5) NOT NULL,
	name 			varchar(20),
	description  	varchar(100),
	creator         varchar(20) NOT NULL,
	
	primary key (g_id),
	foreign key (creator) references member(username)
);

create table location(
	lname		varchar(20) NOT NULL,
	zip		    int(5) NOT NULL,
	street		int(5),
	city        varchar(20),
	latitude	int(5),
	longitude	int(5),
	description varchar(35),
	
	primary key(lname),
	unique (zip)
);

create table event(
	e_id		int(5) NOT NULL,
	title		varchar(20),
	description varchar(100),
	start_time	int(5),
	end_time    int(5),
	e_date      int(7),
	lname       varchar(20) NOT NULL,
	zip         int(5) NOT NULL,
	g_id        int(5) NOT NULL,
	
	primary key(e_id),
	foreign key(lname) references location(lname),
	foreign key(zip) references location(zip),
	foreign key(g_id) references groups(g_id)
);

create table interest(
	intr_name	varchar(20) NOT NULL,
	
	primary key(intr_name)
);

create table attend(
    username    varchar(20) NOT NULL,
	e_id        int(5) NOT NULL,
	
	foreign key (username) references member(username),
	foreign key (e_id) references event(e_id)
);

create table interest_in(
    username     varchar(20) NOT NULL,
	intr_name    varchar(20) NOT NULL,
	
	foreign key (username) references member(username),
	foreign key (intr_name) references interest(intr_name)
);

create table about(
    intr_name    varchar(20) NOT NULL,
	g_id         int(5) NOT NULL,
	
	foreign key(intr_name) references interest_in(intr_name),
	foreign key(g_id) references groups(g_id)
);

create table belong(
    username        varchar(20) NOT NULL,
	g_id            int(5) NOT NULL,
	
	foreign key(username) references member(username),
	foreign key(g_id) references groups(g_id)
);