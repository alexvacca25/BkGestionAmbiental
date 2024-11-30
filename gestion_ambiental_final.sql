-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-11-2024 a las 02:38:09
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestion_ambiental`
--
CREATE DATABASE IF NOT EXISTS `gestion_ambiental` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `gestion_ambiental`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `Empresas_Reciclaje_Actualizar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Empresas_Reciclaje_Actualizar` (IN `p_id_erv` INT, IN `p_nombre` VARCHAR(100), IN `p_tipo` VARCHAR(50), IN `p_direccion` VARCHAR(50), IN `p_telefono` VARCHAR(100), IN `p_id_departamento` INT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE erv_existente INT;

    -- Verificar si ya existe un generador con el mismo nombre (excluyendo el generador a actualizar)
    SELECT COUNT(*) INTO erv_existente
    FROM gestion_ambiental.empresas_reciclaje_vertederos
    WHERE nombre = p_nombre AND id_empresa_vertedero <> p_id_erv;

    IF erv_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: El nombre del generador ya existe';
    ELSE
        -- Intentar actualizar el generador
        UPDATE gestion_ambiental.empresas_reciclaje_vertederos
        SET nombre = p_nombre,
            tipo = p_tipo,
            direccion = p_tipo,
            telefono = p_telefono,
            id_departamento = p_id_departamento
           
        WHERE id_empresa_vertedero = p_id_erv;

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Generador actualizado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al actualizar el generador o el generador no existe';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Empresas_Reciclaje_Crear`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Empresas_Reciclaje_Crear` (IN `p_nombre` VARCHAR(100), IN `p_tipo` VARCHAR(50), IN `p_direccion` VARCHAR(50), IN `p_telefono` VARCHAR(100), IN `p_id_departamento` INT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE erv_existente INT;

    -- Verificar si ya existe un generador con el mismo nombre
    SELECT COUNT(*) INTO erv_existente
    FROM gestion_ambiental.empresas_reciclaje_vertederos
    WHERE nombre = p_nombre;

    IF erv_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: El nombre del generador ya existe';
    ELSE
        -- Intentar insertar el nuevo generador
        INSERT INTO gestion_ambiental.empresas_reciclaje_vertederos (nombre, tipo, direccion, telefono, id_departamento)
        VALUES (p_nombre, p_tipo, p_direccion, p_telefono, p_id_departamento);

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Generador añadido correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al añadir el generador';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Empresas_Reciclaje_Eliminar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Empresas_Reciclaje_Eliminar` (IN `p_id_erv` INT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);

    -- Comprobar si el generador existe
    IF EXISTS (SELECT 1 FROM gestion_ambiental.empresas_reciclaje_vertederos WHERE id_empresa_vertedero = p_id_erv) THEN
        -- Intentar eliminar el generador
        DELETE FROM gestion_ambiental.empresas_reciclaje_vertederos WHERE id_empresa_vertedero = p_id_erv;

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Generador eliminado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al eliminar el generador';
        END IF;
    ELSE
        SET resultado = 0;
        SET mensaje = 'Error: El generador no existe';
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Empresas_Reciclaje_Obtener`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Empresas_Reciclaje_Obtener` ()   BEGIN
    SELECT * FROM gestion_ambiental.empresas_reciclaje_vertederos;
END$$

DROP PROCEDURE IF EXISTS `Generadores_Residuo_Actualizar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Generadores_Residuo_Actualizar` (IN `p_id_generador` INT, IN `p_nombre_generador` VARCHAR(100), IN `p_tipo_generador` VARCHAR(50), IN `p_ubicacion` VARCHAR(50), IN `p_contacto` VARCHAR(100), IN `p_longitud` DECIMAL(10,6), IN `p_latitud` DECIMAL(10,6))   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE generador_existente INT;

    -- Verificar si ya existe un generador con el mismo nombre (excluyendo el generador a actualizar)
    SELECT COUNT(*) INTO generador_existente
    FROM gestion_ambiental.generadores_residuo
    WHERE nombre_generador = p_nombre_generador AND id_generador <> p_id_generador;

    IF generador_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: El nombre del generador ya existe';
    ELSE
        -- Intentar actualizar el generador
        UPDATE gestion_ambiental.generadores_residuo
        SET nombre_generador = p_nombre_generador,
            tipo_generador = p_tipo_generador,
            ubicacion = p_ubicacion,
            contacto = p_contacto,
            longitud = p_longitud,
            latitud = p_latitud
        WHERE id_generador = p_id_generador;

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Generador actualizado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al actualizar el generador o el generador no existe';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Generadores_Residuo_Crear`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Generadores_Residuo_Crear` (IN `p_nombre_generador` VARCHAR(100), IN `p_tipo_generador` VARCHAR(50), IN `p_ubicacion` VARCHAR(50), IN `p_contacto` VARCHAR(100), IN `p_longitud` DECIMAL(10,6), IN `p_latitud` DECIMAL(10,6))   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE generador_existente INT;

    -- Verificar si ya existe un generador con el mismo nombre
    SELECT COUNT(*) INTO generador_existente
    FROM gestion_ambiental.generadores_residuo
    WHERE nombre_generador = p_nombre_generador;

    IF generador_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: El nombre del generador ya existe';
    ELSE
        -- Intentar insertar el nuevo generador
        INSERT INTO gestion_ambiental.generadores_residuo (nombre_generador, tipo_generador, ubicacion, contacto, longitud, latitud)
        VALUES (p_nombre_generador, p_tipo_generador, p_ubicacion, p_contacto, p_longitud, p_latitud);

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Generador añadido correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al añadir el generador';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Generadores_Residuo_Eliminar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Generadores_Residuo_Eliminar` (IN `p_id_generador` INT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);

    -- Comprobar si el generador existe
    IF EXISTS (SELECT 1 FROM gestion_ambiental.generadores_residuo WHERE id_generador = p_id_generador) THEN
        -- Intentar eliminar el generador
        DELETE FROM gestion_ambiental.generadores_residuo WHERE id_generador = p_id_generador;

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Generador eliminado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al eliminar el generador';
        END IF;
    ELSE
        SET resultado = 0;
        SET mensaje = 'Error: El generador no existe';
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Generadores_Residuo_Obtener`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Generadores_Residuo_Obtener` ()   BEGIN
    SELECT * FROM gestion_ambiental.generadores_residuo;
END$$

DROP PROCEDURE IF EXISTS `Generadores_Residuo_Obtener_Id`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Generadores_Residuo_Obtener_Id` (IN `p_id_generador` INT)   BEGIN
    DECLARE mensaje VARCHAR(255);

    -- Comprobar si el generador existe
    IF EXISTS (SELECT 1 FROM gestion_ambiental.generadores_residuo WHERE id_generador = p_id_generador) THEN
        -- Seleccionar el generador si existe
        SELECT * 
        FROM gestion_ambiental.generadores_residuo
        WHERE id_generador = p_id_generador;
    ELSE
        -- Enviar mensaje de error si el generador no existe
        SET mensaje = 'Error: El generador no existe';
        SELECT mensaje;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `GenerarEstadisticas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerarEstadisticas` (IN `tablas` TEXT)   BEGIN
    DECLARE tabla_actual VARCHAR(255);
    DECLARE cantidad INT;
    DECLARE tablas_cursor CURSOR FOR SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(tablas, ',', seq), ',', -1)) AS tabla
                                      FROM (SELECT 1 AS seq UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) seq_table
                                      WHERE seq <= CHAR_LENGTH(tablas) - CHAR_LENGTH(REPLACE(tablas, ',', '')) + 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET tabla_actual = NULL;

    -- Crear tabla temporal para almacenar los resultados
    CREATE TEMPORARY TABLE IF NOT EXISTS Estadisticas (
        nombre_tabla VARCHAR(255),
        cantidad_registros INT
    );

    -- Limpiar tabla temporal
    TRUNCATE TABLE Estadisticas;

    OPEN tablas_cursor;

    tablas_loop: LOOP
        FETCH tablas_cursor INTO tabla_actual;

        IF tabla_actual IS NULL THEN
            LEAVE tablas_loop;
        END IF;

        SET @query = CONCAT('SELECT COUNT(*) INTO @cantidad FROM ', tabla_actual);
        PREPARE stmt FROM @query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        INSERT INTO Estadisticas (nombre_tabla, cantidad_registros) VALUES (tabla_actual, @cantidad);
    END LOOP;

    CLOSE tablas_cursor;

    -- Mostrar los resultados
    SELECT * FROM Estadisticas;
END$$

DROP PROCEDURE IF EXISTS `ObtenerTotalResiduosPorMes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerTotalResiduosPorMes` ()   BEGIN
    -- Obtener el total de residuos por mes
    SELECT 
        MONTH(fecha_registro) AS mes,
        SUM(cantidad) AS total_residuos
    FROM 
        gestion_ambiental.registro_residuos
    GROUP BY 
        MONTH(fecha_registro)
    ORDER BY 
        mes;
END$$

DROP PROCEDURE IF EXISTS `Residuos_Actualizar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Residuos_Actualizar` (IN `p_id_residuo` INT, IN `p_tipo_residuo` VARCHAR(50), IN `p_descripcion` TEXT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE residuo_existente INT;

    -- Verificar si ya existe un residuo con el mismo tipo (excluyendo el residuo a actualizar)
    SELECT COUNT(*) INTO residuo_existente
    FROM gestion_ambiental.residuos
    WHERE tipo_residuo = p_tipo_residuo AND id_residuo <> p_id_residuo;

    IF residuo_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: El tipo de residuo ya existe';
    ELSE
        -- Intentar actualizar el residuo
        UPDATE gestion_ambiental.residuos
        SET tipo_residuo = p_tipo_residuo,
            descripcion = p_descripcion
        WHERE id_residuo = p_id_residuo;

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Residuo actualizado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al actualizar el residuo o el residuo no existe';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Residuos_Crear`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Residuos_Crear` (IN `p_tipo_residuo` VARCHAR(50), IN `p_descripcion` TEXT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE residuo_existente INT;

    -- Verificar si ya existe un residuo con el mismo tipo
    SELECT COUNT(*) INTO residuo_existente
    FROM gestion_ambiental.residuos
    WHERE tipo_residuo = p_tipo_residuo;

    IF residuo_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: El tipo de residuo ya existe';
    ELSE
        -- Intentar insertar el nuevo residuo
        INSERT INTO gestion_ambiental.residuos (tipo_residuo, descripcion)
        VALUES (p_tipo_residuo, p_descripcion);

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Residuo añadido correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al añadir el residuo';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Residuos_Eliminar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Residuos_Eliminar` (IN `p_id_residuo` INT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);

    -- Comprobar si el residuo existe
    IF EXISTS (SELECT 1 FROM gestion_ambiental.residuos WHERE id_residuo = p_id_residuo) THEN
        -- Intentar eliminar el residuo
        DELETE FROM gestion_ambiental.residuos WHERE id_residuo = p_id_residuo;

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Residuo eliminado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al eliminar el residuo';
        END IF;
    ELSE
        SET resultado = 0;
        SET mensaje = 'Error: El residuo no existe';
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Residuos_Obtener`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Residuos_Obtener` ()   BEGIN
    SELECT * FROM gestion_ambiental.residuos;
