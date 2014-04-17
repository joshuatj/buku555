

DROP DATABASE IF EXISTS buku555;
CREATE DATABASE IF NOT EXISTS buku555;
USE buku555;

-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'user'
-- 
-- ---

DROP TABLE IF EXISTS `user`;
		
CREATE TABLE `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fb_user_id` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NULL,
  `password` VARCHAR(100) NULL DEFAULT NULL,
  `currency` INT NOT NULL DEFAULT 142,
  `isRegistered` bit NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'bill_splitees'
-- 
-- ---

DROP TABLE IF EXISTS `bill_splitees`;
		
CREATE TABLE `bill_splitees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `amount_to_pay` INT NULL DEFAULT NULL,
  `currency_id` INT(50) NULL DEFAULT NULL,
  `bill_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'currency'
-- 
-- ---

DROP TABLE IF EXISTS `currency`;
		
CREATE TABLE `currency` (
  `id` INT NOT NULL AUTO_INCREMENT DEFAULT NULL,
  `country_currency_code` VARCHAR(100) NULL DEFAULT NULL,
  `date` VARCHAR(10) NULL DEFAULT NULL,
  `value` VARCHAR(100) NULL DEFAULT NULL,
  UNIQUE (country_currency_code,`date`),
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'transaction'
-- 
-- ---

DROP TABLE IF EXISTS `transaction`;
		
CREATE TABLE `transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `paid_amount` DOUBLE NULL DEFAULT NULL,
  `transaction_date` DATETIME NULL DEFAULT NULL,
  `from_user_id` INT NULL DEFAULT NULL,
  `to_user_id` INT NULL DEFAULT NULL,
  `currency_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'loan_item'
-- 
-- ---

DROP TABLE IF EXISTS `loan_item`;
		
CREATE TABLE `loan_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `owner_user_id` INT NULL DEFAULT NULL,
  `date` DATE NULL DEFAULT NULL,
  `description` VARCHAR(1000) NULL,
  `photo` VARCHAR(1000) NULL DEFAULT NULL,
  `establishment_photo` VARCHAR(1000) NULL DEFAULT NULL,
  `item_type_id` INT NULL DEFAULT NULL,
  `loan_status` VARCHAR(100) NULL DEFAULT NULL,
  `loan_user_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'item_type'
-- 
-- ---

DROP TABLE IF EXISTS `item_type`;
		
CREATE TABLE `item_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `item_type_name` VARCHAR(50) NULL DEFAULT NULL,
  `description` VARCHAR(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'Bill'
-- 
-- ---

DROP TABLE IF EXISTS `Bill`;
		
CREATE TABLE `Bill` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `owner_user_id` INT NOT NULL,
  `date` DATE NULL DEFAULT NULL,
  `total_amount` DOUBLE NULL DEFAULT NULL,
  `reason` VARCHAR(100) NULL DEFAULT NULL,
  `photo` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'currency_code'
-- 
-- ---

DROP TABLE IF EXISTS `currency_code`;
		
CREATE TABLE `currency_code` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `country_currency_code` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'loan_money'
-- 
-- ---

DROP TABLE IF EXISTS `loan_money`;
		
CREATE TABLE `loan_money` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `owner_user_id` INT NULL DEFAULT NULL,
  `loan_user_id` INT NULL DEFAULT NULL,
  `total_loan_amount` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `bill_splitees` ADD FOREIGN KEY (user_id) REFERENCES `user` (`id`);
ALTER TABLE `bill_splitees` ADD FOREIGN KEY (currency_id) REFERENCES `currency` (`id`);
ALTER TABLE `bill_splitees` ADD FOREIGN KEY (bill_id) REFERENCES `Bill` (`id`);
ALTER TABLE `transaction` ADD FOREIGN KEY (from_user_id) REFERENCES `user` (`id`);
ALTER TABLE `transaction` ADD FOREIGN KEY (to_user_id) REFERENCES `user` (`id`);
ALTER TABLE `transaction` ADD FOREIGN KEY (currency_id) REFERENCES `currency` (`id`);
ALTER TABLE `loan_item` ADD FOREIGN KEY (owner_user_id) REFERENCES `user` (`id`);
ALTER TABLE `loan_item` ADD FOREIGN KEY (item_type_id) REFERENCES `item_type` (`id`);
ALTER TABLE `loan_item` ADD FOREIGN KEY (loan_user_id) REFERENCES `user` (`id`);
ALTER TABLE `Bill` ADD FOREIGN KEY (owner_user_id) REFERENCES `user` (`id`);
ALTER TABLE `loan_money` ADD FOREIGN KEY (owner_user_id) REFERENCES `user` (`id`);
ALTER TABLE `loan_money` ADD FOREIGN KEY (loan_user_id) REFERENCES `user` (`id`);
ALTER TABLE `user` ADD FOREIGN KEY (currency) REFERENCES `currency_code` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `user` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `bill_splitees` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `currency` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `transaction` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `loan_item` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `item_type` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Bill` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `currency_code` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `loan_money` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `user` (`id`,`fb_user_id`,`email`,`password`,`isRegistered`) VALUES
-- ('','','','','');
-- INSERT INTO `bill_splitees` (`id`,`user_id`,`amount_to_pay`,`currency_id`,`bill_id`) VALUES
-- ('','','','','');
-- INSERT INTO `currency` (`id`,`country_currency_code`,`currency_date`,`value`) VALUES
-- ('','','','');
-- INSERT INTO `transaction` (`id`,`paid_amount`,`transaction_date`,`from_user_id`,`to_user_id`,`currency_id`) VALUES
-- ('','','','','','');
-- INSERT INTO `loan_item` (`id`,`owner_user_id`,`date`,`description`,`photo`,`establishment_photo`,`item_type_id`,`loan_status`,`loan_user_id`) VALUES
-- ('','','','','','','','','');
-- INSERT INTO `item_type` (`id`,`item_type_name`,`description`) VALUES
-- ('','','');
-- INSERT INTO `Bill` (`id`,`owner_user_id`,`date`,`total_amount`,`reason`,`photo`) VALUES
-- ('','','','','','');
-- INSERT INTO `currency_code` (`id`,`country_currency_code`) VALUES
-- ('','');
-- INSERT INTO `loan_money` (`id`,`owner_user_id`,`loan_user_id`,`total_loan_amount`) VALUES
-- ('','','','');

INSERT INTO `currency` (country_currency_code, date, value) VALUES ('EUR','2014-01-01','0.575693768845'),('EUR','2014-01-02','0.577100646353'),('EUR','2014-01-03','0.579911853398'),('EUR','2014-01-04','0.580852980015'),('EUR','2014-01-05','0.580805760892'),('EUR','2014-01-06','0.579609343303'),('EUR','2014-01-07','0.577200577201'),('EUR','2014-01-08','0.57930714865'),('EUR','2014-01-09','0.577901063338'),('EUR','2014-01-10','0.579542161692'),('EUR','2014-01-11','0.578332139656'),('EUR','2014-01-12','0.578778692143'),('EUR','2014-01-13','0.579038795599'),('EUR','2014-01-14','0.577233895174'),('EUR','2014-01-15','0.577667379123'),('EUR','2014-01-16','0.57743388382'),('EUR','2014-01-17','0.578001271603'),('EUR','2014-01-18','0.579079000599'),('EUR','2014-01-19','0.578818064055'),('EUR','2014-01-20','0.577700751011'),('EUR','2014-01-21','0.577767506355'),('EUR','2014-01-22','0.576801061314'),('EUR','2014-01-23','0.57326301307'),('EUR','2014-01-24','0.570939194976'),('EUR','2014-01-25','0.571799052904'),('EUR','2014-01-26','0.571851379086'),('EUR','2014-01-27','0.57326301307'),('EUR','2014-01-28','0.574778710197'),('EUR','2014-01-29','0.576535024503'),('EUR','2014-01-30','0.577267216995'),('EUR','2014-01-31','0.578770691052'),('EUR','2014-02-01','0.58070658602'),('EUR','2014-02-02','0.580696579295'),('EUR','2014-02-03','0.580990006972'),('EUR','2014-02-04','0.58302238806'),('EUR','2014-02-05','0.582173837108'),('EUR','2014-02-06','0.584282792872'),('EUR','2014-02-07','0.58061893979'),('EUR','2014-02-08','0.57832168935'),('EUR','2014-02-09','0.578319865256'),('EUR','2014-02-10','0.57743388382'),('EUR','2014-02-11','0.577034045009'),('EUR','2014-02-12','0.58186896311'),('EUR','2014-02-13','0.576801061314'),('EUR','2014-02-14','0.578402452426'),('EUR','2014-02-15','0.579636191039'),('EUR','2014-02-16','0.579947364074'),('EUR','2014-02-17','0.580080051047'),('EUR','2014-02-18','0.577533930118'),('EUR','2014-02-19','0.576867608884'),('EUR','2014-02-20','0.576302443522'),('EUR','2014-02-21','0.575506445672'),('EUR','2014-02-22','0.57423612311'),('EUR','2014-02-23','0.574089367734'),('EUR','2014-02-24','0.574283581232'),('EUR','2014-02-25','0.574877838459'),('EUR','2014-02-26','0.575871004895'),('EUR','2014-02-27','0.578435909301'),('EUR','2014-02-28','0.571853376794'),('EUR','2014-03-01','0.571644187413'),('EUR','2014-03-02','0.571523792095'),('EUR','2014-03-03','0.572704885173'),('EUR','2014-03-04','0.572442612628'),('EUR','2014-03-05','0.573953968892'),('EUR','2014-03-06','0.575506445672'),('EUR','2014-03-07','0.569735642662'),('EUR','2014-03-08','0.569735642662'),('EUR','2014-03-09','0.569735642662'),('EUR','2014-03-10','0.568375582585'),('EUR','2014-03-11','0.56983303892'),('EUR','2014-03-12','0.568084985514'),('EUR','2014-03-13','0.567311510751'),('EUR','2014-03-14','0.569184358814'),('EUR','2014-03-15','0.569184358814'),('GBP','2014-01-01','0.478283137323'),('GBP','2014-01-02','0.477954755309'),('GBP','2014-01-03','0.481587798655'),('GBP','2014-01-04','0.480812961798'),('GBP','2014-01-05','0.480773875201'),('GBP','2014-01-06','0.481249637744'),('GBP','2014-01-07','0.47974025974'),('GBP','2014-01-08','0.479492526938'),('GBP','2014-01-09','0.477201803051'),('GBP','2014-01-10','0.479860909881'),('GBP','2014-01-11','0.479570718689'),('GBP','2014-01-12','0.479941013685'),('GBP','2014-01-13','0.4815865663'),('GBP','2014-01-14','0.479941122143'),('GBP','2014-01-15','0.479579458148'),('GBP','2014-01-16','0.480511606421'),('GBP','2014-01-17','0.477544650598'),('GBP','2014-01-18','0.477403871785'),('GBP','2014-01-19','0.477188750677'),('GBP','2014-01-20','0.477296360485'),('GBP','2014-01-21','0.476022648486'),('GBP','2014-01-22','0.472400069216'),('GBP','2014-01-23','0.471078880991'),('GBP','2014-01-24','0.473365686554'),('GBP','2014-01-25','0.474432700241'),('GBP','2014-01-26','0.474476116284'),('GBP','2014-01-27','0.472970648934'),('GBP','2014-01-28','0.472956661685'),('GBP','2014-01-29','0.473969443644'),('GBP','2014-01-30','0.47555273336'),('GBP','2014-01-31','0.475373307096'),('GBP','2014-02-01','0.476460709625'),('GBP','2014-02-02','0.476452499264'),('GBP','2014-02-03','0.479839646758'),('GBP','2014-02-04','0.483354710821'),('GBP','2014-02-05','0.484485067241'),('GBP','2014-02-06','0.484224364592'),('GBP','2014-02-07','0.482726586541'),('GBP','2014-02-08','0.480524846631'),('GBP','2014-02-09','0.480523330999'),('GBP','2014-02-10','0.480194017785'),('GBP','2014-02-11','0.479371032891'),('GBP','2014-02-12','0.478063540091'),('GBP','2014-02-13','0.473842071869'),('GBP','2014-02-14','0.474492451848'),('GBP','2014-02-15','0.47395570414'),('GBP','2014-02-16','0.474210143454'),('GBP','2014-02-17','0.4749985498'),('GBP','2014-02-18','0.475483684666'),('GBP','2014-02-19','0.47597346409'),('GBP','2014-02-20','0.473720608575'),('GBP','2014-02-21','0.472968462247'),('GBP','2014-02-22','0.474745729414'),('GBP','2014-02-23','0.474624400425'),('GBP','2014-02-24','0.473582955263'),('GBP','2014-02-25','0.473670594999'),('GBP','2014-02-26','0.473711488627'),('GBP','2014-02-27','0.474519898195'),('GBP','2014-02-28','0.472493852576'),('GBP','2014-03-01','0.471201177153'),('GBP','2014-03-02','0.471101936371'),('GBP','2014-03-03','0.471364755741'),('GBP','2014-03-04','0.472036178373'),('GBP','2014-03-05','0.471617976238'),('GBP','2014-03-06','0.473872007366'),('GBP','2014-03-07','0.472025979945'),('GBP','2014-03-08','0.472025979945'),('GBP','2014-03-09','0.472025979945'),('GBP','2014-03-10','0.473911560759'),('GBP','2014-03-11','0.475012821243'),('GBP','2014-03-12','0.474862239391'),('GBP','2014-03-13','0.474215691836'),('GBP','2014-03-14','0.475525072571'),('GBP','2014-03-15','0.475525072571'),('MYR','2014-01-01','2.59629251133'),('MYR','2014-01-02','2.59429824561'),('MYR','2014-01-03','2.59568545581'),('MYR','2014-01-04','2.59634326632'),('MYR','2014-01-05','2.59538478295'),('MYR','2014-01-06','2.58975250681'),('MYR','2014-01-07','2.58574314574'),('MYR','2014-01-08','2.57942301008'),('MYR','2014-01-09','2.57859454461'),('MYR','2014-01-10','2.57450014489'),('MYR','2014-01-11','2.58120329044'),('MYR','2014-01-12','2.58416388322'),('MYR','2014-01-13','2.57961783439'),('MYR','2014-01-14','2.5748672362'),('MYR','2014-01-15','2.58292415227'),('MYR','2014-01-16','2.58886707472'),('MYR','2014-01-17','2.58782729322'),('MYR','2014-01-18','2.58632487746'),('MYR','2014-01-19','2.58470807384'),('MYR','2014-01-20','2.59988445985'),('MYR','2014-01-21','2.6087358447'),('MYR','2014-01-22','2.60708311703'),('MYR','2014-01-23','2.60404723687'),('MYR','2014-01-24','2.62072509278'),('MYR','2014-01-25','2.61244520567'),('MYR','2014-01-26','2.61377146218'),('MYR','2014-01-27','2.61706030727'),('MYR','2014-01-28','2.6162202552'),('MYR','2014-01-29','2.61545113866'),('MYR','2014-01-30','2.62177451943'),('MYR','2014-01-31','2.61864799167'),('MYR','2014-02-01','2.6230408076'),('MYR','2014-02-02','2.62299560741'),('MYR','2014-02-03','2.64460841274'),('MYR','2014-02-04','2.62354244403'),('MYR','2014-02-05','2.61134074635'),('MYR','2014-02-06','2.62243645925'),('MYR','2014-02-07','2.62991348778'),('MYR','2014-02-08','2.62313078585'),('MYR','2014-02-09','2.62356251143'),('MYR','2014-02-10','2.63332948377'),('MYR','2014-02-11','2.63006347374'),('MYR','2014-02-12','2.62399627604'),('MYR','2014-02-13','2.62069562208'),('MYR','2014-02-14','2.61206547516'),('MYR','2014-02-15','2.62454400853'),('MYR','2014-02-16','2.62634051664'),('MYR','2014-02-17','2.61790127038'),('MYR','2014-02-18','2.61495812879'),('MYR','2014-02-19','2.61263340063'),('MYR','2014-02-20','2.61410788382'),('MYR','2014-02-21','2.59887200737'),('MYR','2014-02-22','2.59935823848'),('MYR','2014-02-23','2.59824116778'),('MYR','2014-02-24','2.59024866479'),('MYR','2014-02-25','2.59384880713'),('MYR','2014-02-26','2.58894327671'),('MYR','2014-02-27','2.59098796853'),('MYR','2014-02-28','2.58849431006'),('MYR','2014-03-01','2.58502207162'),('MYR','2014-03-02','2.58457623536'),('MYR','2014-03-03','2.58988603173'),('MYR','2014-03-04','2.57879672563'),('MYR','2014-03-05','2.57888997302'),('MYR','2014-03-06','2.5794198895'),('MYR','2014-03-07','2.57782588879'),('MYR','2014-03-08','2.57782588879'),('MYR','2014-03-09','2.57782588879'),('MYR','2014-03-10','2.59037171763'),('MYR','2014-03-11','2.58897942903'),('MYR','2014-03-12','2.59529625632'),('MYR','2014-03-13','2.58955012197'),('MYR','2014-03-14','2.59212248847'),('MYR','2014-03-15','2.59212248847'),('USD','2014-01-01','0.791589519671'),('USD','2014-01-02','0.788204062789'),('USD','2014-01-03','0.790651820923'),('USD','2014-01-04','0.789313951992'),('USD','2014-01-05','0.789249786508'),('USD','2014-01-06','0.78838462876'),('USD','2014-01-07','0.787359307359'),('USD','2014-01-08','0.787510137875'),('USD','2014-01-09','0.786638927416'),('USD','2014-01-10','0.787423935091'),('USD','2014-01-11','0.790515083818'),('USD','2014-01-12','0.791125470917'),('USD','2014-01-13','0.790619571511'),('USD','2014-01-14','0.788905564535'),('USD','2014-01-15','0.785974236035'),('USD','2014-01-16','0.78513685183'),('USD','2014-01-17','0.785156927345'),('USD','2014-01-18','0.784016106827'),('USD','2014-01-19','0.783662824368'),('USD','2014-01-20','0.783708838821'),('USD','2014-01-21','0.781488329096'),('USD','2014-01-22','0.782488319779'),('USD','2014-01-23','0.781873423527'),('USD','2014-01-24','0.781444476163'),('USD','2014-01-25','0.78207790278'),('USD','2014-01-26','0.782149471893'),('USD','2014-01-27','0.782962623252'),('USD','2014-01-28','0.784515461547'),('USD','2014-01-29','0.784548861343'),('USD','2014-01-30','0.783582520349'),('USD','2014-01-31','0.782266466026'),('USD','2014-02-01','0.783285317943'),('USD','2014-02-02','0.783271820386'),('USD','2014-02-03','0.784220311411'),('USD','2014-02-04','0.788187966418'),('USD','2014-02-05','0.788438027595'),('USD','2014-02-06','0.78848962898'),('USD','2014-02-07','0.788132148871'),('USD','2014-02-08','0.788531596461'),('USD','2014-02-09','0.788529109341'),('USD','2014-02-10','0.787504330754'),('USD','2014-02-11','0.789151759954'),('USD','2014-02-12','0.789770743629'),('USD','2014-02-13','0.788775451347'),('USD','2014-02-14','0.792816241541'),('USD','2014-02-15','0.793718826693'),('USD','2014-02-16','0.794144928273'),('USD','2014-02-17','0.794651661929'),('USD','2014-02-18','0.793011839446'),('USD','2014-02-19','0.792904528411'),('USD','2014-02-20','0.789880129092'),('USD','2014-02-21','0.788846685083'),('USD','2014-02-22','0.788986381306'),('USD','2014-02-23','0.78878474301'),('USD','2014-02-24','0.788778498823'),('USD','2014-02-25','0.790686979017'),('USD','2014-02-26','0.790440541319'),('USD','2014-02-27','0.789912077742'),('USD','2014-02-28','0.789901069366'),('USD','2014-03-01','0.78897642144'),('USD','2014-03-02','0.788810253271'),('USD','2014-03-03','0.788500085906'),('USD','2014-03-04','0.788138989066'),('USD','2014-03-05','0.788153590082'),('USD','2014-03-06','0.791033609576'),('USD','2014-03-07','0.791590701914'),('USD','2014-03-08','0.791590701914'),('USD','2014-03-09','0.791590701914'),('USD','2014-03-10','0.788962146186'),('USD','2014-03-11','0.789218758904'),('USD','2014-03-12','0.786797704937'),('USD','2014-03-13','0.787825494979'),('USD','2014-03-14','0.793556833058'),('USD','2014-03-15','0.793556833058');
INSERT INTO `currency_code` VALUES ('1','AED'),('10','AWG'),('100','MAD'),('101','MCF'),('102','MDL'),('103','MGA'),('104','MKD'),('105','MMK'),('106','MNT'),('107','MOP'),('108','MRO'),('109','MTL'),('11','AZN'),('110','MUR'),('111','MVR'),('112','MWK'),('113','MXN'),('114','MYR'),('115','MZN'),('116','NAD'),('117','NGN'),('118','NIO'),('119','NLG'),('12','BAM'),('120','NOK'),('121','NPR'),('122','NZD'),('123','OMR'),('124','PAB'),('125','PEN'),('126','PGK'),('127','PHP'),('128','PKR'),('129','PLN'),('13','BBD'),('130','PTE'),('131','PYG'),('132','QAR'),('133','RON'),('134','RSD'),('135','RUB'),('136','RWF'),('137','SAR'),('138','SBD'),('139','SCR'),('14','BDT'),('140','SDG'),('141','SEK'),('142','SGD'),('143','SHP'),('144','SIT'),('145','SKK'),('146','SLL'),('147','SML'),('148','SOS'),('149','SRD'),('15','BEF'),('150','STD'),('151','SVC'),('152','SYP'),('153','SZL'),('154','THB'),('155','TJS'),('156','TMT'),('157','TND'),('158','TOP'),('159','TRY'),('16','BGN'),('160','TTD'),('161','TWD'),('162','TZS'),('163','UAH'),('164','UGX'),('165','USD'),('166','UYU'),('167','UZS'),('168','VAL'),('169','VEF'),('17','BHD'),('170','VND'),('171','VUV'),('172','WST'),('173','XAF'),('174','XAG'),('175','XAU'),('176','XCD'),('177','XDR'),('178','XOF'),('179','XPF'),('18','BIF'),('180','YER'),('181','ZAR'),('182','ZMK'),('183','ZMW'),('184','ZWL'),('19','BMD'),('2','AFN'),('20','BND'),('21','BOB'),('22','BRL'),('23','BSD'),('24','BTC'),('25','BTN'),('26','BWP'),('27','BYR'),('28','BZD'),('29','CAD'),('3','ALL'),('30','CDF'),('31','CHF'),('32','CLF'),('33','CLP'),('34','CNY'),('35','COP'),('36','CRC'),('37','CUP'),('38','CVE'),('39','CYP'),('4','AMD'),('40','CZK'),('41','DEM'),('42','DJF'),('43','DKK'),('44','DOP'),('45','DZD'),('46','EEK'),('47','EGP'),('48','ERN'),('49','ESP'),('5','ANG'),('50','ETB'),('51','EUR'),('52','FIM'),('53','FJD'),('54','FKP'),('55','FRF'),('56','GBP'),('57','GEL'),('58','GHS'),('59','GIP'),('6','AOA'),('60','GMD'),('61','GNF'),('62','GRD'),('63','GTQ'),('64','GYD'),('65','HKD'),('66','HNL'),('67','HRK'),('68','HTG'),('69','HUF'),('7','ARS'),('70','IDR'),('71','IEP'),('72','ILS'),('73','INR'),('74','IQD'),('75','IRR'),('76','ISK'),('77','ITL'),('78','JEP'),('79','JMD'),('8','ATS'),('80','JOD'),('81','JPY'),('82','KES'),('83','KGS'),('84','KHR'),('85','KMF'),('86','KPW'),('87','KRW'),('88','KWD'),('89','KYD'),('9','AUD'),('90','KZT'),('91','LAK'),('92','LBP'),('93','LKR'),('94','LRD'),('95','LSL'),('96','LTL'),('97','LUF'),('98','LVL'),('99','LYD');

INSERT INTO `buku555`.`user` (`fb_user_id`, `email`, `isRegistered`) VALUES ('11111', 'ducnq135@facebook.com', 1);
INSERT INTO `buku555`.`user` (`fb_user_id`, `email`, `isRegistered`) VALUES ('22222', 'abc@facebook.com', 1);
INSERT INTO `buku555`.`user` (`fb_user_id`, `email`) VALUES ('33333', 'def@fb.com');

INSERT INTO `buku555`.`Bill` (`owner_user_id`, `date`, `total_amount`, `reason`) VALUES ('1', '2013-1-1', '300', 'for test');

INSERT INTO `buku555`.`item_type` (`item_type_name`) VALUES ('Book');
INSERT INTO `buku555`.`item_type` (`item_type_name`) VALUES ('CD');
INSERT INTO `buku555`.`item_type` (`item_type_name`) VALUES ('Phone');

INSERT INTO `buku555`.`bill_splitees` (`user_id`, `amount_to_pay`, `currency_id`, `bill_id`) VALUES ('2', '100', '1', '1');
INSERT INTO `buku555`.`bill_splitees` (`user_id`, `amount_to_pay`, `currency_id`, `bill_id`) VALUES ('3', '100', '1', '1');

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