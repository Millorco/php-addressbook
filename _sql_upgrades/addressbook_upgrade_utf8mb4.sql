--
-- Upgrade script for existing installations: MySQL 8.x / 9.x compatibility.
--
-- * Converts all tables from the deprecated 3-byte "utf8" (utf8mb3) to the
--   full "utf8mb4" character set (emoji, all CJK characters) on InnoDB.
-- * Adds defaults to the NOT NULL columns, as strict SQL mode is the default
--   since MySQL 5.7.
-- * Run "fix_deprecated_logic.sql" first, if not yet applied.
-- * Add your table prefix to the table names, if "$table_prefix" is set.
-- * Tested with MySQL 26.7. Take a backup before running it!
--
-- Note: MySQL widens TEXT columns to MEDIUMTEXT during the conversion, to
--       guarantee that the existing content still fits.
--

ALTER TABLE `addressbook`       ENGINE = InnoDB;
ALTER TABLE `group_list`        ENGINE = InnoDB;
ALTER TABLE `address_in_groups` ENGINE = InnoDB;
ALTER TABLE `month_lookup`      ENGINE = InnoDB;
ALTER TABLE `users`             ENGINE = InnoDB;

ALTER TABLE `addressbook`       CONVERT TO CHARACTER SET utf8mb4;
ALTER TABLE `group_list`        CONVERT TO CHARACTER SET utf8mb4;
ALTER TABLE `address_in_groups` CONVERT TO CHARACTER SET utf8mb4;
ALTER TABLE `month_lookup`      CONVERT TO CHARACTER SET utf8mb4;
ALTER TABLE `users`             CONVERT TO CHARACTER SET utf8mb4;

ALTER TABLE `addressbook`
  MODIFY `firstname`  varchar(255) NOT NULL default '',
  MODIFY `middlename` varchar(255) NOT NULL default '',
  MODIFY `lastname`   varchar(255) NOT NULL default '',
  MODIFY `nickname`   varchar(255) NOT NULL default '',
  MODIFY `company`    varchar(255) NOT NULL default '',
  MODIFY `title`      varchar(255) NOT NULL default '',
  MODIFY `im`         mediumtext,
  MODIFY `im2`        mediumtext,
  MODIFY `im3`        mediumtext,
  MODIFY `bday`       tinyint NOT NULL default 0,
  MODIFY `bmonth`     varchar(50) NOT NULL default '',
  MODIFY `byear`      varchar(4) NOT NULL default '',
  MODIFY `aday`       tinyint NOT NULL default 0,
  MODIFY `amonth`     varchar(50) NOT NULL default '',
  MODIFY `ayear`      varchar(4) NOT NULL default '';

ALTER TABLE `users`
  MODIFY `username`    char(128) NOT NULL DEFAULT '',
  MODIFY `md5_pass`    char(128) NOT NULL DEFAULT '',
  MODIFY `master_code` char(128) NOT NULL DEFAULT '';
