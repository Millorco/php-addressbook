--
-- Creation script with sample data for "php-addressbook"
--
-- * You may add table prefixes, if the "$table_prefix"
--   parameter is set in "config.php".
-- * Uses "utf8mb4" (available since MySQL 5.5.3); tested with MySQL 26.7.
--   Existing installations: see "_sql_upgrades/addressbook_upgrade_utf8mb4.sql".
--
-- $LastChangedDate$
-- $Rev$
--
--

CREATE TABLE addressbook (
  pid int unsigned NOT NULL auto_increment,
  domain_id int unsigned NOT NULL default 0,
  id int unsigned NOT NULL,
  firstname varchar(255) NOT NULL default '',
  middlename varchar(255) NOT NULL default '',
  lastname varchar(255) NOT NULL default '',
  nickname varchar(255) NOT NULL default '',
  company varchar(255) NOT NULL default '',
  title varchar(255) NOT NULL default '',
  address text NOT NULL,
  addr_long text,
  addr_lat text,
  addr_status text,
  home text NOT NULL,
  mobile text NOT NULL,
  work text NOT NULL,
  fax text NOT NULL,
  email text NOT NULL,
  email2 text NOT NULL,
  email3 text NOT NULL,
  im text,
  im2 text,
  im3 text,
  homepage text NOT NULL,
  bday tinyint NOT NULL default 0,
  bmonth varchar(50) NOT NULL default '',
  byear varchar(4) NOT NULL default '',
  aday tinyint NOT NULL default 0,
  amonth varchar(50) NOT NULL default '',
  ayear varchar(4) NOT NULL default '',
  address2 text NOT NULL,
  phone2 text NOT NULL,
  notes text NOT NULL,
  photo mediumtext,
  x_vcard mediumtext,
  x_activesync mediumtext,
  created datetime default NULL,
  modified datetime default NULL,
  deprecated datetime DEFAULT NULL,
  password varchar(256) default NULL,
  login date default NULL,
  role varchar(256) default NULL,
  PRIMARY KEY (pid),
  KEY id_deprecated_domain_id_idx (id,deprecated,domain_id),
  KEY deprecated_domain_id_idx (deprecated,domain_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE group_list (
  `domain_id` int unsigned NOT NULL default 0,
  `group_id` int unsigned NOT NULL auto_increment,
  `group_parent_id` int default NULL,
  `created` datetime default NULL,
  `modified` datetime default NULL,
  `deprecated` datetime DEFAULT NULL,
  `group_name` varchar(255) NOT NULL default '',
  `group_header` mediumtext NOT NULL,
  `group_footer` mediumtext NOT NULL,
  PRIMARY KEY (group_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE address_in_groups (
  `ag_id` int unsigned NOT NULL auto_increment,
  `domain_id` int unsigned NOT NULL default 0,
  `id` int unsigned NOT NULL default 0,
  `group_id` int unsigned NOT NULL default 0,
  `created` datetime default NULL,
  `modified` datetime default NULL,
  `deprecated` datetime DEFAULT NULL,
  PRIMARY KEY (`ag_id`),
  KEY group_id_id_deprecated_idx (`group_id`,`id`, deprecated)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE month_lookup (
  `bmonth` varchar(50) NOT NULL default '',
  `bmonth_short` char(3) NOT NULL default '',
  `bmonth_num` int unsigned NOT NULL default 0,
  PRIMARY KEY (bmonth_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `month_lookup` VALUES ('', '', 0);
INSERT INTO `month_lookup` VALUES ('January', 'Jan', 1);
INSERT INTO `month_lookup` VALUES ('February', 'Feb', 2);
INSERT INTO `month_lookup` VALUES ('March', 'Mar', 3);
INSERT INTO `month_lookup` VALUES ('April', 'Apr', 4);
INSERT INTO `month_lookup` VALUES ('May', 'May', 5);
INSERT INTO `month_lookup` VALUES ('June', 'Jun', 6);
INSERT INTO `month_lookup` VALUES ('July', 'Jul', 7);
INSERT INTO `month_lookup` VALUES ('August', 'Aug', 8);
INSERT INTO `month_lookup` VALUES ('September', 'Sep', 9);
INSERT INTO `month_lookup` VALUES ('October', 'Oct', 10);
INSERT INTO `month_lookup` VALUES ('November', 'Nov', 11);
INSERT INTO `month_lookup` VALUES ('December', 'Dec', 12);

CREATE TABLE users (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `domain_id` int unsigned NOT NULL DEFAULT '0',
  `username` char(128) NOT NULL DEFAULT '',
  `md5_pass` char(128) NOT NULL DEFAULT '',
  `password_hint` varchar(255) NOT NULL DEFAULT '',
  `sso_facebook_uid` varchar(255) DEFAULT NULL,
  `sso_google_uid` varchar(255) DEFAULT NULL,
  `sso_live_uid` varchar(255) DEFAULT NULL,
  `sso_yahoo_uid` varchar(255) DEFAULT NULL,
  `lastname` varchar(50) NOT NULL DEFAULT '',
  `firstname` varchar(50) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `phone` varchar(50) NOT NULL DEFAULT '',
  `address1` varchar(100) NOT NULL DEFAULT '',
  `address2` varchar(100) NOT NULL DEFAULT '',
  `city` varchar(80) NOT NULL DEFAULT '',
  `state` varchar(20) NOT NULL DEFAULT '',
  `zip` varchar(20) NOT NULL DEFAULT '',
  `country` varchar(50) NOT NULL DEFAULT '',
  `master_code` char(128) NOT NULL DEFAULT '',
  `confirmation_code` char(128) DEFAULT NULL,
  `pass_reset_code` char(128) DEFAULT NULL,
  `status` char(128) NOT NULL DEFAULT 'NEW' COMMENT 'New, Ready, Blocked',
  `trials` int NOT NULL DEFAULT '0',
   created datetime default NULL,
   modified datetime default NULL,
   deprecated datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
