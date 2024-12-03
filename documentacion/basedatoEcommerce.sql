-- MySQL Script generated by MySQL Workbench
-- Sat May  6 20:08:27 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bd_automotor
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bd_automotor` ;

-- -----------------------------------------------------
-- Schema bd_automotor
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_automotor` DEFAULT CHARACTER SET utf8 ;
USE `bd_automotor` ;

-- -----------------------------------------------------
-- Table `bd_automotor`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_automotor`.`administrador` (
  `idAdministrador` INT NOT NULL,
  PRIMARY KEY (`idAdministrador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_automotor`.`usuarioRol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_automotor`.`usuarioRol` (
  `idUsuarioRol` INT NOT NULL,
  `tipoUsuario` VARCHAR(45) NOT NULL,
  `administrador_idadministrador` INT NOT NULL,
  PRIMARY KEY (`idUsuarioRol`, `administrador_idadministrador`),
  CONSTRAINT `fk_usuarioRol_administrador1`
    FOREIGN KEY (`administrador_idadministrador`)
    REFERENCES `bd_automotor`.`administrador` (`idAdministrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_usuarioRol_administrador1_idx` ON `bd_automotor`.`usuarioRol` (`administrador_idadministrador` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `bd_automotor`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_automotor`.`cliente` (
  `idDni` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `tel` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `usuarioRol_idUsuarioRol` INT NOT NULL,
  PRIMARY KEY (`idDni`, `usuarioRol_idUsuarioRol`),
  CONSTRAINT `fk_cliente_usuarioRol1`
    FOREIGN KEY (`usuarioRol_idUsuarioRol`)
    REFERENCES `bd_automotor`.`usuarioRol` (`idUsuarioRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_cliente_usuarioRol1_idx` ON `bd_automotor`.`cliente` (`usuarioRol_idUsuarioRol` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `bd_automotor`.`vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_automotor`.`vehiculo` (
  `idVehiculo` INT NOT NULL,
  `tipoVehiculo` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `añoFabricacion` VARCHAR(45) NOT NULL,
  `cliente_idDni` INT NOT NULL,
  PRIMARY KEY (`idVehiculo`, `cliente_idDni`),
  CONSTRAINT `fk_vehiculo_cliente1`
    FOREIGN KEY (`cliente_idDni`)
    REFERENCES `bd_automotor`.`cliente` (`idDni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';

CREATE INDEX `fk_vehiculo_cliente1_idx` ON `bd_automotor`.`vehiculo` (`cliente_idDni` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `bd_automotor`.`orden`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_automotor`.`orden` (
  `idOrden` INT NOT NULL,
  `fechaOrden` DATE NOT NULL,
  `estadoOrden` VARCHAR(45) NOT NULL,
  `fechaEntrega` VARCHAR(45) NOT NULL,
  `cliente_idDni` INT NOT NULL,
  `cliente_usuarioRol_idUsuarioRol` INT NOT NULL,
  PRIMARY KEY (`idOrden`, `cliente_idDni`, `cliente_usuarioRol_idUsuarioRol`),
  CONSTRAINT `fk_orden_cliente1`
    FOREIGN KEY (`cliente_idDni` , `cliente_usuarioRol_idUsuarioRol`)
    REFERENCES `bd_automotor`.`cliente` (`idDni` , `usuarioRol_idUsuarioRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_orden_cliente1_idx` ON `bd_automotor`.`orden` (`cliente_idDni` ASC, `cliente_usuarioRol_idUsuarioRol` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `bd_automotor`.`categoriaProducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_automotor`.`categoriaProducto` (
  `idCategoriaProducto` INT NOT NULL,
  `tipoCategoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoriaProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_automotor`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_automotor`.`producto` (
  `idProducto` INT NOT NULL,
  `nombreProducto` VARCHAR(45) NOT NULL,
  `cantidadProducto` INT(11) NOT NULL,
  `precioProducto` DOUBLE NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `imgProducto` VARCHAR(45) NULL,
  `categoriaProducto_idCategoriaProducto` INT NOT NULL,
  `orden_idOrden` INT NOT NULL,
  `orden_cliente_idDni` INT NOT NULL,
  `orden_cliente_usuarioRol_idUsuarioRol` INT NOT NULL,
  PRIMARY KEY (`idProducto`, `categoriaProducto_idCategoriaProducto`, `orden_idOrden`, `orden_cliente_idDni`, `orden_cliente_usuarioRol_idUsuarioRol`),
  CONSTRAINT `fk_productoServicio_categoriaProducto1`
    FOREIGN KEY (`categoriaProducto_idCategoriaProducto`)
    REFERENCES `bd_automotor`.`categoriaProducto` (`idCategoriaProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productoServicio_orden1`
    FOREIGN KEY (`orden_idOrden` , `orden_cliente_idDni` , `orden_cliente_usuarioRol_idUsuarioRol`)
    REFERENCES `bd_automotor`.`orden` (`idOrden` , `cliente_idDni` , `cliente_usuarioRol_idUsuarioRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_productoServicio_categoriaProducto1_idx` ON `bd_automotor`.`producto` (`categoriaProducto_idCategoriaProducto` ASC) VISIBLE;

CREATE INDEX `fk_productoServicio_orden1_idx` ON `bd_automotor`.`producto` (`orden_idOrden` ASC, `orden_cliente_idDni` ASC, `orden_cliente_usuarioRol_idUsuarioRol` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `bd_automotor`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_automotor`.`reserva` (
  `idReserva` INT NOT NULL,
  PRIMARY KEY (`idReserva`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_automotor`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_automotor`.`sucursal` (
  `id_sucursal` INT NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `tel` INT(11) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `cuit` INT(11) NOT NULL,
  PRIMARY KEY (`id_sucursal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_automotor`.`pagoProducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_automotor`.`pagoProducto` (
  `idPago` INT NOT NULL,
  `numeroFactura` INT(11) NOT NULL,
  `fechaPago` DATE NOT NULL,
  `totalPagar` DOUBLE NOT NULL,
  `tipoPago` VARCHAR(45) NOT NULL,
  `estadoPago` TINYINT NOT NULL,
  `sucursal_id_sucursal` INT NOT NULL,
  `cliente_idDni` INT NOT NULL,
  `cliente_usuarioRol_idUsuarioRol` INT NOT NULL,
  PRIMARY KEY (`idPago`, `sucursal_id_sucursal`, `cliente_idDni`, `cliente_usuarioRol_idUsuarioRol`),
  CONSTRAINT `fk_pagoProducto_sucursal1`
    FOREIGN KEY (`sucursal_id_sucursal`)
    REFERENCES `bd_automotor`.`sucursal` (`id_sucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagoProducto_cliente1`
    FOREIGN KEY (`cliente_idDni` , `cliente_usuarioRol_idUsuarioRol`)
    REFERENCES `bd_automotor`.`cliente` (`idDni` , `usuarioRol_idUsuarioRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pagoProducto_sucursal1_idx` ON `bd_automotor`.`pagoProducto` (`sucursal_id_sucursal` ASC) VISIBLE;

CREATE INDEX `fk_pagoProducto_cliente1_idx` ON `bd_automotor`.`pagoProducto` (`cliente_idDni` ASC, `cliente_usuarioRol_idUsuarioRol` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `bd_automotor`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_automotor`.`empleado` (
  `idEmpleado` INT NOT NULL,
  `cargo` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `sucursal_id_sucursal` INT NOT NULL,
  `usuarioRol_idUsuarioRol` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`, `sucursal_id_sucursal`, `usuarioRol_idUsuarioRol`),
  CONSTRAINT `fk_empleado_sucursal1`
    FOREIGN KEY (`sucursal_id_sucursal`)
    REFERENCES `bd_automotor`.`sucursal` (`id_sucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_usuarioRol1`
    FOREIGN KEY (`usuarioRol_idUsuarioRol`)
    REFERENCES `bd_automotor`.`usuarioRol` (`idUsuarioRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_empleado_sucursal1_idx` ON `bd_automotor`.`empleado` (`sucursal_id_sucursal` ASC) VISIBLE;

CREATE INDEX `fk_empleado_usuarioRol1_idx` ON `bd_automotor`.`empleado` (`usuarioRol_idUsuarioRol` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `bd_automotor`.`servicios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_automotor`.`servicios` (
  `idservicios` INT NOT NULL,
  `tipoServicio` VARCHAR(45) NOT NULL,
  `cliente_idDni` INT NOT NULL,
  `cliente_usuarioRol_idUsuarioRol` INT NOT NULL,
  `reserva_idReserva` INT NOT NULL,
  PRIMARY KEY (`idservicios`, `cliente_idDni`, `cliente_usuarioRol_idUsuarioRol`, `reserva_idReserva`),
  CONSTRAINT `fk_servicios_cliente1`
    FOREIGN KEY (`cliente_idDni` , `cliente_usuarioRol_idUsuarioRol`)
    REFERENCES `bd_automotor`.`cliente` (`idDni` , `usuarioRol_idUsuarioRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicios_reserva1`
    FOREIGN KEY (`reserva_idReserva`)
    REFERENCES `bd_automotor`.`reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_servicios_cliente1_idx` ON `bd_automotor`.`servicios` (`cliente_idDni` ASC, `cliente_usuarioRol_idUsuarioRol` ASC) VISIBLE;

CREATE INDEX `fk_servicios_reserva1_idx` ON `bd_automotor`.`servicios` (`reserva_idReserva` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
