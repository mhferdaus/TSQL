use MyExperiments;

CREATE TABLE ALT_TAB(
UserNumber INTEGER,
UName VARCHAR(30)
);

INSERT INTO ALT_TAB VALUES(1,'Me');
INSERT INTO ALT_TAB VALUES(2,'Myself');
INSERT INTO ALT_TAB VALUES(3,'I');

SELECT * FROM ALT_TAB;

-- changing column name

sp_rename 'ALT_TAB.UName', 'UserName', 'COLUMN';

SELECT * FROM ALT_TAB;

-- changing table name

sp_rename 'ALT_TAB', 'ALT_TABLE';


SELECT * FROM ALT_TABLE;


-- modifying User_Name column type from varchar(30) to char(20)

ALTER TABLE ALT_TABLE
ALTER COLUMN UserName char(20);


-- adding single column

ALTER TABLE ALT_TABLE
ADD NewColumn VARCHAR(30);

-- dropping single column

ALTER TABLE ALT_TABLE
DROP COLUMN NewColumn ;

