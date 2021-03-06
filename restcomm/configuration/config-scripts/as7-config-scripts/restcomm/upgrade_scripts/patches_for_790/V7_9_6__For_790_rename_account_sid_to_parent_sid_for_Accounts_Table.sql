-- SQL Script for MySQL/MariaDB to update DB with the schema changes for issue #5
-- #Author: George Vagenas

-- #To run the script use mysql client:
-- #mysql -u yourusername -p yourpassword yourdatabase < sql_update_script.sql

USE ${RESTCOMM_DBNAME};
DELIMITER //
CREATE PROCEDURE updateProcedure()
 BEGIN
 SELECT DISTINCTROW IFNULL(column_name, '') INTO @colName796
 FROM information_schema.columns
 WHERE table_schema='${RESTCOMM_DBNAME}'
 AND table_name = 'restcomm_accounts'
 AND column_name = 'parent_sid';

IF @colName796 IS NULL THEN
CREATE TABLE temp_table LIKE restcomm_accounts;
ALTER TABLE temp_table CHANGE COLUMN account_sid parent_sid VARCHAR(34);
INSERT INTO temp_table
  (
sid,
date_created,
date_updated,
email_address,
friendly_name,
parent_sid,
type,
status,
auth_token,
role,
uri
  ) SELECT
  sid as sid,
  date_created as date_created,
  date_updated as date_updated,
  email_address as email_address,
  friendly_name as friendly_name,
  account_sid as parent_sid,
  type as type,
  status as status,
  auth_token as auth_token,
  role as role,
  uri as uri
  FROM restcomm_accounts;
  DROP TABLE restcomm_accounts;
  ALTER TABLE temp_table RENAME restcomm_accounts;
END IF;
END //

DELIMITER ;
CALL updateProcedure();
drop procedure updateProcedure;
