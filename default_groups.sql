/*!40000 ALTER TABLE `group_permission_item` DISABLE KEYS */;
INSERT INTO `group_permission_item`
VALUES /* SIS Consumer */
       (1,645,0,1,0,0,0,1,0,1),
       (2,649,0,1,0,0,0,1,0,1),
       (3,650,0,1,0,0,0,1,0,1),
       (4,652,0,1,0,0,0,1,0,1),
       (5,656,0,1,0,0,0,1,0,1),
       (6,659,0,1,0,0,0,1,0,1),
       (7,661,0,1,0,0,0,1,0,1),
       /* SIS Producer */
       (8,645,1,0,0,0,0,0,1,2),
       (9,649,1,0,0,0,0,0,1,2),
       (10,650,1,0,0,0,0,0,1,2),
       (11,652,1,0,0,0,0,0,1,2),
       (12,656,1,0,0,0,0,0,1,2),
       (13,659,1,0,0,0,0,0,1,2),
       (14,661,1,0,0,0,0,0,1,2);
/*!40000 ALTER TABLE `group_permission_item` ENABLE KEYS */;



/*!40000 ALTER TABLE `group_permission` DISABLE KEYS */;
INSERT INTO `group_permission`
VALUES (1,'SIS Consumer','2014-09-16 05:42:34','2014-09-16 05:42:34',1,4),
       (2,'SIS Producer','2014-09-16 05:46:01','2014-09-16 05:46:01',1,4);
/*!40000 ALTER TABLE `group_permission` ENABLE KEYS */;