END$$

DROP PROCEDURE IF EXISTS `Residuos_Obtener_Id`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Residuos_Obtener_Id` (IN `p_id_residuo` INT)   BEGIN
    DECLARE mensaje VARCHAR(255);

    -- Comprobar si el residuo existe
    IF EXISTS (SELECT 1 FROM gestion_ambiental.residuos WHERE id_residuo = p_id_residuo) THEN
        -- Seleccionar el residuo si existe
        SELECT * 
        FROM gestion_ambiental.residuos
        WHERE id_residuo = p_id_residuo;
    ELSE
        -- Enviar mensaje de error si el residuo no existe
        SET mensaje = 'Error: El residuo no existe';
        SELECT mensaje;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `Rol_Actualizar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Rol_Actualizar` (IN `p_id_rol` INT, IN `p_nombre_rol` VARCHAR(100), IN `p_descripcion` VARCHAR(255))   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE rol_existente INT;

    -- Verificar si ya existe un rol con el mismo nombre (excluyendo el rol a actualizar)
    SELECT COUNT(*) INTO rol_existente
    FROM gestion_ambiental.roles
    WHERE nombre_rol = p_nombre_rol AND id_rol <> p_id_rol;

    -- Comprobar si existe un rol con el mismo nombre
    IF rol_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: El nombre del rol ya existe';
    ELSE
        -- Intentar actualizar el rol
        UPDATE gestion_ambiental.roles
        SET nombre_rol = p_nombre_rol,
            descripcion = p_descripcion
        WHERE id_rol = p_id_rol;

        -- Comprobar si la actualización fue exitosa
        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Rol actualizado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al actualizar el rol o el rol no existe';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Rol_Crear`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Rol_Crear` (IN `p_nombre_rol` VARCHAR(50), IN `p_descripcion` TEXT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE rol_existente INT;

    -- Verificar si ya existe un rol con el mismo nombre
    SELECT COUNT(*) INTO rol_existente
    FROM gestion_ambiental.roles
    WHERE nombre_rol = p_nombre_rol;

    -- Comprobar si existe un rol con el mismo nombre
    IF rol_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: El nombre del rol ya existe';
    ELSE
        -- Intentar insertar el nuevo rol
        INSERT INTO gestion_ambiental.roles (nombre_rol, descripcion)
        VALUES (p_nombre_rol, p_descripcion);

        -- Comprobar si la inserción fue exitosa
        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Rol añadido correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al añadir el rol';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Rol_Eliminar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Rol_Eliminar` (IN `p_id_rol` INT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);

    -- Intentar eliminar el rol
    DELETE FROM gestion_ambiental.roles
    WHERE id_rol = p_id_rol;

    -- Comprobar si la eliminación fue exitosa
    IF ROW_COUNT() > 0 THEN
        SET resultado = 1;
        SET mensaje = 'Rol eliminado correctamente';
    ELSE
        SET resultado = 0;
        SET mensaje = 'Error al eliminar el rol o el rol no existe';
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Rol_Obtener`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Rol_Obtener` ()   BEGIN
    -- Seleccionar todos los roles
    SELECT id_rol, nombre_rol, descripcion
    FROM gestion_ambiental.roles;
END$$

DROP PROCEDURE IF EXISTS `Rol_Obtener_Id`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Rol_Obtener_Id` (IN `p_id_rol` INT)   BEGIN
    -- Seleccionar el rol por ID
    SELECT id_rol, nombre_rol, descripcion
    FROM gestion_ambiental.roles
    WHERE id_rol = p_id_rol;
END$$

DROP PROCEDURE IF EXISTS `Transporte_Actualizar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Transporte_Actualizar` (IN `p_id_transporte` INT, IN `p_nombre_empresa` VARCHAR(100), IN `p_tipo_transporte` VARCHAR(50), IN `p_placa` VARCHAR(10), IN `p_contacto` VARCHAR(100))   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE placa_existente INT;

    -- Verificar si ya existe un transporte con la misma placa (excluyendo el transporte a actualizar)
    SELECT COUNT(*) INTO placa_existente
    FROM gestion_ambiental.transporte
    WHERE placa = p_placa AND id_transporte <> p_id_transporte;

    IF placa_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: La placa ya está en uso';
    ELSE
        -- Intentar actualizar el transporte
        UPDATE gestion_ambiental.transporte
        SET nombre_empresa = p_nombre_empresa,
            tipo_transporte = p_tipo_transporte,
            placa = p_placa,
            contacto = p_contacto
        WHERE id_transporte = p_id_transporte;

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Transporte actualizado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al actualizar el transporte o el transporte no existe';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Transporte_Crear`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Transporte_Crear` (IN `p_nombre_empresa` VARCHAR(100), IN `p_tipo_transporte` VARCHAR(50), IN `p_placa` VARCHAR(10), IN `p_contacto` VARCHAR(100))   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE placa_existente INT;

    -- Verificar si ya existe un transporte con la misma placa
    SELECT COUNT(*) INTO placa_existente
    FROM gestion_ambiental.transporte
    WHERE placa = p_placa;

    IF placa_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: La placa ya está en uso';
    ELSE
        -- Intentar insertar el nuevo registro de transporte
        INSERT INTO gestion_ambiental.transporte (nombre_empresa, tipo_transporte, placa, contacto)
        VALUES (p_nombre_empresa, p_tipo_transporte, p_placa, p_contacto);

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Transporte añadido correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al añadir el transporte';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Transporte_Eliminar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Transporte_Eliminar` (IN `p_id_transporte` INT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);

    -- Comprobar si el transporte existe
    IF EXISTS (SELECT 1 FROM gestion_ambiental.transporte WHERE id_transporte = p_id_transporte) THEN
        -- Intentar eliminar el transporte
        DELETE FROM gestion_ambiental.transporte WHERE id_transporte = p_id_transporte;

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Transporte eliminado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al eliminar el transporte';
        END IF;
    ELSE
        SET resultado = 0;
        SET mensaje = 'Error: El transporte no existe';
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Transporte_Obtener`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Transporte_Obtener` ()   BEGIN
    SELECT * FROM gestion_ambiental.transporte;
END$$

DROP PROCEDURE IF EXISTS `Transporte_Obtener_Id`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Transporte_Obtener_Id` (IN `p_id_transporte` INT)   BEGIN
    DECLARE mensaje VARCHAR(255);

    -- Comprobar si el transporte existe
    IF EXISTS (SELECT 1 FROM gestion_ambiental.transporte WHERE id_transporte = p_id_transporte) THEN
        -- Seleccionar el transporte si existe
        SELECT * 
        FROM gestion_ambiental.transporte
        WHERE id_transporte = p_id_transporte;
    ELSE
        -- Enviar mensaje de error si el transporte no existe
        SET mensaje = 'Error: El transporte no existe';
        SELECT mensaje;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `Tratamiento_Residuos_Actualizar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Tratamiento_Residuos_Actualizar` (IN `p_id_tratamiento` INT, IN `p_nombre_tratamiento` VARCHAR(50), IN `p_descripcion` TEXT, IN `p_id_responsable` INT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE tr_existente INT;

    -- Verificar si ya existe un residuo con el mismo tipo (excluyendo el residuo a actualizar)
    SELECT COUNT(*) INTO tr_existente
    FROM gestion_ambiental.tratamiento_residuos
    WHERE nombre_tratamiento = p_nombre_tratamiento AND id_tratamiento <> p_id_tratamiento;

    IF tr_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: El tipo de residuo ya existe';
    ELSE
        -- Intentar actualizar el residuo
        UPDATE gestion_ambiental.tratamiento_residuos
        SET nombre_tratamiento = p_nombre_tratamiento,
            descripcion = p_descripcion,
            responsable = p_id_responsable
        WHERE id_tratamiento = p_id_tratamiento;

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Residuo actualizado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al actualizar el residuo o el residuo no existe';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Tratamiento_Residuos_Crear`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Tratamiento_Residuos_Crear` (IN `p_nombre_tratamiento` VARCHAR(50), IN `p_descripcion` TEXT, IN `p_responsable_id` INT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE tr_existente INT;

    -- Verificar si ya existe un residuo con el mismo tipo
    SELECT COUNT(*) INTO tr_existente
    FROM gestion_ambiental.tratamiento_residuos
    WHERE nombre_tratamiento = p_nombre_tratamiento;

    IF tr_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: El tratamiento de residuo ya existe';
    ELSE
        -- Intentar insertar el nuevo residuo
        INSERT INTO gestion_ambiental.tratamiento_residuos (nombre_tratamiento, descripcion,responsable)
        VALUES (p_nombre_tratamiento, p_descripcion, p_responsable_id);

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Residuo añadido correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al añadir el residuo';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Tratamiento_Residuos_Eliminar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Tratamiento_Residuos_Eliminar` (IN `p_id_tratamiento` INT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);

    -- Comprobar si el residuo existe
    IF EXISTS (SELECT 1 FROM gestion_ambiental.tratamiento_residuos WHERE id_tratamiento = p_id_tratamiento) THEN
        -- Intentar eliminar el residuo
        DELETE FROM gestion_ambiental.tratamiento_residuos WHERE id_tratamiento = p_id_tratamiento;

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Residuo eliminado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al eliminar el residuo';
        END IF;
    ELSE
        SET resultado = 0;
        SET mensaje = 'Error: El residuo no existe';
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Tratamiento_Residuos_Obtener`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Tratamiento_Residuos_Obtener` ()   BEGIN
    SELECT 
        tr.id_tratamiento,       -- Suponiendo que existe un campo ID en la tabla tratamiento_residuos
        tr.nombre_tratamiento,  -- Suponiendo que hay un nombre o descripción del tratamiento
        tr.descripcion,
        u.id_usuario as id_responsable,
        u.nombre AS responsable_nombre,
        u.email AS responsable_email
    FROM 
        gestion_ambiental.tratamiento_residuos tr
    JOIN 
        gestion_ambiental.usuarios u
    ON 
        tr.responsable = u.id_usuario;
END$$

