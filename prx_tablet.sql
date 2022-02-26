CREATE TABLE `prx_tab_lspd_notes` (
	`identifier` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`tipe` CHAR(50) NULL DEFAULT NULL,
	`officer` CHAR(100) NULL DEFAULT NULL,
	`note` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP()
);


CREATE TABLE `prx_tab_lspd_hist` (
	`identifier` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`content` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`fine` INT(50) NULL DEFAULT NULL,
	`date` TIMESTAMP NULL DEFAULT current_timestamp(),
	`time` INT(50) NULL DEFAULT NULL,
	`officer` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci'
);

CREATE TABLE `prx_tab_ems_hist` (
	`identifier` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`doctor` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`label` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`price` INT(11) NULL DEFAULT NULL,
	`date` TIMESTAMP NULL DEFAULT current_timestamp()
);

CREATE TABLE `prx_tab_ems_notes` (
	`identifier` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`sender` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`date` TIMESTAMP NULL DEFAULT current_timestamp(),
	`label` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci'
);


CREATE TABLE `prx_tab_meca_hist` (
	`identifier` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`doctor` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`label` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`price` INT(11) NULL DEFAULT NULL,
	`date` TIMESTAMP NULL DEFAULT current_timestamp()
);

CREATE TABLE `prx_tab_meca_notes` (
	`identifier` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`sender` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`date` TIMESTAMP NULL DEFAULT current_timestamp(),
	`label` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci'
);


ALTER TABLE `users`
	ADD COLUMN `foto` VARCHAR(10000) NULL DEFAULT NULL,
	CHANGE COLUMN `foto` `foto` LONGTEXT NULL DEFAULT 'https://us.123rf.com/450wm/thesomeday123/thesomeday1231712/thesomeday123171200008/91087328-icono-de-perfil-de-avatar-predeterminado-para-mujer-marcador-de-posición-de-foto-gris-vector-de-ilus.jpg?ver=6',
	ADD COLUMN `search` VARCHAR(255) NULL DEFAULT '{"inSearch":false,"motivo":""}' AFTER `foto`,
	ADD COLUMN `dangerous` VARCHAR(255) NULL DEFAULT '{"danger":false,"motivo":""}' AFTER `search`;




INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('tablet', 'Tablet', 1, 0, 1);