drop table if exists rating;
drop table if exists hotel_order;
drop table if exists room_info;
drop table if exists room_type;
drop table if exists hotel;
drop table if exists customer;

CREATE TABLE customer (
  uID int NOT NULL,
  uName varchar(255)  NOT NULL,
  PRIMARY KEY (uID)
);
/*Data for the table customer */

insert  into customer(uID,uName) values 
(201901,'叶文博'),
(201902,'李鸿柯'),
(201903,'梅野石'),
(201904,'李琦'),
(201905,'徐胜治'),
(201906,'齐守正'),
(201907,'李佳奇'),
(201908,'乔振华'),
(201909,'江浩然'),
(2019010,'赵伟'),
(2019011,'徐达'),
(2019012,'张超'),
(2019013,'黄柏慧'),
(2019014,'朱孟然'),
(2019015,'张东升'),
(2019016,'李煜'),
(2019017,'曾宇然'),
(2019018,'罗翔');

/*Table structure for table hotel */

CREATE TABLE hotel (
  hotel_id int NOT NULL,
  hotel_name varchar(255),
  PRIMARY KEY (hotel_id)
);

/*Data for the table hotel */

insert  into hotel(hotel_id,hotel_name) values 
(1,'丽呈东谷酒店'),
(2,'启悦酒店'),
(3,'来住大酒店'),
(4,'悦杏温泉酒店'),
(5,'希尔顿大酒店'),
(6,'希尔顿度假酒店');