DROP PROCEDURE IF EXISTS `Usuarios_Actualizar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Usuarios_Actualizar` (IN `p_id_usuario` INT, IN `p_nombre` VARCHAR(50), IN `p_email` VARCHAR(100), IN `p_password` VARCHAR(50), IN `p_estado` ENUM('activo','inactivo'), IN `p_foto_url` VARCHAR(255), IN `p_telefono` VARCHAR(15), IN `p_cargo` VARCHAR(50), IN `p_profesion` VARCHAR(50))   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE usuario_existente INT;

    -- Verificar si ya existe un usuario con el mismo email (excluyendo el usuario a actualizar)
    SELECT COUNT(*) INTO usuario_existente
    FROM gestion_ambiental.usuarios
    WHERE email = p_email AND id_usuario <> p_id_usuario;

    -- Comprobar si existe un usuario con el mismo email
    IF usuario_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: El email ya está en uso por otro usuario';
    ELSE
        -- Intentar actualizar el usuario
        UPDATE gestion_ambiental.usuarios
        SET nombre = p_nombre,
            email = p_email,
            password = p_password,
            estado = p_estado,
            foto_url = p_foto_url,
            telefono = p_telefono,
            cargo = p_cargo,
            profesion = p_profesion
        WHERE id_usuario = p_id_usuario;

        -- Comprobar si la actualización fue exitosa
        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Usuario actualizado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al actualizar el usuario o el usuario no existe';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Usuarios_Actualizar_Estado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Usuarios_Actualizar_Estado` (IN `p_id_usuario` INT, IN `p_estado` ENUM('activo','inactivo'))   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE usuario_existente INT;

    -- Verificar si ya existe un usuario con el mismo email (excluyendo el usuario a actualizar)
    SELECT COUNT(*) INTO usuario_existente
    FROM gestion_ambiental.usuarios
    WHERE  id_usuario = p_id_usuario;

    -- Comprobar si existe un usuario con el mismo email
    IF usuario_existente = 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: El Usuario No Existe';
    ELSE
        -- Intentar actualizar el usuario
        UPDATE gestion_ambiental.usuarios
        SET
            estado = p_estado
        
        WHERE id_usuario = p_id_usuario;

        -- Comprobar si la actualización fue exitosa
        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Usuario actualizado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al actualizar el usuario o el usuario no existe';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Usuarios_Crear`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Usuarios_Crear` (IN `p_nombre` VARCHAR(50), IN `p_email` VARCHAR(100), IN `p_password` VARCHAR(60), IN `p_fecha_creacion` DATETIME, IN `p_estado` ENUM('activo','inactivo'), IN `p_foto_url` VARCHAR(255), IN `p_telefono` VARCHAR(15), IN `p_cargo` VARCHAR(50), IN `p_profesion` VARCHAR(50))   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE usuario_existente INT;

    -- Verificar si ya existe un usuario con el mismo email
    SELECT COUNT(*) INTO usuario_existente
    FROM gestion_ambiental.usuarios
    WHERE email = p_email;

    -- Comprobar si existe un usuario con el mismo email
    IF usuario_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: El email ya está en uso por otro usuario';
    ELSE
        -- Intentar insertar el nuevo usuario
        INSERT INTO gestion_ambiental.usuarios (nombre, email, password_user, fecha_creacion, estado, foto_url, telefono, cargo, profesion)
        VALUES (p_nombre, p_email, p_password, p_fecha_creacion, p_estado, p_foto_url, p_telefono, p_cargo, p_profesion);

        -- Comprobar si la inserción fue exitosa
        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Usuario creado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al crear el usuario';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Usuarios_Eliminar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Usuarios_Eliminar` (IN `p_id_usuario` INT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);

    -- Comprobar si el usuario existe
    IF EXISTS (SELECT 1 FROM gestion_ambiental.usuarios WHERE id_usuario = p_id_usuario) THEN
        -- Intentar eliminar el usuario
        DELETE FROM gestion_ambiental.usuarios WHERE id_usuario = p_id_usuario;

        -- Comprobar si la eliminación fue exitosa
        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Usuario eliminado correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al eliminar el usuario';
        END IF;
    ELSE
        -- Enviar mensaje de error si el usuario no existe
        SET resultado = 0;
        SET mensaje = 'Error: El usuario no existe';
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Usuarios_Obtener`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Usuarios_Obtener` ()   BEGIN
    -- Seleccionar todos los usuarios de la tabla
    SELECT * 
    FROM gestion_ambiental.usuarios;
END$$

DROP PROCEDURE IF EXISTS `Usuarios_Obtener_email`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Usuarios_Obtener_email` (IN `p_email_usuario` VARCHAR(50))   BEGIN
    DECLARE mensaje VARCHAR(255);

    -- Comprobar si el usuario existe
    IF EXISTS (SELECT 1 FROM gestion_ambiental.usuarios WHERE email = p_email_usuario) THEN
        -- Seleccionar el usuario si existe
        SELECT * 
        FROM gestion_ambiental.usuarios
        WHERE email = p_email_usuario;
    ELSE
        -- Enviar mensaje de error si el usuario no existe
        SET mensaje = 'Error: El usuario no existe';
        SELECT mensaje;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `Usuarios_Obtener_Id`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Usuarios_Obtener_Id` (IN `p_id_usuario` INT)   BEGIN
    DECLARE mensaje VARCHAR(255);

    -- Comprobar si el usuario existe
    IF EXISTS (SELECT 1 FROM gestion_ambiental.usuarios WHERE id_usuario = p_id_usuario) THEN
        -- Seleccionar el usuario si existe
        SELECT * 
        FROM gestion_ambiental.usuarios
        WHERE id_usuario = p_id_usuario;
    ELSE
        -- Enviar mensaje de error si el usuario no existe
        SET mensaje = 'Error: El usuario no existe';
        SELECT mensaje;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `Usuarios_Roles_Crear`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Usuarios_Roles_Crear` (IN `p_id_usuario` INT, IN `p_id_rol` INT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);
    DECLARE asignacion_existente INT;

    -- Verificar si ya existe la asignación
    SELECT COUNT(*) INTO asignacion_existente
    FROM gestion_ambiental.usuarios_roles
    WHERE id_usuario = p_id_usuario AND id_rol = p_id_rol;

    IF asignacion_existente > 0 THEN
        SET resultado = 0;
        SET mensaje = 'Error: La asignación ya existe';
    ELSE
        -- Intentar insertar la asignación
        INSERT INTO gestion_ambiental.usuarios_roles (id_usuario, id_rol)
        VALUES (p_id_usuario, p_id_rol);

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Asignación creada correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al crear la asignación';
        END IF;
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DROP PROCEDURE IF EXISTS `Usuarios_Roles_Eliminar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Usuarios_Roles_Eliminar` (IN `p_id_usuario` INT, IN `p_id_rol` INT)   BEGIN
    DECLARE resultado INT DEFAULT 0;
    DECLARE mensaje VARCHAR(255);

    -- Verificar si la asignación existe
    IF EXISTS (SELECT 1 FROM gestion_ambiental.usuarios_roles WHERE id_usuario = p_id_usuario AND id_rol = p_id_rol) THEN
        -- Intentar eliminar la asignación
        DELETE FROM gestion_ambiental.usuarios_roles
        WHERE id_usuario = p_id_usuario AND id_rol = p_id_rol;

        IF ROW_COUNT() > 0 THEN
            SET resultado = 1;
            SET mensaje = 'Asignación eliminada correctamente';
        ELSE
            SET resultado = 0;
            SET mensaje = 'Error al eliminar la asignación';
        END IF;
    ELSE
        SET resultado = 0;
        SET mensaje = 'Error: La asignación no existe';
    END IF;

    -- Seleccionar el resultado y mensaje
    SELECT resultado, mensaje;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE `departamentos` (
  `id_departamento` int(11) NOT NULL,
  `nombre_departamento` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`id_departamento`, `nombre_departamento`) VALUES
(5, 'Antioquia'),
(8, 'Atlántico'),
(11, 'Bogotá D.C.'),
(13, 'Bolívar'),
(15, 'Boyacá'),
(17, 'Caldas'),
(18, 'Caquetá'),
(19, 'Cauca'),
(20, 'Cesar'),
(23, 'Córdoba'),
(25, 'Cundinamarca'),
(27, 'Chocó'),
(41, 'Huila'),
(44, 'La Guajira'),
(47, 'Magdalena'),
(50, 'Meta'),
(52, 'Nariño'),
(54, 'Norte de Santander'),
(63, 'Quindío'),
(66, 'Risaralda'),
(68, 'Santander'),
(70, 'Sucre'),
(73, 'Tolima'),
(76, 'Valle del Cauca'),
(81, 'Arauca'),
(85, 'Casanare'),
(86, 'Putumayo'),
(88, 'Archipiélago de San Andrés, Providencia y Santa Catalina'),
(91, 'Amazonas'),
(94, 'Guainía'),
(95, 'Guaviare'),
(97, 'Vaupés'),
(99, 'Vichada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas_reciclaje_vertederos`
--

