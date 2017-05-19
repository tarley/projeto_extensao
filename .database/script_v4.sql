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
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `extensao`.`situacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`situacao` (
  `id` SMALLINT NOT NULL,
  `descricao` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7;


-- -----------------------------------------------------
-- Table `extensao`.`tipo_acao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`tipo_acao` (
  `id` SMALLINT NOT NULL,
  `descricao` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6;


-- -----------------------------------------------------
-- Table `extensao`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `senha` VARCHAR(20) NOT NULL,
  `idc_tipo_usuario` SMALLINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `usuario_i01` (`email` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 4
ROW_FORMAT = DEFAULT;


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
  `professor_id` INT NULL,
  `coordenador_id` INT NULL,
  `extensao_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `acao_i01` (`curso_id` ASC),
  INDEX `acao_i02` (`situacao_id` ASC),
  INDEX `acao_i03` (`tipo_acao_id` ASC),
  UNIQUE INDEX `acao_i04` (`titulo` ASC),
  INDEX `acao_i05` (`descricao` ASC),
  INDEX `acao_i06` (`dt_inicio` ASC),
  INDEX `acao_i07` (`dt_termino` ASC),
  INDEX `acao_i08` (`dt_registro` ASC),
  INDEX `fk_acao_usuario1_idx` (`professor_id` ASC),
  INDEX `fk_acao_usuario2_idx` (`coordenador_id` ASC),
  INDEX `fk_acao_usuario3_idx` (`extensao_id` ASC),
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
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_acao_usuario1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `extensao`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_acao_usuario2`
    FOREIGN KEY (`coordenador_id`)
    REFERENCES `extensao`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_acao_usuario3`
    FOREIGN KEY (`extensao_id`)
    REFERENCES `extensao`.`usuario` (`id`)
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
ENGINE = InnoDB
AUTO_INCREMENT = 4;


-- -----------------------------------------------------
-- Table `extensao`.`conceito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`conceito` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `ativo` BIT NOT NULL DEFAULT 1,
  `tipo_conceito_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `conceito_i01` (`nome` ASC),
  INDEX `conceito_i02` (`tipo_conceito_id` ASC),
  CONSTRAINT `fk_conceito_tipo_conceito_01`
    FOREIGN KEY (`tipo_conceito_id`)
    REFERENCES `extensao`.`tipo_conceito` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 32;


-- -----------------------------------------------------
-- Table `extensao`.`conceito_acao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`conceito_acao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `conceito_id` INT NOT NULL,
  `acao_id` INT NOT NULL,
  INDEX `conceito_acao_i01` (`acao_id` ASC),
  INDEX `conceito_acao_i02` (`conceito_id` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `conceito_acao_i03` (`conceito_id` ASC, `acao_id` ASC),
  CONSTRAINT `fk_conceito_acao_conceito_01`
    FOREIGN KEY (`conceito_id`)
    REFERENCES `extensao`.`conceito` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conceito_acao_acao_01`
    FOREIGN KEY (`acao_id`)
    REFERENCES `extensao`.`acao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `extensao`.`palavrachave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`palavrachave` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `acao_id` INT NOT NULL,
  `palavra` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `palavrachave_i01` (`acao_id` ASC),
  INDEX `palavrachave_i02` (`palavra` ASC),
  CONSTRAINT `fk_palavrachave_acao_01`
    FOREIGN KEY (`acao_id`)
    REFERENCES `extensao`.`acao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `extensao`.`atividade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`atividade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `acao_id` INT NOT NULL,
  `nome` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `atividade_i01` (`acao_id` ASC),
  INDEX `atividade_i02` (`nome` ASC),
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


-- -----------------------------------------------------
-- Table `extensao`.`acao_vinculada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`acao_vinculada` (
  `acao_id` INT NOT NULL,
  `acao_vinculada_id` INT NOT NULL,
  PRIMARY KEY (`acao_id`, `acao_vinculada_id`),
  INDEX `acao_vinculada_i01` (`acao_vinculada_id` ASC),
  INDEX `acao_vinculada_i02` (`acao_id` ASC),
  CONSTRAINT `fk_acao_vinculada_01`
    FOREIGN KEY (`acao_id`)
    REFERENCES `extensao`.`acao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_acao_vinculada_02`
    FOREIGN KEY (`acao_vinculada_id`)
    REFERENCES `extensao`.`acao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `extensao`.`curso_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `extensao`.`curso_usuario` (
  `curso_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`curso_id`, `usuario_id`),
  INDEX `fk_curso_has_usuario_usuario1_idx` (`usuario_id` ASC),
  INDEX `fk_curso_has_usuario_curso1_idx` (`curso_id` ASC),
  CONSTRAINT `fk_curso_has_usuario_curso1`
    FOREIGN KEY (`curso_id`)
    REFERENCES `extensao`.`curso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_has_usuario_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `extensao`.`usuario` (`id`)
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
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (1, 'Direito', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (2, 'Letras', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (3, 'Ciências Biologicas', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (4, 'Engenharia Ambiental', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (5, 'Jornalismo', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (6, 'Administração', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (7, 'Pedagocia', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (8, 'Sistemas de Informação', DEFAULT);
INSERT INTO `extensao`.`curso` (`id`, `nome`, `ativo`) VALUES (9, 'Datilografia', DEFAULT);

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
-- Data for table `extensao`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `extensao`;
INSERT INTO `extensao`.`usuario` (`id`, `nome`, `email`, `senha`, `idc_tipo_usuario`) VALUES (1, 'Leonardo Silva', 'extensao@email.com', '123', 3);
INSERT INTO `extensao`.`usuario` (`id`, `nome`, `email`, `senha`, `idc_tipo_usuario`) VALUES (2, 'Monica', 'coordenador@email.com', '123', 2);
INSERT INTO `extensao`.`usuario` (`id`, `nome`, `email`, `senha`, `idc_tipo_usuario`) VALUES (3, 'Tarley', 'professor@email.com', '123', 1);

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
-- Data for table `extensao`.`conceito`
-- -----------------------------------------------------
START TRANSACTION;
USE `extensao`;
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (1, 'Saúde e Qualidade de Vida', 1, 1);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (2, 'Arte, Cultura e Educação', 1, 1);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (3, 'Meio Ambiente', 1, 1);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (4, 'Direitos Humanos e Inclusão Social', 1, 1);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (5, 'Industria e Negócios', 1, 1);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (6, 'Urbanização', 1, 1);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (7, 'Tecnologia da Informação e Comunicação', 1, 1);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (8, 'Erradicação da Pobreza', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (9, 'Fome Zero e Agricultura Sustentável', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (10, 'Saúde e Bem-Estar', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (11, 'Educação de Qualidade', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (12, 'Igualdade de Gênero', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (13, 'Água Potável e Saneamento', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (14, 'Energia Acessível e Limpa', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (15, 'Trabalho Descente e Crescimento Econômico', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (16, 'Industria, Inovação e Infraestrutura', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (17, 'Redução das Desigualdades', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (18, 'Cidades e Comunidades Sustentáveis', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (19, 'Consumo e Produção Sustentável', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (20, 'Ação Contra a Mudança Global do Clima', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (21, 'Vida na Água', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (22, 'Vida Terrestre', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (23, 'Paz, Justiça e Instituições Eficazes', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (24, 'Parcerias e Meios de Implementação', 1, 2);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (25, 'Belo Horizonte como município de muito alto desenvolvimento humano.', 1, 3);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (26, 'Cidade sem miséria, inclusiva e com moradia digna para todos.', 1, 3);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (27, 'Cidade resiliente e ambientalmente sustentável.', 1, 3);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (28, 'Cidade compacta, integrada, inclusiva e conectada com mobilidade sustentável.', 1, 3);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (29, 'Cidade em que se vive mais, com saúde, segurança e educação de qualidade.', 1, 3);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (30, 'Belo Horizonte com gestão transparente, compartilhada e de excelência.', 1, 3);
INSERT INTO `extensao`.`conceito` (`id`, `nome`, `ativo`, `tipo_conceito_id`) VALUES (31, 'Economia municipal em contínuo crescimento sustentável.', 1, 3);

COMMIT;

