-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema extensao
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `extensao` ;

-- -----------------------------------------------------
-- Schema extensao
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `extensao` DEFAULT CHARACTER SET latin1 ;
USE `extensao` ;

-- -----------------------------------------------------
-- Table `extensao`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`curso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `ativo` BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `curso_i01` (`nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `extensao`.`situacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`situacao` (
  `id` SMALLINT NOT NULL,
  `descricao` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `extensao`.`tipo_acao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`tipo_acao` (
  `id` SMALLINT NOT NULL,
  `descricao` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `extensao`.`acao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`acao` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Atributo chave primáia da Tabela Ação, atributo gerado automaticamente pelo sistema.',
  `titulo` VARCHAR(100) NOT NULL,
  `situacao_id` SMALLINT NOT NULL,
  `tipo_acao_id` SMALLINT NOT NULL,
  `curso_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `acao_i01` (`curso_id` ASC),
  INDEX `acao_i02` (`situacao_id` ASC),
  INDEX `acao_i03` (`tipo_acao_id` ASC),
  UNIQUE INDEX `acao_i04` (`titulo` ASC),
  CONSTRAINT `fk_acao_curso_01`
    FOREIGN KEY (`curso_id`)
    REFERENCES `extensao`.`curso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_acao_situacao_01`
    FOREIGN KEY (`situacao_id`)
    REFERENCES `extensao`.`situacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_acao_tipo_acao_01`
    FOREIGN KEY (`tipo_acao_id`)
    REFERENCES `extensao`.`tipo_acao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `extensao`.`curso`
-- -----------------------------------------------------
START TRANSACTION;
USE `extensao`;
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (DEFAULT, 'Direito', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (DEFAULT, 'Letras', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (DEFAULT, 'Ciências Biologicas', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (DEFAULT, 'Engenharia Ambiental', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (DEFAULT, 'Jornalismo', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (DEFAULT, 'Administração', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (DEFAULT, 'Pedagocia', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (DEFAULT, 'Sistemas de Informação', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `extensao`.`situacao`
-- -----------------------------------------------------
START TRANSACTION;
USE `extensao`;
INSERT INTO `extensao`.`situacao` (`id`, `descricao`) VALUES (1, 'Rascunho');
INSERT INTO `extensao`.`situacao` (`id`, `descricao`) VALUES (3, 'Pendênte aprovação coordenação');
INSERT INTO `extensao`.`situacao` (`id`, `descricao`) VALUES (4, 'Pendênte aprovação extensão');
INSERT INTO `extensao`.`situacao` (`id`, `descricao`) VALUES (2, 'Cancelado');
INSERT INTO `extensao`.`situacao` (`id`, `descricao`) VALUES (5, 'Em andamento');
INSERT INTO `extensao`.`situacao` (`id`, `descricao`) VALUES (6, 'Concluido');

COMMIT;


-- -----------------------------------------------------
-- Data for table `extensao`.`tipo_acao`
-- -----------------------------------------------------
START TRANSACTION;
USE `extensao`;
INSERT INTO `extensao`.`tipo_acao` (`id`, `descricao`) VALUES (2, 'Projeto');
INSERT INTO `extensao`.`tipo_acao` (`id`, `descricao`) VALUES (1, 'Programa');
INSERT INTO `extensao`.`tipo_acao` (`id`, `descricao`) VALUES (3, 'Curso');
INSERT INTO `extensao`.`tipo_acao` (`id`, `descricao`) VALUES (4, 'Evento');
INSERT INTO `extensao`.`tipo_acao` (`id`, `descricao`) VALUES (5, 'Prestação de Serviço');

COMMIT;

