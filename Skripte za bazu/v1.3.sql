-- MySQL Script generated by MySQL Workbench
-- Tue Apr 23 11:51:43 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sql11699822
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sql11699822
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sql11699822` DEFAULT CHARACTER SET utf8 ;
USE `sql11699822` ;

-- -----------------------------------------------------
-- Table `sql11699822`.`Period`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql11699822`.`Period` (
  `idPERIOD` INT NOT NULL AUTO_INCREMENT,
  `Naziv` VARCHAR(45) NULL,
  `Pocetak_perioda` INT NULL,
  `Kraj_perioda` INT NULL,
  `TXT0` TEXT(3000) NULL,
  `TXT1` TEXT(5000) NULL,
  `TXT2` TEXT(8000) NULL,
  PRIMARY KEY (`idPERIOD`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql11699822`.`Licnost`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql11699822`.`Licnost` (
  `idLicnost` INT NOT NULL AUTO_INCREMENT,
  `Ime` VARCHAR(45) NULL,
  `Prezime` VARCHAR(45) NULL,
  `Mesto_rodjenja` VARCHAR(45) NULL,
  `Godina_rodjenja` VARCHAR(45) NULL,
  `Godina_smrti` VARCHAR(45) NULL,
  `Period_idPERIOD` INT NOT NULL,
  PRIMARY KEY (`idLicnost`),
  INDEX `fk_Licnost_Period_idx` (`Period_idPERIOD` ASC) ,
  CONSTRAINT `fk_Licnost_Period`
    FOREIGN KEY (`Period_idPERIOD`)
    REFERENCES `sql11699822`.`Period` (`idPERIOD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql11699822`.`Umetnost`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql11699822`.`Umetnost` (
  `idUmetnost` INT NOT NULL AUTO_INCREMENT,
  `Naziv` VARCHAR(45) NULL,
  `Opis` VARCHAR(45) NULL,
  PRIMARY KEY (`idUmetnost`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql11699822`.`Muzej`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql11699822`.`Muzej` (
  `idPERIOD` INT NOT NULL AUTO_INCREMENT,
  `Naziv` VARCHAR(45) NULL,
  `TXT0` TEXT(3000) NULL,
  `TXT1` TEXT(5000) NULL,
  `TXT2` TEXT(8000) NULL,
  `Koordinate` VARCHAR(45) NULL,
  `Adresa` VARCHAR(45) NULL,
  `Maps_link` VARCHAR(45) NULL,
  `Maps_deo_za_link` VARCHAR(45) NULL,
  `Kratak_opis` VARCHAR(200) NULL,
  PRIMARY KEY (`idPERIOD`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql11699822`.`Delo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql11699822`.`Delo` (
  `idPERIOD` INT NOT NULL AUTO_INCREMENT,
  `Naziv` VARCHAR(45) NULL,
  `TXT0` TEXT(3000) NULL,
  `TXT1` TEXT(5000) NULL,
  `TXT2` TEXT(8000) NULL,
  `Godina_nastanka` VARCHAR(45) NULL,
  `Period_idPERIOD` INT NOT NULL,
  `Licnost_idLicnost` INT NOT NULL,
  `Kratki_opis` VARCHAR(200) NULL,
  PRIMARY KEY (`idPERIOD`),
  INDEX `fk_Delo_Period1_idx` (`Period_idPERIOD` ASC) ,
  INDEX `fk_Delo_Licnost1_idx` (`Licnost_idLicnost` ASC) ,
  CONSTRAINT `fk_Delo_Period1`
    FOREIGN KEY (`Period_idPERIOD`)
    REFERENCES `sql11699822`.`Period` (`idPERIOD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Delo_Licnost1`
    FOREIGN KEY (`Licnost_idLicnost`)
    REFERENCES `sql11699822`.`Licnost` (`idLicnost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql11699822`.`Korisnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql11699822`.`Korisnik` (
  `idKorisnik` INT NOT NULL AUTO_INCREMENT,
  `Ime` VARCHAR(45) NOT NULL,
  `Prezime` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Salt` VARCHAR(45) NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Preference` VARCHAR(255) NULL,
  PRIMARY KEY (`idKorisnik`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql11699822`.`Ruta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql11699822`.`Ruta` (
  `idRuta` INT NOT NULL AUTO_INCREMENT,
  `Ime_Rute` VARCHAR(45) NULL,
  `Opis` VARCHAR(45) NULL,
  `Stanice` TEXT(1500) NULL,
  `Korisnik_idKorisnik` INT NOT NULL,
  PRIMARY KEY (`idRuta`),
  INDEX `fk_Ruta_Korisnik1_idx` (`Korisnik_idKorisnik` ASC) ,
  CONSTRAINT `fk_Ruta_Korisnik1`
    FOREIGN KEY (`Korisnik_idKorisnik`)
    REFERENCES `sql11699822`.`Korisnik` (`idKorisnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql11699822`.`Muzej_has_Period`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql11699822`.`Muzej_has_Period` (
  `Muzej_idPERIOD` INT NOT NULL,
  `Period_idPERIOD` INT NOT NULL,
  PRIMARY KEY (`Muzej_idPERIOD`, `Period_idPERIOD`),
  INDEX `fk_Muzej_has_Period_Period1_idx` (`Period_idPERIOD` ASC) ,
  INDEX `fk_Muzej_has_Period_Muzej1_idx` (`Muzej_idPERIOD` ASC) ,
  CONSTRAINT `fk_Muzej_has_Period_Muzej1`
    FOREIGN KEY (`Muzej_idPERIOD`)
    REFERENCES `sql11699822`.`Muzej` (`idPERIOD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Muzej_has_Period_Period1`
    FOREIGN KEY (`Period_idPERIOD`)
    REFERENCES `sql11699822`.`Period` (`idPERIOD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql11699822`.`Licnost_did_Umetnost`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql11699822`.`Licnost_did_Umetnost` (
  `Licnost_idLicnost` INT NOT NULL,
  `Umetnost_idUmetnost` INT NOT NULL,
  PRIMARY KEY (`Licnost_idLicnost`, `Umetnost_idUmetnost`),
  INDEX `fk_Licnost_has_Umetnost_Umetnost1_idx` (`Umetnost_idUmetnost` ASC) ,
  INDEX `fk_Licnost_has_Umetnost_Licnost1_idx` (`Licnost_idLicnost` ASC) ,
  CONSTRAINT `fk_Licnost_has_Umetnost_Licnost1`
    FOREIGN KEY (`Licnost_idLicnost`)
    REFERENCES `sql11699822`.`Licnost` (`idLicnost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Licnost_has_Umetnost_Umetnost1`
    FOREIGN KEY (`Umetnost_idUmetnost`)
    REFERENCES `sql11699822`.`Umetnost` (`idUmetnost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql11699822`.`Ruta_has_Muzej`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql11699822`.`Ruta_has_Muzej` (
  `Ruta_idRuta` INT NOT NULL,
  `Muzej_idPERIOD` INT NOT NULL,
  PRIMARY KEY (`Ruta_idRuta`, `Muzej_idPERIOD`),
  INDEX `fk_Ruta_has_Muzej_Muzej1_idx` (`Muzej_idPERIOD` ASC) ,
  INDEX `fk_Ruta_has_Muzej_Ruta1_idx` (`Ruta_idRuta` ASC) ,
  CONSTRAINT `fk_Ruta_has_Muzej_Ruta1`
    FOREIGN KEY (`Ruta_idRuta`)
    REFERENCES `sql11699822`.`Ruta` (`idRuta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ruta_has_Muzej_Muzej1`
    FOREIGN KEY (`Muzej_idPERIOD`)
    REFERENCES `sql11699822`.`Muzej` (`idPERIOD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sql11699822`.`Korisnik_has_Ruta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql11699822`.`Korisnik_has_Ruta` (
  `Korisnik_idKorisnik` INT NOT NULL,
  `Ruta_idRuta` INT NOT NULL,
  PRIMARY KEY (`Korisnik_idKorisnik`, `Ruta_idRuta`),
  INDEX `fk_Korisnik_has_Ruta_Ruta1_idx` (`Ruta_idRuta` ASC) ,
  INDEX `fk_Korisnik_has_Ruta_Korisnik1_idx` (`Korisnik_idKorisnik` ASC) ,
  CONSTRAINT `fk_Korisnik_has_Ruta_Korisnik1`
    FOREIGN KEY (`Korisnik_idKorisnik`)
    REFERENCES `sql11699822`.`Korisnik` (`idKorisnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Korisnik_has_Ruta_Ruta1`
    FOREIGN KEY (`Ruta_idRuta`)
    REFERENCES `sql11699822`.`Ruta` (`idRuta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
