--
-- Convert all table to transactional.
--
alter table addressbook       ENGINE=InnoDB;
alter table address_in_groups ENGINE=InnoDB;
alter table group_list        ENGINE=InnoDB;
alter table month_lookup      ENGINE=InnoDB;

--
-- Add foreign keys
--
ALTER TABLE address_in_groups ADD FOREIGN KEY addr_of_group (domain_id, group_id) 
                                   REFERENCES group_list    (domain_id, group_id);
ALTER TABLE address_in_groups ADD FOREIGN KEY addr_of_group (domain_id, id) 
                                   REFERENCES addressbook   (domain_id, id);
