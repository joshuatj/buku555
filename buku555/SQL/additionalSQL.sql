-- This file is for any additional sql queries
-- no need to rerun the original one

-- change type of amount_to_pay to double
ALTER TABLE `buku555`.`bill_splitees` CHANGE COLUMN `amount_to_pay` `amount_to_pay` DOUBLE NULL DEFAULT NULL;

-- add column receive_notimail to let user choose to receive email or not
ALTER TABLE `buku555`.`user` ADD COLUMN `receive_notimail` BIT NULL DEFAULT 1  AFTER `password` ;

ALTER TABLE `buku555`.`user` ADD COLUMN `name` varchar(50) NULL AFTER `password` ;



-- new changes from version 4 

-- change type of transaction_date to Date
ALTER TABLE `buku555`.`transaction` CHANGE COLUMN `transaction_date` `transaction_date` DATE NULL DEFAULT NULL;

-- add column to facilitate record history
ALTER TABLE `buku555`.`transaction` ADD COLUMN `transaction_type` int default 1 AFTER `to_user_id` ;
ALTER TABLE `buku555`.`transaction` ADD COLUMN `photo` varchar(200) AFTER `to_user_id` ;
ALTER TABLE `buku555`.`transaction` ADD COLUMN `reason` varchar(500) AFTER `to_user_id` ;

