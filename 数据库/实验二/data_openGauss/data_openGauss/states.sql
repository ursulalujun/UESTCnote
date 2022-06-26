create table states
(
state_id CHAR(2),
state_name VARCHAR2(40),
area_id NUMBER,
constraint state_c_id_pk primary key (state_ID)
);

insert into states (state_id, state_name, area_id)values ('AR', 'Argentina', 2);

insert into states (state_id, state_name, area_id)values ('AU', 'Australia', 3);

insert into states (state_id, state_name, area_id)values ('BE', 'Belgium', 1);

insert into states (state_id, state_name, area_id)values ('BR', 'Brazil', 2);

insert into states (state_id, state_name, area_id)values ('CA', 'Canada', 2);

insert into states (state_id, state_name, area_id)values ('CH', 'Switzerland', 1);

insert into states (state_id, state_name, area_id)values ('CN', 'China', 3);

insert into states (state_id, state_name, area_id)values ('DE', 'Germany', 1);

insert into states (state_id, state_name, area_id)values ('DK', 'Denmark', 1);

insert into states (state_id, state_name, area_id)values ('EG', 'Egypt', 4);

insert into states (state_id, state_name, area_id)values ('FR', 'France', 1);

insert into states (state_id, state_name, area_id)values ('HK', 'HongKong', 3);

insert into states (state_id, state_name, area_id)values ('IL', 'Israel', 4);

insert into states (state_id, state_name, area_id)values ('IN', 'India', 3);

insert into states (state_id, state_name, area_id)values ('IT', 'Italy', 1);

insert into states (state_id, state_name, area_id)values ('JP', 'Japan', 3);

insert into states (state_id, state_name, area_id)values ('KW', 'Kuwait', 4);

insert into states (state_id, state_name, area_id)values ('MX', 'Mexico', 2);

insert into states (state_id, state_name, area_id)values ('NG', 'Nigeria', 4);

insert into states (state_id, state_name, area_id)values ('NL', 'Netherlands', 1);

insert into states (state_id, state_name, area_id)values ('SG', 'Singapore', 3);

insert into states (state_id, state_name, area_id)values ('UK', 'United Kingdom', 1);

insert into states (state_id, state_name, area_id)values ('US', 'United States of America', 2);

insert into states (state_id, state_name, area_id)values ('ZM', 'Zambia', 4);

insert into states (state_id, state_name, area_id)values ('ZW', 'Zimbabwe', 4);
