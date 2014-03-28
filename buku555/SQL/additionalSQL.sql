-- This file is for any additional sql queries
-- no need to rerun the original one

-- change type of amount_to_pay to double
ALTER TABLE `buku555`.`bill_splitees` CHANGE COLUMN `amount_to_pay` `amount_to_pay` DOUBLE NULL DEFAULT NULL  ;

-- add column receive_notimail to let user choose to receive email or not
ALTER TABLE `buku555`.`user` ADD COLUMN `receive_notimail` BIT NULL DEFAULT 1  AFTER `password` ;