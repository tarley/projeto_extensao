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
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Atributo chave primária da Tabela Ação, atributo gerado automaticamente pelo sistema.',
  `titulo` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  `objetivo` LONGTEXT NOT NULL,
  `publico_alvo` LONGTEXT NOT NULL,
  `local` VARCHAR(200) NOT NULL,
  `dt_inicio` DATETIME NOT NULL,
  `dt_termino` DATETIME NULL,
  `dt_registro` DATETIME NOT NULL,
  `tipo_acao_id` SMALLINT NOT NULL,
  `situacao_id` SMALLINT NOT NULL,
  `curso_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `acao_i01` (`curso_id` ASC),
  INDEX `acao_i02` (`situacao_id` ASC),
  INDEX `acao_i03` (`tipo_acao_id` ASC),
  UNIQUE INDEX `acao_i04` (`titulo` ASC),
  INDEX `acao_i05` (`descricao` ASC),
  INDEX `acao_i06` (`dt_inicio` ASC),
  INDEX `acao_i07` (`dt_termino` ASC),
  INDEX `acao_i08` (`dt_registro` ASC),
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


-- -----------------------------------------------------
-- Table `extensao`.`tipo_conceito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`tipo_conceito` (
  `id` INT NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tipo_conceito_i01` (`descricao` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `extensao`.`conceito_extensao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`conceito_extensao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `ativo` BIT NOT NULL DEFAULT 1,
  `tipo_conceito_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `conceito_extensao_i01` (`nome` ASC),
  INDEX `conceito_extensao_i02` (`tipo_conceito_id` ASC),
  CONSTRAINT `fk_conceito_extensao_tipo_conceito_01`
    FOREIGN KEY (`tipo_conceito_id`)
    REFERENCES `extensao`.`tipo_conceito` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `extensao`.`conceito_extensao_acao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`conceito_extensao_acao` (
  `conceito_extensao_id` INT NOT NULL,
  `acao_id` INT NOT NULL,
  PRIMARY KEY (`conceito_extensao_id`, `acao_id`),
  INDEX `conceito_extensao_acao_i01` (`acao_id` ASC),
  INDEX `conceito_extensao_acao_i02` (`conceito_extensao_id` ASC),
  CONSTRAINT `fk_acao_conceito_extensao_01`
    FOREIGN KEY (`conceito_extensao_id`)
    REFERENCES `extensao`.`conceito_extensao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conceito_extensao_acao_01`
    FOREIGN KEY (`acao_id`)
    REFERENCES `extensao`.`acao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `extensao`.`palavra_chave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`palavra_chave` (
  `acao_id` INT NOT NULL,
  `palavra` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`acao_id`, `palavra`),
  INDEX `palavra_chave_i01` (`acao_id` ASC),
  INDEX `palavra_chave_i02` (`palavra` ASC),
  CONSTRAINT `fk_palavra_chave_acao_01`
    FOREIGN KEY (`acao_id`)
    REFERENCES `extensao`.`acao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `extensao`.`atividade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`atividade` (
  `acao_id` INT NOT NULL,
  `nome` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`acao_id`, `nome`),
  INDEX `atividade_acao_i01` (`acao_id` ASC),
  INDEX `atividade_acao_i02` (`nome` ASC),
  CONSTRAINT `fk_atividade_acao_01`
    FOREIGN KEY (`acao_id`)
    REFERENCES `extensao`.`acao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `extensao`.`curso_envolvido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`curso_envolvido` (
  `acao_id` INT NOT NULL,
  `curso_id` INT NOT NULL,
  PRIMARY KEY (`acao_id`, `curso_id`),
  INDEX `curso_envolvido_i01` (`curso_id` ASC),
  INDEX `curso_envolvido_i02` (`acao_id` ASC),
  CONSTRAINT `fk_curso_envolvido_acao_01`
    FOREIGN KEY (`acao_id`)
    REFERENCES `extensao`.`acao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_envolvido_curso_01`
    FOREIGN KEY (`curso_id`)
    REFERENCES `extensao`.`curso` (`id`)
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
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (DEFAULT, 'Datilografia', DEFAULT);

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


-- -----------------------------------------------------
-- Data for table `extensao`.`tipo_conceito`
-- -----------------------------------------------------
START TRANSACTION;
USE `extensao`;
INSERT INTO `extensao`.`tipo_conceito` (`id`, `descricao`) VALUES (1, 'ÁREA TEMÁTICA INTEGRADORA');
INSERT INTO `extensao`.`tipo_conceito` (`id`, `descricao`) VALUES (2, 'OBJETIVOS DE DESENVOLVIMENTO SUSTENTÁVEL DA ONU');
INSERT INTO `extensao`.`tipo_conceito` (`id`, `descricao`) VALUES (3, 'DESAFIOS DO PLANEJAMENTO ESTRATÉGICO DE BH 2030');

COMMIT;


-- -----------------------------------------------------
-- Data for table `extensao`.`conceito_extensao`
-- -----------------------------------------------------
START TRANSACTION;
USE `extensao`;
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (1, 'Saúde e Qualidade de Vida', 1, 1);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (2, 'Arte, Cultura e Educação', 1, 1);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (3, 'Meio Ambiente', 1, 1);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (4, 'Direitos Humanos e Inclusão Social', 1, 1);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (5, 'Industria e Negócios', 1, 1);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (6, 'Urbanização', 1, 1);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (7, 'Tecnologia da Informação e Comunicação', 1, 1);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Erradicação da Pobreza', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Fome Zero e Agricultura Sustentável', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Saúde e Bem-Estar', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Educação de Qualidade', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Igualdade de Gênero', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Água Potável e Saneamento', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Energia Acessível e Limpa', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Trabalho Descente e Crescimento Econômico', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Industria, Inovação e Infraestrutura', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Redução das Desigualdades', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Cidades e Comunidades Sustentáveis', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Consumo e Produção Sustentável', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Ação Contra a Mudança Global do Clima', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Vida na Água', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Vida Terrestre', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Paz, Justiça e Instituições Eficazes', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Parcerias e Meios de Implementação', 1, 2);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Belo Horizonte como município de muito alto desenvolvimento humano.', 1, 3);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Cidade sem miséria, inclusiva e com moradia digna para todos.', 1, 3);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Cidade resiliente e ambientalmente sustentável.', 1, 3);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Cidade compacta, integrada, inclusiva e conectada com mobilidade sustentável.', 1, 3);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Cidade em que se vive mais, com saúde, segurança e educação de qualidade.', 1, 3);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Belo Horizonte com gestão transparente, compartilhada e de excelência.', 1, 3);
INSERT INTO `extensao`.`conceito_extensao` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (DEFAULT, 'Economia municipal em contínuo crescimento sustentável.', 1, 3);

COMMIT;