DROP TABLE IF EXISTS `empresas_reciclaje_vertederos`;
CREATE TABLE `empresas_reciclaje_vertederos` (
  `id_empresa_vertedero` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `tipo` enum('Reciclaje','Vertedero') DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `id_departamento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empresas_reciclaje_vertederos`
--

INSERT INTO `empresas_reciclaje_vertederos` (`id_empresa_vertedero`, `nombre`, `tipo`, `direccion`, `telefono`, `id_departamento`) VALUES
(1, 'Empreas ERV x3', '', 'ABC124', 'Nuevo Contacto x2', 25),
(2, 'Empreas ERV x3', '', 'ABC124', 'Nuevo Contacto x2', 25),
(3, 'Empreas ERV x3', '', 'ABC124', 'Nuevo Contacto x2', 25),
(4, 'Empreas ERV x3', '', 'ABC124', 'Nuevo Contacto x2', 25),
(5, 'Empreas ERV x6', 'Reciclaje', 'Reciclaje', 'Nuevo Contacto x2', 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `generadores_residuo`
--

DROP TABLE IF EXISTS `generadores_residuo`;
CREATE TABLE `generadores_residuo` (
  `id_generador` int(11) NOT NULL,
  `nombre_generador` varchar(100) NOT NULL,
  `tipo_generador` varchar(50) DEFAULT NULL,
  `ubicacion` int(11) DEFAULT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `longitud` decimal(10,6) DEFAULT NULL,
  `latitud` decimal(10,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `generadores_residuo`
--

INSERT INTO `generadores_residuo` (`id_generador`, `nombre_generador`, `tipo_generador`, `ubicacion`, `contacto`, `longitud`, `latitud`) VALUES
(1, 'Fábrica de Cemento', 'Industrial', 252, 'contacto@cemento.com', -74.081750, 4.609710),
(2, 'Clínica San Pedro', 'Hospitalario', 2512, 'info@clinicasanpedro.com', -74.083650, 4.613720),
(3, 'Fábrica ABCDE X2', 'Industrial', 2512, 'contacto01@fabricaabc.com', -74.075500, 4.627200),
(4, 'Universidad Regional', 'Educativo', 2532, 'info@uniregional.edu.co', -74.070980, 4.647630),
(5, 'Hotel La Esperanza', 'Turístico', 2543, 'reservas@laesperanza.com', -74.085740, 4.610520),
(6, 'Supermercado Todo Días', 'Comercial', 2553, 'contacto@tododias.com', -74.078320, 4.617890),
(7, 'Laboratorio FarmaVida', 'Industrial', 2558, 'info@farmavida.com', -74.089130, 4.625670),
(8, 'Granja AgroPlus', 'Agrícola', 2574, 'contacto@agroplus.com', -74.076450, 4.631450),
(9, 'Parque Industrial Puli', 'Industrial', 25035, 'info@parqueindustrial.com', -74.082240, 4.635670),
(10, 'Centro Comercial La Plaza', 'Comercial', 25099, 'info@laplaza.com', -74.073580, 4.639830);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipios`
--

DROP TABLE IF EXISTS `municipios`;
CREATE TABLE `municipios` (
  `id_municipio` int(11) NOT NULL,
  `id_departamento` int(11) DEFAULT NULL,
  `nombre_municipio` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `municipios`
--

INSERT INTO `municipios` (`id_municipio`, `id_departamento`, `nombre_municipio`) VALUES
(54, 5, 'La Unión'),
(136, 13, 'Río Viejo'),
(155, 15, 'Oicatá'),
(156, 15, 'Ráquira'),
(191, 19, 'Bolívar'),
(193, 19, 'Guachené'),
(233, 23, 'Cotorra'),
(235, 23, 'Moñitos'),
(252, 25, 'Cogua'),
(276, 27, 'Río Quito'),
(278, 27, 'Unguía'),
(503, 5, 'Amagá'),
(504, 5, 'Anorí'),
(512, 5, 'Cáceres'),
(515, 5, 'Carolina'),
(519, 5, 'Cisneros'),
(524, 5, 'Ebéjico'),
(525, 5, 'El Bagre'),
(531, 5, 'Gómez Plata'),
(536, 5, 'Itagui'),
(538, 5, 'La Estrella'),
(539, 5, 'La Pintada'),
(544, 5, 'Marinilla'),
(548, 5, 'Mutatá'),
(549, 5, 'Necoclí'),
(566, 5, 'San Luis'),
(567, 5, 'San Roque'),
(569, 5, 'Santo Domingo'),
(579, 5, 'Tarazá'),
(589, 5, 'Yolombó'),
(877, 8, 'Suan'),
(1314, 13, 'Calamar'),
(1316, 13, 'Cantagallo'),
(1343, 13, 'Magangué'),
(1344, 13, 'Margarita'),
(1349, 13, 'Norosí'),
(1358, 13, 'Regidor'),
(1365, 13, 'San Fernando'),
(1376, 13, 'Soplaviento'),
(1378, 13, 'Talaigua Nuevo'),
(1381, 13, 'Tiquisio'),
(1509, 15, 'Berbeo'),
(1518, 15, 'Chiscas'),
(1538, 15, 'La Capilla'),
(1548, 15, 'Muzo'),
(1555, 15, 'Pisba'),
(1558, 15, 'Quípama'),
(1566, 15, 'San Eduardo'),
(1569, 15, 'Santa María'),
(1572, 15, 'Sativanorte'),
(1574, 15, 'Siachoque'),
(1579, 15, 'Tasco'),
(1581, 15, 'Tipacoque'),
(1582, 15, 'Tópaga'),
(1705, 17, 'Aranzazu'),
(1738, 17, 'La Dorada'),
(1886, 18, 'Valparaíso'),
(1905, 19, 'Argelia'),
(1911, 19, 'Buenos Aires'),
(1913, 19, 'Cajibío'),
(1929, 19, 'Florencia'),
(1945, 19, 'Mercaderes'),
(1976, 19, 'Sotara'),
(1978, 19, 'Suárez'),
(2006, 20, 'Bosconia'),
(2025, 20, 'El Paso'),
(2031, 20, 'González'),
(2055, 20, 'Pelaya'),
(2057, 20, 'Pueblo Bello'),
(2071, 20, 'San Alberto'),
(2075, 20, 'San Diego'),
(2077, 20, 'San Martín'),
(2309, 23, 'Canalete'),
(2357, 23, 'Pueblo Nuevo'),
(2366, 23, 'Sahagún'),
(2367, 23, 'San Andrés Sotavento'),
(2512, 25, 'Cabrera'),
(2526, 25, 'El Rosal'),
(2532, 25, 'Guaduas'),
(2543, 25, 'Madrid'),
(2553, 25, 'Paratebueno'),
(2558, 25, 'Pulí'),
(2574, 25, 'Sibaté'),
(2705, 27, 'Atrato'),
(2716, 27, 'Cértegui'),
(2743, 27, 'Medio Baudó'),
(2745, 27, 'Medio San Juan'),
(2758, 27, 'Río Iro'),
(4102, 41, 'Algeciras'),
(4153, 41, 'Palestina'),
(4166, 41, 'Saladoblanco'),
(4177, 41, 'Suaza'),
(4409, 44, 'Dibula'),
(4411, 44, 'El Molino'),
(4443, 44, 'Maicao'),
(4456, 44, 'Manaure'),
(4703, 47, 'Algarrobo'),
(4717, 47, 'Chivolo'),
(4746, 47, 'Nueva Granada'),
(4796, 47, 'Zapayán'),
(4798, 47, 'Zona Bananera'),
(5001, 5, 'Medellín'),
(5002, 5, 'Abejorral'),
(5004, 5, 'Abriaquí'),
(5021, 5, 'Alejandría'),
(5027, 50, 'El Dorado'),
(5031, 5, 'Amalfi'),
(5033, 50, 'Mesetas'),
(5034, 5, 'Andes'),
(5035, 50, 'La Macarena'),
(5036, 5, 'Angelópolis'),
(5037, 50, 'Uribe'),
(5038, 5, 'Angostura'),
(5044, 5, 'Anza'),
(5045, 5, 'Apartadó'),
(5051, 5, 'Arboletes'),
(5055, 5, 'Argelia'),
(5059, 5, 'Armenia'),
(5079, 5, 'Barbosa'),
(5086, 5, 'Belmira'),
(5088, 5, 'Bello'),
(5091, 5, 'Betania'),
(5093, 5, 'Betulia'),
(5101, 5, 'Ciudad Bolívar'),
(5107, 5, 'Briceño'),
(5113, 5, 'Buriticá'),
(5125, 5, 'Caicedo'),
(5129, 5, 'Caldas'),
(5134, 5, 'Campamento'),
(5138, 5, 'Cañasgordas'),
(5142, 5, 'Caracolí'),
(5145, 5, 'Caramanta'),
(5147, 5, 'Carepa'),
(5154, 5, 'Caucasia'),
(5172, 5, 'Chigorodó'),
(5197, 5, 'Cocorná'),
(5206, 5, 'Concepción'),
(5209, 5, 'Concordia'),
(5212, 5, 'Copacabana'),
(5234, 5, 'Dabeiba'),
(5237, 5, 'Don Matías'),
(5264, 5, 'Entrerrios'),
(5266, 5, 'Envigado'),
(5282, 5, 'Fredonia'),
(5306, 5, 'Giraldo'),
(5308, 5, 'Girardota'),
(5315, 5, 'Guadalupe'),
(5318, 5, 'Guarne'),
(5321, 5, 'Guatapé'),
(5347, 5, 'Heliconia'),
(5353, 5, 'Hispania'),
(5361, 5, 'Ituango'),
(5368, 5, 'Jericó'),
(5376, 5, 'La Ceja'),
(5411, 5, 'Liborina'),
(5425, 5, 'Maceo'),
(5467, 5, 'Montebello'),
(5475, 5, 'Murindó'),
(5483, 5, 'Nariño'),
(5495, 5, 'Nechí'),
(5501, 5, 'Olaya'),
(5541, 5, 'Peñol'),
(5543, 5, 'Peque'),
(5576, 5, 'Pueblorrico'),
(5579, 5, 'Puerto Berrío'),
(5585, 5, 'Puerto Nare'),
(5591, 5, 'Puerto Triunfo'),
(5604, 5, 'Remedios'),
(5607, 5, 'Retiro'),
(5615, 5, 'Rionegro'),
(5628, 5, 'Sabanalarga'),
(5631, 5, 'Sabaneta'),
(5642, 5, 'Salgar'),
(5652, 5, 'San Francisco'),
(5656, 5, 'San Jerónimo'),
(5664, 5, 'San Pedro'),
(5667, 5, 'San Rafael'),
(5674, 5, 'San Vicente'),
(5679, 5, 'Santa Bárbara'),
(5697, 5, 'El Santuario'),
(5736, 5, 'Segovia'),
(5761, 5, 'Sopetrán'),
(5789, 5, 'Támesis'),
(5792, 5, 'Tarso'),
(5809, 5, 'Titiribí'),
(5819, 5, 'Toledo'),
(5837, 5, 'Turbo'),
(5842, 5, 'Uramita'),
(5847, 5, 'Urrao'),
(5854, 5, 'Valdivia'),
(5856, 5, 'Valparaíso'),
(5858, 5, 'Vegachí'),
(5861, 5, 'Venecia'),
(5885, 5, 'Yalí'),
(5887, 5, 'Yarumal'),
(5893, 5, 'Yondó'),
(5895, 5, 'Zaragoza'),
(8001, 8, 'Barranquilla'),
(8078, 8, 'Baranoa'),
(8141, 8, 'Candelaria'),
(8296, 8, 'Galapa'),
(8421, 8, 'Luruaco'),
(8433, 8, 'Malambo'),
(8436, 8, 'Manatí'),
(8549, 8, 'Piojó'),
(8558, 8, 'Polonuevo'),
(8634, 8, 'Sabanagrande'),
(8638, 8, 'Sabanalarga'),
(8675, 8, 'Santa Lucía'),
(8685, 8, 'Santo Tomás'),
(8758, 8, 'Soledad'),
(8832, 8, 'Tubará'),
(8849, 8, 'Usiacurí'),
(13006, 13, 'Achí'),
(13042, 13, 'Arenal'),
(13052, 13, 'Arjona'),
(13062, 13, 'Arroyohondo'),
(13188, 13, 'Cicuco'),
(13212, 13, 'Córdoba'),
(13222, 13, 'Clemencia'),
(13248, 13, 'El Guamo'),
(13433, 13, 'Mahates'),
(13458, 13, 'Montecristo'),
(13468, 13, 'Mompós'),
(13473, 13, 'Morales'),
(13549, 13, 'Pinillos'),
(13647, 13, 'San Estanislao'),
(13657, 13, 'San Juan Nepomuceno'),
(13673, 13, 'Santa Catalina'),
(13683, 13, 'Santa Rosa'),
(13744, 13, 'Simití'),
(13836, 13, 'Turbaco'),
(13838, 13, 'Turbaná'),
(13873, 13, 'Villanueva'),
(15001, 15, 'Tunja'),
(15022, 15, 'Almeida'),
(15047, 15, 'Aquitania'),
(15051, 15, 'Arcabuco'),
(15092, 15, 'Betéitiva'),
(15097, 15, 'Boavita'),
(15104, 15, 'Boyacá'),
(15106, 15, 'Briceño'),
(15109, 15, 'Buena Vista'),
(15114, 15, 'Busbanzá'),
(15131, 15, 'Caldas'),
(15135, 15, 'Campohermoso'),
(15162, 15, 'Cerinza'),
(15172, 15, 'Chinavita'),
(15176, 15, 'Chiquinquirá'),
(15183, 15, 'Chita'),
(15185, 15, 'Chitaraque'),
(15187, 15, 'Chivatá'),
(15189, 15, 'Ciénega'),
(15204, 15, 'Cómbita'),
(15212, 15, 'Coper'),
(15215, 15, 'Corrales'),
(15218, 15, 'Covarachía'),
(15223, 15, 'Cubará'),
(15224, 15, 'Cucaita'),
(15226, 15, 'Cuítiva'),
(15232, 15, 'Chíquiza'),
(15236, 15, 'Chivor'),
(15238, 15, 'Duitama'),
(15244, 15, 'El Cocuy'),
(15248, 15, 'El Espino'),
(15272, 15, 'Firavitoba'),
(15276, 15, 'Floresta'),
(15293, 15, 'Gachantivá'),
(15296, 15, 'Gameza'),
(15299, 15, 'Garagoa'),
(15317, 15, 'Guacamayas'),
(15322, 15, 'Guateque'),
(15325, 15, 'Guayatá'),
(15332, 15, 'Güicán'),
(15362, 15, 'Iza'),
(15367, 15, 'Jenesano'),
(15368, 15, 'Jericó'),
(15377, 15, 'Labranzagrande'),
(15401, 15, 'La Victoria'),
(15425, 15, 'Macanal'),
(15442, 15, 'Maripí'),
(15455, 15, 'Miraflores'),
(15464, 15, 'Mongua'),
(15466, 15, 'Monguí'),
(15469, 15, 'Moniquirá'),
(15476, 15, 'Motavita'),
(15491, 15, 'Nobsa'),
(15494, 15, 'Nuevo Colón'),
(15507, 15, 'Otanche'),
(15511, 15, 'Pachavita'),
(15514, 15, 'Páez'),
(15516, 15, 'Paipa'),
(15518, 15, 'Pajarito'),
(15522, 15, 'Panqueba'),
(15531, 15, 'Pauna'),
(15533, 15, 'Paya'),
(15542, 15, 'Pesca'),
(15572, 15, 'Puerto Boyacá'),
(15599, 15, 'Ramiriquí'),
(15621, 15, 'Rondón'),
(15632, 15, 'Saboyá'),
(15638, 15, 'Sáchica'),
(15646, 15, 'Samacá'),
(15673, 15, 'San Mateo'),
(15686, 15, 'Santana'),
(15696, 15, 'Santa Sofía'),
(15723, 15, 'Sativasur'),
(15753, 15, 'Soatá'),
(15755, 15, 'Socotá'),
(15757, 15, 'Socha'),
(15759, 15, 'Sogamoso'),
(15761, 15, 'Somondoco'),
(15762, 15, 'Sora'),
(15763, 15, 'Sotaquirá'),
(15764, 15, 'Soracá'),
(15774, 15, 'Susacón'),
(15776, 15, 'Sutamarchán'),
(15778, 15, 'Sutatenza'),
(15798, 15, 'Tenza'),
(15804, 15, 'Tibaná'),
(15808, 15, 'Tinjacá'),
(15814, 15, 'Toca'),
(15822, 15, 'Tota'),
(15832, 15, 'Tununguá'),
(15835, 15, 'Turmequé'),
(15839, 15, 'Tutazá'),
(15842, 15, 'Umbita'),
(15861, 15, 'Ventaquemada'),
(15879, 15, 'Viracachá'),
(15897, 15, 'Zetaquira'),
(17001, 17, 'Manizales'),
(17013, 17, 'Aguadas'),
(17042, 17, 'Anserma'),
(17088, 17, 'Belalcázar'),
(17174, 17, 'Chinchiná'),
(17272, 17, 'Filadelfia'),
(17388, 17, 'La Merced'),
(17433, 17, 'Manzanares'),
(17442, 17, 'Marmato'),
(17446, 17, 'Marulanda'),
(17486, 17, 'Neira'),
(17495, 17, 'Norcasia'),
(17513, 17, 'Pácora'),
(17524, 17, 'Palestina'),
(17541, 17, 'Pensilvania'),
(17614, 17, 'Riosucio'),
(17616, 17, 'Risaralda'),
(17653, 17, 'Salamina'),
(17662, 17, 'Samaná'),
(17665, 17, 'San José'),
(17777, 17, 'Supía'),
(17867, 17, 'Victoria'),
(17873, 17, 'Villamaría'),
(17877, 17, 'Viterbo'),
(18001, 18, 'Florencia'),
(18029, 18, 'Albania'),
(18205, 18, 'Curillo'),
(18247, 18, 'El Doncello'),
(18256, 18, 'El Paujil'),
(18479, 18, 'Morelia'),
(18592, 18, 'Puerto Rico'),
(18756, 18, 'Solano'),
(18785, 18, 'Solita'),
(19001, 19, 'Popayán'),
(19022, 19, 'Almaguer'),
(19075, 19, 'Balboa'),
(19137, 19, 'Caldono'),
(19142, 19, 'Caloto'),
(19212, 19, 'Corinto'),
(19256, 19, 'El Tambo'),
(19318, 19, 'Guapi'),
(19355, 19, 'Inzá'),
(19364, 19, 'Jambaló'),
(19392, 19, 'La Sierra'),
(19397, 19, 'La Vega'),
(19418, 19, 'López'),
(19455, 19, 'Miranda'),
(19473, 19, 'Morales'),
(19513, 19, 'Padilla'),
(19532, 19, 'Patía'),
(19533, 19, 'Piamonte'),
(19548, 19, 'Piendamó'),
(19573, 19, 'Puerto Tejada'),
(19585, 19, 'Puracé'),
(19622, 19, 'Rosas'),
(19701, 19, 'Santa Rosa'),
(19743, 19, 'Silvia'),
(19785, 19, 'Sucre'),
(19807, 19, 'Timbío'),
(19809, 19, 'Timbiquí'),
(19821, 19, 'Toribio'),
(19824, 19, 'Totoró'),
(19845, 19, 'Villa Rica'),
(20001, 20, 'Valledupar'),
(20011, 20, 'Aguachica'),
(20013, 20, 'Agustín Codazzi'),
(20032, 20, 'Astrea'),
(20045, 20, 'Becerril'),
(20175, 20, 'Chimichagua'),
(20178, 20, 'Chiriguaná'),
(20228, 20, 'Curumaní'),
(20238, 20, 'El Copey'),
(20295, 20, 'Gamarra'),
(20383, 20, 'La Gloria'),
(20443, 20, 'Manaure'),
(20517, 20, 'Pailitas'),
(20621, 20, 'La Paz'),
(20787, 20, 'Tamalameque'),
(23001, 23, 'Montería'),
(23068, 23, 'Ayapel'),
(23079, 23, 'Buenavista'),
(23162, 23, 'Cereté'),
(23168, 23, 'Chimá'),
(23182, 23, 'Chinú'),
(23417, 23, 'Lorica'),
(23419, 23, 'Los Córdobas'),
(23464, 23, 'Momil'),
(23555, 23, 'Planeta Rica'),
(23574, 23, 'Puerto Escondido'),
(23586, 23, 'Purísima'),
(23672, 23, 'San Antero'),
(23675, 23, 'San Bernardo del Viento'),
(23686, 23, 'San Pelayo'),
(23807, 23, 'Tierralta'),
(23815, 23, 'Tuchín'),
(23855, 23, 'Valencia'),
(25035, 25, 'Anapoima'),
(25053, 25, 'Arbeláez'),
(25086, 25, 'Beltrán'),
(25095, 25, 'Bituima'),
(25099, 25, 'Bojacá'),
(25123, 25, 'Cachipay'),
(25126, 25, 'Cajicá'),
(25148, 25, 'Caparrapí'),
(25151, 25, 'Caqueza'),
(25168, 25, 'Chaguaní'),
(25178, 25, 'Chipaque'),
(25181, 25, 'Choachí'),
(25183, 25, 'Chocontá'),
(25214, 25, 'Cota'),
(25224, 25, 'Cucunubá'),
(25245, 25, 'El Colegio'),
(25279, 25, 'Fomeque'),
(25281, 25, 'Fosca'),
(25286, 25, 'Funza'),
(25288, 25, 'Fúquene'),
(25293, 25, 'Gachala'),
(25295, 25, 'Gachancipá'),
(25297, 25, 'Gachetá'),
(25307, 25, 'Girardot'),
(25312, 25, 'Granada'),
(25317, 25, 'Guachetá'),
(25322, 25, 'Guasca'),
(25324, 25, 'Guataquí'),
(25326, 25, 'Guatavita'),
(25335, 25, 'Guayabetal'),
(25339, 25, 'Gutiérrez'),
(25368, 25, 'Jerusalén'),
(25372, 25, 'Junín'),
(25377, 25, 'La Calera'),
(25386, 25, 'La Mesa'),
(25394, 25, 'La Palma'),
(25398, 25, 'La Peña'),
(25402, 25, 'La Vega'),
(25407, 25, 'Lenguazaque'),
(25426, 25, 'Macheta'),
(25436, 25, 'Manta'),
(25438, 25, 'Medina'),
(25473, 25, 'Mosquera'),
(25483, 25, 'Nariño'),
(25486, 25, 'Nemocón'),
(25488, 25, 'Nilo'),
(25489, 25, 'Nimaima'),
(25491, 25, 'Nocaima'),
(25506, 25, 'Venecia'),
(25513, 25, 'Pacho'),
(25518, 25, 'Paime'),
(25524, 25, 'Pandi'),
(25535, 25, 'Pasca'),
(25572, 25, 'Puerto Salgar'),
(25592, 25, 'Quebradanegra'),
(25594, 25, 'Quetame'),
(25596, 25, 'Quipile'),
(25599, 25, 'Apulo'),
(25612, 25, 'Ricaurte'),
(25649, 25, 'San Bernardo'),
(25653, 25, 'San Cayetano'),
(25658, 25, 'San Francisco'),
(25736, 25, 'Sesquilé'),
(25743, 25, 'Silvania'),
(25745, 25, 'Simijaca'),
(25754, 25, 'Soacha'),
(25769, 25, 'Subachoque'),
(25772, 25, 'Suesca'),
(25777, 25, 'Supatá'),
(25779, 25, 'Susa'),
(25781, 25, 'Sutatausa'),
(25785, 25, 'Tabio'),
(25793, 25, 'Tausa'),
(25797, 25, 'Tena'),
(25799, 25, 'Tenjo'),
(25805, 25, 'Tibacuy'),
(25807, 25, 'Tibirita'),
(25815, 25, 'Tocaima'),
(25817, 25, 'Tocancipá'),
(25823, 25, 'Topaipí'),
(25839, 25, 'Ubalá'),
(25841, 25, 'Ubaque'),
(25845, 25, 'Une'),
(25851, 25, 'Útica'),
(25867, 25, 'Vianí'),
(25871, 25, 'Villagómez'),
(25873, 25, 'Villapinzón'),
(25875, 25, 'Villeta'),
(25878, 25, 'Viotá'),
(25898, 25, 'Zipacón'),
(27001, 27, 'Quibdó'),
(27006, 27, 'Acandí'),
(27025, 27, 'Alto Baudo'),
(27073, 27, 'Bagadó'),
(27075, 27, 'Bahía Solano'),
(27077, 27, 'Bajo Baudó'),
(27099, 27, 'Bojaya'),
(27205, 27, 'Condoto'),
(27361, 27, 'Istmina'),
(27372, 27, 'Juradó'),
(27413, 27, 'Lloró'),
(27425, 27, 'Medio Atrato'),
(27491, 27, 'Nóvita'),
(27495, 27, 'Nuquí'),
(27615, 27, 'Riosucio'),
(27745, 27, 'Sipí'),
(41001, 41, 'Neiva'),
(41006, 41, 'Acevedo'),
(41013, 41, 'Agrado'),
(41016, 41, 'Aipe'),
(41026, 41, 'Altamira'),
(41078, 41, 'Baraya'),
(41132, 41, 'Campoalegre'),
(41206, 41, 'Colombia'),
(41244, 41, 'Elías'),
(41298, 41, 'Garzón'),
(41306, 41, 'Gigante'),
(41319, 41, 'Guadalupe'),
(41349, 41, 'Hobo'),
(41357, 41, 'Iquira'),
(41359, 41, 'Isnos'),
(41378, 41, 'La Argentina'),
(41396, 41, 'La Plata'),
(41483, 41, 'Nátaga'),
(41503, 41, 'Oporapa'),
(41518, 41, 'Paicol'),
(41524, 41, 'Palermo'),
(41548, 41, 'Pital'),
(41551, 41, 'Pitalito'),
(41615, 41, 'Rivera'),
(41676, 41, 'Santa María'),
(41791, 41, 'Tarqui'),
(41797, 41, 'Tesalia'),
(41799, 41, 'Tello'),
(41801, 41, 'Teruel'),
(41807, 41, 'Timaná'),
(41872, 41, 'Villavieja'),
(41885, 41, 'Yaguará'),
(44001, 44, 'Riohacha'),
(44035, 44, 'Albania'),
(44078, 44, 'Barrancas'),
(44098, 44, 'Distracción'),
(44279, 44, 'Fonseca'),
(44378, 44, 'Hatonuevo'),
(44847, 44, 'Uribia'),
(44855, 44, 'Urumita'),
(44874, 44, 'Villanueva'),
(47001, 47, 'Santa Marta'),
(47053, 47, 'Aracataca'),
(47058, 47, 'Ariguaní'),
(47161, 47, 'Cerro San Antonio'),
(47205, 47, 'Concordia'),
(47245, 47, 'El Banco'),
(47258, 47, 'El Piñon'),
(47268, 47, 'El Retén'),
(47288, 47, 'Fundación'),
(47318, 47, 'Guamal'),
(47541, 47, 'Pedraza'),
(47551, 47, 'Pivijay'),
(47555, 47, 'Plato'),
(47605, 47, 'Remolino'),
(47675, 47, 'Salamina'),
(47703, 47, 'San Zenón'),
(47707, 47, 'Santa Ana'),
(47745, 47, 'Sitionuevo'),
(47798, 47, 'Tenerife'),
(50001, 50, 'Villavicencio'),
(50006, 50, 'Acacias'),
(50124, 50, 'Cabuyaro'),
(50223, 50, 'Cubarral'),
(50226, 50, 'Cumaral'),
(50245, 50, 'El Calvario'),
(50251, 50, 'El Castillo'),
(50313, 50, 'Granada'),
(50318, 50, 'Guamal'),
(50325, 50, 'Mapiripán'),
(52699, 52, 'Santacruz'),
(68573, 68, 'Puerto Parra'),
(68575, 68, 'Puerto Wilches');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_residuos`
--

DROP TABLE IF EXISTS `registro_residuos`;
CREATE TABLE `registro_residuos` (
  `id_registro` int(11) NOT NULL,
  `id_generador` int(11) DEFAULT NULL,
  `id_residuo` int(11) DEFAULT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `fecha_registro` date NOT NULL,
  `destino` varchar(50) DEFAULT NULL,
  `id_departamento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_residuos`
--

INSERT INTO `registro_residuos` (`id_registro`, `id_generador`, `id_residuo`, `cantidad`, `fecha_registro`, `destino`, `id_departamento`) VALUES
(1, 1, 1, 1500.50, '2024-01-15', 'Reciclaje', 25),
(2, 2, 3, 250.00, '2024-02-10', 'Disposición final', 25),
(3, 3, 2, 1200.75, '2024-03-20', 'Reciclaje', 25),
(4, 4, 4, 500.00, '2024-04-05', 'Reutilización', 25),
(5, 5, 5, 750.50, '2024-05-11', 'Disposición final', 25),
(6, 6, 1, 300.00, '2024-06-25', 'Compostaje', 25),
(7, 7, 3, 400.00, '2024-07-30', 'Tratamiento especial', 25),
(8, 8, 9, 2000.00, '2024-08-10', 'Reciclaje', 25),
(9, 9, 8, 1750.00, '2024-09-15', 'Disposición final', 25),
(10, 10, 2, 950.25, '2024-10-05', 'Reciclaje', 25),
(11, 1, 1, 150.00, '2024-01-10', 'Reciclaje', 25),
(12, 2, 2, 300.00, '2024-01-25', 'Compostaje', 25),
(13, 3, 3, 200.00, '2024-02-05', 'Disposición final', 25),
(14, 4, 4, 450.00, '2024-02-15', 'Reutilización', 25),
(15, 5, 5, 500.00, '2024-03-10', 'Tratamiento especial', 25),
(16, 6, 1, 600.00, '2024-03-25', 'Reciclaje', 25),
(17, 7, 2, 700.00, '2024-04-05', 'Compostaje', 25),
(18, 8, 3, 800.00, '2024-04-15', 'Disposición final', 25),
(19, 9, 4, 900.00, '2024-05-05', 'Reutilización', 25),
(20, 10, 5, 1000.00, '2024-05-25', 'Tratamiento especial', 25),
(21, 1, 1, 1500.00, '2024-06-10', 'Reciclaje', 25),
(22, 2, 2, 2000.00, '2024-06-25', 'Compostaje', 25),
(23, 3, 3, 2500.00, '2024-07-05', 'Disposición final', 25),
(24, 4, 4, 3000.00, '2024-07-15', 'Reutilización', 25),
(25, 5, 5, 3500.00, '2024-08-10', 'Tratamiento especial', 25),
(26, 6, 1, 4000.00, '2024-08-25', 'Reciclaje', 25),
(27, 7, 2, 4500.00, '2024-09-05', 'Compostaje', 25),
(28, 8, 3, 5000.00, '2024-09-15', 'Disposición final', 25),
(29, 9, 4, 5500.00, '2024-10-05', 'Reutilización', 25),
(30, 10, 5, 6000.00, '2024-10-25', 'Tratamiento especial', 25),
(31, 1, 1, 6500.00, '2024-11-10', 'Reciclaje', 25),
(32, 2, 2, 7000.00, '2024-11-25', 'Compostaje', 25),
(33, 3, 3, 7500.00, '2024-12-05', 'Disposición final', 25),
(34, 4, 4, 8000.00, '2024-12-15', 'Reutilización', 25),
(35, 1, 1, 1200.00, '2024-03-05', 'Reciclaje', 25),
(36, 2, 2, 450.00, '2024-03-10', 'Disposición final', 25),
(37, 3, 3, 800.00, '2024-03-15', 'Reutilización', 25),
(38, 4, 4, 600.00, '2024-03-20', 'Tratamiento especial', 25),
(39, 5, 5, 1000.00, '2024-03-25', 'Reciclaje', 25),
(40, 6, 1, 750.00, '2024-03-28', 'Disposición final', 25),
(41, 7, 2, 300.00, '2024-03-29', 'Compostaje', 25),
(42, 8, 3, 400.00, '2024-03-30', 'Reciclaje', 25),
(43, 9, 4, 950.00, '2024-03-31', 'Tratamiento especial', 25),
(44, 10, 5, 1250.00, '2024-03-31', 'Reutilización', 25),
(45, 1, 1, 1200.00, '2024-03-05', 'Reciclaje', 25),
(46, 2, 2, 450.00, '2024-03-10', 'Disposición final', 25),
(47, 3, 3, 800.00, '2024-03-15', 'Reutilización', 25),
(48, 4, 4, 600.00, '2024-03-20', 'Tratamiento especial', 25),
(49, 5, 5, 1000.00, '2024-03-25', 'Reciclaje', 25),
(50, 6, 1, 750.00, '2024-03-28', 'Disposición final', 25),
(51, 7, 2, 300.00, '2024-03-29', 'Compostaje', 25),
(52, 8, 3, 400.00, '2024-03-30', 'Reciclaje', 25),
(53, 9, 4, 950.00, '2024-03-31', 'Tratamiento especial', 25),
(54, 10, 5, 1250.00, '2024-03-31', 'Reutilización', 25),
(55, 1, 1, 1400.00, '2024-04-05', 'Reciclaje', 25),
(56, 2, 2, 500.00, '2024-04-10', 'Disposición final', 25),
(57, 3, 3, 900.00, '2024-04-15', 'Reutilización', 25),
(58, 4, 4, 700.00, '2024-04-20', 'Tratamiento especial', 25),
(59, 5, 5, 1100.00, '2024-04-25', 'Reciclaje', 25),
(60, 6, 1, 800.00, '2024-04-26', 'Disposición final', 25),
(61, 7, 2, 400.00, '2024-04-27', 'Compostaje', 25),
(62, 8, 3, 600.00, '2024-04-28', 'Reciclaje', 25),
(63, 9, 4, 1050.00, '2024-04-29', 'Tratamiento especial', 25),
(64, 10, 5, 1300.00, '2024-04-30', 'Reutilización', 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_residuos_empresas`
--

DROP TABLE IF EXISTS `registro_residuos_empresas`;
CREATE TABLE `registro_residuos_empresas` (
  `id_registro` int(11) NOT NULL,
  `id_empresa_vertedero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_residuos_empresas`
--

INSERT INTO `registro_residuos_empresas` (`id_registro`, `id_empresa_vertedero`) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(4, 3),
(5, 2),
(6, 4),
(7, 5),
(8, 3),
(9, 1),
(10, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_residuos_transporte`
--

DROP TABLE IF EXISTS `registro_residuos_transporte`;
CREATE TABLE `registro_residuos_transporte` (
  `id_registro` int(11) NOT NULL,
  `id_transporte` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_residuos_transporte`
--

INSERT INTO `registro_residuos_transporte` (`id_registro`, `id_transporte`) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(5, 2),
(6, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_tratamientos`
--

DROP TABLE IF EXISTS `registro_tratamientos`;
CREATE TABLE `registro_tratamientos` (
  `id_registro_tratamiento` int(11) NOT NULL,
  `id_registro` int(11) DEFAULT NULL,
  `id_tratamiento` int(11) DEFAULT NULL,
  `fecha_tratamiento` date NOT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_tratamientos`
--

INSERT INTO `registro_tratamientos` (`id_registro_tratamiento`, `id_registro`, `id_tratamiento`, `fecha_tratamiento`, `observaciones`) VALUES
(1, 1, 1, '2024-01-20', 'Compostaje exitoso, residuos convertidos en abono en 3 semanas.'),
(2, 2, 3, '2024-02-15', 'Incineración realizada sin incidentes, volumen de residuos peligrosos reducido en un 80%.'),
(3, 3, 2, '2024-03-25', 'Residuos inorgánicos reciclados en productos plásticos reutilizables.'),
(4, 4, 4, '2024-04-10', 'Materiales reciclables reutilizados en la universidad para nuevos proyectos estudiantiles.'),
(5, 5, 5, '2024-05-20', 'Residuos electrónicos dispuestos en relleno sanitario controlado.'),
(6, 6, 6, '2024-06-30', 'Tratamiento químico aplicado para neutralizar residuos peligrosos en el supermercado.'),
(7, 7, 7, '2024-07-05', 'Compactación de residuos completada con éxito, volumen reducido en un 50%.'),
(8, 8, 8, '2024-08-15', 'Residuos agrícolas clasificados y separados para su tratamiento.'),
(9, 9, 9, '2024-09-20', 'Tratamiento biológico aplicado a residuos orgánicos e industriales.'),
(10, 10, 10, '2024-10-10', 'Desinfección completada, residuos sanitarios eliminados sin riesgos.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `residuos`
--

DROP TABLE IF EXISTS `residuos`;
CREATE TABLE `residuos` (
  `id_residuo` int(11) NOT NULL,
  `tipo_residuo` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `residuos`
--

INSERT INTO `residuos` (`id_residuo`, `tipo_residuo`, `descripcion`) VALUES
(1, 'Orgánico', 'Residuos biodegradables provenientes de restos de comida, jardinería, etc.'),
(2, 'InorgÃ¡nico x2', 'Residuos no biodegradables, como plÃ¡sticos, metales y vidrios.x2'),
(3, 'Peligroso', 'Residuos que contienen sustancias peligrosas para la salud o el medio ambiente, como baterías, solventes, y productos químicos.'),
(4, 'Reciclable', 'Residuos que pueden ser reciclados y reutilizados, como papel, cartÃ³n, plÃ¡sticos y metales.'),
(5, 'Electrónico', 'Residuos de aparatos electrónicos y eléctricos, como teléfonos, computadoras, y electrodomésticos.'),
(6, 'Sanitario', 'Residuos generados en instalaciones de salud, como guantes, mascarillas, jeringas y otros desechos biomédicos.'),
(7, 'Construcción', 'Residuos de actividades de construcción y demolición, como escombros, madera y metales.'),
(8, 'Industrial', 'Residuos generados por actividades industriales, incluyendo productos químicos, aceites, y residuos sólidos.'),
(9, 'Agrícola', 'Residuos generados en actividades agrícolas, como restos de cultivos, fertilizantes, y plásticos de invernaderos.'),
(10, 'Sustancias Quimicas', 'Residuos generados por productos químicos.'),
(18, 'Baterias 2A', 'Baterias Pequeñas'),
(21, 'Nuevo R x10', 'Detalle Rx10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre_rol`, `descripcion`) VALUES
(1, 'Administrador', 'Gestiona el sistema, asignando roles y permisos a los demás usuarios. Supervisa el cumplimiento de normativas y asegura la integridad de los datos en la plataforma. Realiza configuraciones para la integración con sistemas externos y la generación de informes.'),
(2, 'Operador de Residuos', 'Registra los datos de recolección de residuos (tipo, cantidad, ubicación). Puede actualizar el estado de los residuos en cada etapa, desde la recolección hasta el tratamiento. A través de dispositivos móviles o aplicaciones, captura la información en campo.'),
(3, 'Auditor Ambiental', 'Accede a informes de impacto ambiental y análisis de sostenibilidad. Consulta los reportes sobre la huella de carbono y las emisiones generadas en cada proceso. Verifica el cumplimiento de normativas ambientales, evaluando las métricas de sostenibilidad.'),
(4, 'Usuario Empresarial', 'Visualiza el impacto ambiental específico de su empresa, como la huella de carbono generada. Consulta informes detallados de sostenibilidad personalizados por período o tipo de residuo. Aporta datos sobre los residuos generados y gestiona la información relativa a su propia organización.'),
(5, 'Comunidad', 'Accede a informes de sostenibilidad que reflejan los esfuerzos de la comunidad en la reducción de residuos. Recibe reportes educativos sobre el impacto de los residuos y el reciclaje en su área.'),
(7, 'Conductor', 'Conductor'),
(9, 'Conductor', 'Conductor'),
(10, 'Nuevo Rol x1', 'Gestion de Consultas'),
(11, 'Nuevo Rol x2', 'Gestion de Consultas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transporte`
--

DROP TABLE IF EXISTS `transporte`;
CREATE TABLE `transporte` (
  `id_transporte` int(11) NOT NULL,
  `nombre_empresa` varchar(100) DEFAULT NULL,
  `tipo_transporte` varchar(50) DEFAULT NULL,
  `placa` varchar(10) DEFAULT NULL,
  `contacto` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `transporte`
--

INSERT INTO `transporte` (`id_transporte`, `nombre_empresa`, `tipo_transporte`, `placa`, `contacto`) VALUES
(1, 'Transporte Ambiental', 'Camión', 'ABC123', 'contacto@transporte.com'),
(2, 'Logística Verde', 'Furgoneta', 'DEF456', 'contacto@logisticaverde.com'),
(3, 'EcoMovil', 'Camión', 'GHI789', 'contacto@ecomovil.com'),
(5, 'Transportes del Norte', 'Camión', 'JKL123', 'contacto@transportesdelnorte.com'),
(6, 'Nuevo Transporte x1', 'Camion', 'ABC124', 'Nuevo Contacto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamiento_residuos`
--

DROP TABLE IF EXISTS `tratamiento_residuos`;
CREATE TABLE `tratamiento_residuos` (
  `id_tratamiento` int(11) NOT NULL,
  `nombre_tratamiento` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `responsable` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tratamiento_residuos`
--

INSERT INTO `tratamiento_residuos` (`id_tratamiento`, `nombre_tratamiento`, `descripcion`, `responsable`) VALUES
(1, 'Compostaje', 'Proceso de descomposición de residuos orgánicos para producir abono natural.', 1),
(2, 'Reciclaje', 'Proceso de transformación de residuos inorgánicos en nuevos productos reutilizables.', 2),
(3, 'Incineración', 'Quema de residuos peligrosos a altas temperaturas para reducir su volumen y peligrosidad.', 3),
(4, 'Reutilización', 'Uso de residuos reciclables en otros procesos o como materia prima secundaria.', 4),
(5, 'Disposición final en relleno sanitario', 'Deposición de residuos en un relleno sanitario controlado.', 5),
(6, 'Tratamiento químico', 'Aplicación de productos químicos para neutralizar residuos peligrosos.', 6),
(7, 'Compactación', 'Reducción del volumen de residuos mediante compactación mecánica.', 7),
(8, 'Separación y clasificación', 'Separación de residuos por tipo para facilitar su reciclaje o tratamiento adecuado.', 8),
(9, 'Tratamiento biológico', 'Uso de microorganismos para descomponer residuos orgánicos y peligrosos.', 9),
(10, 'Desinfección', 'Eliminación de agentes patógenos en residuos sanitarios para prevenir riesgos a la salud.', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_user` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `foto_url` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `cargo` varchar(100) DEFAULT NULL,
  `profesion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password_user`, `fecha_creacion`, `estado`, `foto_url`, `telefono`, `cargo`, `profesion`) VALUES
(1, 'Carlos Díaz', 'carlos.diaz01@example.com', 'new_password123', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(2, 'Ana Gomez', 'ana.gomez@example.com', 'password2', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_ana.jpg', '3001234568', 'Analista de Residuos', 'Química'),
(3, 'Juan Martinez', 'juan.martinez@example.com', 'password3', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_juan.jpg', '3001234569', 'Técnico de Campo', 'Agronomía'),
(4, 'Maria Rodriguez', 'maria.rodriguez@example.com', 'password4', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_maria.jpg', '3001234570', 'Coordinadora de Sustentabilidad', 'Ecología'),
(5, 'Luis Torres', 'luis.torres@example.com', 'password5', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_luis.jpg', '3001234571', 'Ingeniero Ambiental', 'Ingeniería Ambiental'),
(6, 'Sofia Herrera', 'sofia.herrera@example.com', 'password6', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_sofia.jpg', '3001234572', 'Especialista en Reciclaje', 'Gestión Ambiental'),
(7, 'Jorge Ramirez', 'jorge.ramirez@example.com', 'password7', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_jorge.jpg', '3001234573', 'Técnico de Laboratorio', 'Biología'),
(8, 'Laura Fernandez', 'laura.fernandez@example.com', 'password8', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_laura.jpg', '3001234574', 'Analista de Sostenibilidad', 'Ciencias Ambientales'),
(9, 'Miguel Vargas', 'miguel.vargas@example.com', 'password9', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_miguel.jpg', '3001234575', 'Coordinador de Campo', 'Forestal'),
(10, 'Elena Ortiz', 'elena.ortiz@example.com', 'password10', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_elena.jpg', '3001234576', 'Consultora Ambiental', 'Derecho Ambiental'),
(12, 'Juan Perez', 'juan.perez@example.com', '$2b$12$pFfrz/JX6bXsR/wVf6awbu8y28UhlfkQGNU5Zh47.n.', '2024-11-08 05:00:00', 'activo', 'http://example.com/foto_juan.jpg', '3001234567', 'Analista de Datos', 'Ingeniería de Sistemas'),
(13, 'Juan Perez', 'juan01.perez@example.com', '$2b$12$aOBDtY23limYRF7koyHefOhZT8CmRn7yDB/uEkMwkE2', '2024-11-08 05:00:00', 'activo', 'http://example.com/foto_juan.jpg', '3001234567', 'Analista de Datos', 'Ingeniería de Sistemas'),
(14, 'Alex Vacca', 'alex@example.com', '$5$rounds=535000$bQytoNORab7ncx5g$F4MgzNzYWMAlfyo4', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(15, 'Alex Vacca', 'alex01@example.com', '$5$rounds=535000$lxEl0jJx/25v5JaH$PbfU.70PlGcKL1rA', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(16, 'Alex Vacca x2', 'alex001@example.com', '$2b$12$koTa3bLgCA.oLDLfwvqsWuvRUjSD0.U0kVVVXT1M8fu', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(17, 'Alex Vacca x3', 'alex0001@example.com', '$2b$12$ylfsUa87eLL42SO1Hc5USeREOlYbzbduGFbasRzpuuO', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(18, 'Alex Vacca x3', 'n01@example.com', '$2b$12$8pzQr8rW1PWNrEMMDNhC6.TF8htSIDwo5KANn5ky/qq', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(19, 'Alex Vacca x3', 'n02@example.com', '$2b$12$Y/CYQhnfHPxWPB5awASASDASDASDASDASDmVp.s/p6qUIYKqwtCFv4b1hNLAAAAASDASDASDASDASD', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(20, 'Alex Vacca x3', 'n04@example.com', '$2b$12$Y/CYQhnfHPxWPB5awASASDASDASDASDASDmVp.s/p6qUIYKqwtCFv4b1hNLAAAAASDASDASDASDASD', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(21, 'Alex Vacca x3', 'n05@example.com', '$2b$12$1WzVPMvBP1AMxSFpkMSb9.GZsC7A84e3mPKMctX5TNT', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(22, 'Alex Vacca x3', 'n06@example.com', '$2b$12$yWHtcAQkw0R14Z2I4cWOReQu4C.4Ru.FkwrGpN/GSpf', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(23, 'Alex Vacca x3', 'n07@example.com', '$2b$12$J35LJ.dujV31KaTOHN1W..abLlf./GTTjfiVi7QqIlYk5JP01bg52', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(24, 'Alex Vacca x3', 'n08@example.com', '$2b$12$QHd7Q9X.2SkSGliFtg.w/..ITAzBLWXUAiUvzLqINE0ujK6zUkF8C', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(25, 'Alex Vacca x4', 'alexv@example.com', '$2b$12$Neg12kltfuSv6XOnE6rvse.wAJX3Cq9y8qkdvDgn1Aa', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(26, 'Alex Vacca x5', 'alexv01@example.com', '$2b$12$nemQNKLoFS6w.Q/5CSVu7eDezOWaX0i8WoPO0WZ76y4KMsNIl.ZTu', '2024-11-08 00:36:18', 'activo', 'http://example.com/foto_carlos.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(27, '', 'nuevo@registro.com', '$2b$12$D5D7c.wbPozn7yFriVYPOOsB33BejnoBdObZxss8q3zDZ3PWO2r9C', '2024-11-08 00:36:18', 'inactivo', '', '', '', ''),
(28, '', 'mariadiaz@mail.com', '$2b$12$rNpuqZD6zSKzu94arB0m7.KraeFvieHiPt9sB4GnjdJnoQ9z2N8QG', '2024-11-08 00:36:18', 'inactivo', '', '', '', ''),
(29, '', 'pedroperez@mail.com', '$2b$12$kVmhjRJWuRHScErj6QEaYOmfnr80AfXWUP0U7UMso9ehT09R7jrsi', '2024-11-08 00:36:18', 'inactivo', '', '', '', ''),
(30, '', 'juanes@mail.com', '$2b$12$MCBqBsz4QsWiKxQRdFO8YuT7Wa4VxAWb8Vw2vdUxHnt7ucBt8bjOu', '2024-11-28 00:20:01', 'inactivo', '', '', '', ''),
(31, '', 'aleja@mail.com', '$2b$12$ySyVmAxbu4YF.bxYjQCZMeFXpsY8zR4fGacQN1DuM7oSh/K.ZWxrW', '2024-11-28 00:21:42', 'inactivo', '', '', '', ''),
(32, '', 'gabo@mail.com', '$2b$12$B72bi8S0jTXaosjQJCrCd.r0om3QnfQ0lF9IXIevB0dxr.31d/S8.', '2024-11-28 00:45:09', 'inactivo', '', '', '', ''),
(33, 'Valentina Castro', 'vale@mail.com', '$2b$12$LnDdwO79kwTdpWDp23R0zuG41wWXgDqxE1Ybuk6rnOcWTd6bzO0N2', '2024-11-08 00:36:18', 'activo', 'https://klik.mx/wp-content/uploads/2023/06/Retrato-Corporativo.jpg', '3001234567', 'Ingeniero de Campo', 'Ingeniería Ambiental'),
(34, '', 'marcela@mail.com', '$2b$12$tbTaVTxQXcC2m9XR5tl5PuLo2g.Kaw9CtP8uyRNDj80Mc01zq19Gq', '2024-11-28 01:52:56', 'inactivo', '', '', '', ''),
(35, '', 'pablito@mail.com', '$2b$12$FymxxvYQA2jWY8eXu9x7ouJ0IcS7invs0HWISENVgIeUUDzvRSpF2', '2024-11-28 23:28:03', 'inactivo', '', '', '', ''),
(36, '', 'pedrito@mail.com', '$2b$12$V/ojx8wG0C4hVMp3xIyIfO83beOgWbUJ7KaPx53gq6uDrCdqIFvvq', '2024-11-29 00:27:26', 'inactivo', '', '', '', ''),
(37, '', 'alexa@mail.com', '$2b$12$ANIdpgKWzqoWmj2gkwr1iux825Cbj/WDYINC2SdlRRNPWs6j2GoFK', '2024-11-29 13:51:12', 'activo', '', '', '', ''),
(38, '', 'julio@mail.com', '$2b$12$2Cs28jMUPS6UlAxdE3stC.TZOvFbm8t0oNTyXDwWYk3zYI5WjdmNW', '2024-11-30 01:06:30', 'inactivo', '', '', '', ''),
(39, '', 'felipe@mail.com', '$2b$12$tyI3AWDvOcSLupgQKvflC.BCkL2SCcH/PmyOuaQPmFYPmmbEUYdTq', '2024-11-30 01:07:14', 'inactivo', '', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_roles`
--

DROP TABLE IF EXISTS `usuarios_roles`;
CREATE TABLE `usuarios_roles` (
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios_roles`
--

INSERT INTO `usuarios_roles` (`id_usuario`, `id_rol`) VALUES
(1, 1),
(2, 2),
(2, 4),
(3, 3),
(4, 4),
(5, 5),
(6, 2),
(7, 2),
(7, 3),
(8, 4),
(9, 5),
(10, 1),
(10, 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id_departamento`);

--
-- Indices de la tabla `empresas_reciclaje_vertederos`
--
ALTER TABLE `empresas_reciclaje_vertederos`
  ADD PRIMARY KEY (`id_empresa_vertedero`),
  ADD KEY `id_departamento` (`id_departamento`);

--
-- Indices de la tabla `generadores_residuo`
--
ALTER TABLE `generadores_residuo`
  ADD PRIMARY KEY (`id_generador`),
  ADD KEY `ubicacion` (`ubicacion`);

--
-- Indices de la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD PRIMARY KEY (`id_municipio`),
  ADD KEY `id_departamento` (`id_departamento`);

--
-- Indices de la tabla `registro_residuos`
--
ALTER TABLE `registro_residuos`
  ADD PRIMARY KEY (`id_registro`),
  ADD KEY `id_generador` (`id_generador`),
  ADD KEY `id_residuo` (`id_residuo`),
  ADD KEY `id_departamento` (`id_departamento`);

--
-- Indices de la tabla `registro_residuos_empresas`
--
ALTER TABLE `registro_residuos_empresas`
  ADD PRIMARY KEY (`id_registro`,`id_empresa_vertedero`),
  ADD KEY `id_empresa_vertedero` (`id_empresa_vertedero`);

--
-- Indices de la tabla `registro_residuos_transporte`
--
ALTER TABLE `registro_residuos_transporte`
  ADD PRIMARY KEY (`id_registro`,`id_transporte`),
  ADD KEY `id_transporte` (`id_transporte`);

--
-- Indices de la tabla `registro_tratamientos`
--
ALTER TABLE `registro_tratamientos`
  ADD PRIMARY KEY (`id_registro_tratamiento`),
  ADD KEY `id_registro` (`id_registro`),
  ADD KEY `id_tratamiento` (`id_tratamiento`);

--
-- Indices de la tabla `residuos`
--
ALTER TABLE `residuos`
  ADD PRIMARY KEY (`id_residuo`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `transporte`
--
ALTER TABLE `transporte`
  ADD PRIMARY KEY (`id_transporte`);

--
-- Indices de la tabla `tratamiento_residuos`
--
ALTER TABLE `tratamiento_residuos`
  ADD PRIMARY KEY (`id_tratamiento`),
  ADD KEY `responsable` (`responsable`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `usuarios_roles`
--
ALTER TABLE `usuarios_roles`
  ADD PRIMARY KEY (`id_usuario`,`id_rol`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id_departamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT de la tabla `empresas_reciclaje_vertederos`
--
ALTER TABLE `empresas_reciclaje_vertederos`
  MODIFY `id_empresa_vertedero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `generadores_residuo`
--
ALTER TABLE `generadores_residuo`
  MODIFY `id_generador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `municipios`
--
ALTER TABLE `municipios`
  MODIFY `id_municipio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68576;

--
-- AUTO_INCREMENT de la tabla `registro_residuos`
--
ALTER TABLE `registro_residuos`
  MODIFY `id_registro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de la tabla `registro_tratamientos`
--
ALTER TABLE `registro_tratamientos`
  MODIFY `id_registro_tratamiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `residuos`
--
ALTER TABLE `residuos`
  MODIFY `id_residuo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `transporte`
--
ALTER TABLE `transporte`
  MODIFY `id_transporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tratamiento_residuos`
--
ALTER TABLE `tratamiento_residuos`
  MODIFY `id_tratamiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `empresas_reciclaje_vertederos`
--
ALTER TABLE `empresas_reciclaje_vertederos`
  ADD CONSTRAINT `empresas_reciclaje_vertederos_ibfk_1` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id_departamento`);

--
-- Filtros para la tabla `generadores_residuo`
--
ALTER TABLE `generadores_residuo`
  ADD CONSTRAINT `generadores_residuo_ibfk_1` FOREIGN KEY (`ubicacion`) REFERENCES `municipios` (`id_municipio`);

--
-- Filtros para la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD CONSTRAINT `municipios_ibfk_1` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id_departamento`);

--
-- Filtros para la tabla `registro_residuos`
--
ALTER TABLE `registro_residuos`
  ADD CONSTRAINT `registro_residuos_ibfk_1` FOREIGN KEY (`id_generador`) REFERENCES `generadores_residuo` (`id_generador`),
  ADD CONSTRAINT `registro_residuos_ibfk_2` FOREIGN KEY (`id_residuo`) REFERENCES `residuos` (`id_residuo`),
  ADD CONSTRAINT `registro_residuos_ibfk_3` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id_departamento`);

--
-- Filtros para la tabla `registro_residuos_empresas`
--
ALTER TABLE `registro_residuos_empresas`
  ADD CONSTRAINT `registro_residuos_empresas_ibfk_1` FOREIGN KEY (`id_registro`) REFERENCES `registro_residuos` (`id_registro`),
  ADD CONSTRAINT `registro_residuos_empresas_ibfk_2` FOREIGN KEY (`id_empresa_vertedero`) REFERENCES `empresas_reciclaje_vertederos` (`id_empresa_vertedero`);

--
-- Filtros para la tabla `registro_residuos_transporte`
--
ALTER TABLE `registro_residuos_transporte`
  ADD CONSTRAINT `registro_residuos_transporte_ibfk_1` FOREIGN KEY (`id_registro`) REFERENCES `registro_residuos` (`id_registro`),
  ADD CONSTRAINT `registro_residuos_transporte_ibfk_2` FOREIGN KEY (`id_transporte`) REFERENCES `transporte` (`id_transporte`);

--
-- Filtros para la tabla `registro_tratamientos`
--
ALTER TABLE `registro_tratamientos`
  ADD CONSTRAINT `registro_tratamientos_ibfk_1` FOREIGN KEY (`id_registro`) REFERENCES `registro_residuos` (`id_registro`),
  ADD CONSTRAINT `registro_tratamientos_ibfk_2` FOREIGN KEY (`id_tratamiento`) REFERENCES `tratamiento_residuos` (`id_tratamiento`);

--
-- Filtros para la tabla `tratamiento_residuos`
--
ALTER TABLE `tratamiento_residuos`
  ADD CONSTRAINT `tratamiento_residuos_ibfk_1` FOREIGN KEY (`responsable`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `usuarios_roles`
--
ALTER TABLE `usuarios_roles`
  ADD CONSTRAINT `usuarios_roles_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `usuarios_roles_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