CREATE TABLE room_type (
  room_id int NOT NULL,
  room_name varchar(255),
  hotel_id int DEFAULT NULL,
  PRIMARY KEY (room_id),
  CONSTRAINT hotel_room_key FOREIGN KEY (hotel_id) REFERENCES hotel (hotel_id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

/*Data for the table room_type */

insert  into room_type(room_id,room_name,hotel_id) values 
(1,'商务双床房',1),
(2,'行政大床房',1),
(3,'豪华套房',1),
(4,'海景房',2),
(5,'园景房',2),
(6,'山景房',2),
(7,'总统套房',3),
(8,'豪华套房',3),
(9,'普通套房',3),
(10,'行政双床房',1),
(11,'亲子房',1),
(12,'总统套房',4),
(13,'豪华海景房',4),
(14,'标准双床房',4),
(15,'情侣大床房',1),
(16,'总统套房',5),
(17,'行政套房',5),
(18,'商务双床房',5),
(19,'豪华海景房',6),
(20,'别墅海景房',6);



/*Table structure for table room_info */


CREATE TABLE room_info (
  info_id int NOT NULL,
  date date DEFAULT NULL,
  price decimal(10,2) DEFAULT NULL,
  remain int DEFAULT NULL,
  room_id int DEFAULT NULL,
  PRIMARY KEY (info_id),
  CONSTRAINT room_info_key FOREIGN KEY (room_id) REFERENCES room_type (room_id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ;

/*Data for the table room_info */

insert  into room_info(info_id,date,price,remain,room_id) values 
(1,'2020-11-28',1459.00,6,1),
(2,'2020-11-29',1468.00,4,1),
(3,'2020-11-30',1488.00,6,1),
(4,'2020-11-14',1300.00,2,2),
(5,'2020-11-15',1300.00,1,2),
(6,'2020-11-16',1400.00,1,2),
(7,'2020-11-14',1200.00,4,3),
(8,'2020-11-15',1200.00,3,3),
(9,'2020-11-16',1300.00,4,3),
(10,'2020-11-14',1450.00,5,4),
(11,'2020-11-15',1300.00,5,4),
(12,'2020-11-16',1450.00,5,4),
(13,'2020-11-14',1400.00,2,5),
(14,'2020-11-15',1250.00,2,5),
(15,'2020-11-16',1400.00,3,5),
(16,'2020-11-14',1300.00,1,6),
(18,'2020-11-16',1300.00,5,6),
(19,'2020-11-14',1300.00,2,7),
(20,'2020-11-15',1250.00,3,7),
(21,'2020-11-16',1300.00,8,7),
(22,'2020-11-14',1250.00,1,8),
(23,'2020-11-15',1200.00,1,8),
(24,'2020-11-16',1200.00,5,8),
(25,'2020-11-14',1200.00,2,9),
(26,'2020-11-15',1150.00,4,9),
(27,'2020-11-16',1150.00,1,9),
(28,'2020-11-28',1659.00,7,10),
(29,'2020-11-29',1668.00,5,10),
(30,'2022-11-30',1688.00,7,10),
(31,'2020-11-14',1500.00,3,11),
(32,'2020-11-15',1500.00,2,11),
(33,'2020-11-16',1600.00,2,11),
(34,'2020-11-14',1400.00,5,12),
(35,'2020-11-15',1400.00,4,12),
(36,'2020-11-16',1500.00,5,12),
(37,'2020-11-14',1650.00,3,13),
(38,'2020-11-15',1500.00,1,13),
(39,'2020-11-16',1650.00,4,13),
(40,'2020-11-14',1600.00,3,14),
(41,'2020-11-15',1450.00,3,14),
(42,'2020-11-16',1600.00,3,14),
(43,'2020-11-14',1500.00,2,15),
(44,'2020-11-15',1400.00,2,15),
(45,'2020-11-16',1500.00,6,15),
(46,'2020-11-14',1500.00,3,16),
(47,'2020-11-15',1450.00,4,16),
(48,'2020-11-16',1500.00,9,16),
(49,'2020-11-14',1450.00,2,17),
(50,'2020-11-15',1400.00,2,17),
(51,'2020-11-16',1400.00,6,17),
(52,'2020-11-14',1400.00,3,18),
(53,'2020-11-15',1350.00,5,18),
(54,'2020-11-21',1400.00,4,19),
(55,'2020-11-22',1560.00,3,20);

/*Table structure for table room_type */



/*Table structure for table order */


CREATE TABLE hotel_order (
  order_id int NOT NULL,
  room_id int DEFAULT NULL,
  start_date date DEFAULT NULL,
  leave_date date DEFAULT NULL,
  amount int DEFAULT NULL,
  payment decimal(10,2) DEFAULT NULL,
  create_date date NOT NULL,
  customer_id int NOT NULL,
  PRIMARY KEY (order_id),
  CONSTRAINT order_ibfk_1 FOREIGN KEY (customer_id) REFERENCES customer (uID) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT room_order_id FOREIGN KEY (room_id) REFERENCES room_type (room_id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

/*Data for the table order */

insert  into hotel_order(order_id,room_id,start_date,leave_date,amount,payment,create_date,customer_id) values 
(1,5,'2020-11-14','2020-11-15',2,5300.00,'2020-11-01',201904),
(2,1,'2020-11-28','2020-11-28',5,7295.00,'2020-11-01',201901),
(3,8,'2020-11-14','2020-11-16',2,7300.00,'2020-11-01',201902),
(4,4,'2020-11-14','2020-11-16',2,8400.00,'2020-11-01',201905),
(5,2,'2020-11-14','2020-11-16',4,16000.00,'2020-11-01',201906),
(6,6,'2020-11-14','2020-11-16',2,5200.00,'2020-11-01',201907),
(7,3,'2020-11-14','2020-11-14',5,6000.00,'2020-11-01',201908),
(8,7,'2020-11-14','2020-11-16',4,15400.00,'2020-11-01',201909),
(9,10,'2020-11-28','2020-11-29',2,6654.00,'2020-11-01',2019010),
(10,12,'2020-11-14','2020-11-16',3,12900.00,'2020-11-01',2019011),
(11,11,'2020-11-14','2020-11-16',2,9200.00,'2020-11-01',2019012),
(12,14,'2020-11-14','2020-11-16',1,4650.00,'2020-11-01',2019013),
(13,16,'2020-11-14','2020-11-16',4,17800.00,'2020-11-01',2019014),
(14,18,'2020-11-14','2020-11-15',3,8250.00,'2020-11-01',2019015),
(15,15,'2020-11-14','2020-11-16',2,8800.00,'2020-11-01',2019016),
(16,17,'2020-11-14','2020-11-16',4,17000.00,'2020-11-01',2019017),
(17,13,'2020-11-14','2020-11-14',3,4950.00,'2020-11-01',2019018),
(18,9,'2020-11-14','2020-11-15',5,11750.00,'2020-11-01',201903),
(19,9,'2020-11-16','2020-11-16',3,3450.00,'2020-11-01',201903),
(20,5,'2020-11-16','2020-11-16',4,5600.00,'2020-11-01',201904),
(21,13,'2020-11-15','2020-11-16',2,6300.00,'2020-11-01',2019018),
(22,7,'2020-09-01','2020-09-04',4,12000.00,'2020-09-01',201907),
(23,12,'2020-07-01','2020-07-10',3,12000.00,'2020-06-01',201907),
(24,16,'2020-10-01','2020-10-04',3,180000.00,'2020-08-01',201907),
(25,7,'2020-11-01','2020-11-01',3,7500.00,'2020-09-01',201908),
(26,12,'2020-11-01','2020-11-01',2,6000.00,'2020-08-01',201908),
(27,16,'2020-11-01','2020-11-03',1,8000.00,'2020-09-01',201908);

/*Table structure for table rating */


CREATE TABLE rating (
  rID int NOT NULL,
  stars int NOT NULL ,
  order_id int NOT NULL,
  uID int DEFAULT NULL,
  rate_date date DEFAULT NULL,
  PRIMARY KEY (rID),
  CONSTRAINT rating_ibfk_2 FOREIGN KEY (uID) REFERENCES customer (uID) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT rating_ibfk_3 FOREIGN KEY (order_id) REFERENCES hotel_order (order_id)
);
/*Data for the table rating */

insert  into rating(rID,stars,order_id,uID,rate_date) values 
(1,4,1,201904,NULL),
(2,4,2,201901,NULL),
(3,5,3,201902,NULL),
(4,4,4,201905,NULL),
(5,5,5,201906,NULL),
(6,4,6,201907,NULL),
(7,5,7,201908,NULL),
(8,5,8,201909,NULL),
(9,5,9,2019010,NULL),
(10,5,10,2019011,NULL),
(11,5,11,2019012,NULL),
(12,5,12,2019013,NULL),
(13,4,13,2019014,NULL),
(14,4,14,2019015,NULL),
(15,5,15,2019016,NULL),
(16,5,16,2019017,NULL),
(17,5,17,2019018,NULL),
(18,4,18,201903,NULL),
(19,4,19,201903,NULL),
(20,5,20,201904,NULL),
(21,5,21,2019018,NULL),
(22,5,22,201907,NULL),
(23,4,23,201907,NULL),
(24,4,24,201907,NULL);

