-- Create a default "qa" zone for the "canvas" agent for tests

/*!40000 ALTER TABLE `zones` DISABLE KEYS */;
INSERT INTO `zones` VALUES (1,'qa','qa','2014-09-17 01:54:02',NULL,1,4,0,0);
/*!40000 ALTER TABLE `zones` ENABLE KEYS */;

/*!40000 ALTER TABLE `agent` DISABLE KEYS */;
INSERT INTO `agent` VALUES (1,'canvas','canvas',NULL,NULL,NULL,NULL,1,1,NULL,NULL);
/*!40000 ALTER TABLE `agent` ENABLE KEYS */;

/*!40000 ALTER TABLE `agent_permissions` DISABLE KEYS */;
INSERT INTO `agent_permissions`
VALUES 
       (1,1,1,645,0,1,0,0,0,1,0,1,NULL),
       (2,1,1,649,0,1,0,0,0,1,0,1,NULL),
       (3,1,1,650,0,1,0,0,0,1,0,1,NULL),
       (4,1,1,652,0,1,0,0,0,1,0,1,NULL),
       (5,1,1,656,0,1,0,0,0,1,0,1,NULL),
       (6,1,1,659,0,1,0,0,0,1,0,1,NULL),
       (7,1,1,661,0,1,0,0,0,1,0,1,NULL),
       (8,1,1,648,0,1,0,0,0,1,0,1,NULL);
/*!40000 ALTER TABLE `agent_permissions` ENABLE KEYS */;

/*!40000 ALTER TABLE `agent_zone_context` DISABLE KEYS */;
INSERT INTO `agent_zone_context` VALUES (1,1,1);
/*!40000 ALTER TABLE `agent_zone_context` ENABLE KEYS */;
