create table places
(
place_id NUMBER(4) not null,
street_address VARCHAR2(40),
postal_code VARCHAR2(12),
city VARCHAR2(30),
state_province VARCHAR2(25),
state_id CHAR(2)
);


insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (1000, '1297 Via Cola di Rie', '00989', 'Roma', '', 'IT');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (1100, '93091 Calle della Testa', '10934', 'Venice', '', 'IT');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', '', 'JP');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (2000, '40-5-12 Laogianggen', '190518', 'Beijing', '', 'CN');
insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (2300, '198 Clementi North', '540198', 'Singapore', '', 'SG');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (2400, '8204 Arthur St', '', 'London', '', 'UK');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford','UK');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (2600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (2800, 'Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL');

insert into places (place_id, street_address, postal_code, city, state_province,state_id)values (3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal', 'MX');
