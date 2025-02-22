-- MySQL Script generated by MySQL Workbench
-- Fri Jul 17 10:13:55 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cul_ampolla
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cul_ampolla` ;

-- -----------------------------------------------------
-- Schema cul_ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cul_ampolla` DEFAULT CHARACTER SET utf8 ;
USE `cul_ampolla` ;

-- -----------------------------------------------------
-- Table `cul_ampolla`.`TAULA_EMPLEAT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`TAULA_EMPLEAT` (
  `id_empleat` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `cognom` VARCHAR(45) NULL,
  PRIMARY KEY (`id_empleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`TAULA_CLIENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`TAULA_CLIENTS` (
  `id_client` INT NOT NULL,
  `nom` VARCHAR(150) NULL,
  `codi_postal` VARCHAR(20) NULL,
  `telefon` VARCHAR(40) NULL,
  `email` VARCHAR(100) NULL,
  `data_registre` DATE NULL,
  PRIMARY KEY (`id_client`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`TAULA_PROVEIDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`TAULA_PROVEIDOR` (
  `id_proveidor` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `NIF` VARCHAR(45) NULL,
  `carrer` VARCHAR(45) NULL,
  `numero` INT NULL,
  `pis` INT NULL,
  `porta` VARCHAR(10) NULL,
  `ciutat` VARCHAR(45) NULL,
  `codi_postal` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE,
  PRIMARY KEY (`id_proveidor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`TAULA_MARCA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`TAULA_MARCA` (
  `id_marca` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `proveidor_id` INT NULL,
  PRIMARY KEY (`id_marca`),
  INDEX `proveidor_id_idx` (`proveidor_id` ASC) VISIBLE,
  CONSTRAINT `proveidor_id`
    FOREIGN KEY (`proveidor_id`)
    REFERENCES `cul_ampolla`.`TAULA_PROVEIDOR` (`id_proveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`TAULA_TIPUS_MONTURA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`TAULA_TIPUS_MONTURA` (
  `id_tipus_montura` INT NOT NULL,
  `tipus` VARCHAR(45) NULL,
  PRIMARY KEY (`id_tipus_montura`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`TAULA_TIPUS_ULLERES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`TAULA_TIPUS_ULLERES` (
  `id_tipus_ulleres` INT NOT NULL,
  `model` VARCHAR(45) NULL,
  `marca_id` INT NULL,
  `tipus_montura_id` INT NULL,
  `color` VARCHAR(45) NULL,
  `preu` INT NULL,
  PRIMARY KEY (`id_tipus_ulleres`),
  INDEX `marca_id_idx` (`marca_id` ASC) VISIBLE,
  INDEX `tipus_montura_id_idx` (`tipus_montura_id` ASC) VISIBLE,
  CONSTRAINT `marca_id`
    FOREIGN KEY (`marca_id`)
    REFERENCES `cul_ampolla`.`TAULA_MARCA` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tipus_montura_id`
    FOREIGN KEY (`tipus_montura_id`)
    REFERENCES `cul_ampolla`.`TAULA_TIPUS_MONTURA` (`id_tipus_montura`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`TAULA_VENUDES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`TAULA_VENUDES` (
  `id_venudes` INT NOT NULL,
  `tipus_ulleres_id` INT NULL,
  `grad_vidre_esq` FLOAT(4) NULL,
  `grad_vidre_dret` FLOAT(4) NULL,
  `color_vidre_esq` VARCHAR(45) NULL DEFAULT 'Transparent',
  `color_vidre_dret` VARCHAR(45) NULL DEFAULT 'Transparent',
  `data_venda` DATE NULL,
  `empleat_id` INT NULL,
  `client_id` INT NULL,
  PRIMARY KEY (`id_venudes`),
  INDEX `empleat_id_idx` (`empleat_id` ASC) VISIBLE,
  INDEX `client_id_idx` (`client_id` ASC) VISIBLE,
  INDEX `tipus_ulleres_id_idx` (`tipus_ulleres_id` ASC) VISIBLE,
  CONSTRAINT `empleat_id`
    FOREIGN KEY (`empleat_id`)
    REFERENCES `cul_ampolla`.`TAULA_EMPLEAT` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `cul_ampolla`.`TAULA_CLIENTS` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tipus_ulleres_id`
    FOREIGN KEY (`tipus_ulleres_id`)
    REFERENCES `cul_ampolla`.`TAULA_TIPUS_ULLERES` (`id_tipus_ulleres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CHECKSUM = 1;


-- -----------------------------------------------------
-- Table `cul_ampolla`.`TAULA_RECOMANATS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_ampolla`.`TAULA_RECOMANATS` (
  `id_client` INT NOT NULL,
  `id_recomenat` INT NOT NULL,
  INDEX `id_recomentat_idx` (`id_recomenat` ASC) VISIBLE,
  PRIMARY KEY (`id_recomenat`, `id_client`),
  CONSTRAINT `FK_RECOMANAT_CLIENT`
    FOREIGN KEY (`id_client`)
    REFERENCES `cul_ampolla`.`TAULA_CLIENTS` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RECOMANAT_RECOMENAT`
    FOREIGN KEY (`id_recomenat`)
    REFERENCES `cul_ampolla`.`TAULA_CLIENTS` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
