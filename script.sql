CREATE DATABASE IF NOT EXISTS `test`;

USE `test`;

CREATE TABLE `tab` (
  `idtab` INT NOT NULL AUTO_INCREMENT,
  `tabcol` VARCHAR(45) NULL,
  PRIMARY KEY (`idtab`));

INSERT INTO `tab` (`tabcol`) VALUES ('test');
INSERT INTO `tab` (`tabcol`) VALUES ('new');