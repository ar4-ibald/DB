-- MySQL Script generated by MySQL Workbench
-- Mon Apr  6 11:55:10 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User_Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User_Role` (
  `ID_User_Role` INT NOT NULL AUTO_INCREMENT,
  `Role_Name` VARCHAR(100) NOT NULL DEFAULT 'Player',
  PRIMARY KEY (`ID_User_Role`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `ID_User` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Surname` VARCHAR(100) NOT NULL,
  `Second_Name` VARCHAR(100) NULL,
  `Phone_Number` VARCHAR(100) NULL,
  `Email` VARCHAR(100) NULL,
  `ID_Role` INT NOT NULL,
  PRIMARY KEY (`ID_User`),
  INDEX `FK_Role_idx` (`ID_Role` ASC) VISIBLE,
  INDEX `Email` (`Email` ASC) VISIBLE,
  CONSTRAINT `FK_Role`
    FOREIGN KEY (`ID_Role`)
    REFERENCES `mydb`.`User_Role` (`ID_User_Role`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Account` (
  `ID_Account` INT NOT NULL AUTO_INCREMENT,
  `Login` VARCHAR(100) NOT NULL,
  `Password` VARCHAR(100) NOT NULL,
  `ID_User` INT NOT NULL,
  PRIMARY KEY (`ID_Account`),
  INDEX `FK_User_idx` (`ID_User` ASC) VISIBLE,
  INDEX `Login` () VISIBLE,
  CONSTRAINT `FK_User`
    FOREIGN KEY (`ID_User`)
    REFERENCES `mydb`.`User` (`ID_User`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prize`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Prize` (
  `ID_Prize` INT NOT NULL AUTO_INCREMENT,
  `Type` VARCHAR(100) NOT NULL,
  `Amount` VARCHAR(100) NOT NULL,
  `Places` VARCHAR(200) NOT NULL DEFAULT '1',
  `Percent` VARCHAR(200) NULL,
  PRIMARY KEY (`ID_Prize`),
  INDEX `Type` (`Type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Address` (
  `ID_Address` INT NOT NULL AUTO_INCREMENT,
  `Country` VARCHAR(100) NOT NULL,
  `City` VARCHAR(100) NOT NULL,
  `Street` VARCHAR(100) NOT NULL,
  `Building` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID_Address`),
  INDEX `Country` (`Country` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Event` (
  `ID_Event` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Tier` VARCHAR(100) NOT NULL DEFAULT 'Minor',
  `ID_Prize` INT NOT NULL,
  `ID_Adress` INT NOT NULL,
  PRIMARY KEY (`ID_Event`),
  INDEX `ID_Prize_idx` (`ID_Prize` ASC) VISIBLE,
  INDEX `FK_Adress_idx` (`ID_Adress` ASC) VISIBLE,
  INDEX `Tier` (`Tier` ASC) VISIBLE,
  CONSTRAINT `FK_Prize`
    FOREIGN KEY (`ID_Prize`)
    REFERENCES `mydb`.`Prize` (`ID_Prize`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_Adress`
    FOREIGN KEY (`ID_Adress`)
    REFERENCES `mydb`.`Address` (`ID_Address`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Discipline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Discipline` (
  `ID_Discipline` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID_Discipline`),
  INDEX `Discipline_Name` () VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Roster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Roster` (
  `ID_Roster` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Amount` INT NOT NULL DEFAULT 1,
  `ID_Discipline` INT NOT NULL,
  INDEX `FK_Discipline_idx` (`ID_Discipline` ASC) VISIBLE,
  PRIMARY KEY (`ID_Roster`),
  CONSTRAINT `FK_Discipline`
    FOREIGN KEY (`ID_Discipline`)
    REFERENCES `mydb`.`Discipline` (`ID_Discipline`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Schedule` (
  `ID_Schedule` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NOT NULL,
  `Time` TIME NOT NULL,
  `Place` VARCHAR(100) NOT NULL,
  `Incident` VARCHAR(100) NOT NULL,
  `ID_Event` INT NOT NULL,
  PRIMARY KEY (`ID_Schedule`),
  INDEX `FK_Event_idx` (`ID_Event` ASC) VISIBLE,
  INDEX `Date` (`Date` ASC) VISIBLE,
  CONSTRAINT `FK_Event`
    FOREIGN KEY (`ID_Event`)
    REFERENCES `mydb`.`Event` (`ID_Event`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User_has_Roster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User_has_Roster` (
  `User_ID_User` INT NOT NULL,
  `Roster_ID_Roster` INT NOT NULL,
  PRIMARY KEY (`User_ID_User`, `Roster_ID_Roster`),
  INDEX `fk_User_has_Roster_Roster1_idx` (`Roster_ID_Roster` ASC) VISIBLE,
  INDEX `fk_User_has_Roster_User1_idx` (`User_ID_User` ASC) VISIBLE,
  CONSTRAINT `fk_User_has_Roster_User1`
    FOREIGN KEY (`User_ID_User`)
    REFERENCES `mydb`.`User` (`ID_User`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_User_has_Roster_Roster1`
    FOREIGN KEY (`Roster_ID_Roster`)
    REFERENCES `mydb`.`Roster` (`ID_Roster`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Roster_has_Event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Roster_has_Event` (
  `Roster_ID_Roster` INT NOT NULL,
  `Event_ID_Event` INT NOT NULL,
  `Place` INT NULL,
  PRIMARY KEY (`Roster_ID_Roster`, `Event_ID_Event`),
  INDEX `fk_Roster_has_Event_Event1_idx` (`Event_ID_Event` ASC) VISIBLE,
  INDEX `fk_Roster_has_Event_Roster1_idx` (`Roster_ID_Roster` ASC) VISIBLE,
  CONSTRAINT `fk_Roster_has_Event_Roster1`
    FOREIGN KEY (`Roster_ID_Roster`)
    REFERENCES `mydb`.`Roster` (`ID_Roster`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Roster_has_Event_Event1`
    FOREIGN KEY (`Event_ID_Event`)
    REFERENCES `mydb`.`Event` (`ID_Event`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `mydb`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Account_BEFORE_INSERT` BEFORE INSERT ON `Account` FOR EACH ROW
BEGIN
SET NEW.Password = md5(NEW.password);
END$$

USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Schedule_BEFORE_INSERT` BEFORE INSERT ON `Schedule` FOR EACH ROW
BEGIN
 IF NEW.Place is NULL THEN
 SET NEW.Place = 'Main Stage';
 END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`User_Role`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`User_Role` (`ID_User_Role`, `Role_Name`) VALUES (1, 'Player');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (1, 'Michael', 'Vu', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (2, 'Lasse', 'Urpalainen', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (3, 'Nikolay', 'Nikolov', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (4, 'Jin', 'Zhiyi', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (5, 'Zhang', 'Chengjun', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (6, 'Song', 'Chun', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (7, 'Andrew', 'Halim', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (8, 'Nuenghara', 'Teeramahanon', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (9, 'Kim', 'Villafierte', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (10, 'Egor', 'Grigorenko', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (11, 'Vladislav', 'Krystanek', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (12, 'Yawar', 'Hassan', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (13, 'Artour', 'Babaev', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (14, 'William', 'Medeiros de Anastacio', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (15, 'Hector', 'Rodriguez', NULL, NULL, NULL, 1);
INSERT INTO `mydb`.`User` (`ID_User`, `Name`, `Surname`, `Second_Name`, `Phone_Number`, `Email`, `ID_Role`) VALUES (16, 'Amer', 'Al-Barkawi', NULL, NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Account`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (1, 'miCKe', '1234', 1);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (2, 'MATUMBAMAN', '1234', 2);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (3, 'Nikobaby', '1234', 3);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (4, 'flyfly', '1234', 4);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (5, 'Eurus', '1234', 5);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (6, 'Sccc', '1234', 6);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (7, 'Drew', '1234', 7);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (8, '23savage', '1234', 8);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (9, 'Gabbi', '1234', 9);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (10, 'epileptick1d', '1234', 10);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (11, 'Crystallize', '1234', 11);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (12, 'YawaR', '1234', 12);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (13, 'Arteezy', '1234', 13);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (14, 'hFn', '1234', 14);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (15, 'K1', '1234', 15);
INSERT INTO `mydb`.`Account` (`ID_Account`, `Login`, `Password`, `ID_User`) VALUES (16, 'Miracle-', '1234', 16);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Prize`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Prize` (`ID_Prize`, `Type`, `Amount`, `Places`, `Percent`) VALUES (1, '$', '1000000', '1 2 3 4 5-6 7-8 9-12 13-16 ', '30 16 11 8 6 4 2.5 1.25');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Address`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Address` (`ID_Address`, `Country`, `City`, `Street`, `Building`) VALUES (1, 'Germany', 'Leipzig', 'Messe-Allee', '1');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Event`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Event` (`ID_Event`, `Name`, `Tier`, `ID_Prize`, `ID_Adress`) VALUES (1, 'DreamLeague Season 13', 'Major', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Discipline`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Discipline` (`ID_Discipline`, `Name`) VALUES (1, 'DOTA 2');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Roster`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (1, 'Team Secret', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (2, 'Evil Geniuses', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (3, 'Vici Gaming', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (4, 'Alliance', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (5, 'Invictus Gaming', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (6, 'Team Liquid', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (7, 'beastcoast', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (8, 'TNC Predotor', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (9, 'Team Nigma', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (10, 'Team Aster', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (11, 'Fnatic', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (12, 'Natus Vincere', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (13, 'paiN Gaming', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (14, 'Chaos Esprots Club', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (15, 'Reality Rift', 5, 1);
INSERT INTO `mydb`.`Roster` (`ID_Roster`, `Name`, `Amount`, `ID_Discipline`) VALUES (16, 'Virtus.pro', 5, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Schedule`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (1, '21.01.2020', '12 30', 'Main Stage', 'Team Nigma / Evil Geniuses', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (2, '21.01.2020', '16 30', 'Main Stage', 'Invictus Gaming / Vici Gaming', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (3, '21.01.2020', '21 00', 'Main Stage', 'beastcoast / paiN Gaming', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (4, '21.01.2020', '22 00', 'Main Stage', 'Team Aster / Chaos Esports Club', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (5, '21.01.2020', '23 10', 'Main Stage', 'Reality Rift / TNC Predator', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (6, '22.01.2020', '00 20', 'Main Stage', 'Team Liquid  / Virtus.pro', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (7, '22.01.2020', '12 30', 'Main Stage', 'Team Secret / Fnatic', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (8, '22.01.2020', '17 00', 'Main Stage', 'Natus Vincere / Alliance', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (9, '22.01.2020', '20 00', 'Main Stage', 'Team Nigma / beastcoast', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (10, '22.01.2020', '23 30', 'Main Stage', 'Invictus Gaming / Team Aster', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (11, '23.01.2020', '12 30', 'Main Stage', 'Fnatic / TNC Predator', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (12, '23.01.2020', '16 00', 'Main Stage', 'Natus Vincere / Team Liquid', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (13, '23.01.2020', '19 15', 'Main Stage', 'Evil Geniuses / Vici Gaming', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (14, '23.01.2020', '22 00', 'Main Stage', 'Team Secret / Alliance', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (15, '24.01.2020', '12 30', 'Main Stage', 'beastcoast / Invictus Gaming', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (16, '24.01.2020', '15 30', 'Main Stage', 'TNC Predator / Team Liquid', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (17, '24.01.2020', '19 30', 'Main Stage', 'Evil Geniuses / Invictus Gaming', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (18, '25.01.2020', '12 30', 'Main Stage', 'Alliance / Team Liquid', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (19, '25.01.2020', '16 30', 'Main Stage', 'Vici Gaming / Team Secret', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (20, '25.01.2020', '19 30', 'Main Stage', 'Evil Geniuses / Alliance', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (21, '26.01.2020', '12 30', 'Main Stage', 'Vici Gaming / Evil Geniuses', 1);
INSERT INTO `mydb`.`Schedule` (`ID_Schedule`, `Date`, `Time`, `Place`, `Incident`, `ID_Event`) VALUES (22, '26.01.2020', '17 45', 'Main Stage', 'Team Secret / Evil Geniuses', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`User_has_Roster`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (1, 6);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (2, 1);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (3, 4);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (4, 5);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (5, 3);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (6, 10);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (7, 15);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (8, 11);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (9, 8);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (10, 16);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (11, 12);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (12, 14);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (13, 2);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (14, 13);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (15, 7);
INSERT INTO `mydb`.`User_has_Roster` (`User_ID_User`, `Roster_ID_Roster`) VALUES (16, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Roster_has_Event`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (1, 1, 1);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (2, 1, 2);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (3, 1, 3);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (4, 1, 4);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (5, 1, 5-6);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (6, 1, 5-6);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (7, 1, 7-8);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (8, 1, 7-8);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (9, 1, 9-12);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (10, 1, 9-12);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (11, 1, 9-12);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (12, 1, 9-12);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (13, 1, 13-16);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (14, 1, 13-16);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (15, 1, 13-16);
INSERT INTO `mydb`.`Roster_has_Event` (`Roster_ID_Roster`, `Event_ID_Event`, `Place`) VALUES (16, 1, 13-16);

COMMIT;

