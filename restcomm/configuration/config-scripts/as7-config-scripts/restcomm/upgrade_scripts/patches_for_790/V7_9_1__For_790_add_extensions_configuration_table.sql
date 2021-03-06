-- SQL Script for MySQL/MariaDB to update DB with the schema changes for issue #5
-- #Author: George Vagenas

-- #To run the script use mysql client:
-- #mysql -u yourusername -p yourpassword yourdatabase < sql_update_script.sql

USE ${RESTCOMM_DBNAME};
DELIMITER //
CREATE PROCEDURE updateProcedure()
 BEGIN
 SELECT DISTINCTROW IFNULL(table_name, '') INTO @tblName791
 FROM information_schema.columns
 WHERE table_schema='${RESTCOMM_DBNAME}'
 AND table_name = 'restcomm_extensions_configuration';

  IF @tblName791 IS NULL THEN
		CREATE TABLE restcomm_extensions_configuration (
      sid VARCHAR(34) NOT NULL PRIMARY KEY,
      extension VARCHAR(255) NOT NULL,
      configuration_data LONGTEXT NOT NULL,
      configuration_type VARCHAR(255) NOT NULL,
      date_created DATETIME NOT NULL,
      date_updated DATETIME
		);
END IF;
END //

DELIMITER ;
CALL updateProcedure();
drop procedure updateProcedure;
