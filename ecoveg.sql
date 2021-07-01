-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-06-2021 a las 02:49:55
-- Versión del servidor: 10.4.13-MariaDB
-- Versión de PHP: 7.2.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ecoveg`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_actualizar_empresa` (IN `_nombre` VARCHAR(300), IN `_direccion` VARCHAR(300), IN `_rnc` VARCHAR(20), IN `_telefono` VARCHAR(50), IN `_fondo` INT, IN `_logo` VARCHAR(300))  NO SQL
UPDATE empresa SET nombre_empresa = _nombre, direccion_empresa = _direccion, rnc_empresa = _rnc, telefono_empresa = _telefono, fondo_caja = _fondo, logo_empresa = _logo WHERE id = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscar_producto_codigo` (IN `_codigo` VARCHAR(50))  NO SQL
SELECT * FROM productos WHERE codigo = _codigo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_imprimir_cotizacion` (IN `_id_cotizacion` INT)  NO SQL
SELECT cotizaciones.id_cotizacion, cotizaciones.productos, cotizaciones.neto, cotizaciones.impuesto, cotizaciones.total, cotizaciones.fecha, clientes.nombre AS nombre_cliente, clientes.id, usuarios.nombre AS nombre_vendedor FROM cotizaciones INNER JOIN clientes ON cotizaciones.id_cliente = clientes.id

INNER JOIN usuarios ON cotizaciones.id_vendedor = usuarios.id WHERE cotizaciones.id_cotizacion = _id_cotizacion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_insertar_cotizacion` (IN `_id_vendedor` INT, IN `_id_cliente` INT, IN `_productos` TEXT, IN `_neto` DOUBLE, IN `_impuesto` DOUBLE, IN `_total` DOUBLE)  NO SQL
INSERT INTO cotizaciones (id_vendedor, id_cliente, productos, neto, impuesto, total) VALUES (_id_vendedor, _id_cliente, _productos, _neto, _impuesto, _total)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_produccion` (IN `_descripcion` VARCHAR(500), IN `_inversion_inicial` DOUBLE, IN `_fechaInicio` DATE)  INSERT INTO producciones (descripcion_produccion, inversion_inicial, fecha_inicio, estado) 
VALUES(_descripcion, _inversion_inicial, _fechaInicio, 'Activo')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Listar_Tipo_Comprobantes` ()  BEGIN 

select * FROM tipo_comprobante;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MostrarEmpresa` ()  NO SQL
SELECT * FROM empresa$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_mostrar_cotizaciones` ()  NO SQL
SELECT * FROM cotizaciones ORDER BY id_cotizacion DESC LIMIT 100$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_sucursales` ()  NO SQL
SELECT * FROM sucursales$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_suc_acceso` (IN `_id_usuario` INT)  NO SQL
SELECT s.*, u.nombre, u.foto, u.perfil, a.* FROM sucursales s, usuarios u, acceso_sucursales a WHERE s.suc_id = a.id_sucursal AND u.id = a.id_usuario AND a.estado = 1 AND a.id_usuario = _id_usuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_acceso` (IN `_usuario` INT, IN `_sucursal` INT)  NO SQL
INSERT INTO acceso_sucursales (id_usuario, id_sucursal) VALUES (_usuario, _sucursal)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Empresa` (IN `_nombre_empresa` VARCHAR(250), IN `_logo_empresa` VARCHAR(200), IN `_direccion_empresa` VARCHAR(300), IN `_rnc_empresa` VARCHAR(15), IN `_telefono_empresa` VARCHAR(30))  NO SQL
UPDATE empresa SET nombre_empresa = _nombre_empresa, logo_empresa = _logo_empresa, direccion_empresa = _direccion_empresa, rnc_empresa = _rnc_empresa, telefono_empresa = _telefono_empresa$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acceso_sucursales`
--

CREATE TABLE `acceso_sucursales` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `acceso_sucursales`
--

INSERT INTO `acceso_sucursales` (`id`, `id_usuario`, `id_sucursal`, `estado`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 4, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja`
--

CREATE TABLE `caja` (
  `id` int(11) NOT NULL,
  `fondo_de_caja` float NOT NULL,
  `ventas_del_dia` float NOT NULL,
  `ventas_credito` double NOT NULL,
  `ventas_efectivo` double NOT NULL,
  `ventas_tarjeta` double NOT NULL,
  `salidas` float NOT NULL,
  `diferencia` float NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `caja`
--

INSERT INTO `caja` (`id`, `fondo_de_caja`, `ventas_del_dia`, `ventas_credito`, `ventas_efectivo`, `ventas_tarjeta`, `salidas`, `diferencia`, `fecha`) VALUES
(1, 1000, 3045, 0, 0, 0, 800, 245, '2019-12-02 19:17:38'),
(2, 1000, 0, 0, 0, 0, 0, 0, '2020-07-19 00:34:02'),
(3, 1000, 0, 0, 0, 0, 0, 0, '2021-02-05 22:33:46'),
(4, 2006, 0, 0, 0, 0, 0, 0, '2021-04-12 21:39:53'),
(5, 2000, 8719, 0, 0, 0, 4420, 6299, '2021-04-18 19:38:56'),
(6, 2010, 0, 0, 0, 0, 0, 0, '2021-04-23 22:00:27'),
(7, 2055, 663, 0, 0, 0, 0, 2718, '2021-04-24 21:08:42'),
(8, 2071, 0, 0, 0, 0, 0, 0, '2021-04-26 21:35:43'),
(9, 2014, 2681, 0, 0, 0, 0, 4695, '2021-04-28 21:41:38'),
(10, 2000, 0, 0, 0, 0, 0, 0, '2021-04-29 21:48:24'),
(11, 2004, 0, 0, 0, 0, 0, 0, '2021-04-30 23:06:37'),
(12, 2002, 0, 0, 0, 0, 0, 0, '2021-05-01 21:07:28'),
(13, 2000, 0, 0, 0, 0, 0, 0, '2021-05-02 18:58:43'),
(14, 2004, 0, 0, 0, 0, 0, 0, '2021-05-03 21:35:07'),
(15, 2033, 714, 0, 0, 0, 30, 2337, '2021-05-05 21:43:13'),
(16, 2008, 8861, 0, 0, 0, 300, 10569, '2021-05-06 21:59:33'),
(17, 1985, 0, 0, 0, 0, 0, 0, '2021-05-07 15:09:23'),
(18, 2015, 0, 0, 0, 0, 0, 0, '2021-05-09 14:41:59'),
(19, 2014, 0, 0, 0, 0, 0, 0, '2021-05-10 12:36:04'),
(20, 2004, 0, 0, 0, 0, 0, 0, '2021-05-12 12:23:16'),
(21, 2000, 0, 0, 0, 0, 0, 0, '2021-05-13 12:20:08'),
(22, 2002, 0, 0, 0, 0, 0, 0, '2021-05-14 12:17:43'),
(23, 2085, 0, 0, 0, 0, 0, 0, '2021-05-20 12:27:32'),
(24, 2000, 0, 0, 0, 0, 0, 0, '2021-05-21 12:17:40'),
(25, 2000, 0, 0, 0, 0, 0, 0, '2021-05-23 15:16:29'),
(26, 2000, 0, 0, 0, 0, 0, 0, '2021-05-24 13:30:48'),
(27, 2000, 0, 0, 0, 0, 0, 0, '2021-05-26 13:03:47'),
(28, 2000, 0, 0, 0, 0, 0, 0, '2021-05-27 20:35:04'),
(29, 2000, 0, 0, 0, 0, 0, 0, '2021-05-28 18:05:48'),
(30, 2000, 0, 0, 0, 0, 0, 0, '2021-05-29 13:57:02'),
(31, 2000, 0, 0, 0, 0, 0, 0, '2021-05-30 13:10:37'),
(32, 2000, 0, 0, 0, 0, 0, 0, '2021-05-31 20:22:59'),
(33, 2000, 0, 0, 0, 0, 0, 0, '2021-06-02 18:23:26'),
(34, 2000, 0, 0, 0, 0, 0, 0, '2021-06-03 13:09:03'),
(35, 2000, 0, 0, 0, 0, 0, 0, '2021-06-05 13:57:00'),
(36, 2000, 0, 0, 0, 0, 0, 0, '2021-06-06 13:57:35'),
(37, 2000, 0, 0, 0, 0, 0, 0, '2021-06-07 13:06:48'),
(38, 2000, 0, 0, 0, 0, 0, 0, '2021-06-09 21:32:15'),
(39, 2585, 0, 0, 0, 0, 0, 0, '2021-06-10 13:12:27'),
(40, 1918, 299, 0, 234, 0, 0, 2552, '2021-06-11 21:47:43'),
(41, 2000, 0, 0, 0, 0, 0, 0, '2021-06-12 14:40:05'),
(42, 2000, 0, 0, 0, 0, 0, 0, '2021-06-13 14:22:47'),
(43, 1930, 0, 0, 0, 0, 0, 0, '2021-06-14 21:26:09'),
(44, 1950, 0, 0, 0, 0, 0, 0, '2021-06-16 13:29:28'),
(45, 2000, 0, 0, 0, 0, 0, 0, '2021-06-17 13:18:45'),
(46, 2000, 0, 0, 0, 0, 0, 0, '2021-06-18 12:30:04'),
(47, 2000, 401, 0, 401, 0, 100, 2301, '2021-06-19 21:03:12'),
(48, 2301, 0, 0, 0, 0, 0, 0, '2021-06-20 13:27:00'),
(49, 2000, 0, 0, 0, 0, 0, 0, '2021-06-21 14:47:58'),
(50, 2000, 0, 0, 0, 0, 0, 0, '2021-06-23 12:16:34'),
(51, 2000, 0, 0, 0, 0, 0, 0, '2021-06-24 12:26:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `categoria` text COLLATE utf8_spanish_ci NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `categoria`, `fecha`) VALUES
(1, 'Vegetales ', '2021-04-11 16:21:40'),
(2, 'Frutas', '2021-04-11 16:21:48'),
(3, 'Especias', '2021-04-11 16:22:03'),
(5, 'Hierbas Aromaticas', '2021-04-11 18:14:53'),
(6, 'Tuberculo', '2021-04-11 19:04:43'),
(7, 'Bebidas', '2021-04-11 19:34:49'),
(8, 'Leguminosas', '2021-04-11 19:47:41'),
(9, 'Frutos Secos', '2021-04-15 13:19:48'),
(10, 'Envio', '2021-04-28 13:48:07'),
(11, 'Otros', '2021-05-17 18:44:41'),
(12, 'Semillas Organicas', '2021-05-29 15:27:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `tipo_cliente` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `documento` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `email` text COLLATE utf8_spanish_ci NOT NULL,
  `telefono` text COLLATE utf8_spanish_ci NOT NULL,
  `direccion` text COLLATE utf8_spanish_ci NOT NULL,
  `compras` int(11) NOT NULL,
  `ultima_compra` datetime NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `tipo_cliente`, `nombre`, `documento`, `email`, `telefono`, `direccion`, `compras`, `ultima_compra`, `fecha`) VALUES
(1, 'mayorista', 'Pedro Santana de León', '224-0035917-4', 'thepeca@gmail.com', '(809) 878-9878', 'Herrera, Santo Domingo Oeste', 46, '0000-00-00 00:00:00', '2021-06-04 03:08:08'),
(2, 'Consumidor final', 'Juan Santos de Los Santos', '224-0035917-7', 'juan@hotmail.com', '(849) 626-8540', 'Calle Prolongacion 27 de Febrero # 4-A, Las Caobas', 55, '2020-09-25 02:01:24', '2021-05-14 14:05:46'),
(3, 'mayorista', 'Tito Fuente', '001232343445', 'tito@hotmail.com', '(809) 678-6567', 'Calle Principal NO. 5, Herrera', -190, '2019-10-11 13:39:20', '2021-05-06 15:47:22'),
(4, 'mayorista', 'Luis Manuel Guichardo', '1312323432', 'guichardo@gmail.com', '(809) 676-5654', 'Calle Central NO. 5, Las Mercedes', 0, '0000-00-00 00:00:00', '2021-03-14 17:55:40'),
(5, 'consumidor', 'Liliana Quezada', '402-2121935-1', 'liliana.q.a@hotmail.com', '(809) 903-3139', 'Constanza', -20, '2021-05-16 11:59:53', '2021-05-17 20:26:19'),
(6, 'mayorista', 'Marcos Abud', '00000000000', '', '(829) 871-0867', 'Constanza', 230, '2021-05-06 11:47:23', '2021-05-06 15:47:23'),
(7, 'mayorista', 'ALTO CERRO VILLAS Y APARTAHOTEL SRL', '101-71873-2', '', '(849) 886-7103', 'Constanza', 0, '0000-00-00 00:00:00', '2021-04-18 16:06:56'),
(8, 'Seleccione tipo', 'Amy s Pasteleria', '000000000', '', '', 'Constanza', -16, '2021-05-19 12:12:14', '2021-05-19 15:27:43'),
(10, 'mayorista', 'Vegetales en casa', '00000000000', 'chencopina@gmail.com', '(809) 669-1090', 'Constanza', 326, '2021-06-11 18:42:15', '2021-06-14 21:16:07'),
(11, 'mayorista', 'Melfry', '00000000000', 'liliana.q.a@hotmail.com', '', 'Constanza', 0, '0000-00-00 00:00:00', '2021-06-02 21:37:23'),
(12, 'mayorista', 'EXCOVEG SRL', '131-885-543', 'info@excoveg.com', '(809) 748-3113', 'Constanza', 1118, '2021-05-15 18:18:29', '2021-05-15 22:18:29'),
(13, 'consumidor', 'Daniela Piña', '00000000000', 'fjnbjghkkgf@fjfvvhb', '(850) 222-2525', 'Constanza', 0, '0000-00-00 00:00:00', '2021-04-25 19:15:56'),
(14, 'consumidor', 'Lidia Aquino', '00000000000', 'liliana.q.a@hotmail.com', '', 'Constanza', -36, '2021-06-23 11:25:55', '2021-06-23 14:42:31'),
(15, 'consumidor', 'Osmayra Martinez', '00000000000', 'liliana.q.a@hotmail.com', '(829) 810-3759', 'Jarabacoa', 0, '0000-00-00 00:00:00', '2021-04-28 13:50:31'),
(16, 'mayorista', 'La Esquina Gastro Bar', '000000000', 'liliana.q.a@hotmail.com', '(809) 539-1711', 'Constanza', -3, '2021-05-12 15:22:29', '2021-05-12 19:43:33'),
(17, 'consumidor', 'Hancell', '00000000000', 'fjnbjghkkgf@fjfvvhb', '(849) 750-9864', 'Constanza', 0, '0000-00-00 00:00:00', '2021-05-15 19:23:52'),
(18, 'consumidor', 'Sandra Vega', '00000000000', 'liliana.q.a@hotmail.com', '(809) 986-0748', 'Constanza', 0, '0000-00-00 00:00:00', '2021-05-15 21:01:00'),
(19, 'consumidor', 'Randy Q', '00000000000', 'fjnbjghkkgf@fjfvvhb', '(849) 851-8430', 'Constanza', 0, '0000-00-00 00:00:00', '2021-05-30 13:48:32'),
(20, 'mayorista', 'Mario', '00000000000', '', '', 'Constanza', 0, '0000-00-00 00:00:00', '2021-06-01 13:20:43'),
(21, 'consumidor', 'Caonabo Quezada', '00000000000', 'vegetalesquezada@gmail.com', '(809) 519-9161', 'Constanza', 0, '0000-00-00 00:00:00', '2021-06-12 15:22:06'),
(22, 'consumidor', 'Hermanas del Perpetuo Socorro', '00000000000', '', '', 'Constanza', 0, '0000-00-00 00:00:00', '2021-06-23 15:51:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobro_creditos`
--

CREATE TABLE `cobro_creditos` (
  `id` int(11) NOT NULL,
  `factura` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `pagado` double NOT NULL,
  `restante` double NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `cobro_creditos`
--

INSERT INTO `cobro_creditos` (`id`, `factura`, `pagado`, `restante`, `id_cliente`, `fecha`) VALUES
(1, '10324', 500, 119, 14, '2021-05-29 15:55:15'),
(2, '10304', 676.5, 0, 18, '2021-05-31 14:13:53'),
(3, '10400', 445, 0, 14, '2021-06-11 14:01:27'),
(4, '10388', 55, 40.5, 14, '2021-06-11 14:02:28'),
(5, '10388', 41, -0.5, 14, '2021-06-17 18:00:24'),
(6, '10244', 65, 145, 11, '2021-06-18 19:49:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `codigo_factura` text COLLATE utf8_spanish_ci NOT NULL,
  `productos` text COLLATE utf8_spanish_ci NOT NULL,
  `impuesto` float NOT NULL,
  `neto` float NOT NULL,
  `total` float NOT NULL,
  `metodo_pago` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `dias` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id`, `id_proveedor`, `codigo_factura`, `productos`, `impuesto`, `neto`, `total`, `metodo_pago`, `dias`, `estado`, `fecha`) VALUES
(3, 9, '7072', '[{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"50\",\"stock\":\"4850\",\"precio\":\"45\",\"total\":\"2250\"}]', 0, 2, 2250, '', '', 1, '2021-05-22 18:41:29'),
(4, 10, '1', '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"23\",\"stock\":\"6623\",\"precio\":\"35\",\"total\":\"805\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"200\",\"stock\":\"29200\",\"precio\":\"7\",\"total\":\"1400\"}]', 0, 2, 0, '', '', 1, '2021-05-22 18:55:09'),
(5, 11, '1', '[{\"id\":\"139\",\"descripcion\":\"Granola Paq\",\"cantidad\":\"3\",\"stock\":\"6\",\"precio\":\"70\",\"total\":\"210\"},{\"id\":\"140\",\"descripcion\":\"Granola Funda\",\"cantidad\":\"2\",\"stock\":\"4\",\"precio\":\"250\",\"total\":\"500\"},{\"id\":\"141\",\"descripcion\":\"Granola sobre\",\"cantidad\":\"6\",\"stock\":\"12\",\"precio\":\"50\",\"total\":\"300\"},{\"id\":\"142\",\"descripcion\":\"Mixto Paq\",\"cantidad\":\"3\",\"stock\":\"4\",\"precio\":\"110\",\"total\":\"330\"}]', 0, 1, 1340, 'Credito', '5', 1, '2021-05-26 14:55:48'),
(6, 4, '10', '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"85\",\"stock\":\"103\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"130\",\"descripcion\":\"Tomate ensalada 2da\",\"cantidad\":\"30\",\"stock\":\"30\",\"precio\":\"5\",\"total\":\"150\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"55\",\"stock\":\"76\",\"precio\":\"12\",\"total\":\"660\"}]', 0, 835, 835, 'Credito', '7', 1, '2021-05-26 20:20:22'),
(7, 2, '2', '[{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"5.5\",\"stock\":\"15.5\",\"precio\":\"75\",\"total\":\"412.5\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"28\",\"stock\":\"41\",\"precio\":\"15\",\"total\":\"420\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"36\",\"stock\":\"57\",\"precio\":\"20\",\"total\":\"720\"},{\"id\":\"17\",\"descripcion\":\"Remolacha\",\"cantidad\":\"6\",\"stock\":\"7\",\"precio\":\"10\",\"total\":\"60\"},{\"id\":\"51\",\"descripcion\":\"Zucchini\",\"cantidad\":\"25\",\"stock\":\"33\",\"precio\":\"15\",\"total\":\"375\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"10\",\"stock\":\"31\",\"precio\":\"200\",\"total\":\"200\"}]', 0, 1, 0, 'Efectivo', '0', 1, '2021-05-27 21:37:04'),
(8, 4, '2', '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"50\",\"stock\":\"149\",\"precio\":\"38\",\"total\":\"1900\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"25\",\"stock\":\"94\",\"precio\":\"13\",\"total\":\"325\"}]', 0, 1, 0, 'Credito', '', 1, '2021-05-27 21:38:20'),
(9, 2, '7776', '[{\"id\":\"17\",\"descripcion\":\"Remolacha\",\"cantidad\":\"3\",\"stock\":\"10\",\"precio\":\"10\",\"total\":\"30\"},{\"id\":\"19\",\"descripcion\":\"Repollo Verde\",\"cantidad\":\"2\",\"stock\":\"5\",\"precio\":\"60\",\"total\":\"120\"},{\"id\":\"43\",\"descripcion\":\"Repollo Chino\",\"cantidad\":\"3\",\"stock\":\"4\",\"precio\":\"25\",\"total\":\"75\"},{\"id\":\"44\",\"descripcion\":\"Repollo Morado\",\"cantidad\":\"2\",\"stock\":\"23\",\"precio\":\"40\",\"total\":\"40\"},{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"3\",\"stock\":\"7\",\"precio\":\"15\",\"total\":\"45\"}]', 0, 310, 310, 'Efectivo', '0', 1, '2021-05-29 16:11:03'),
(10, 10, '3', '[{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"16.7\",\"stock\":\"59.7\",\"precio\":\"11\",\"total\":\"183.7\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"60\",\"stock\":\"136\",\"precio\":\"7\",\"total\":\"420\"}]', 0, 653.8, 0, 'Credito', '', 1, '2021-06-02 18:14:08'),
(11, 2, '7809', '[{\"id\":\"145\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"4\",\"stock\":\"6\",\"precio\":\"15\",\"total\":\"60\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"5\",\"stock\":\"42\",\"precio\":\"20\",\"total\":\"100\"},{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"20\",\"stock\":\"42\",\"precio\":\"30\",\"total\":\"600\"},{\"id\":\"51\",\"descripcion\":\"Zucchini\",\"cantidad\":\"4\",\"stock\":\"37\",\"precio\":\"15\",\"total\":\"60\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"15\",\"stock\":\"45\",\"precio\":\"15\",\"total\":\"225\"},{\"id\":\"43\",\"descripcion\":\"Repollo Chino\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 970, 970, 'Efectivo', '0', 1, '2021-06-02 21:27:20'),
(12, 2, '7826', '[{\"id\":\"40\",\"descripcion\":\"Perejil Liso\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"3\",\"stock\":\"43\",\"precio\":\"20\",\"total\":\"60\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"3\",\"stock\":\"56\",\"precio\":\"25\",\"total\":\"75\"},{\"id\":\"10\",\"descripcion\":\"Apio\",\"cantidad\":\"2\",\"stock\":\"19\",\"precio\":\"20\",\"total\":\"40\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"9\",\"stock\":\"18\",\"precio\":\"15\",\"total\":\"135\"},{\"id\":\"42\",\"descripcion\":\"Puerro Grueso\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"15\",\"total\":\"15\"},{\"id\":\"127\",\"descripcion\":\"Rabanito libra\",\"cantidad\":\"3\",\"stock\":\"5\",\"precio\":\"25\",\"total\":\"75\"},{\"id\":\"44\",\"descripcion\":\"Repollo Morado\",\"cantidad\":\"3\",\"stock\":\"26\",\"precio\":\"20\",\"total\":\"60\"},{\"id\":\"19\",\"descripcion\":\"Repollo Verde\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"60\",\"total\":\"60\"},{\"id\":\"47\",\"descripcion\":\"Tayota\",\"cantidad\":\"7\",\"stock\":\"7\",\"precio\":\"12\",\"total\":\"84\"},{\"id\":\"49\",\"descripcion\":\"Vainitas Chinas\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"50\",\"total\":\"50\"},{\"id\":\"50\",\"descripcion\":\"Vainitas Española\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"30\",\"total\":\"30\"},{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"6\",\"stock\":\"7\",\"precio\":\"15\",\"total\":\"90\"}]', 0, 799, 799, 'Efectivo', '0', 1, '2021-06-06 14:59:05'),
(13, 12, '1', '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"12\",\"stock\":\"14\",\"precio\":\"200\",\"total\":\"200\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"12\",\"stock\":\"25\",\"precio\":\"19\",\"total\":\"228\"}]', 0, 440, 0, 'Efectivo', '0', 1, '2021-06-12 14:49:03'),
(14, 13, '16569', '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"20\",\"stock\":\"37\",\"precio\":\"6\",\"total\":\"120\"}]', 0, 250, 0, 'Efectivo', '0', 1, '2021-06-12 14:49:41'),
(15, 10, '6', '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"101\",\"stock\":\"110\",\"precio\":\"7\",\"total\":\"707\"}]', 0, 707, 707, 'Credito', '', 1, '2021-06-13 18:03:35'),
(16, 10, '63', '[{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"19\",\"stock\":\"23.5\",\"precio\":\"8\",\"total\":\"152\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"15\",\"stock\":\"20.4\",\"precio\":\"18\",\"total\":\"270\"},{\"id\":\"42\",\"descripcion\":\"Puerro Grueso\",\"cantidad\":\"3\",\"stock\":\"3\",\"precio\":\"15\",\"total\":\"45\"},{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"20\",\"stock\":\"49.6\",\"precio\":\"11\",\"total\":\"220\"},{\"id\":\"27\",\"descripcion\":\"Cilantro Fino Paq\",\"cantidad\":\"3\",\"stock\":\"3\",\"precio\":\"8\",\"total\":\"24\"}]', 0, 711, 711, 'Credito', '', 1, '2021-06-18 14:09:54'),
(17, 10, '618', '[{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"2.4\",\"stock\":\"3\",\"precio\":\"30\",\"total\":\"72\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"19\",\"stock\":\"39.900000000000006\",\"precio\":\"15\",\"total\":\"285\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"6\",\"stock\":\"5.9\",\"precio\":\"38\",\"total\":\"228\"},{\"id\":\"129\",\"descripcion\":\"Aji Morron 2da\",\"cantidad\":\"26\",\"stock\":\"46.6\",\"precio\":\"17\",\"total\":\"442\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"4.4\",\"stock\":\"49.199999999999996\",\"precio\":\"14\",\"total\":\"61.6\"},{\"id\":\"130\",\"descripcion\":\"Tomate ensalada 2da\",\"cantidad\":\"22\",\"stock\":\"41\",\"precio\":\"5\",\"total\":\"110\"}]', 0, 1, 1198.6, 'Credito', '', 1, '2021-06-18 14:54:33'),
(18, 9, '617', '[{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"48\",\"stock\":\"62\",\"precio\":\"45\",\"total\":\"2160\"}]', 0, 2, 2160, 'Credito', '5', 1, '2021-06-18 15:00:24'),
(19, 8, '617', '[{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"119\",\"stock\":\"168.2\",\"precio\":\"15\",\"total\":\"1785\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"20\",\"stock\":\"21.6\",\"precio\":\"8\",\"total\":\"160\"}]', 0, 1, 1945, 'Credito', '', 1, '2021-06-18 15:02:01'),
(20, 4, '617', '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"70\",\"stock\":\"75.9\",\"precio\":\"38\",\"total\":\"2660\"},{\"id\":\"129\",\"descripcion\":\"Aji Morron 2da\",\"cantidad\":\"30\",\"stock\":\"76.6\",\"precio\":\"17\",\"total\":\"510\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"60\",\"stock\":\"60\",\"precio\":\"13\",\"total\":\"780\"},{\"id\":\"130\",\"descripcion\":\"Tomate ensalada 2da\",\"cantidad\":\"30\",\"stock\":\"71\",\"precio\":\"5\",\"total\":\"150\"}]', 0, 4, 4100, 'Credito', '15', 1, '2021-06-18 15:02:51'),
(21, 14, '617', '[{\"id\":\"133\",\"descripcion\":\"Perejil liso Paq\",\"cantidad\":\"3\",\"stock\":\"3\",\"precio\":\"8\",\"total\":\"24\"},{\"id\":\"41\",\"descripcion\":\"Perejil Rizado\",\"cantidad\":\"3\",\"stock\":\"3\",\"precio\":\"8\",\"total\":\"24\"},{\"id\":\"18\",\"descripcion\":\"Espinaca\",\"cantidad\":\"9\",\"stock\":\"9\",\"precio\":\"10\",\"total\":\"90\"},{\"id\":\"46\",\"descripcion\":\"Rucula\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 158, 158, 'Efectivo', '0', 1, '2021-06-18 15:57:18'),
(22, 2, '7917', '[{\"id\":\"10\",\"descripcion\":\"Apio\",\"cantidad\":\"4\",\"stock\":\"23\",\"precio\":\"15\",\"total\":\"60\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"4\",\"stock\":\"4\",\"precio\":\"20\",\"total\":\"80\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"5\",\"stock\":\"8\",\"precio\":\"30\",\"total\":\"150\"},{\"id\":\"145\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"5\",\"stock\":\"11\",\"precio\":\"15\",\"total\":\"75\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"7\",\"stock\":\"7.8\",\"precio\":\"15\",\"total\":\"105\"},{\"id\":\"36\",\"descripcion\":\"Lechuga Rizada\",\"cantidad\":\"2\",\"stock\":\"2.01\",\"precio\":\"10\",\"total\":\"20\"},{\"id\":\"14\",\"descripcion\":\"Lechuga Morada\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"10\",\"total\":\"10\"},{\"id\":\"42\",\"descripcion\":\"Puerro Grueso\",\"cantidad\":\"2\",\"stock\":\"5\",\"precio\":\"15\",\"total\":\"30\"},{\"id\":\"17\",\"descripcion\":\"Remolacha\",\"cantidad\":\"5\",\"stock\":\"5\",\"precio\":\"10\",\"total\":\"50\"},{\"id\":\"19\",\"descripcion\":\"Repollo Verde\",\"cantidad\":\"3\",\"stock\":\"3\",\"precio\":\"70\",\"total\":\"210\"},{\"id\":\"43\",\"descripcion\":\"Repollo Chino\",\"cantidad\":\"3\",\"stock\":\"3\",\"precio\":\"25\",\"total\":\"75\"},{\"id\":\"44\",\"descripcion\":\"Repollo Morado\",\"cantidad\":\"2\",\"stock\":\"5\",\"precio\":\"20\",\"total\":\"40\"},{\"id\":\"50\",\"descripcion\":\"Vainitas Española\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"51\",\"descripcion\":\"Zucchini\",\"cantidad\":\"2\",\"stock\":\"5.1\",\"precio\":\"20\",\"total\":\"40\"},{\"id\":\"16\",\"descripcion\":\"Rabano\",\"cantidad\":\"3\",\"stock\":\"6\",\"precio\":\"25\",\"total\":\"75\"},{\"id\":\"47\",\"descripcion\":\"Tayota\",\"cantidad\":\"12\",\"stock\":\"12\",\"precio\":\"12\",\"total\":\"144\"}]', 0, 1, 1189, 'Efectivo', '0', 1, '2021-06-19 18:54:12'),
(23, 2, '13714', '[{\"id\":\"10\",\"descripcion\":\"Apio\",\"cantidad\":\"1\",\"stock\":\"24\",\"precio\":\"15\",\"total\":\"15\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"2\",\"stock\":\"6\",\"precio\":\"20\",\"total\":\"40\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"2\",\"stock\":\"10\",\"precio\":\"30\",\"total\":\"60\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"4\",\"stock\":\"11.8\",\"precio\":\"15\",\"total\":\"60\"},{\"id\":\"14\",\"descripcion\":\"Lechuga Morada\",\"cantidad\":\"2\",\"stock\":\"3\",\"precio\":\"10\",\"total\":\"20\"},{\"id\":\"49\",\"descripcion\":\"Vainitas Chinas\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"50\",\"total\":\"50\"},{\"id\":\"50\",\"descripcion\":\"Vainitas Española\",\"cantidad\":\"2\",\"stock\":\"3\",\"precio\":\"25\",\"total\":\"50\"},{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"2\",\"stock\":\"6.6\",\"precio\":\"25\",\"total\":\"50\"},{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"4\",\"stock\":\"4\",\"precio\":\"15\",\"total\":\"60\"}]', 0, 405, 405, 'Efectivo', '0', 1, '2021-06-19 18:58:31'),
(24, 13, '15007', '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"20\",\"stock\":\"21\",\"precio\":\"6\",\"total\":\"120\"}]', 0, 125, 0, 'Efectivo', '0', 1, '2021-06-24 20:01:36'),
(25, 12, '2406', '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"20\",\"stock\":\"22\",\"precio\":\"10\",\"total\":\"200\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"20\",\"stock\":\"27\",\"precio\":\"12\",\"total\":\"240\"}]', 0, 440, 440, 'Efectivo', '0', 1, '2021-06-24 20:02:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizaciones`
--

CREATE TABLE `cotizaciones` (
  `id_cotizacion` int(11) NOT NULL,
  `id_vendedor` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `productos` text COLLATE utf8_spanish_ci NOT NULL,
  `neto` double NOT NULL,
  `impuesto` double NOT NULL,
  `total` double NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `creditos`
--

CREATE TABLE `creditos` (
  `id` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `codigo_venta` int(11) NOT NULL,
  `monto` float NOT NULL,
  `fecha_pago` date NOT NULL,
  `estado` text COLLATE utf8_spanish_ci NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `creditos`
--

INSERT INTO `creditos` (`id`, `id_cliente`, `codigo_venta`, `monto`, `fecha_pago`, `estado`, `fecha`) VALUES
(1, 0, 10036, 150, '0000-00-00', 'Pendiente', '2021-04-18 14:52:51'),
(2, 7, 10038, 5538, '0000-00-00', 'Pendiente', '2021-04-22 00:13:49'),
(3, 8, 10043, 0, '0000-00-00', 'Saldado', '2021-04-22 12:52:24'),
(4, 5, 10052, 0, '0000-00-00', 'Saldado', '2021-05-07 19:17:45'),
(5, 5, 10058, 0, '0000-00-00', 'Saldado', '2021-05-07 19:17:32'),
(6, 0, 10060, 51, '0000-00-00', 'Pendiente', '2021-04-21 18:39:59'),
(7, 10, 10063, 150, '0000-00-00', 'Pendiente', '2021-04-22 00:11:31'),
(8, 11, 10069, 150, '0000-00-00', 'Pendiente', '2021-04-22 21:29:30'),
(9, 5, 10084, 0, '0000-00-00', 'Saldado', '2021-05-07 19:17:20'),
(10, 5, 10087, 0, '0000-00-00', 'Saldado', '2021-05-07 19:17:09'),
(11, 13, 10093, 260.78, '0000-00-00', 'Pendiente', '2021-04-25 19:16:44'),
(12, 14, 10094, 0, '0000-00-00', 'Saldado', '2021-04-26 13:21:12'),
(13, 5, 10095, 0, '0000-00-00', 'Saldado', '2021-05-07 19:16:57'),
(14, 5, 10102, 0, '0000-00-00', 'Saldado', '2021-05-07 19:18:06'),
(15, 14, 10108, 0, '0000-00-00', 'Saldado', '2021-05-05 18:47:34'),
(16, 8, 10110, 705, '0000-00-00', 'Pendiente', '2021-04-28 20:06:20'),
(17, 5, 10112, 0, '0000-00-00', 'Saldado', '2021-05-07 19:16:18'),
(18, 14, 10113, 0, '0000-00-00', 'Saldado', '2021-05-05 18:47:13'),
(19, 5, 10117, 0, '0000-00-00', 'Saldado', '2021-05-07 19:16:02'),
(20, 5, 10119, 0, '0000-00-00', 'Saldado', '2021-05-07 19:15:40'),
(21, 5, 10120, 0, '0000-00-00', 'Saldado', '2021-05-07 19:15:28'),
(22, 5, 10152, 0, '0000-00-00', 'Saldado', '2021-05-07 19:15:14'),
(23, 5, 10154, 0, '0000-00-00', 'Saldado', '2021-05-07 19:14:46'),
(24, 14, 10155, 0, '0000-00-00', 'Saldado', '2021-05-05 18:46:58'),
(25, 5, 10156, 0, '0000-00-00', 'Saldado', '2021-05-06 21:20:09'),
(26, 10, 10171, 4619, '0000-00-00', 'Pendiente', '2021-05-05 22:43:58'),
(27, 7, 10172, 7300, '0000-00-00', 'Pendiente', '2021-05-05 22:55:10'),
(28, 7, 10178, 540, '0000-00-00', 'Pendiente', '2021-05-06 15:45:10'),
(29, 5, 10181, 0, '0000-00-00', 'Saldado', '2021-05-06 21:19:41'),
(30, 5, 10184, 0, '0000-00-00', 'Saldado', '2021-05-06 21:18:18'),
(31, 12, 10188, 9434, '0000-00-00', 'Pendiente', '2021-05-07 20:35:08'),
(32, 12, 10193, 14042, '0000-00-00', 'Pendiente', '2021-05-08 17:54:01'),
(33, 14, 10194, 0, '0000-00-00', 'Saldado', '2021-05-13 13:16:03'),
(34, 14, 10198, 0, '0000-00-00', 'Saldado', '2021-05-13 13:15:48'),
(35, 5, 10199, 65, '0000-00-00', 'Pendiente', '2021-05-09 16:34:25'),
(36, 5, 10200, 116, '0000-00-00', 'Pendiente', '2021-05-09 16:38:01'),
(37, 10, 10201, 116, '0000-00-00', 'Pendiente', '2021-05-09 17:13:15'),
(38, 5, 10207, 116, '0000-00-00', 'Pendiente', '2021-05-10 19:19:20'),
(39, 10, 10211, 2668, '0000-00-00', 'Pendiente', '2021-05-12 14:25:57'),
(40, 16, 10213, 1565, '0000-00-00', 'Pendiente', '2021-05-12 18:22:29'),
(41, 16, 10214, 1047, '0000-00-00', 'Pendiente', '2021-05-12 18:28:17'),
(42, 10, 10222, 5498, '0000-00-00', 'Pendiente', '2021-05-13 20:32:28'),
(43, 5, 10227, 20, '0000-00-00', 'Pendiente', '2021-05-14 13:19:57'),
(44, 14, 10228, 458.9, '0000-00-00', 'Pendiente', '2021-05-14 13:57:32'),
(45, 5, 10230, 62.5, '0000-00-00', 'Pendiente', '2021-05-14 14:01:18'),
(46, 14, 10231, 110, '0000-00-00', 'Pendiente', '2021-05-14 14:20:23'),
(47, 14, 10232, 72, '0000-00-00', 'Pendiente', '2021-05-14 14:41:31'),
(48, 7, 10235, 6275, '0000-00-00', 'Pendiente', '2021-05-14 21:03:47'),
(49, 10, 10238, 65, '0000-00-00', 'Pendiente', '2021-05-14 21:37:58'),
(50, 14, 10241, 512, '0000-00-00', 'Pendiente', '2021-05-15 14:56:15'),
(51, 11, 10244, 145, '0000-00-00', 'Pendiente', '2021-06-18 19:49:44'),
(52, 5, 10247, 20, '0000-00-00', 'Pendiente', '2021-05-15 17:10:33'),
(53, 17, 10248, 0, '0000-00-00', 'Saldado', '2021-05-16 18:49:49'),
(54, 14, 10251, 60, '0000-00-00', 'Pendiente', '2021-05-15 21:10:11'),
(55, 12, 10252, 3158, '0000-00-00', 'Pendiente', '2021-05-15 22:45:42'),
(56, 7, 10254, 512, '0000-00-00', 'Pendiente', '2021-05-16 14:11:48'),
(57, 5, 10256, 116, '0000-00-00', 'Pendiente', '2021-05-16 14:59:53'),
(58, 10, 10263, 270.1, '0000-00-00', 'Pendiente', '2021-05-17 15:41:25'),
(59, 5, 10267, 70, '0000-00-00', 'Pendiente', '2021-05-17 19:57:03'),
(60, 5, 10268, 70, '0000-00-00', 'Pendiente', '2021-05-17 20:28:50'),
(61, 8, 10271, 449.5, '0000-00-00', 'Pendiente', '2021-05-19 13:15:26'),
(62, 8, 10273, 153, '0000-00-00', 'Pendiente', '2021-05-19 15:12:14'),
(63, 8, 10274, 376.9, '0000-00-00', 'Pendiente', '2021-05-19 15:29:08'),
(64, 14, 10277, 224, '0000-00-00', 'Pendiente', '2021-05-19 18:15:51'),
(65, 5, 10278, 130, '0000-00-00', 'Pendiente', '2021-05-19 19:24:45'),
(66, 14, 10293, 83, '0000-00-00', 'Pendiente', '2021-05-23 15:20:26'),
(67, 5, 10295, 65, '0000-00-00', 'Pendiente', '2021-05-23 16:04:27'),
(68, 5, 10297, 65, '0000-00-00', 'Pendiente', '2021-05-23 17:57:44'),
(69, 18, 10304, 0, '0000-00-00', 'Saldado', '2021-05-31 14:13:53'),
(70, 5, 10305, 65, '0000-00-00', 'Pendiente', '2021-05-24 21:27:30'),
(71, 5, 10312, 75, '0000-00-00', 'Pendiente', '2021-05-26 14:59:11'),
(72, 5, 10315, 65, '0000-00-00', 'Pendiente', '2021-05-26 18:28:55'),
(73, 10, 10317, 150, '0000-00-00', 'Pendiente', '2021-05-26 19:02:44'),
(74, 5, 10319, 65, '0000-00-00', 'Pendiente', '2021-05-26 20:05:03'),
(75, 14, 10324, 119, '0000-00-00', 'Pendiente', '2021-05-29 15:55:14'),
(76, 5, 10326, 65, '0000-00-00', 'Pendiente', '2021-05-28 13:36:26'),
(77, 5, 10328, 65, '0000-00-00', 'Pendiente', '2021-05-28 19:59:11'),
(78, 4, 10332, 105, '0000-00-00', 'Pendiente', '2021-05-29 15:54:38'),
(79, 14, 10339, 198, '0000-00-00', 'Pendiente', '2021-05-29 20:22:01'),
(80, 5, 10340, 70, '0000-00-00', 'Pendiente', '2021-05-29 20:24:01'),
(81, 5, 10341, 65, '0000-00-00', 'Pendiente', '2021-05-29 20:47:10'),
(82, 19, 10342, 140, '0000-00-00', 'Pendiente', '2021-05-30 13:49:53'),
(83, 5, 10347, 75, '0000-00-00', 'Pendiente', '2021-05-31 14:49:31'),
(84, 20, 10353, 300, '0000-00-00', 'Pendiente', '2021-06-01 13:22:49'),
(85, 1, 10364, 85, '0000-00-00', 'Pendiente', '2021-06-04 03:07:20'),
(86, 14, 10365, 370, '0000-00-00', 'Pendiente', '2021-06-04 14:29:12'),
(87, 10, 10366, 140, '0000-00-00', 'Pendiente', '2021-06-04 18:40:00'),
(88, 5, 10367, 65, '0000-00-00', 'Pendiente', '2021-06-04 19:48:43'),
(89, 10, 10371, 139.9, '0000-00-00', 'Pendiente', '2021-06-04 23:17:17'),
(90, 5, 10375, 240, '0000-00-00', 'Pendiente', '2021-06-05 17:15:20'),
(91, 5, 10379, 10, '0000-00-00', 'Pendiente', '2021-06-05 19:02:20'),
(92, 19, 10380, 116, '0000-00-00', 'Pendiente', '2021-06-06 14:09:41'),
(93, 17, 10384, 10, '0000-00-00', 'Pendiente', '2021-06-06 17:55:22'),
(94, 5, 10385, 65, '0000-00-00', 'Pendiente', '2021-06-06 18:05:46'),
(95, 14, 10388, -0.5, '0000-00-00', 'Saldado', '2021-06-17 18:00:24'),
(96, 5, 10393, 65, '0000-00-00', 'Pendiente', '2021-06-07 20:25:13'),
(97, 14, 10400, 0, '0000-00-00', 'Saldado', '2021-06-11 14:01:27'),
(98, 5, 10402, 130, '0000-00-00', 'Pendiente', '2021-06-10 20:35:37'),
(99, 5, 10404, 65, '0000-00-00', 'Pendiente', '2021-06-11 20:53:36'),
(100, 21, 10407, 40, '0000-00-00', 'Pendiente', '2021-06-12 15:22:38'),
(101, 5, 10413, 25, '0000-00-00', 'Pendiente', '2021-06-13 14:53:32'),
(102, 5, 10421, 65, '0000-00-00', 'Pendiente', '2021-06-13 18:08:42'),
(103, 10, 10429, 233.8, '0000-00-00', 'Pendiente', '2021-06-14 19:33:52'),
(104, 10, 10436, 202.2, '0000-00-00', 'Pendiente', '2021-06-16 18:59:20'),
(105, 10, 10438, 12, '0000-00-00', 'Pendiente', '2021-06-16 20:30:46'),
(106, 5, 10440, 260, '0000-00-00', 'Pendiente', '2021-06-17 13:20:13'),
(107, 14, 10444, 35, '0000-00-00', 'Pendiente', '2021-06-17 18:06:22'),
(108, 5, 10452, 10.5, '0000-00-00', 'Pendiente', '2021-06-18 15:09:58'),
(109, 14, 10453, 114, '0000-00-00', 'Pendiente', '2021-06-18 15:58:48'),
(110, 5, 10457, 10, '0000-00-00', 'Pendiente', '2021-06-18 19:33:00'),
(111, 19, 10458, 10, '0000-00-00', 'Pendiente', '2021-06-18 19:33:33'),
(112, 5, 10469, 102, '0000-00-00', 'Pendiente', '2021-06-21 14:51:34'),
(113, 5, 10474, 10, '0000-00-00', 'Pendiente', '2021-06-21 21:26:29'),
(114, 14, 10476, 311.3, '0000-00-00', 'Pendiente', '2021-06-23 13:46:57'),
(115, 14, 10479, 60, '0000-00-00', 'Pendiente', '2021-06-23 14:25:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas_por_pagar`
--

CREATE TABLE `cuentas_por_pagar` (
  `id` int(11) NOT NULL,
  `factura` text COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `monto` float NOT NULL,
  `fecha_pago` date NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `id_det_compra` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `precio_producto` decimal(10,0) NOT NULL,
  `cant_producto` decimal(10,0) NOT NULL,
  `total` decimal(10,0) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `cedula` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `cargo` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `salario` float NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id`, `nombre`, `cedula`, `telefono`, `direccion`, `cargo`, `salario`, `estado`, `fecha`) VALUES
(1, 'Ezequiel Mendez', '003-2343453-3', '(809) 987-8990', 'Calle Principal', 'Encargado', 20000, 1, '2019-12-02 19:14:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `id` int(11) NOT NULL,
  `nombre_empresa` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `logo_empresa` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `direccion_empresa` varchar(300) COLLATE utf8_spanish_ci NOT NULL,
  `rnc_empresa` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `telefono_empresa` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `fondo_caja` int(11) NOT NULL,
  `fiscal` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`id`, `nombre_empresa`, `logo_empresa`, `direccion_empresa`, `rnc_empresa`, `telefono_empresa`, `fondo_caja`, `fiscal`) VALUES
(1, 'Vegetales Quezada', 'vistas/img/plantilla/1143676687.jpg', 'Av. Enrique Jimenez Moya, calle AltoCerro', '', '(829) 693-7281', 1000, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `existencias`
--

CREATE TABLE `existencias` (
  `exist_id` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `existencia` float NOT NULL,
  `insertado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `actualizado` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gasto_produccion`
--

CREATE TABLE `gasto_produccion` (
  `id_gasto` int(11) NOT NULL,
  `id_produccion` int(11) NOT NULL,
  `descripcion_gasto` varchar(300) NOT NULL,
  `cantidad` double NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `gasto_produccion`
--

INSERT INTO `gasto_produccion` (`id_gasto`, `id_produccion`, `descripcion_gasto`, `cantidad`, `fecha`, `id_usuario`) VALUES
(3, 1, 'pago a trabajadores', 1200, '2021-06-25 19:41:08', 1),
(4, 2, 'Compra de fumiga', 6000, '2021-06-26 00:38:18', 1),
(5, 1, 'Pago para deshierbar', 500, '2021-06-26 00:40:37', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

CREATE TABLE `movimientos` (
  `id` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `tipo` text COLLATE utf8_spanish_ci NOT NULL,
  `descripcion_movimiento` text COLLATE utf8_spanish_ci NOT NULL,
  `habia` int(11) NOT NULL,
  `hay` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `movimientos`
--

INSERT INTO `movimientos` (`id`, `id_producto`, `tipo`, `descripcion_movimiento`, `habia`, `hay`, `fecha`) VALUES
(1, 1, 'Venta', 'Factura #10001', 199, 194, '2021-04-11 15:25:48'),
(2, 2, 'Venta', 'Factura #10001', 100, 70, '2021-04-11 15:25:48'),
(3, 1, 'Venta', 'Factura #10002', 194, 193, '2021-04-11 16:14:34'),
(4, 3, 'Venta', 'Factura #10003', 3, 1, '2021-04-12 12:28:23'),
(5, 55, 'Entrada', '', 0, 20, '2021-04-12 13:03:48'),
(6, 57, 'Venta', 'Factura #10004', 24, 23, '2021-04-12 13:29:27'),
(7, 99, 'Venta', 'Factura #10005', 21, 19, '2021-04-12 18:10:49'),
(8, 57, 'Venta', 'Factura #10005', 23, 21, '2021-04-12 18:10:49'),
(9, 30, 'Venta', 'Factura #10006', 2, 1, '2021-04-12 18:39:18'),
(10, 57, 'Venta', 'Factura #10007', 21, 20, '2021-04-12 19:23:43'),
(11, 43, 'Venta', 'Factura #10008', 2, 1, '2021-04-12 20:26:06'),
(12, 10, 'Venta', 'Factura #10008', 6, 5, '2021-04-12 20:26:06'),
(13, 5, 'Venta', 'Factura #10008', 8, 6, '2021-04-12 20:26:06'),
(14, 4, 'Venta', 'Factura #10008', 17, 15, '2021-04-12 20:26:06'),
(15, 8, 'Venta', 'Factura #10008', 30, 29, '2021-04-12 20:26:06'),
(16, 33, 'Venta', 'Factura #10008', 4, 3, '2021-04-12 20:26:06'),
(17, 59, 'Venta', 'Factura #10008', 5, 3, '2021-04-12 20:26:06'),
(18, 18, 'Venta', 'Factura #10008', 5, 4, '2021-04-12 20:26:06'),
(19, 39, 'Entrada', '', 0, 6, '2021-04-13 20:54:34'),
(20, 49, 'Entrada', '', 0, 1, '2021-04-13 20:55:11'),
(21, 20, 'Entrada', '', 6, 8, '2021-04-13 20:55:30'),
(22, 25, 'Entrada', '', 1, 5, '2021-04-13 20:55:49'),
(23, 44, 'Entrada', '', 0, 2, '2021-04-13 20:56:06'),
(24, 46, 'Entrada', '', 0, 1, '2021-04-13 20:56:23'),
(25, 13, 'Entrada', '', 1, 2, '2021-04-13 20:56:37'),
(26, 14, 'Entrada', '', 1, 2, '2021-04-13 20:56:56'),
(27, 15, 'Entrada', '', 1, 2, '2021-04-13 20:57:12'),
(28, 36, 'Entrada', '', 0, 1, '2021-04-13 20:57:25'),
(29, 35, 'Entrada', '', 0, 1, '2021-04-13 20:57:36'),
(30, 23, 'Entrada', '', 0, 2, '2021-04-13 20:57:48'),
(31, 56, 'Entrada', '', 0, 9, '2021-04-13 21:00:25'),
(32, 54, 'Entrada', '', 0, 8, '2021-04-13 21:02:51'),
(33, 38, 'Entrada', '', 6, 21, '2021-04-13 21:03:03'),
(34, 21, 'Entrada', '', 0, 2, '2021-04-13 21:04:36'),
(35, 53, 'Venta', 'Factura #10009', 30, 26, '2021-04-13 21:07:33'),
(36, 56, 'Venta', 'Factura #10009', 9, 6, '2021-04-13 21:07:33'),
(37, 20, 'Venta', 'Factura #10009', 8, 6, '2021-04-13 21:07:33'),
(38, 21, 'Venta', 'Factura #10009', 2, 0, '2021-04-13 21:07:33'),
(39, 49, 'Venta', 'Factura #10009', 1, 0, '2021-04-13 21:07:33'),
(40, 53, 'Venta', 'Factura #10009', 30, 26, '2021-04-13 21:14:11'),
(41, 56, 'Venta', 'Factura #10009', 9, 6, '2021-04-13 21:14:11'),
(42, 20, 'Venta', 'Factura #10009', 8, 6, '2021-04-13 21:14:11'),
(43, 21, 'Venta', 'Factura #10009', 2, 0, '2021-04-13 21:14:11'),
(44, 49, 'Venta', 'Factura #10009', 1, 0, '2021-04-13 21:14:11'),
(45, 100, 'Venta', 'Factura #10010', 39, 38, '2021-04-14 12:23:05'),
(46, 56, 'Venta', 'Factura #10011', -4, -5, '2021-04-14 12:48:25'),
(47, 55, 'Venta', 'Factura #10011', 20, 9, '2021-04-14 12:48:25'),
(48, 100, 'Venta', 'Factura #10012', 38, 36, '2021-04-14 13:40:38'),
(49, 58, 'Venta', 'Factura #10013', 3, 2, '2021-04-14 14:22:41'),
(50, 53, 'Venta', 'Factura #10014', 27, 26, '2021-04-14 15:23:19'),
(51, 30, 'Venta', 'Factura #10015', 1, 0, '2021-04-14 15:54:17'),
(52, 30, 'Entrada', '', 0, 3, '2021-04-14 15:56:24'),
(53, 100, 'Venta', 'Factura #10016', 36, 35, '2021-04-14 18:48:09'),
(54, 9, 'Venta', 'Factura #10017', 18, 17, '2021-04-14 18:51:55'),
(55, 66, 'Venta', 'Factura #10018', 1, 0, '2021-04-14 19:53:47'),
(56, 76, 'Venta', 'Factura #10018', 1, 0, '2021-04-14 19:53:47'),
(57, 72, 'Venta', 'Factura #10018', 1, 0, '2021-04-14 19:53:47'),
(58, 100, 'Venta', 'Factura #10019', 35, 34, '2021-04-15 13:14:38'),
(59, 55, 'Venta', 'Factura #10020', 9, 8, '2021-04-15 13:22:24'),
(60, 56, 'Venta', 'Factura #10020', -5, -6, '2021-04-15 13:22:24'),
(61, 100, 'Venta', 'Factura #10021', 34, 33, '2021-04-15 13:38:19'),
(62, 99, 'Venta', 'Factura #10022', 19, 18, '2021-04-15 14:07:01'),
(63, 57, 'Venta', 'Factura #10023', 20, 17, '2021-04-15 18:05:20'),
(64, 57, 'Venta', 'Factura #10024', 17, 16, '2021-04-15 18:23:25'),
(65, 99, 'Venta', 'Factura #10025', 18, 17, '2021-04-15 18:30:13'),
(66, 100, 'Venta', 'Factura #10026', 33, 32, '2021-04-15 18:42:17'),
(67, 7, 'Venta', 'Factura #10027', 25, 20, '2021-04-15 19:22:36'),
(68, 4, 'Venta', 'Factura #10027', 15, 8, '2021-04-15 19:22:36'),
(69, 99, 'Venta', 'Factura #10028', 17, 15, '2021-04-16 13:03:26'),
(70, 27, 'Entrada', '', 0, 4, '2021-04-16 13:09:10'),
(71, 100, 'Venta', 'Factura #10029', 32, 30, '2021-04-16 13:12:14'),
(72, 99, 'Venta', 'Factura #10029', 15, 14, '2021-04-16 13:12:14'),
(73, 36, 'Entrada', '', 1, 2, '2021-04-16 13:54:43'),
(74, 15, 'Entrada', '', 0, 1, '2021-04-16 13:55:15'),
(75, 10, 'Entrada', '', 0, 2, '2021-04-16 13:57:51'),
(76, 21, 'Entrada', '', 0, 3, '2021-04-16 15:01:41'),
(77, 49, 'Entrada', '', 0, 5, '2021-04-16 15:21:01'),
(78, 54, 'Venta', 'Factura #10030', 6, 5, '2021-04-16 16:17:28'),
(79, 5, 'Venta', 'Factura #10030', 6, 4, '2021-04-16 16:17:28'),
(80, 4, 'Venta', 'Factura #10030', 6, 4, '2021-04-16 16:17:28'),
(81, 57, 'Venta', 'Factura #10031', 16, 15, '2021-04-16 20:21:32'),
(82, 51, 'Entrada', '', 9, 9, '2021-04-16 20:58:49'),
(83, 57, 'Venta', 'Factura #10032', 15, 14, '2021-04-16 21:45:56'),
(84, 102, 'Venta', 'Factura #10032', 6, 5, '2021-04-16 21:45:56'),
(85, 54, 'Venta', 'Factura #10033', 5, 3, '2021-04-17 15:33:53'),
(86, 53, 'Venta', 'Factura #10033', 26, 25, '2021-04-17 15:33:53'),
(87, 10, 'Entrada', '', 2, 12, '2021-04-17 17:11:06'),
(88, 23, 'Entrada', '', 2, 4, '2021-04-17 17:11:28'),
(89, 20, 'Entrada', '', 3, 8, '2021-04-17 17:11:42'),
(90, 21, 'Entrada', '', 3, 41, '2021-04-17 17:12:22'),
(91, 34, 'Entrada', '', 0, 7, '2021-04-17 17:13:13'),
(92, 103, 'Entrada', '', 5, 15, '2021-04-17 17:14:56'),
(93, 41, 'Entrada', '', 0, 10, '2021-04-17 17:16:08'),
(94, 18, 'Entrada', '', 2, 4, '2021-04-17 17:16:59'),
(95, 14, 'Entrada', '', 1, 18, '2021-04-17 17:17:32'),
(96, 15, 'Entrada', '', 1, 2, '2021-04-17 17:17:47'),
(97, 39, 'Entrada', '', 6, 26, '2021-04-17 17:18:03'),
(98, 44, 'Entrada', '', 2, 4, '2021-04-17 17:18:21'),
(99, 19, 'Entrada', '', 2, 3, '2021-04-17 17:18:52'),
(100, 46, 'Entrada', '', 1, 3, '2021-04-17 17:19:36'),
(101, 47, 'Entrada', '', 11, 17, '2021-04-17 17:20:00'),
(102, 51, 'Entrada', '', 10, 30, '2021-04-17 17:20:37'),
(103, 31, 'Entrada', '', 0, 3, '2021-04-17 17:21:02'),
(104, 30, 'Entrada', '', 2, 3, '2021-04-17 17:22:43'),
(105, 6, 'Entrada', '', 2, 62, '2021-04-17 17:23:25'),
(106, 5, 'Entrada', '', 0, 105, '2021-04-17 17:23:53'),
(107, 4, 'Entrada', '', 5, 45, '2021-04-17 17:24:47'),
(108, 24, 'Entrada', '', 0, 4, '2021-04-17 17:25:01'),
(109, 100, 'Venta', 'Factura #10034', 30, 29, '2021-04-17 17:50:33'),
(110, 100, 'Venta', 'Factura #10035', 29, 28, '2021-04-18 14:51:11'),
(111, 31, 'Venta', 'Factura #10036', 3, 2, '2021-04-18 14:52:51'),
(112, 54, 'Venta', 'Factura #10037', 3, 1, '2021-04-18 15:33:01'),
(113, 4, 'Venta', 'Factura #10037', 42, 40, '2021-04-18 15:33:01'),
(114, 7, 'Venta', 'Factura #10037', 19, 17, '2021-04-18 15:33:01'),
(115, 53, 'Venta', 'Factura #10037', 26, 25, '2021-04-18 15:33:01'),
(116, 6, 'Venta', 'Factura #10037', 62, 61, '2021-04-18 15:33:01'),
(117, 31, 'Entrada', '', 2, 6, '2021-04-18 15:55:54'),
(118, 104, 'Entrada', '', 0, 2, '2021-04-18 16:13:22'),
(119, 4, 'Venta', 'Factura #10038', 41, 16, '2021-04-18 16:15:47'),
(120, 5, 'Venta', 'Factura #10038', 105, 55, '2021-04-18 16:15:47'),
(121, 6, 'Venta', 'Factura #10038', 62, 42, '2021-04-18 16:15:47'),
(122, 10, 'Venta', 'Factura #10038', 12, 2, '2021-04-18 16:15:47'),
(123, 14, 'Venta', 'Factura #10038', 18, 3, '2021-04-18 16:15:47'),
(124, 21, 'Venta', 'Factura #10038', 41, 6, '2021-04-18 16:15:47'),
(125, 46, 'Venta', 'Factura #10038', 3, 1, '2021-04-18 16:15:47'),
(126, 39, 'Venta', 'Factura #10038', 26, 6, '2021-04-18 16:15:47'),
(127, 51, 'Venta', 'Factura #10038', 30, 10, '2021-04-18 16:15:47'),
(128, 104, 'Venta', 'Factura #10038', 2, 0, '2021-04-18 16:15:47'),
(129, 13, 'Venta', 'Factura #10039', 2, 1, '2021-04-18 16:22:48'),
(130, 39, 'Venta', 'Factura #10039', 6, 5, '2021-04-18 16:22:48'),
(131, 41, 'Venta', 'Factura #10039', 10, 9, '2021-04-18 16:22:48'),
(132, 105, 'Venta', 'Factura #10040', 21, 6, '2021-04-18 18:27:05'),
(133, 6, 'Venta', 'Factura #10041', 42, 12, '2021-04-18 19:22:06'),
(134, 5, 'Venta', 'Factura #10041', 55, 15, '2021-04-18 19:22:06'),
(135, 3, 'Entrada', '', 1, 7, '2021-04-18 19:26:20'),
(136, 39, 'Venta', 'Factura #10042', 5, 4, '2021-04-18 19:31:03'),
(137, 3, 'Venta', 'Factura #10042', 7, 5, '2021-04-18 19:31:03'),
(138, 4, 'Venta', 'Factura #10042', 16, 9, '2021-04-18 19:31:03'),
(139, 20, 'Venta', 'Factura #10042', 8, 6, '2021-04-18 19:31:03'),
(140, 5, 'Venta', 'Factura #10042', 15, 13, '2021-04-18 19:31:03'),
(141, 21, 'Venta', 'Factura #10042', 6, 4, '2021-04-18 19:31:03'),
(142, 13, 'Venta', 'Factura #10042', 1, 0, '2021-04-18 19:31:03'),
(143, 43, 'Venta', 'Factura #10042', 1, 0, '2021-04-18 19:31:03'),
(144, 6, 'Venta', 'Factura #10042', 12, 11, '2021-04-18 19:31:03'),
(145, 9, 'Venta', 'Factura #10042', 18, 16, '2021-04-18 19:31:03'),
(146, 59, 'Venta', 'Factura #10042', 3, 2, '2021-04-18 19:31:03'),
(147, 7, 'Venta', 'Factura #10043', 12, 10, '2021-04-19 12:59:18'),
(148, 4, 'Venta', 'Factura #10043', 8, 5, '2021-04-19 12:59:18'),
(149, 55, 'Venta', 'Factura #10043', 8, 6, '2021-04-19 12:59:18'),
(150, 56, 'Venta', 'Factura #10043', -6, -7, '2021-04-19 12:59:18'),
(151, 27, 'Venta', 'Factura #10043', 4, 3, '2021-04-19 12:59:18'),
(152, 99, 'Venta', 'Factura #10044', 14, 13, '2021-04-19 13:08:14'),
(153, 99, 'Venta', 'Factura #10045', 13, 12, '2021-04-19 13:17:08'),
(154, 57, 'Venta', 'Factura #10045', 14, 13, '2021-04-19 13:17:08'),
(155, 99, 'Venta', 'Factura #10046', 12, 9, '2021-04-19 14:04:32'),
(156, 99, 'Venta', 'Factura #10047', 9, 7, '2021-04-19 14:07:17'),
(157, 100, 'Venta', 'Factura #10048', 28, 25, '2021-04-19 14:08:20'),
(158, 100, 'Venta', 'Factura #10049', 25, 24, '2021-04-19 14:08:57'),
(159, 57, 'Venta', 'Factura #10050', 13, 12, '2021-04-19 14:09:49'),
(160, 4, 'Venta', 'Factura #10051', 5, 2, '2021-04-19 18:20:58'),
(161, 4, 'Entrada', '', 2, 10, '2021-04-19 18:24:50'),
(162, 29, 'Entrada', '', 1, 1, '2021-04-19 18:37:59'),
(163, 55, 'Entrada', '', 6, 36, '2021-04-19 18:49:19'),
(164, 56, 'Entrada', '', -7, 20, '2021-04-19 18:51:08'),
(165, 102, 'Venta', 'Factura #10052', 5, 4, '2021-04-19 19:56:49'),
(166, 53, 'Venta', 'Factura #10053', 25, 24, '2021-04-19 20:10:56'),
(167, 38, 'Venta', 'Factura #10053', 15, 9, '2021-04-19 20:10:56'),
(168, 105, 'Venta', 'Factura #10054', 6, 4, '2021-04-19 21:23:24'),
(169, 22, 'Venta', 'Factura #10055', 67, 66, '2021-04-19 21:25:25'),
(170, 15, 'Entrada', '', 2, 27, '2021-04-20 22:52:17'),
(171, 13, 'Entrada', '', 0, 4, '2021-04-20 22:52:32'),
(172, 20, 'Entrada', '', 6, 10, '2021-04-20 22:53:15'),
(173, 5, 'Entrada', '', 9, 49, '2021-04-20 22:53:29'),
(174, 6, 'Entrada', '', 5, 29, '2021-04-20 22:54:29'),
(175, 5, 'Venta', 'Factura #10056', 49, 9, '2021-04-20 22:56:23'),
(176, 6, 'Venta', 'Factura #10056', 29, 4, '2021-04-20 22:56:23'),
(177, 15, 'Venta', 'Factura #10056', 27, 2, '2021-04-20 22:56:23'),
(178, 100, 'Venta', 'Factura #10057', 24, 23, '2021-04-21 12:02:18'),
(179, 57, 'Venta', 'Factura #10058', 12, 10, '2021-04-21 13:35:13'),
(180, 106, 'Venta', 'Factura #10058', 6, 5, '2021-04-21 13:35:13'),
(181, 15, 'Venta', 'Factura #10058', 2, 1, '2021-04-21 13:35:13'),
(182, 71, 'Entrada', '', 0, 2, '2021-04-21 13:47:42'),
(183, 80, 'Entrada', '', 0, 1, '2021-04-21 13:50:42'),
(184, 92, 'Entrada', '', 0, 2, '2021-04-21 13:52:50'),
(185, 72, 'Entrada', '', 1, 1, '2021-04-21 13:56:53'),
(186, 88, 'Entrada', '', 1, 1, '2021-04-21 13:57:24'),
(187, 55, 'Venta', 'Factura #10059', 36, 32, '2021-04-21 15:06:30'),
(188, 12, 'Venta', 'Factura #10059', 14, 12, '2021-04-21 15:06:30'),
(189, 5, 'Venta', 'Factura #10059', 9, 6, '2021-04-21 15:06:30'),
(190, 16, 'Venta', 'Factura #10059', 5, 4, '2021-04-21 15:06:30'),
(191, 49, 'Venta', 'Factura #10059', 5, 4, '2021-04-21 15:06:30'),
(192, 106, 'Venta', 'Factura #10059', 5, 4, '2021-04-21 15:06:30'),
(193, 20, 'Venta', 'Factura #10059', 10, 8, '2021-04-21 15:06:30'),
(194, 92, 'Venta', 'Factura #10059', 2, 1, '2021-04-21 15:06:30'),
(195, 4, 'Venta', 'Factura #10060', 7, 2, '2021-04-21 16:08:25'),
(196, 14, 'Venta', 'Factura #10060', 3, 1, '2021-04-21 16:08:25'),
(197, 103, 'Venta', 'Factura #10060', 5, 4, '2021-04-21 16:08:25'),
(198, 57, 'Venta', 'Factura #10061', 10, 9, '2021-04-21 18:19:54'),
(199, 5, 'Entrada', '', 7, 29, '2021-04-21 19:46:14'),
(200, 5, 'Entrada', '', 30, 110, '2021-04-21 19:46:39'),
(201, 4, 'Entrada', '', 2, 98, '2021-04-21 19:50:53'),
(202, 57, 'Entrada', '', 9, 69, '2021-04-21 19:52:35'),
(203, 55, 'Entrada', '', 32, 74, '2021-04-21 19:55:52'),
(204, 57, 'Venta', 'Factura #10062', 69, 68, '2021-04-21 20:18:46'),
(205, 31, 'Venta', 'Factura #10063', 6, 5, '2021-04-21 20:37:43'),
(206, 15, 'Entrada', '', 1, 3, '2021-04-21 21:02:15'),
(207, 36, 'Entrada', '', 1, 3, '2021-04-21 21:02:36'),
(208, 39, 'Entrada', '', 5, 10, '2021-04-21 21:03:11'),
(209, 51, 'Entrada', '', 8, 12, '2021-04-21 21:03:24'),
(210, 9, 'Entrada', '', 14, 24, '2021-04-21 21:20:45'),
(211, 54, 'Entrada', '', 1, 15, '2021-04-21 21:28:21'),
(212, 53, 'Venta', 'Factura #10064', 24, 22, '2021-04-22 13:36:43'),
(213, 56, 'Venta', 'Factura #10064', 19, 16, '2021-04-22 13:36:43'),
(214, 4, 'Venta', 'Factura #10064', 98, 95, '2021-04-22 13:36:43'),
(215, 49, 'Venta', 'Factura #10064', 4, 3, '2021-04-22 13:36:43'),
(216, 15, 'Venta', 'Factura #10064', 3, 2, '2021-04-22 13:36:43'),
(217, 39, 'Venta', 'Factura #10064', 10, 7, '2021-04-22 13:36:43'),
(218, 5, 'Venta', 'Factura #10064', 110, 108, '2021-04-22 13:36:43'),
(219, 44, 'Venta', 'Factura #10064', 4, 2, '2021-04-22 13:36:43'),
(220, 99, 'Venta', 'Factura #10065', 7, 5, '2021-04-22 13:40:09'),
(221, 100, 'Venta', 'Factura #10065', 23, 22, '2021-04-22 13:40:09'),
(222, 55, 'Venta', 'Factura #10066', 74, 72, '2021-04-22 15:10:41'),
(223, 57, 'Venta', 'Factura #10067', 68, 67, '2021-04-22 19:48:56'),
(224, 92, 'Venta', 'Factura #10068', 2, 1, '2021-04-22 21:21:48'),
(225, 92, 'Venta', 'Factura #10069', 2, 1, '2021-04-22 21:29:30'),
(226, 56, 'Entrada', '', 16, 174, '2021-04-22 21:56:09'),
(227, 7, 'Entrada', '', 9, 39, '2021-04-22 22:01:16'),
(228, 8, 'Entrada', '', 22, 34, '2021-04-22 22:01:53'),
(229, 105, 'Entrada', '', 4, 13, '2021-04-22 22:02:23'),
(230, 21, 'Entrada', '', 2, 3, '2021-04-22 22:06:03'),
(231, 32, 'Entrada', '', 0, 1, '2021-04-22 22:10:24'),
(232, 33, 'Entrada', '', 1, 6, '2021-04-22 22:14:57'),
(233, 13, 'Entrada', '', 4, 6, '2021-04-22 22:15:21'),
(234, 36, 'Entrada', '', 3, 5, '2021-04-22 22:15:35'),
(235, 12, 'Entrada', '', 13, 21, '2021-04-22 22:17:06'),
(236, 11, 'Entrada', '', 33, 64, '2021-04-22 22:18:04'),
(237, 47, 'Entrada', '', 6, 8, '2021-04-22 22:20:50'),
(238, 3, 'Entrada', '', 5, 24, '2021-04-22 22:21:44'),
(239, 100, 'Venta', 'Factura #10070', 22, 21, '2021-04-23 13:35:57'),
(240, 99, 'Venta', 'Factura #10071', 5, 4, '2021-04-23 13:42:13'),
(241, 57, 'Venta', 'Factura #10071', 67, 64, '2021-04-23 13:42:13'),
(242, 54, 'Venta', 'Factura #10072', 15, 14, '2021-04-23 13:44:27'),
(243, 100, 'Venta', 'Factura #10073', 21, 20, '2021-04-23 13:46:58'),
(244, 3, 'Venta', 'Factura #10074', 24, 12, '2021-04-23 18:13:30'),
(245, 4, 'Venta', 'Factura #10074', 96, 86, '2021-04-23 18:13:30'),
(246, 22, 'Venta', 'Factura #10074', 66, 63, '2021-04-23 18:13:30'),
(247, 22, 'Venta', 'Factura #10075', 63, 61, '2021-04-23 18:17:10'),
(248, 3, 'Venta', 'Factura #10075', 12, 3, '2021-04-23 18:17:10'),
(249, 90, 'Venta', 'Factura #10076', 1, 0, '2021-04-23 21:08:48'),
(250, 92, 'Venta', 'Factura #10076', 2, 1, '2021-04-23 21:08:48'),
(251, 29, 'Venta', 'Factura #10076', 2, 1, '2021-04-23 21:08:48'),
(252, 100, 'Venta', 'Factura #10076', 20, 19, '2021-04-23 21:08:48'),
(253, 102, 'Venta', 'Factura #10077', 4, 3, '2021-04-24 13:36:00'),
(254, 55, 'Venta', 'Factura #10078', 72, 71, '2021-04-24 14:12:20'),
(255, 4, 'Venta', 'Factura #10078', 85, 83, '2021-04-24 14:12:20'),
(256, 102, 'Venta', 'Factura #10079', 3, 2, '2021-04-24 14:13:16'),
(257, 118, 'Venta', 'Factura #10080', 24, 22, '2021-04-24 15:02:59'),
(258, 99, 'Venta', 'Factura #10080', 4, 3, '2021-04-24 15:02:59'),
(259, 5, 'Venta', 'Factura #10081', 109, 107, '2021-04-24 15:51:30'),
(260, 102, 'Venta', 'Factura #10082', 2, 1, '2021-04-24 16:00:37'),
(261, 55, 'Venta', 'Factura #10083', 71, 68, '2021-04-24 16:08:21'),
(262, 10, 'Venta', 'Factura #10083', 1, 0, '2021-04-24 16:08:21'),
(263, 20, 'Entrada', '', 9, 33, '2021-04-24 16:21:08'),
(264, 21, 'Entrada', '', 3, 60, '2021-04-24 16:21:41'),
(265, 14, 'Entrada', '', 1, 9, '2021-04-24 16:22:52'),
(266, 15, 'Entrada', '', 2, 57, '2021-04-24 16:25:48'),
(267, 41, 'Entrada', '', 9, 14, '2021-04-24 16:28:05'),
(268, 42, 'Entrada', '', 0, 2, '2021-04-24 16:32:45'),
(269, 17, 'Entrada', '', 0, 2, '2021-04-24 16:33:27'),
(270, 44, 'Entrada', '', 2, 12, '2021-04-24 16:34:22'),
(271, 34, 'Entrada', '', 7, 14, '2021-04-24 16:40:09'),
(272, 32, 'Entrada', '', 1, 9, '2021-04-24 16:42:44'),
(273, 9, 'Entrada', '', 24, 59, '2021-04-24 16:44:45'),
(274, 10, 'Entrada', '', 0, 22, '2021-04-24 16:52:55'),
(275, 118, 'Venta', 'Factura #10084', 22, 21, '2021-04-24 16:54:36'),
(276, 53, 'Venta', 'Factura #10085', 22, 20, '2021-04-24 20:30:11'),
(277, 20, 'Venta', 'Factura #10085', 33, 32, '2021-04-24 20:30:11'),
(278, 55, 'Venta', 'Factura #10085', 68, 66, '2021-04-24 20:30:11'),
(279, 53, 'Entrada', '', 21, 33, '2021-04-24 20:52:11'),
(280, 100, 'Venta', 'Factura #10086', 19, 18, '2021-04-25 13:52:51'),
(281, 102, 'Venta', 'Factura #10087', 1, 0, '2021-04-25 14:30:43'),
(282, 30, 'Entrada', '', 3, 6, '2021-04-25 14:32:00'),
(283, 31, 'Entrada', '', 5, 8, '2021-04-25 14:33:00'),
(284, 72, 'Venta', 'Factura #10088', 2, 1, '2021-04-25 14:47:01'),
(285, 5, 'Venta', 'Factura #10088', 108, 107, '2021-04-25 14:47:01'),
(286, 6, 'Venta', 'Factura #10088', 3, 2, '2021-04-25 14:47:01'),
(287, 3, 'Venta', 'Factura #10088', 3, 0, '2021-04-25 14:47:01'),
(288, 51, 'Venta', 'Factura #10088', 12, 10, '2021-04-25 14:47:01'),
(289, 31, 'Venta', 'Factura #10088', 8, 7, '2021-04-25 14:47:01'),
(290, 55, 'Venta', 'Factura #10088', 66, 63, '2021-04-25 14:47:01'),
(291, 54, 'Venta', 'Factura #10088', 14, 13, '2021-04-25 14:47:01'),
(292, 20, 'Venta', 'Factura #10089', 32, 30, '2021-04-25 15:01:13'),
(293, 21, 'Venta', 'Factura #10089', 61, 57, '2021-04-25 15:01:13'),
(294, 11, 'Venta', 'Factura #10089', 65, 62, '2021-04-25 15:01:13'),
(295, 9, 'Venta', 'Factura #10089', 59, 57, '2021-04-25 15:01:13'),
(296, 4, 'Venta', 'Factura #10089', 84, 81, '2021-04-25 15:01:13'),
(297, 44, 'Venta', 'Factura #10089', 12, 10, '2021-04-25 15:01:13'),
(298, 21, 'Venta', 'Factura #10090', 58, 54, '2021-04-25 15:34:10'),
(299, 4, 'Venta', 'Factura #10091', 82, 80, '2021-04-25 16:00:52'),
(300, 95, 'Venta', 'Factura #10092', 1, 0, '2021-04-25 17:48:49'),
(301, 78, 'Venta', 'Factura #10092', 2, 1, '2021-04-25 17:48:49'),
(302, 68, 'Venta', 'Factura #10092', 1, 0, '2021-04-25 17:48:49'),
(303, 71, 'Venta', 'Factura #10092', 2, 1, '2021-04-25 17:48:49'),
(304, 91, 'Venta', 'Factura #10092', 2, 1, '2021-04-25 17:48:49'),
(305, 3, 'Entrada', '', 1, 53, '2021-04-25 19:12:45'),
(306, 3, 'Venta', 'Factura #10093', 53, 51, '2021-04-25 19:16:44'),
(307, 4, 'Venta', 'Factura #10093', 81, 77, '2021-04-25 19:16:44'),
(308, 5, 'Venta', 'Factura #10093', 107, 104, '2021-04-25 19:16:44'),
(309, 6, 'Venta', 'Factura #10093', 3, 1, '2021-04-25 19:16:44'),
(310, 27, 'Entrada', '', 0, 2, '2021-04-25 19:23:25'),
(311, 4, 'Venta', 'Factura #10094', 78, 72, '2021-04-25 19:24:38'),
(312, 27, 'Venta', 'Factura #10094', 2, 1, '2021-04-25 19:24:38'),
(313, 39, 'Venta', 'Factura #10094', 7, 4, '2021-04-25 19:24:38'),
(314, 13, 'Venta', 'Factura #10094', 6, 4, '2021-04-25 19:24:38'),
(315, 118, 'Venta', 'Factura #10095', 21, 20, '2021-04-25 19:25:45'),
(316, 21, 'Entrada', '', 55, 60, '2021-04-26 12:50:46'),
(317, 50, 'Entrada', '', -1, 0, '2021-04-26 12:51:03'),
(318, 39, 'Entrada', '', 4, 8, '2021-04-26 12:51:34'),
(319, 15, 'Entrada', '', 57, 58, '2021-04-26 12:51:46'),
(320, 13, 'Entrada', '', 4, 5, '2021-04-26 12:52:01'),
(321, 6, 'Entrada', '', 0, 85, '2021-04-26 13:24:10'),
(322, 100, 'Venta', 'Factura #10096', 18, 17, '2021-04-26 14:05:04'),
(323, 100, 'Venta', 'Factura #10096', 17, 16, '2021-04-26 14:05:27'),
(324, 100, 'Venta', 'Factura #10096', 16, 15, '2021-04-26 14:06:01'),
(325, 99, 'Entrada', '', 3, 27, '2021-04-26 14:06:30'),
(326, 100, 'Entrada', '', 15, 27, '2021-04-26 14:06:57'),
(327, 100, 'Venta', 'Factura #10096', 27, 26, '2021-04-26 14:07:18'),
(328, 100, 'Venta', 'Factura #10096', 26, 25, '2021-04-26 14:11:46'),
(329, 100, 'Venta', 'Factura #10096', 25, 24, '2021-04-26 14:12:43'),
(330, 3, 'Venta', 'Factura #10096', 51, 50, '2021-04-26 14:13:10'),
(331, 55, 'Venta', 'Factura #10096', 63, 57, '2021-04-26 14:21:25'),
(332, 100, 'Venta', 'Factura #10096', 24, 23, '2021-04-26 14:32:29'),
(333, 100, 'Venta', 'Factura #10096', 23, 22, '2021-04-26 14:33:51'),
(334, 55, 'Venta', 'Factura #10097', 57, 51, '2021-04-26 14:35:27'),
(335, 55, 'Venta', 'Factura #10098', 51, 26, '2021-04-26 15:31:51'),
(336, 56, 'Venta', 'Factura #10098', 174, 168, '2021-04-26 15:31:51'),
(337, 100, 'Venta', 'Factura #10099', 22, 21, '2021-04-26 19:41:28'),
(338, 32, 'Venta', 'Factura #10100', 9, 8, '2021-04-28 12:52:05'),
(339, 95, 'Venta', 'Factura #10101', 1, 0, '2021-04-28 13:51:26'),
(340, 125, 'Venta', 'Factura #10101', 1, 0, '2021-04-28 13:51:26'),
(341, 118, 'Venta', 'Factura #10102', 20, 18, '2021-04-28 14:40:31'),
(342, 30, 'Venta', 'Factura #10102', 6, 5, '2021-04-28 14:40:31'),
(343, 54, 'Venta', 'Factura #10103', 13, 11, '2021-04-28 14:52:09'),
(344, 54, 'Venta', 'Factura #10104', 11, 9, '2021-04-28 14:57:23'),
(345, 55, 'Venta', 'Factura #10105', 26, 22, '2021-04-28 15:01:38'),
(346, 56, 'Venta', 'Factura #10105', 168, 166, '2021-04-28 15:01:38'),
(347, 55, 'Venta', 'Factura #10106', 22, 20, '2021-04-28 15:03:18'),
(348, 70, 'Venta', 'Factura #10107', 1, 0, '2021-04-28 15:14:25'),
(349, 90, 'Venta', 'Factura #10107', 1, 0, '2021-04-28 15:14:25'),
(350, 87, 'Venta', 'Factura #10107', 1, 0, '2021-04-28 15:14:25'),
(351, 5, 'Venta', 'Factura #10108', 104, 100, '2021-04-28 15:31:43'),
(352, 118, 'Venta', 'Factura #10109', 18, 17, '2021-04-28 19:10:48'),
(353, 8, 'Venta', 'Factura #10110', 34, 32, '2021-04-28 20:06:20'),
(354, 51, 'Venta', 'Factura #10110', 10, 7, '2021-04-28 20:06:20'),
(355, 3, 'Venta', 'Factura #10110', 50, 47, '2021-04-28 20:06:20'),
(356, 5, 'Venta', 'Factura #10110', 100, 98, '2021-04-28 20:06:20'),
(357, 21, 'Venta', 'Factura #10110', 60, 57, '2021-04-28 20:06:20'),
(358, 54, 'Venta', 'Factura #10110', 10, 8, '2021-04-28 20:06:20'),
(359, 126, 'Venta', 'Factura #10110', 3, 2, '2021-04-28 20:06:20'),
(360, 15, 'Venta', 'Factura #10110', 58, 52, '2021-04-28 20:06:20'),
(361, 27, 'Venta', 'Factura #10110', 1, 0, '2021-04-28 20:06:20'),
(362, 55, 'Venta', 'Factura #10110', 20, 15, '2021-04-28 20:06:20'),
(363, 5, 'Venta', 'Factura #10111', 98, 95, '2021-04-29 13:34:12'),
(364, 30, 'Venta', 'Factura #10111', 5, 4, '2021-04-29 13:34:12'),
(365, 101, 'Venta', 'Factura #10111', 4, 3, '2021-04-29 13:34:12'),
(366, 6, 'Venta', 'Factura #10112', 82, 80, '2021-04-29 13:54:01'),
(367, 13, 'Venta', 'Factura #10113', 5, 3, '2021-04-29 14:05:35'),
(368, 41, 'Venta', 'Factura #10113', 5, 4, '2021-04-29 14:05:35'),
(369, 55, 'Entrada', '', 15, 82, '2021-04-29 14:29:45'),
(370, 55, 'Venta', 'Factura #10114', 82, 67, '2021-04-29 14:50:07'),
(371, 54, 'Venta', 'Factura #10115', 8, 6, '2021-04-29 14:51:55'),
(372, 101, 'Venta', 'Factura #10116', 3, 2, '2021-04-29 14:54:15'),
(373, 101, 'Venta', 'Factura #10117', 2, 1, '2021-04-29 14:56:26'),
(374, 55, 'Venta', 'Factura #10118', 67, 34, '2021-04-29 15:46:34'),
(375, 56, 'Venta', 'Factura #10118', 166, 164, '2021-04-29 15:46:34'),
(376, 41, 'Entrada', '', 4, 8, '2021-04-29 18:13:27'),
(377, 118, 'Venta', 'Factura #10119', 17, 16, '2021-04-29 18:17:22'),
(378, 57, 'Venta', 'Factura #10120', 64, 63, '2021-04-29 20:01:19'),
(379, 56, 'Entrada', '', -36, 364, '2021-04-30 01:01:51'),
(380, 6, 'Entrada', '', 79, 181, '2021-04-30 01:02:32'),
(381, 3, 'Entrada', '', 47, 127, '2021-04-30 01:02:53'),
(382, 18, 'Entrada', '', 4, 19, '2021-04-30 01:04:31'),
(383, 20, 'Entrada', '', 28, 58, '2021-04-30 01:05:23'),
(384, 21, 'Entrada', '', 58, 98, '2021-04-30 01:05:50'),
(385, 119, 'Entrada', '', 2, 5, '2021-04-30 01:06:04'),
(386, 100, 'Venta', 'Factura #10121', 21, 18, '2021-04-30 13:23:12'),
(387, 31, 'Venta', 'Factura #10122', 7, 4, '2021-04-30 13:24:52'),
(388, 57, 'Venta', 'Factura #10123', 63, 62, '2021-04-30 15:26:01'),
(389, 55, 'Entrada', '', 25, 45, '2021-04-30 15:27:34'),
(390, 38, 'Entrada', '', 5, 36, '2021-04-30 15:31:59'),
(391, 56, 'Entrada', '', 364, 379, '2021-04-30 15:36:38'),
(392, 55, 'Entrada', '', 45, 70, '2021-04-30 15:37:31'),
(393, 30, 'Venta', 'Factura #10124', 4, 1, '2021-04-30 15:43:55'),
(394, 56, 'Venta', 'Factura #10125', 379, 378, '2021-04-30 15:49:44'),
(395, 4, 'Venta', 'Factura #10125', 72, 70, '2021-04-30 15:49:44'),
(396, 42, 'Venta', 'Factura #10126', 2, 0, '2021-04-30 16:17:20'),
(397, 10, 'Venta', 'Factura #10126', 22, 20, '2021-04-30 16:17:20'),
(398, 7, 'Venta', 'Factura #10126', 38, 31, '2021-04-30 16:17:20'),
(399, 5, 'Venta', 'Factura #10126', 96, 92, '2021-04-30 16:17:20'),
(400, 9, 'Venta', 'Factura #10126', 55, 51, '2021-04-30 16:17:20'),
(401, 57, 'Venta', 'Factura #10127', 62, 61, '2021-04-30 18:24:20'),
(402, 7, 'Venta', 'Factura #10128', 31, 27, '2021-04-30 19:30:00'),
(403, 55, 'Venta', 'Factura #10128', 70, 67, '2021-04-30 19:30:00'),
(404, 22, 'Venta', 'Factura #10129', 62, 61, '2021-04-30 20:34:35'),
(405, 7, 'Venta', 'Factura #10129', 27, 25, '2021-04-30 20:34:35'),
(406, 8, 'Venta', 'Factura #10129', 32, 31, '2021-04-30 20:34:35'),
(407, 55, 'Venta', 'Factura #10129', 67, 64, '2021-04-30 20:34:35'),
(408, 9, 'Venta', 'Factura #10130', 51, 45, '2021-04-30 20:48:12'),
(409, 20, 'Venta', 'Factura #10130', 58, 56, '2021-04-30 20:48:12'),
(410, 21, 'Venta', 'Factura #10130', 98, 94, '2021-04-30 20:48:12'),
(411, 4, 'Venta', 'Factura #10130', 70, 64, '2021-04-30 20:48:12'),
(412, 39, 'Venta', 'Factura #10130', 8, 5, '2021-04-30 20:48:12'),
(413, 22, 'Venta', 'Factura #10130', 61, 59, '2021-04-30 20:48:12'),
(414, 19, 'Venta', 'Factura #10130', 3, 2, '2021-04-30 20:48:12'),
(415, 118, 'Venta', 'Factura #10131', 16, 13, '2021-04-30 20:50:04'),
(416, 57, 'Venta', 'Factura #10132', 61, 60, '2021-04-30 20:53:12'),
(417, 55, 'Venta', 'Factura #10133', 64, 54, '2021-04-30 21:05:09'),
(418, 56, 'Venta', 'Factura #10133', 378, 377, '2021-04-30 21:05:09'),
(419, 56, 'Venta', 'Factura #10134', 377, 364, '2021-04-30 21:10:48'),
(420, 6, 'Venta', 'Factura #10135', 181, 167, '2021-04-30 21:20:47'),
(421, 5, 'Venta', 'Factura #10136', 93, 89, '2021-05-01 13:54:38'),
(422, 100, 'Venta', 'Factura #10137', 18, 15, '2021-05-01 13:55:37'),
(423, 99, 'Venta', 'Factura #10137', 27, 25, '2021-05-01 13:55:37'),
(424, 101, 'Venta', 'Factura #10138', 1, 0, '2021-05-01 14:43:40'),
(425, 100, 'Venta', 'Factura #10138', 15, 14, '2021-05-01 14:43:40'),
(426, 57, 'Venta', 'Factura #10139', 60, 59, '2021-05-01 14:53:20'),
(427, 100, 'Venta', 'Factura #10139', 14, 13, '2021-05-01 14:53:20'),
(428, 25, 'Entrada', '', 4, 6, '2021-05-01 16:09:11'),
(429, 13, 'Entrada', '', 3, 5, '2021-05-01 16:10:29'),
(430, 36, 'Entrada', '', 2, 7, '2021-05-01 16:11:11'),
(431, 14, 'Entrada', '', 9, 12, '2021-05-01 16:12:06'),
(432, 15, 'Entrada', '', 51, 54, '2021-05-01 16:12:36'),
(433, 39, 'Entrada', '', 5, 17, '2021-05-01 16:13:59'),
(434, 40, 'Entrada', '', 0, 1, '2021-05-01 16:14:59'),
(435, 42, 'Entrada', '', 0, 2, '2021-05-01 16:15:46'),
(436, 44, 'Entrada', '', 11, 18, '2021-05-01 16:20:25'),
(437, 43, 'Entrada', '', 0, 3, '2021-05-01 16:21:03'),
(438, 19, 'Entrada', '', 2, 4, '2021-05-01 16:21:56'),
(439, 46, 'Entrada', '', 1, 2, '2021-05-01 16:23:34'),
(440, 47, 'Entrada', '', 8, 17, '2021-05-01 16:23:58'),
(441, 47, 'Entrada', '', 8, 17, '2021-05-01 16:24:08'),
(442, 51, 'Entrada', '', 7, 13, '2021-05-01 16:24:38'),
(443, 104, 'Entrada', '', 0, 7, '2021-05-01 16:25:14'),
(444, 34, 'Entrada', '', 14, 15, '2021-05-01 16:26:08'),
(445, 12, 'Entrada', '', 22, 39, '2021-05-01 16:26:43'),
(446, 55, 'Entrada', '', 54, 84, '2021-05-01 16:27:01'),
(447, 56, 'Entrada', '', 364, 394, '2021-05-01 16:27:16'),
(448, 9, 'Venta', 'Factura #10140', 45, 43, '2021-05-01 17:03:15'),
(449, 30, 'Venta', 'Factura #10140', 1, 0, '2021-05-01 17:03:15'),
(450, 31, 'Venta', 'Factura #10140', 7, 6, '2021-05-01 17:03:15'),
(451, 121, 'Venta', 'Factura #10140', 7, 6, '2021-05-01 17:03:15'),
(452, 19, 'Venta', 'Factura #10140', 4, 3, '2021-05-01 17:03:15'),
(453, 56, 'Venta', 'Factura #10141', 394, 390, '2021-05-01 18:01:20'),
(454, 55, 'Venta', 'Factura #10141', 84, 76, '2021-05-01 18:01:20'),
(455, 4, 'Venta', 'Factura #10141', 64, 61, '2021-05-01 18:01:20'),
(456, 34, 'Venta', 'Factura #10141', 15, 14, '2021-05-01 18:01:20'),
(457, 21, 'Venta', 'Factura #10141', 94, 91, '2021-05-01 18:01:20'),
(458, 111, 'Venta', 'Factura #10141', 5, 4, '2021-05-01 18:01:20'),
(459, 22, 'Venta', 'Factura #10141', 60, 59, '2021-05-01 18:01:20'),
(460, 7, 'Venta', 'Factura #10141', 25, 23, '2021-05-01 18:01:20'),
(461, 6, 'Venta', 'Factura #10141', 167, 166, '2021-05-01 18:01:20'),
(462, 9, 'Venta', 'Factura #10141', 43, 41, '2021-05-01 18:01:20'),
(463, 38, 'Venta', 'Factura #10141', 36, 32, '2021-05-01 18:01:20'),
(464, 39, 'Venta', 'Factura #10141', 17, 14, '2021-05-01 18:01:20'),
(465, 80, 'Venta', 'Factura #10141', 1, 0, '2021-05-01 18:01:20'),
(466, 100, 'Venta', 'Factura #10142', 13, 12, '2021-05-01 18:20:55'),
(467, 25, 'Entrada', '', 6, 10, '2021-05-01 18:32:58'),
(468, 39, 'Entrada', '', 15, 21, '2021-05-01 18:37:18'),
(469, 38, 'Venta', 'Factura #10143', 32, 27, '2021-05-01 20:04:53'),
(470, 128, 'Venta', 'Factura #10143', 3, 0, '2021-05-01 20:04:53'),
(471, 118, 'Venta', 'Factura #10144', 13, 12, '2021-05-01 20:19:42'),
(472, 118, 'Venta', 'Factura #10145', 12, 11, '2021-05-01 20:20:27'),
(473, 118, 'Venta', 'Factura #10146', 11, 10, '2021-05-01 20:25:54'),
(474, 56, 'Venta', 'Factura #10147', 390, 380, '2021-05-02 15:57:28'),
(475, 9, 'Venta', 'Factura #10148', 41, 37, '2021-05-02 16:24:52'),
(476, 7, 'Venta', 'Factura #10148', 24, 22, '2021-05-02 16:24:52'),
(477, 8, 'Venta', 'Factura #10148', 31, 29, '2021-05-02 16:24:52'),
(478, 6, 'Venta', 'Factura #10148', 166, 164, '2021-05-02 16:24:52'),
(479, 22, 'Venta', 'Factura #10148', 60, 59, '2021-05-02 16:24:52'),
(480, 4, 'Venta', 'Factura #10148', 59, 56, '2021-05-02 16:24:52'),
(481, 17, 'Venta', 'Factura #10148', 2, 0, '2021-05-02 16:24:52'),
(482, 39, 'Venta', 'Factura #10148', 20, 18, '2021-05-02 16:24:52'),
(483, 6, 'Entrada', '', 165, 265, '2021-05-03 12:56:38'),
(484, 100, 'Venta', 'Factura #10149', 12, 11, '2021-05-03 13:16:20'),
(485, 56, 'Venta', 'Factura #10150', 380, 377, '2021-05-03 14:34:10'),
(486, 4, 'Venta', 'Factura #10150', 57, 55, '2021-05-03 14:34:10'),
(487, 99, 'Venta', 'Factura #10151', 25, 24, '2021-05-03 15:53:10'),
(488, 118, 'Venta', 'Factura #10152', 10, 9, '2021-05-03 18:40:58'),
(489, 57, 'Venta', 'Factura #10153', 59, 58, '2021-05-03 18:47:32'),
(490, 118, 'Venta', 'Factura #10154', 9, 8, '2021-05-03 19:11:00'),
(491, 39, 'Entrada', '', 17, 20, '2021-05-05 12:30:09'),
(492, 20, 'Entrada', '', 56, 60, '2021-05-05 12:30:27'),
(493, 15, 'Entrada', '', 54, 61, '2021-05-05 13:49:56'),
(494, 13, 'Entrada', '', 5, 7, '2021-05-05 13:50:07'),
(495, 4, 'Venta', 'Factura #10155', 54, 49, '2021-05-05 14:30:23'),
(496, 13, 'Venta', 'Factura #10155', 7, 5, '2021-05-05 14:30:23'),
(497, 15, 'Venta', 'Factura #10156', 61, 60, '2021-05-05 14:30:57'),
(498, 128, 'Entrada', '', 0, 1, '2021-05-05 14:38:58'),
(499, 55, 'Venta', 'Factura #10157', 76, 75, '2021-05-05 14:40:05'),
(500, 56, 'Venta', 'Factura #10157', 377, 376, '2021-05-05 14:40:05'),
(501, 128, 'Venta', 'Factura #10157', 1, 0, '2021-05-05 14:40:05'),
(502, 57, 'Venta', 'Factura #10158', 58, 54, '2021-05-05 14:40:42'),
(503, 5, 'Entrada', '', 71, 151, '2021-05-05 14:46:32'),
(504, 57, 'Venta', 'Factura #10159', 54, 53, '2021-05-05 14:48:07'),
(505, 57, 'Venta', 'Factura #10160', 53, 50, '2021-05-05 15:18:48'),
(506, 99, 'Venta', 'Factura #10160', 24, 23, '2021-05-05 15:18:48'),
(507, 55, 'Venta', 'Factura #10161', 75, 74, '2021-05-05 15:23:05'),
(508, 56, 'Venta', 'Factura #10161', 376, 375, '2021-05-05 15:23:05'),
(509, 57, 'Venta', 'Factura #10162', 50, 49, '2021-05-05 18:17:27'),
(510, 57, 'Venta', 'Factura #10163', 49, 47, '2021-05-05 18:24:07'),
(511, 55, 'Venta', 'Factura #10164', 74, 72, '2021-05-05 18:45:04'),
(512, 57, 'Venta', 'Factura #10165', 47, 46, '2021-05-05 19:44:43'),
(513, 99, 'Venta', 'Factura #10166', 23, 21, '2021-05-05 19:51:30'),
(514, 57, 'Venta', 'Factura #10167', 46, 45, '2021-05-05 19:57:23'),
(515, 57, 'Venta', 'Factura #10168', 45, 39, '2021-05-05 20:00:45'),
(516, 55, 'Venta', 'Factura #10169', 72, 52, '2021-05-05 21:24:22'),
(517, 3, 'Entrada', '', 119, 287, '2021-05-05 22:33:08'),
(518, 4, 'Entrada', '', 49, 139, '2021-05-05 22:36:51'),
(519, 5, 'Entrada', '', 151, 231, '2021-05-05 22:38:18'),
(520, 15, 'Entrada', '', 60, 95, '2021-05-05 22:38:35'),
(521, 5, 'Venta', 'Factura #10170', 231, 161, '2021-05-05 22:40:39'),
(522, 6, 'Venta', 'Factura #10170', 251, 191, '2021-05-05 22:40:39'),
(523, 15, 'Venta', 'Factura #10170', 95, 65, '2021-05-05 22:40:39'),
(524, 3, 'Venta', 'Factura #10170', 287, 257, '2021-05-05 22:40:39'),
(525, 3, 'Venta', 'Factura #10171', 257, 189, '2021-05-05 22:43:58'),
(526, 4, 'Venta', 'Factura #10171', 139, 89, '2021-05-05 22:43:58'),
(527, 130, 'Venta', 'Factura #10171', 30, 0, '2021-05-05 22:43:58'),
(528, 5, 'Venta', 'Factura #10171', 161, 111, '2021-05-05 22:43:58'),
(529, 129, 'Venta', 'Factura #10171', 30, 0, '2021-05-05 22:43:58'),
(530, 6, 'Venta', 'Factura #10171', 191, 146, '2021-05-05 22:43:58'),
(531, 20, 'Entrada', '', 60, 80, '2021-05-05 22:44:34'),
(532, 21, 'Entrada', '', 91, 126, '2021-05-05 22:48:28'),
(533, 104, 'Entrada', '', 7, 8, '2021-05-05 22:48:45'),
(534, 34, 'Entrada', '', 15, 16, '2021-05-05 22:49:04'),
(535, 17, 'Entrada', '', 0, 10, '2021-05-05 22:49:21'),
(536, 20, 'Venta', 'Factura #10172', 80, 60, '2021-05-05 22:55:10'),
(537, 21, 'Venta', 'Factura #10172', 126, 91, '2021-05-05 22:55:10'),
(538, 131, 'Venta', 'Factura #10172', 1, 0, '2021-05-05 22:55:10'),
(539, 104, 'Venta', 'Factura #10172', 8, 7, '2021-05-05 22:55:10'),
(540, 132, 'Venta', 'Factura #10172', 1, 0, '2021-05-05 22:55:10'),
(541, 34, 'Venta', 'Factura #10172', 16, 15, '2021-05-05 22:55:10'),
(542, 17, 'Venta', 'Factura #10172', 10, 0, '2021-05-05 22:55:10'),
(543, 3, 'Venta', 'Factura #10172', 189, 159, '2021-05-05 22:55:10'),
(544, 4, 'Venta', 'Factura #10172', 89, 59, '2021-05-05 22:55:10'),
(545, 5, 'Venta', 'Factura #10172', 111, 71, '2021-05-05 22:55:10'),
(546, 57, 'Venta', 'Factura #10173', 39, 38, '2021-05-06 12:23:36'),
(547, 99, 'Venta', 'Factura #10174', 21, 20, '2021-05-06 13:14:10'),
(548, 57, 'Venta', 'Factura #10175', 38, 37, '2021-05-06 13:26:40'),
(549, 100, 'Venta', 'Factura #10175', 11, 10, '2021-05-06 13:26:40'),
(550, 30, 'Entrada', '', 0, 3, '2021-05-06 14:53:49'),
(551, 30, 'Venta', 'Factura #10176', 3, 1, '2021-05-06 15:20:59'),
(552, 51, 'Venta', 'Factura #10176', 12, 9, '2021-05-06 15:20:59'),
(553, 25, 'Venta', 'Factura #10176', 10, 7, '2021-05-06 15:20:59'),
(554, 20, 'Venta', 'Factura #10176', 60, 59, '2021-05-06 15:20:59'),
(555, 21, 'Venta', 'Factura #10176', 91, 87, '2021-05-06 15:20:59'),
(556, 3, 'Venta', 'Factura #10176', 159, 157, '2021-05-06 15:20:59'),
(557, 4, 'Venta', 'Factura #10176', 59, 57, '2021-05-06 15:20:59'),
(558, 57, 'Venta', 'Factura #10177', 37, 36, '2021-05-06 15:29:08'),
(559, 6, 'Entrada', '', 146, 167, '2021-05-06 15:44:36'),
(560, 6, 'Venta', 'Factura #10178', 167, 147, '2021-05-06 15:45:10'),
(561, 57, 'Venta', 'Factura #10179', 36, 33, '2021-05-06 15:50:15'),
(562, 100, 'Venta', 'Factura #10179', 10, 9, '2021-05-06 15:50:15'),
(563, 20, 'Venta', 'Factura #10180', 59, 58, '2021-05-06 18:22:34'),
(564, 21, 'Venta', 'Factura #10180', 87, 85, '2021-05-06 18:22:34'),
(565, 3, 'Venta', 'Factura #10180', 117, 116, '2021-05-06 18:22:34'),
(566, 4, 'Venta', 'Factura #10180', 58, 57, '2021-05-06 18:22:34'),
(567, 5, 'Venta', 'Factura #10180', 161, 159, '2021-05-06 18:22:34'),
(568, 22, 'Venta', 'Factura #10180', 59, 58, '2021-05-06 18:22:34'),
(569, 7, 'Venta', 'Factura #10180', 23, 22, '2021-05-06 18:22:34'),
(570, 30, 'Venta', 'Factura #10180', 1, 0, '2021-05-06 18:22:34'),
(571, 11, 'Venta', 'Factura #10180', 62, 61, '2021-05-06 18:22:34'),
(572, 8, 'Entrada', '', 29, 79, '2021-05-06 18:27:57'),
(573, 57, 'Venta', 'Factura #10181', 33, 32, '2021-05-06 18:37:40'),
(574, 57, 'Venta', 'Factura #10182', 32, 30, '2021-05-06 18:51:17'),
(575, 100, 'Venta', 'Factura #10182', 9, 8, '2021-05-06 18:51:17'),
(576, 57, 'Venta', 'Factura #10183', 30, 29, '2021-05-06 20:57:44'),
(577, 118, 'Venta', 'Factura #10184', 8, 7, '2021-05-06 21:15:32'),
(578, 118, 'Venta', 'Factura #10184', 7, 6, '2021-05-06 21:15:54'),
(579, 30, 'Entrada', '', 0, 5, '2021-05-06 21:38:55'),
(580, 11, 'Venta', 'Factura #10185', 61, 60, '2021-05-06 21:55:47'),
(581, 7, 'Venta', 'Factura #10185', 22, 21, '2021-05-06 21:55:47'),
(582, 22, 'Venta', 'Factura #10185', 59, 58, '2021-05-06 21:55:47'),
(583, 21, 'Venta', 'Factura #10185', 85, 83, '2021-05-06 21:55:47'),
(584, 20, 'Venta', 'Factura #10185', 58, 56, '2021-05-06 21:55:47'),
(585, 4, 'Venta', 'Factura #10185', 57, 55, '2021-05-06 21:55:47'),
(586, 3, 'Venta', 'Factura #10185', 116, 115, '2021-05-06 21:55:47'),
(587, 5, 'Venta', 'Factura #10185', 160, 159, '2021-05-06 21:55:47'),
(588, 30, 'Venta', 'Factura #10185', 5, 4, '2021-05-06 21:55:47'),
(589, 57, 'Entrada', '', 29, 63, '2021-05-07 12:47:25'),
(590, 55, 'Venta', 'Factura #10186', 52, 51, '2021-05-07 15:09:53'),
(591, 56, 'Venta', 'Factura #10186', 374, 373, '2021-05-07 15:09:53'),
(592, 55, 'Venta', 'Factura #10187', 51, 45, '2021-05-07 18:41:35'),
(593, 9, 'Entrada', '', 32, 97, '2021-05-07 19:53:56'),
(594, 53, 'Entrada', '', 32, 40, '2021-05-07 19:54:11'),
(595, 55, 'Entrada', '', 45, 70, '2021-05-07 19:54:26'),
(596, 111, 'Entrada', '', 4, 5, '2021-05-07 19:54:45'),
(597, 5, 'Entrada', '', 159, 168, '2021-05-07 19:55:01'),
(598, 21, 'Entrada', '', 84, 13, '2021-05-07 19:55:39'),
(599, 20, 'Entrada', '', 57, 60, '2021-05-07 19:56:14'),
(600, 4, 'Entrada', '', 55, 61, '2021-05-07 19:56:24'),
(601, 6, 'Entrada', '', 191, 195, '2021-05-07 19:56:40'),
(602, 23, 'Entrada', '', 0, 5, '2021-05-07 20:01:45'),
(603, 27, 'Entrada', '', 0, 5, '2021-05-07 20:03:09'),
(604, 113, 'Entrada', '', 9, 28, '2021-05-07 20:04:21'),
(605, 112, 'Entrada', '', 3, 5, '2021-05-07 20:04:45'),
(606, 103, 'Entrada', '', 0, 3, '2021-05-07 20:05:36'),
(607, 16, 'Entrada', '', 0, 2, '2021-05-07 20:07:24'),
(608, 17, 'Entrada', '', 0, 4, '2021-05-07 20:07:46'),
(609, 55, 'Venta', 'Factura #10188', 70, 58, '2021-05-07 20:35:08'),
(610, 56, 'Venta', 'Factura #10188', 373, 163, '2021-05-07 20:35:08'),
(611, 6, 'Venta', 'Factura #10188', 195, 191, '2021-05-07 20:35:08'),
(612, 5, 'Venta', 'Factura #10188', 169, 164, '2021-05-07 20:35:08'),
(613, 22, 'Venta', 'Factura #10188', 59, 57, '2021-05-07 20:35:08'),
(614, 23, 'Venta', 'Factura #10188', 5, 0, '2021-05-07 20:35:08'),
(615, 10, 'Venta', 'Factura #10188', 20, 16, '2021-05-07 20:35:08'),
(616, 20, 'Venta', 'Factura #10188', 61, 56, '2021-05-07 20:35:08'),
(617, 25, 'Venta', 'Factura #10188', 7, 6, '2021-05-07 20:35:08'),
(618, 7, 'Venta', 'Factura #10188', 21, 9, '2021-05-07 20:35:08'),
(619, 105, 'Venta', 'Factura #10188', 13, 2, '2021-05-07 20:35:08'),
(620, 27, 'Venta', 'Factura #10188', 5, 0, '2021-05-07 20:35:08'),
(621, 21, 'Venta', 'Factura #10188', 14, 13, '2021-05-07 20:35:08'),
(622, 18, 'Venta', 'Factura #10188', 17, 13, '2021-05-07 20:35:08'),
(623, 32, 'Venta', 'Factura #10188', 7, 5, '2021-05-07 20:35:08'),
(624, 112, 'Venta', 'Factura #10188', 5, 0, '2021-05-07 20:35:08'),
(625, 113, 'Venta', 'Factura #10188', 28, 13, '2021-05-07 20:35:08'),
(626, 54, 'Venta', 'Factura #10188', 7, 3, '2021-05-07 20:35:08'),
(627, 103, 'Venta', 'Factura #10188', 3, 0, '2021-05-07 20:35:08'),
(628, 13, 'Venta', 'Factura #10188', 5, 4, '2021-05-07 20:35:08'),
(629, 14, 'Venta', 'Factura #10188', 12, 10, '2021-05-07 20:35:08'),
(630, 15, 'Venta', 'Factura #10188', 65, 62, '2021-05-07 20:35:08'),
(631, 36, 'Venta', 'Factura #10188', 4, 0, '2021-05-07 20:35:08'),
(632, 53, 'Venta', 'Factura #10188', 41, 30, '2021-05-07 20:35:08'),
(633, 38, 'Venta', 'Factura #10188', 25, 19, '2021-05-07 20:35:08'),
(634, 11, 'Venta', 'Factura #10188', 60, 35, '2021-05-07 20:35:08'),
(635, 12, 'Venta', 'Factura #10188', -11, -12, '2021-05-07 20:35:08'),
(636, 40, 'Venta', 'Factura #10188', 1, 0, '2021-05-07 20:35:08'),
(637, 42, 'Venta', 'Factura #10188', 2, 0, '2021-05-07 20:35:08'),
(638, 16, 'Venta', 'Factura #10188', 2, 0, '2021-05-07 20:35:08'),
(639, 17, 'Venta', 'Factura #10188', 4, 0, '2021-05-07 20:35:08'),
(640, 19, 'Venta', 'Factura #10188', 3, 2, '2021-05-07 20:35:08'),
(641, 43, 'Venta', 'Factura #10188', 3, 1, '2021-05-07 20:35:08'),
(642, 44, 'Venta', 'Factura #10188', 18, 12, '2021-05-07 20:35:08'),
(643, 106, 'Venta', 'Factura #10188', 2, 0, '2021-05-07 20:35:08'),
(644, 47, 'Venta', 'Factura #10188', 17, 8, '2021-05-07 20:35:08'),
(645, 3, 'Venta', 'Factura #10188', 115, 108, '2021-05-07 20:35:08'),
(646, 4, 'Venta', 'Factura #10188', 62, 57, '2021-05-07 20:35:08'),
(647, 122, 'Venta', 'Factura #10188', 1, 0, '2021-05-07 20:35:08'),
(648, 9, 'Venta', 'Factura #10188', 97, 77, '2021-05-07 20:35:08'),
(649, 51, 'Venta', 'Factura #10188', 10, 7, '2021-05-07 20:35:08'),
(650, 12, 'Entrada', '', -12, 135, '2021-05-07 20:37:03'),
(651, 99, 'Venta', 'Factura #10189', 20, 19, '2021-05-08 15:41:40'),
(652, 118, 'Venta', 'Factura #10190', 6, 3, '2021-05-08 15:42:25'),
(653, 100, 'Venta', 'Factura #10190', 8, 7, '2021-05-08 15:42:25'),
(654, 55, 'Venta', 'Factura #10191', 58, 55, '2021-05-08 15:44:10'),
(655, 37, 'Entrada', '', 0, 1, '2021-05-08 16:45:51'),
(656, 80, 'Venta', 'Factura #10192', 1, 0, '2021-05-08 16:53:02'),
(657, 37, 'Venta', 'Factura #10192', 1, 0, '2021-05-08 16:53:02'),
(658, 55, 'Venta', 'Factura #10192', 55, 53, '2021-05-08 16:53:02'),
(659, 53, 'Venta', 'Factura #10192', 30, 28, '2021-05-08 16:53:02'),
(660, 57, 'Venta', 'Factura #10192', 63, 62, '2021-05-08 16:53:02'),
(661, 11, 'Entrada', '', 35, 55, '2021-05-08 17:21:00'),
(662, 10, 'Entrada', '', 16, 18, '2021-05-08 17:21:26'),
(663, 23, 'Entrada', '', 0, 6, '2021-05-08 17:22:02'),
(664, 20, 'Entrada', '', 54, 6, '2021-05-08 17:22:37'),
(665, 18, 'Entrada', '', 13, 16, '2021-05-08 17:22:56'),
(666, 54, 'Entrada', '', 3, 26, '2021-05-08 17:23:32'),
(667, 36, 'Entrada', '', 0, 2, '2021-05-08 17:23:57'),
(668, 13, 'Entrada', '', 4, 12, '2021-05-08 17:24:20'),
(669, 14, 'Entrada', '', 10, 12, '2021-05-08 17:24:52'),
(670, 15, 'Entrada', '', 61, 64, '2021-05-08 17:25:08'),
(671, 37, 'Entrada', '', 0, 5, '2021-05-08 17:25:31'),
(672, 127, 'Entrada', '', 2, 4, '2021-05-08 17:25:55'),
(673, 17, 'Entrada', '', 0, 2, '2021-05-08 17:26:14'),
(674, 43, 'Entrada', '', 0, 2, '2021-05-08 17:26:40'),
(675, 44, 'Entrada', '', 12, 18, '2021-05-08 17:27:27'),
(676, 19, 'Entrada', '', 2, 4, '2021-05-08 17:28:13'),
(677, 47, 'Entrada', '', 8, 16, '2021-05-08 17:29:08'),
(678, 51, 'Entrada', '', 7, 11, '2021-05-08 17:29:23'),
(679, 42, 'Entrada', '', 0, 4, '2021-05-08 17:29:54'),
(680, 49, 'Entrada', '', 3, 5, '2021-05-08 17:30:50'),
(681, 50, 'Entrada', '', 1, 2, '2021-05-08 17:31:42'),
(682, 56, 'Entrada', '', 163, 369, '2021-05-08 17:35:45'),
(683, 53, 'Entrada', '', 29, 44, '2021-05-08 17:36:03'),
(684, 40, 'Entrada', '', 0, 1, '2021-05-08 17:36:45'),
(685, 27, 'Entrada', '', 0, 5, '2021-05-08 17:37:03'),
(686, 120, 'Entrada', '', 1, 5, '2021-05-08 17:37:24'),
(687, 34, 'Entrada', '', 15, 17, '2021-05-08 17:37:47'),
(688, 119, 'Entrada', '', 5, 7, '2021-05-08 17:38:15'),
(689, 56, 'Venta', 'Factura #10193', 369, 61, '2021-05-08 17:54:01'),
(690, 55, 'Venta', 'Factura #10193', 53, 50, '2021-05-08 17:54:01'),
(691, 6, 'Venta', 'Factura #10193', 191, 190, '2021-05-08 17:54:01'),
(692, 5, 'Venta', 'Factura #10193', 164, 163, '2021-05-08 17:54:01'),
(693, 22, 'Venta', 'Factura #10193', 57, 56, '2021-05-08 17:54:01'),
(694, 67, 'Venta', 'Factura #10193', 1, 0, '2021-05-08 17:54:01'),
(695, 23, 'Venta', 'Factura #10193', 6, 5, '2021-05-08 17:54:01'),
(696, 68, 'Venta', 'Factura #10193', 1, 0, '2021-05-08 17:54:01'),
(697, 10, 'Venta', 'Factura #10193', 18, 17, '2021-05-08 17:54:01'),
(698, 24, 'Venta', 'Factura #10193', 4, 3, '2021-05-08 17:54:01'),
(699, 69, 'Venta', 'Factura #10193', 2, 1, '2021-05-08 17:54:01'),
(700, 20, 'Venta', 'Factura #10193', 6, 5, '2021-05-08 17:54:01'),
(701, 25, 'Venta', 'Factura #10193', 6, 5, '2021-05-08 17:54:01'),
(702, 71, 'Venta', 'Factura #10193', 2, 1, '2021-05-08 17:54:01'),
(703, 95, 'Venta', 'Factura #10193', 1, 0, '2021-05-08 17:54:01'),
(704, 8, 'Venta', 'Factura #10193', 79, 78, '2021-05-08 17:54:01'),
(705, 7, 'Venta', 'Factura #10193', 9, 8, '2021-05-08 17:54:01'),
(706, 27, 'Venta', 'Factura #10193', 5, 0, '2021-05-08 17:54:01'),
(707, 21, 'Venta', 'Factura #10193', 13, 10, '2021-05-08 17:54:01'),
(708, 29, 'Venta', 'Factura #10193', 2, 1, '2021-05-08 17:54:01'),
(709, 123, 'Venta', 'Factura #10193', 1, 0, '2021-05-08 17:54:01'),
(710, 78, 'Venta', 'Factura #10193', 2, 1, '2021-05-08 17:54:01'),
(711, 18, 'Venta', 'Factura #10193', 16, 13, '2021-05-08 17:54:01'),
(712, 32, 'Venta', 'Factura #10193', 5, 0, '2021-05-08 17:54:01'),
(713, 113, 'Venta', 'Factura #10193', 13, 3, '2021-05-08 17:54:01'),
(714, 31, 'Venta', 'Factura #10193', -7, -8, '2021-05-08 17:54:01'),
(715, 30, 'Venta', 'Factura #10193', -1, -2, '2021-05-08 17:54:01'),
(716, 54, 'Venta', 'Factura #10193', 26, 13, '2021-05-08 17:54:01'),
(717, 34, 'Venta', 'Factura #10193', 17, 16, '2021-05-08 17:54:01'),
(718, 14, 'Venta', 'Factura #10193', 12, 10, '2021-05-08 17:54:01'),
(719, 13, 'Venta', 'Factura #10193', 12, 4, '2021-05-08 17:54:01'),
(720, 36, 'Venta', 'Factura #10193', 2, 0, '2021-05-08 17:54:01'),
(721, 15, 'Venta', 'Factura #10193', 64, 61, '2021-05-08 17:54:01'),
(722, 53, 'Venta', 'Factura #10193', 44, 39, '2021-05-08 17:54:01'),
(723, 37, 'Venta', 'Factura #10193', 5, 1, '2021-05-08 17:54:01'),
(724, 86, 'Venta', 'Factura #10193', 1, 0, '2021-05-08 17:54:01'),
(725, 38, 'Venta', 'Factura #10193', 19, 8, '2021-05-08 17:54:01'),
(726, 11, 'Venta', 'Factura #10193', 55, 39, '2021-05-08 17:54:01'),
(727, 12, 'Venta', 'Factura #10193', 86, 39, '2021-05-08 17:54:01'),
(728, 39, 'Venta', 'Factura #10193', 20, 14, '2021-05-08 17:54:01'),
(729, 40, 'Venta', 'Factura #10193', 1, 0, '2021-05-08 17:54:01'),
(730, 119, 'Venta', 'Factura #10193', 7, 6, '2021-05-08 17:54:01'),
(731, 42, 'Venta', 'Factura #10193', 4, 0, '2021-05-08 17:54:01'),
(732, 127, 'Venta', 'Factura #10193', 4, 2, '2021-05-08 17:54:01'),
(733, 17, 'Venta', 'Factura #10193', -5, -6, '2021-05-08 17:54:01'),
(734, 43, 'Venta', 'Factura #10193', 2, 0, '2021-05-08 17:54:01'),
(735, 44, 'Venta', 'Factura #10193', 18, 12, '2021-05-08 17:54:01'),
(736, 19, 'Venta', 'Factura #10193', 4, 2, '2021-05-08 17:54:01'),
(737, 120, 'Venta', 'Factura #10193', 5, 4, '2021-05-08 17:54:01'),
(738, 92, 'Venta', 'Factura #10193', 2, 1, '2021-05-08 17:54:01'),
(739, 47, 'Venta', 'Factura #10193', 16, 10, '2021-05-08 17:54:01'),
(740, 3, 'Venta', 'Factura #10193', 108, 99, '2021-05-08 17:54:01'),
(741, 4, 'Venta', 'Factura #10193', 57, 43, '2021-05-08 17:54:01'),
(742, 9, 'Venta', 'Factura #10193', 77, 57, '2021-05-08 17:54:01'),
(743, 51, 'Venta', 'Factura #10193', 11, 7, '2021-05-08 17:54:01'),
(744, 32, 'Entrada', '', 0, 2, '2021-05-08 17:55:06'),
(745, 112, 'Entrada', '', 0, 14, '2021-05-08 17:55:27'),
(746, 30, 'Entrada', '', -2, 4, '2021-05-08 17:55:49'),
(747, 17, 'Entrada', '', -6, 2, '2021-05-08 17:56:22'),
(748, 27, 'Entrada', '', 0, 3, '2021-05-08 18:05:26'),
(749, 41, 'Entrada', '', 0, 3, '2021-05-08 18:06:03'),
(750, 4, 'Venta', 'Factura #10194', 43, 38, '2021-05-08 18:06:42'),
(751, 27, 'Venta', 'Factura #10194', 3, 2, '2021-05-08 18:06:42'),
(752, 41, 'Venta', 'Factura #10194', 3, 2, '2021-05-08 18:06:42'),
(753, 100, 'Venta', 'Factura #10195', 7, 6, '2021-05-08 18:33:55'),
(754, 55, 'Venta', 'Factura #10196', 50, 46, '2021-05-08 18:56:11'),
(755, 56, 'Venta', 'Factura #10196', 61, 59, '2021-05-08 18:56:11'),
(756, 57, 'Venta', 'Factura #10197', 62, 60, '2021-05-08 19:00:24'),
(757, 126, 'Entrada', '', 2, 4, '2021-05-08 19:54:09'),
(758, 16, 'Entrada', '', 0, 6, '2021-05-08 19:54:59'),
(759, 111, 'Entrada', '', 6, 6, '2021-05-08 21:01:35'),
(760, 13, 'Venta', 'Factura #10198', 4, 2, '2021-05-09 14:43:13'),
(761, 31, 'Entrada', '', -8, 6, '2021-05-09 15:57:24'),
(762, 30, 'Entrada', '', 4, 6, '2021-05-09 15:57:41'),
(763, 118, 'Venta', 'Factura #10199', 3, 2, '2021-05-09 16:34:25'),
(764, 30, 'Venta', 'Factura #10200', 6, 5, '2021-05-09 16:38:01'),
(765, 30, 'Venta', 'Factura #10201', 5, 4, '2021-05-09 17:13:15'),
(766, 100, 'Venta', 'Factura #10202', 6, 5, '2021-05-10 12:36:21'),
(767, 5, 'Venta', 'Factura #10203', 162, 161, '2021-05-10 13:57:48'),
(768, 22, 'Venta', 'Factura #10203', 56, 55, '2021-05-10 13:57:48'),
(769, 66, 'Venta', 'Factura #10203', 1, 0, '2021-05-10 13:57:48'),
(770, 92, 'Venta', 'Factura #10203', 1, 0, '2021-05-10 13:57:48'),
(771, 68, 'Entrada', '', 0, 1, '2021-05-10 14:08:31'),
(772, 68, 'Venta', 'Factura #10204', 2, 1, '2021-05-10 14:12:50'),
(773, 55, 'Venta', 'Factura #10205', 46, 44, '2021-05-10 15:35:48'),
(774, 95, 'Entrada', '', 0, 1, '2021-05-10 15:46:40'),
(775, 76, 'Venta', 'Factura #10206', 1, 0, '2021-05-10 15:56:26'),
(776, 22, 'Venta', 'Factura #10206', 55, 54, '2021-05-10 15:56:26'),
(777, 55, 'Venta', 'Factura #10206', 44, 39, '2021-05-10 15:56:26'),
(778, 53, 'Venta', 'Factura #10206', 39, 38, '2021-05-10 15:56:26'),
(779, 30, 'Venta', 'Factura #10207', 4, 3, '2021-05-10 19:19:20'),
(780, 100, 'Venta', 'Factura #10208', 5, 3, '2021-05-10 20:46:09'),
(781, 99, 'Venta', 'Factura #10208', 19, 15, '2021-05-10 20:46:09'),
(782, 57, 'Venta', 'Factura #10209', 60, 59, '2021-05-10 21:37:51'),
(783, 5, 'Entrada', '', 161, 194, '2021-05-12 14:19:41'),
(784, 4, 'Entrada', '', 32, 63, '2021-05-12 14:20:36'),
(785, 6, 'Entrada', '', 190, 210, '2021-05-12 14:20:50'),
(786, 3, 'Entrada', '', 97, 117, '2021-05-12 14:21:04'),
(787, 30, 'Entrada', '', 1, 11, '2021-05-12 14:22:07'),
(788, 57, 'Venta', 'Factura #10210', 59, 58, '2021-05-12 14:22:17'),
(789, 30, 'Venta', 'Factura #10211', 11, 1, '2021-05-12 14:25:57'),
(790, 5, 'Venta', 'Factura #10211', 194, 161, '2021-05-12 14:25:57'),
(791, 6, 'Venta', 'Factura #10211', 210, 196, '2021-05-12 14:25:57'),
(792, 3, 'Venta', 'Factura #10211', 117, 97, '2021-05-12 14:25:57'),
(793, 4, 'Venta', 'Factura #10211', 63, 42, '2021-05-12 14:25:57'),
(794, 20, 'Entrada', '', 0, 2, '2021-05-12 14:31:38'),
(795, 55, 'Venta', 'Factura #10212', 39, 4, '2021-05-12 15:56:28'),
(796, 56, 'Venta', 'Factura #10212', 59, 54, '2021-05-12 15:56:28'),
(797, 55, 'Entrada', '', 4, 39, '2021-05-12 16:01:03');
INSERT INTO `movimientos` (`id`, `id_producto`, `tipo`, `descripcion_movimiento`, `habia`, `hay`, `fecha`) VALUES
(798, 71, 'Entrada', '', 1, 2, '2021-05-12 18:18:57'),
(799, 71, 'Venta', 'Factura #10213', 2, 0, '2021-05-12 18:22:29'),
(800, 90, 'Venta', 'Factura #10213', 1, 0, '2021-05-12 18:22:29'),
(801, 78, 'Venta', 'Factura #10213', 1, 0, '2021-05-12 18:22:29'),
(802, 68, 'Venta', 'Factura #10213', 2, 1, '2021-05-12 18:22:29'),
(803, 91, 'Venta', 'Factura #10213', 2, 1, '2021-05-12 18:22:29'),
(804, 71, 'Entrada', '', 0, 2, '2021-05-12 18:26:08'),
(805, 90, 'Entrada', '', 0, 1, '2021-05-12 18:26:19'),
(806, 71, 'Venta', 'Factura #10214', 2, 1, '2021-05-12 18:28:17'),
(807, 90, 'Venta', 'Factura #10214', 1, 0, '2021-05-12 18:28:17'),
(808, 78, 'Venta', 'Factura #10214', 1, 0, '2021-05-12 18:28:17'),
(809, 91, 'Venta', 'Factura #10214', 2, 1, '2021-05-12 18:28:17'),
(810, 68, 'Venta', 'Factura #10214', 2, 1, '2021-05-12 18:28:17'),
(811, 9, 'Entrada', '', 40, 50, '2021-05-12 19:45:36'),
(812, 100, 'Venta', 'Factura #10214', 3, 2, '2021-05-12 19:45:45'),
(813, 11, 'Entrada', '', 39, 49, '2021-05-12 19:46:10'),
(814, 10, 'Entrada', '', 17, 28, '2021-05-12 19:47:24'),
(815, 20, 'Entrada', '', 2, 9, '2021-05-12 19:47:39'),
(816, 21, 'Entrada', '', 9, 18, '2021-05-12 19:48:10'),
(817, 13, 'Entrada', '', 2, 11, '2021-05-12 19:50:19'),
(818, 5, 'Entrada', '', 161, 294, '2021-05-12 19:55:52'),
(819, 129, 'Entrada', '', 0, 11, '2021-05-12 19:56:19'),
(820, 130, 'Entrada', '', 0, 30, '2021-05-12 19:56:37'),
(821, 4, 'Entrada', '', 42, 102, '2021-05-12 19:56:56'),
(822, 20, 'Venta', 'Factura #10215', 9, 2, '2021-05-12 20:14:56'),
(823, 13, 'Venta', 'Factura #10215', 11, 2, '2021-05-12 20:14:56'),
(824, 10, 'Venta', 'Factura #10215', 28, 21, '2021-05-12 20:14:56'),
(825, 21, 'Venta', 'Factura #10215', 18, 12, '2021-05-12 20:14:56'),
(826, 22, 'Venta', 'Factura #10215', 55, 52, '2021-05-12 20:14:56'),
(827, 8, 'Venta', 'Factura #10215', 77, 71, '2021-05-12 20:14:56'),
(828, 5, 'Venta', 'Factura #10215', 294, 288, '2021-05-12 20:14:56'),
(829, 6, 'Venta', 'Factura #10215', 196, 193, '2021-05-12 20:14:56'),
(830, 9, 'Venta', 'Factura #10215', 50, 41, '2021-05-12 20:14:56'),
(831, 11, 'Venta', 'Factura #10215', 49, 34, '2021-05-12 20:14:56'),
(832, 39, 'Venta', 'Factura #10215', 13, 7, '2021-05-12 20:14:56'),
(833, 3, 'Venta', 'Factura #10215', 97, 92, '2021-05-12 20:14:56'),
(834, 55, 'Venta', 'Factura #10216', 39, 37, '2021-05-12 21:03:59'),
(835, 56, 'Venta', 'Factura #10216', 54, 53, '2021-05-12 21:03:59'),
(836, 56, 'Venta', 'Factura #10217', 53, 51, '2021-05-13 13:28:42'),
(837, 20, 'Venta', 'Factura #10217', 2, 1, '2021-05-13 13:28:42'),
(838, 7, 'Venta', 'Factura #10218', 8, 7, '2021-05-13 14:12:46'),
(839, 55, 'Venta', 'Factura #10218', 29, 28, '2021-05-13 14:12:46'),
(840, 57, 'Venta', 'Factura #10219', 58, 56, '2021-05-13 14:37:54'),
(841, 56, 'Venta', 'Factura #10220', 51, 48, '2021-05-13 15:24:57'),
(842, 100, 'Venta', 'Factura #10221', 2, 1, '2021-05-13 15:49:32'),
(843, 100, 'Entrada', '', 1, 33, '2021-05-13 19:57:41'),
(844, 100, 'Entrada', '', 33, 37, '2021-05-13 20:01:13'),
(845, 99, 'Entrada', '', 15, 35, '2021-05-13 20:03:53'),
(846, 55, 'Entrada', '', 28, 274, '2021-05-13 20:25:30'),
(847, 3, 'Entrada', '', 92, 192, '2021-05-13 20:26:17'),
(848, 129, 'Entrada', '', 11, 23, '2021-05-13 20:26:44'),
(849, 5, 'Entrada', '', 288, 421, '2021-05-13 20:27:10'),
(850, 3, 'Venta', 'Factura #10222', 192, 112, '2021-05-13 20:32:28'),
(851, 4, 'Venta', 'Factura #10222', 99, 49, '2021-05-13 20:32:28'),
(852, 5, 'Venta', 'Factura #10222', 421, 353, '2021-05-13 20:32:28'),
(853, 6, 'Venta', 'Factura #10222', 193, 148, '2021-05-13 20:32:28'),
(854, 129, 'Venta', 'Factura #10222', 23, 11, '2021-05-13 20:32:28'),
(855, 130, 'Venta', 'Factura #10222', 30, 0, '2021-05-13 20:32:28'),
(856, 30, 'Venta', 'Factura #10222', 1, 0, '2021-05-13 20:32:28'),
(857, 30, 'Entrada', '', 0, 50, '2021-05-13 20:33:07'),
(858, 3, 'Venta', 'Factura #10223', 112, 92, '2021-05-13 20:37:36'),
(859, 91, 'Venta', 'Factura #10224', 3, 2, '2021-05-13 21:19:48'),
(860, 99, 'Venta', 'Factura #10225', 35, 34, '2021-05-13 21:32:45'),
(861, 3, 'Venta', 'Factura #10226', 92, 72, '2021-05-13 21:39:59'),
(862, 25, 'Entrada', 'Correccion Inventario', 4, 4, '2021-05-13 22:12:52'),
(863, 7, 'Entrada', '', 7, 32, '2021-05-13 22:13:13'),
(864, 22, 'Entrada', 'Correccion Inventario', 48, 88, '2021-05-13 22:14:35'),
(865, 28, 'Entrada', 'Correccion Inventario', 1, 2, '2021-05-13 22:14:53'),
(866, 29, 'Entrada', 'Correccion Inventario', 1, 1, '2021-05-13 22:15:51'),
(867, 0, 'Entrada', '', 0, 2, '2021-05-13 22:20:01'),
(868, 122, 'Entrada', '', 0, 5, '2021-05-13 22:20:26'),
(869, 43, 'Entrada', 'Correccion Inventario', 0, 3, '2021-05-13 22:21:00'),
(870, 13, 'Entrada', '', 2, 5, '2021-05-13 22:21:55'),
(871, 20, 'Entrada', '', 1, 4, '2021-05-13 22:22:10'),
(872, 113, 'Entrada', '', 3, 10, '2021-05-13 22:23:48'),
(873, 62, 'Entrada', 'Correccion Inventario', 3, 4, '2021-05-13 22:24:02'),
(874, 65, 'Entrada', 'Correccion Inventario', 2, 4, '2021-05-13 22:24:18'),
(875, 69, 'Entrada', 'Correccion Inventario', 1, 4, '2021-05-13 22:28:54'),
(876, 92, 'Entrada', '', 1, 1, '2021-05-13 22:30:00'),
(877, 70, 'Entrada', '', 1, 1, '2021-05-13 22:30:17'),
(878, 67, 'Entrada', '', 0, 4, '2021-05-13 22:31:04'),
(879, 77, 'Entrada', '', 1, 1, '2021-05-13 22:32:12'),
(880, 72, 'Entrada', 'Correccion Inventario', 2, 2, '2021-05-13 22:33:14'),
(881, 74, 'Entrada', '', 0, 1, '2021-05-13 22:33:43'),
(882, 73, 'Entrada', 'Correccion Inventario', 1, 2, '2021-05-13 22:33:59'),
(883, 85, 'Entrada', 'Correccion Inventario', 1, 1, '2021-05-13 22:37:33'),
(884, 88, 'Entrada', 'Correccion Inventario', 1, 1, '2021-05-13 22:37:56'),
(885, 94, 'Entrada', '', 1, 1, '2021-05-13 22:38:26'),
(886, 93, 'Entrada', 'Correccion Inventario', 1, 1, '2021-05-13 22:38:42'),
(887, 108, 'Entrada', '', 1, 1, '2021-05-13 22:39:02'),
(888, 134, 'Entrada', 'Correccion Inventario', 0, 0, '2021-05-13 22:42:07'),
(889, 80, 'Entrada', 'Correccion Inventario', 0, 0, '2021-05-13 22:43:36'),
(890, 84, 'Entrada', '', 1, 1, '2021-05-13 22:45:47'),
(891, 86, 'Entrada', '', 0, 0, '2021-05-13 22:46:05'),
(892, 83, 'Entrada', '', 1, 4, '2021-05-13 22:46:20'),
(893, 81, 'Entrada', '', 1, 1, '2021-05-13 22:46:55'),
(894, 75, 'Entrada', '', 1, 1, '2021-05-13 22:47:06'),
(895, 100, 'Venta', 'Factura #10227', 31, 30, '2021-05-14 13:19:57'),
(896, 13, 'Venta', 'Factura #10228', 6, 4, '2021-05-14 13:57:32'),
(897, 33, 'Venta', 'Factura #10228', 1, 0, '2021-05-14 13:57:32'),
(898, 126, 'Venta', 'Factura #10228', 4, 2, '2021-05-14 13:57:32'),
(899, 5, 'Venta', 'Factura #10228', 10, 6, '2021-05-14 13:57:32'),
(900, 99, 'Venta', 'Factura #10229', 34, 33, '2021-05-14 14:00:06'),
(901, 15, 'Venta', 'Factura #10230', 10, 7, '2021-05-14 14:01:18'),
(902, 57, 'Venta', 'Factura #10230', 48, 47, '2021-05-14 14:01:18'),
(903, 82, 'Entrada', '', 1, 1, '2021-05-14 14:15:52'),
(904, 4, 'Venta', 'Factura #10231', 29, 24, '2021-05-14 14:20:23'),
(905, 56, 'Venta', 'Factura #10232', 23, 17, '2021-05-14 14:41:31'),
(906, 7, 'Entrada', 'Comprada a Caonabo Quezada', 33, 73, '2021-05-14 15:13:42'),
(907, 100, 'Venta', 'Factura #10233', 30, 29, '2021-05-14 20:34:21'),
(908, 5, 'Entrada', '', 6, 60, '2021-05-14 20:38:20'),
(909, 21, 'Entrada', '', 2, 66, '2021-05-14 20:38:44'),
(910, 4, 'Entrada', '', 24, 74, '2021-05-14 20:39:02'),
(911, 20, 'Entrada', '', 4, 37, '2021-05-14 20:39:18'),
(912, 51, 'Entrada', '', 5, 27, '2021-05-14 20:40:52'),
(913, 13, 'Entrada', '', 4, 7, '2021-05-14 20:41:34'),
(914, 47, 'Entrada', '', 10, 12, '2021-05-14 20:42:09'),
(915, 57, 'Venta', 'Factura #10234', 47, 46, '2021-05-14 20:49:00'),
(916, 59, 'Venta', 'Factura #10234', 2, 0, '2021-05-14 20:49:00'),
(917, 30, 'Entrada', '', 1, 46, '2021-05-14 20:55:46'),
(918, 31, 'Entrada', '', 1, 6, '2021-05-14 20:56:02'),
(919, 3, 'Entrada', 'Compra a Caonabo Quezada', 10, 40, '2021-05-14 21:01:16'),
(920, 21, 'Venta', 'Factura #10235', 66, 6, '2021-05-14 21:03:47'),
(921, 20, 'Venta', 'Factura #10235', 37, 7, '2021-05-14 21:03:47'),
(922, 5, 'Venta', 'Factura #10235', 61, 21, '2021-05-14 21:03:47'),
(923, 4, 'Venta', 'Factura #10235', 74, 44, '2021-05-14 21:03:47'),
(924, 3, 'Venta', 'Factura #10235', 40, 10, '2021-05-14 21:03:47'),
(925, 104, 'Venta', 'Factura #10235', 7, 6, '2021-05-14 21:03:47'),
(926, 34, 'Venta', 'Factura #10235', 16, 15, '2021-05-14 21:03:47'),
(927, 51, 'Venta', 'Factura #10235', 26, 6, '2021-05-14 21:03:47'),
(928, 99, 'Venta', 'Factura #10236', 33, 32, '2021-05-14 21:07:20'),
(929, 57, 'Venta', 'Factura #10236', 46, 45, '2021-05-14 21:07:20'),
(930, 100, 'Venta', 'Factura #10237', 29, 25, '2021-05-14 21:24:36'),
(931, 30, 'Venta', 'Factura #10238', 46, 45, '2021-05-14 21:37:58'),
(932, 100, 'Venta', 'Factura #10239', 25, 24, '2021-05-15 14:07:10'),
(933, 3, 'Entrada', '', 10, 16, '2021-05-15 14:21:13'),
(934, 56, 'Venta', 'Factura #10240', 17, 13, '2021-05-15 14:43:21'),
(935, 13, 'Venta', 'Factura #10241', 7, 3, '2021-05-15 14:56:15'),
(936, 56, 'Venta', 'Factura #10241', 13, 7, '2021-05-15 14:56:15'),
(937, 4, 'Venta', 'Factura #10241', 44, 32, '2021-05-15 14:56:15'),
(938, 44, 'Venta', 'Factura #10241', 4, 2, '2021-05-15 14:56:15'),
(939, 57, 'Venta', 'Factura #10242', 45, 44, '2021-05-15 15:38:23'),
(940, 53, 'Venta', 'Factura #10242', 15, 14, '2021-05-15 15:38:23'),
(941, 100, 'Venta', 'Factura #10242', 24, 23, '2021-05-15 15:38:23'),
(942, 53, 'Venta', 'Factura #10243', 15, 14, '2021-05-15 15:42:35'),
(943, 56, 'Venta', 'Factura #10243', 7, 5, '2021-05-15 15:42:35'),
(944, 92, 'Venta', 'Factura #10244', 2, 1, '2021-05-15 15:46:56'),
(945, 55, 'Venta', 'Factura #10244', 253, 249, '2021-05-15 15:46:56'),
(946, 57, 'Venta', 'Factura #10245', 44, 43, '2021-05-15 15:51:05'),
(947, 9, 'Entrada', '', 7, 17, '2021-05-15 16:12:23'),
(948, 10, 'Entrada', '', 0, 6, '2021-05-15 16:12:33'),
(949, 11, 'Entrada', '', 13, 30, '2021-05-15 16:12:50'),
(950, 20, 'Venta', 'Factura #10246', 7, 4, '2021-05-15 16:48:20'),
(951, 21, 'Venta', 'Factura #10246', 6, 3, '2021-05-15 16:48:20'),
(952, 19, 'Venta', 'Factura #10246', 1, 0, '2021-05-15 16:48:20'),
(953, 5, 'Venta', 'Factura #10246', 21, 18, '2021-05-15 16:48:20'),
(954, 10, 'Venta', 'Factura #10246', 6, 3, '2021-05-15 16:48:20'),
(955, 4, 'Venta', 'Factura #10246', 32, 28, '2021-05-15 16:48:20'),
(956, 22, 'Venta', 'Factura #10246', 88, 86, '2021-05-15 16:48:20'),
(957, 39, 'Venta', 'Factura #10246', 5, 2, '2021-05-15 16:48:20'),
(958, 30, 'Venta', 'Factura #10246', 45, 43, '2021-05-15 16:48:20'),
(959, 31, 'Venta', 'Factura #10246', 6, 5, '2021-05-15 16:48:20'),
(960, 100, 'Venta', 'Factura #10247', 23, 22, '2021-05-15 17:10:33'),
(961, 53, 'Venta', 'Factura #10248', 15, 14, '2021-05-15 19:51:54'),
(962, 5, 'Venta', 'Factura #10248', 18, 17, '2021-05-15 19:51:54'),
(963, 6, 'Venta', 'Factura #10248', 5, 4, '2021-05-15 19:51:54'),
(964, 7, 'Venta', 'Factura #10248', 73, 72, '2021-05-15 19:51:54'),
(965, 3, 'Venta', 'Factura #10248', 16, 15, '2021-05-15 19:51:54'),
(966, 55, 'Venta', 'Factura #10249', 249, 246, '2021-05-15 20:59:34'),
(967, 30, 'Venta', 'Factura #10249', 43, 42, '2021-05-15 20:59:35'),
(968, 3, 'Venta', 'Factura #10249', 15, 13, '2021-05-15 20:59:35'),
(969, 53, 'Venta', 'Factura #10249', 14, 13, '2021-05-15 20:59:35'),
(970, 7, 'Venta', 'Factura #10249', 73, 71, '2021-05-15 20:59:35'),
(971, 4, 'Venta', 'Factura #10249', 29, 27, '2021-05-15 20:59:35'),
(972, 22, 'Venta', 'Factura #10250', 87, 86, '2021-05-15 21:00:11'),
(973, 56, 'Venta', 'Factura #10251', 5, 0, '2021-05-15 21:10:11'),
(974, 27, 'Entrada', '', 0, 1, '2021-05-15 21:29:26'),
(975, 5, 'Entrada', '', 18, 34, '2021-05-15 21:51:43'),
(976, 67, 'Entrada', '', 4, 6, '2021-05-15 21:52:37'),
(977, 23, 'Entrada', '', 5, 6, '2021-05-15 21:52:55'),
(978, 71, 'Entrada', '', 0, 0, '2021-05-15 21:53:12'),
(979, 95, 'Entrada', '', 2, 2, '2021-05-15 21:53:32'),
(980, 8, 'Entrada', '', 58, 61, '2021-05-15 21:54:03'),
(981, 7, 'Entrada', '', 72, 109, '2021-05-15 21:54:16'),
(982, 76, 'Entrada', '', 1, 1, '2021-05-15 21:54:43'),
(983, 78, 'Entrada', '', 2, 2, '2021-05-15 21:54:58'),
(984, 32, 'Entrada', '', 2, 9, '2021-05-15 21:55:17'),
(985, 112, 'Entrada', '', 14, 17, '2021-05-15 21:55:43'),
(986, 30, 'Entrada', '', 42, 45, '2021-05-15 21:56:10'),
(987, 103, 'Entrada', '', 0, 2, '2021-05-15 21:56:29'),
(988, 86, 'Entrada', '', 1, 1, '2021-05-15 21:56:48'),
(989, 17, 'Entrada', '', 2, 8, '2021-05-15 21:57:06'),
(990, 92, 'Entrada', '', 2, 4, '2021-05-15 21:57:19'),
(991, 24, 'Entrada', '', -8, 1, '2021-05-15 22:21:16'),
(992, 20, 'Entrada', '', -1, 2, '2021-05-15 22:21:35'),
(993, 27, 'Entrada', '', 0, 1, '2021-05-15 22:23:54'),
(994, 55, 'Venta', 'Factura #10252', 246, 43, '2021-05-15 22:45:42'),
(995, 5, 'Venta', 'Factura #10252', 20, 19, '2021-05-15 22:45:42'),
(996, 24, 'Venta', 'Factura #10252', 1, 0, '2021-05-15 22:45:42'),
(997, 20, 'Venta', 'Factura #10252', 2, 0, '2021-05-15 22:45:42'),
(998, 7, 'Venta', 'Factura #10252', 73, 70, '2021-05-15 22:45:42'),
(999, 105, 'Venta', 'Factura #10252', 2, 0, '2021-05-15 22:45:42'),
(1000, 136, 'Venta', 'Factura #10252', 50, 40, '2021-05-15 22:45:42'),
(1001, 27, 'Venta', 'Factura #10252', 0, -1, '2021-05-15 22:45:42'),
(1002, 31, 'Venta', 'Factura #10252', 6, 4, '2021-05-15 22:45:42'),
(1003, 30, 'Venta', 'Factura #10252', 43, 41, '2021-05-15 22:45:42'),
(1004, 13, 'Venta', 'Factura #10252', 4, 1, '2021-05-15 22:45:42'),
(1005, 53, 'Venta', 'Factura #10252', 39, 36, '2021-05-15 22:45:42'),
(1006, 11, 'Venta', 'Factura #10252', 39, 34, '2021-05-15 22:45:42'),
(1007, 39, 'Venta', 'Factura #10252', 14, 13, '2021-05-15 22:45:42'),
(1008, 50, 'Venta', 'Factura #10252', 2, 1, '2021-05-15 22:45:42'),
(1009, 115, 'Venta', 'Factura #10252', 2, 0, '2021-05-15 22:45:42'),
(1010, 9, 'Venta', 'Factura #10252', 57, 53, '2021-05-15 22:45:42'),
(1011, 3, 'Venta', 'Factura #10252', 99, 92, '2021-05-15 22:45:42'),
(1012, 47, 'Venta', 'Factura #10252', 2, 0, '2021-05-15 22:45:42'),
(1013, 99, 'Venta', 'Factura #10253', 32, 31, '2021-05-16 13:24:09'),
(1014, 100, 'Venta', 'Factura #10253', 22, 21, '2021-05-16 13:24:09'),
(1015, 55, 'Entrada', '', 43, 68, '2021-05-16 14:04:33'),
(1016, 6, 'Entrada', '', 188, 191, '2021-05-16 14:04:49'),
(1017, 3, 'Entrada', '', 92, 103, '2021-05-16 14:05:02'),
(1018, 9, 'Entrada', '', 53, 58, '2021-05-16 14:05:12'),
(1019, 8, 'Venta', 'Factura #10254', 59, 43, '2021-05-16 14:11:48'),
(1020, 30, 'Venta', 'Factura #10255', 41, 38, '2021-05-16 14:53:01'),
(1021, 30, 'Venta', 'Factura #10256', 38, 37, '2021-05-16 14:59:53'),
(1022, 118, 'Entrada', '', 2, 24, '2021-05-16 15:17:41'),
(1023, 58, 'Entrada', '', 2, 12, '2021-05-16 15:19:35'),
(1024, 55, 'Venta', 'Factura #10257', 68, 62, '2021-05-16 15:27:35'),
(1025, 5, 'Venta', 'Factura #10258', 19, 17, '2021-05-16 15:34:42'),
(1026, 4, 'Venta', 'Factura #10258', 43, 40, '2021-05-16 15:34:42'),
(1027, 55, 'Venta', 'Factura #10258', 62, 59, '2021-05-16 15:34:42'),
(1028, 51, 'Venta', 'Factura #10259', 7, 4, '2021-05-16 15:39:01'),
(1029, 4, 'Venta', 'Factura #10259', 41, 38, '2021-05-16 15:39:01'),
(1030, 7, 'Venta', 'Factura #10259', 70, 66, '2021-05-16 15:39:01'),
(1031, 5, 'Venta', 'Factura #10259', 17, 12, '2021-05-16 15:39:01'),
(1032, 3, 'Venta', 'Factura #10259', 103, 101, '2021-05-16 15:39:01'),
(1033, 30, 'Venta', 'Factura #10260', 37, 35, '2021-05-16 17:58:14'),
(1034, 55, 'Venta', 'Factura #10260', 59, 58, '2021-05-16 17:58:14'),
(1035, 30, 'Venta', 'Factura #10260', 37, 35, '2021-05-16 18:03:04'),
(1036, 55, 'Venta', 'Factura #10260', 59, 56, '2021-05-16 18:03:04'),
(1037, 4, 'Venta', 'Factura #10261', 38, 36, '2021-05-16 21:02:57'),
(1038, 5, 'Venta', 'Factura #10261', 13, 11, '2021-05-16 21:02:57'),
(1039, 39, 'Venta', 'Factura #10261', 13, 11, '2021-05-16 21:02:57'),
(1040, 8, 'Venta', 'Factura #10261', 43, 42, '2021-05-16 21:02:57'),
(1041, 7, 'Venta', 'Factura #10261', 67, 66, '2021-05-16 21:02:57'),
(1042, 9, 'Venta', 'Factura #10261', 58, 56, '2021-05-16 21:02:57'),
(1043, 22, 'Venta', 'Factura #10261', 84, 83, '2021-05-16 21:02:57'),
(1044, 99, 'Venta', 'Factura #10261', 31, 30, '2021-05-16 21:02:57'),
(1045, 79, 'Venta', 'Factura #10261', 1, 0, '2021-05-16 21:02:57'),
(1046, 30, 'Venta', 'Factura #10261', 35, 33, '2021-05-16 21:02:57'),
(1047, 20, 'Entrada', '', 0, 3, '2021-05-17 14:30:51'),
(1048, 54, 'Entrada', '', 13, 27, '2021-05-17 14:31:17'),
(1049, 21, 'Entrada', '', 10, 12, '2021-05-17 14:31:39'),
(1050, 44, 'Entrada', '', 12, 16, '2021-05-17 14:32:01'),
(1051, 19, 'Entrada', '', 2, 3, '2021-05-17 14:32:26'),
(1052, 13, 'Entrada', '', 1, 4, '2021-05-17 14:32:46'),
(1053, 51, 'Entrada', '', 4, 7, '2021-05-17 14:33:09'),
(1054, 25, 'Entrada', '', 5, 11, '2021-05-17 14:33:28'),
(1055, 39, 'Entrada', '', 11, 15, '2021-05-17 14:33:57'),
(1056, 55, 'Entrada', '', 56, 65, '2021-05-17 14:34:18'),
(1057, 0, 'Entrada', '', 0, 17, '2021-05-17 15:58:25'),
(1058, 122, 'Entrada', '', 2, 3, '2021-05-17 18:48:29'),
(1059, 58, 'Venta', 'Factura #10267', 12, 11, '2021-05-17 20:27:44'),
(1060, 58, 'Venta', 'Factura #10268', 11, 10, '2021-05-17 20:28:50'),
(1061, 100, 'Venta', 'Factura #10269', 21, 20, '2021-05-17 21:41:40'),
(1062, 99, 'Venta', 'Factura #10269', 30, 29, '2021-05-17 21:41:40'),
(1063, 4, 'Venta', 'Factura #10270', 36, 26, '2021-05-19 12:30:45'),
(1064, 55, 'Venta', 'Factura #10270', 65, 62, '2021-05-19 12:30:45'),
(1065, 4, 'Venta', 'Factura #10271', 26, 16, '2021-05-19 13:15:26'),
(1066, 13, 'Venta', 'Factura #10271', 5, 3, '2021-05-19 13:15:26'),
(1067, 53, 'Venta', 'Factura #10271', 36, 34, '2021-05-19 13:15:26'),
(1068, 122, 'Venta', 'Factura #10271', 3, 1, '2021-05-19 13:15:26'),
(1069, 100, 'Venta', 'Factura #10272', 20, 19, '2021-05-19 13:36:21'),
(1070, 5, 'Entrada', '', 11, 15, '2021-05-19 14:31:57'),
(1071, 4, 'Entrada', '', 16, 30, '2021-05-19 14:32:06'),
(1072, 4, 'Entrada', '', 30, 41, '2021-05-19 14:34:59'),
(1073, 33, 'Entrada', '', 0, 0, '2021-05-19 14:35:26'),
(1074, 33, 'Entrada', '', 0, 0, '2021-05-19 14:36:22'),
(1075, 33, 'Entrada', '', 0, 0, '2021-05-19 14:36:54'),
(1076, 55, 'Entrada', '', 62, 90, '2021-05-19 15:05:16'),
(1077, 33, 'Entrada', '', 0, 0, '2021-05-19 15:11:12'),
(1078, 93, 'Venta', 'Factura #10273', 2, 1, '2021-05-19 15:12:14'),
(1079, 53, 'Venta', 'Factura #10274', 36, 34, '2021-05-19 15:29:08'),
(1080, 4, 'Venta', 'Factura #10274', 52, 45, '2021-05-19 15:29:08'),
(1081, 122, 'Venta', 'Factura #10274', 3, 1, '2021-05-19 15:29:08'),
(1082, 13, 'Venta', 'Factura #10274', 5, 3, '2021-05-19 15:29:08'),
(1083, 99, 'Venta', 'Factura #10275', 28, 27, '2021-05-19 16:02:48'),
(1084, 55, 'Venta', 'Factura #10276', 90, 85, '2021-05-19 18:14:36'),
(1085, 4, 'Venta', 'Factura #10277', 45, 40, '2021-05-19 18:15:51'),
(1086, 39, 'Venta', 'Factura #10277', 15, 11, '2021-05-19 18:15:51'),
(1087, 33, 'Entrada', '', 0, 0, '2021-05-19 18:19:31'),
(1088, 33, 'Entrada', '', 0, 0, '2021-05-19 18:20:46'),
(1089, 118, 'Venta', 'Factura #10278', 24, 22, '2021-05-19 19:24:45'),
(1090, 55, 'Venta', 'Factura #10279', 85, 55, '2021-05-20 14:40:32'),
(1091, 55, 'Venta', 'Factura #10280', 55, 46, '2021-05-20 15:24:39'),
(1092, 55, 'Venta', 'Factura #10281', 46, 36, '2021-05-20 20:49:14'),
(1093, 4, 'Venta', 'Factura #10282', 45, 40, '2021-05-20 21:00:33'),
(1094, 39, 'Venta', 'Factura #10282', 15, 11, '2021-05-20 21:00:33'),
(1095, 99, 'Venta', 'Factura #10283', 27, 26, '2021-05-21 12:18:18'),
(1096, 20, 'Entrada', '', 3, 7, '2021-05-21 15:10:42'),
(1097, 21, 'Entrada', '', 11, 16, '2021-05-21 15:10:58'),
(1098, 13, 'Entrada', '', 3, 7, '2021-05-21 15:11:14'),
(1099, 39, 'Entrada', '', 11, 15, '2021-05-21 15:11:31'),
(1100, 51, 'Entrada', '', 4, 8, '2021-05-21 15:11:48'),
(1101, 3, 'Entrada', '', 99, 103, '2021-05-21 15:12:19'),
(1102, 4, 'Entrada', '', 39, 56, '2021-05-21 15:12:36'),
(1103, 9, 'Entrada', '', 56, 75, '2021-05-21 15:12:52'),
(1104, 22, 'Entrada', '', 84, 88, '2021-05-21 15:13:09'),
(1105, 121, 'Entrada', '', 0, 20, '2021-05-21 15:13:29'),
(1106, 11, 'Entrada', '', 22, 44, '2021-05-21 15:13:43'),
(1107, 53, 'Entrada', '', 34, 43, '2021-05-21 15:13:58'),
(1108, 6, 'Entrada', '', 192, 195, '2021-05-21 15:14:15'),
(1109, 5, 'Entrada', '', 16, 25, '2021-05-21 15:14:29'),
(1110, 4, 'Venta', 'Factura #10284', 57, 55, '2021-05-21 15:18:02'),
(1111, 138, 'Compra', 'Compra factura #1102', 1, 6, '2021-05-21 15:24:30'),
(1112, 61, 'Entrada', '', 0, 50, '2021-05-21 15:25:11'),
(1113, 100, 'Venta', 'Factura #10285', 19, 17, '2021-05-21 15:33:31'),
(1114, 100, 'Venta', 'Factura #10286', 17, 16, '2021-05-21 20:10:31'),
(1115, 53, 'Entrada', '', 44, 67, '2021-05-22 12:55:58'),
(1116, 53, 'Venta', 'Factura #10287', 67, 66, '2021-05-22 15:43:56'),
(1117, 4, 'Venta', 'Factura #10287', 56, 55, '2021-05-22 15:43:56'),
(1118, 61, 'Venta', 'Factura #10288', 50, 47, '2021-05-22 18:03:07'),
(1119, 61, 'Compra', 'Compra factura #7072', 4800, 4850, '2021-05-22 18:41:29'),
(1120, 54, 'Venta', 'Factura #10289', 27, 25, '2021-05-22 18:54:02'),
(1121, 53, 'Compra', 'Compra factura #0001', 6600, 6623, '2021-05-22 18:55:09'),
(1122, 55, 'Compra', 'Compra factura #0001', 29000, 29200, '2021-05-22 18:55:09'),
(1123, 8, 'Entrada', '', 42, 92, '2021-05-22 19:06:39'),
(1124, 17, 'Entrada', '', 1, 3, '2021-05-22 19:19:51'),
(1125, 53, 'Venta', 'Factura #10290', 32, 30, '2021-05-22 19:22:32'),
(1126, 17, 'Venta', 'Factura #10290', 4, 1, '2021-05-22 19:22:32'),
(1127, 55, 'Venta', 'Factura #10290', 200, 198, '2021-05-22 19:22:32'),
(1128, 58, 'Venta', 'Factura #10290', 10, 9, '2021-05-22 19:22:32'),
(1129, 133, 'Entrada', '', 0, 6, '2021-05-22 19:51:22'),
(1130, 41, 'Entrada', '', 0, 5, '2021-05-22 19:51:48'),
(1131, 103, 'Entrada', '', 2, 5, '2021-05-22 19:52:08'),
(1132, 122, 'Entrada', '', 1, 4, '2021-05-22 19:52:24'),
(1133, 27, 'Entrada', '', -1, 3, '2021-05-22 19:52:56'),
(1134, 55, 'Venta', 'Factura #10291', 198, 158, '2021-05-23 15:14:31'),
(1135, 30, 'Venta', 'Factura #10292', 32, 31, '2021-05-23 15:15:36'),
(1136, 13, 'Venta', 'Factura #10293', 7, 6, '2021-05-23 15:20:26'),
(1137, 39, 'Venta', 'Factura #10293', 14, 13, '2021-05-23 15:20:26'),
(1138, 4, 'Venta', 'Factura #10293', 30, 29, '2021-05-23 15:20:26'),
(1139, 27, 'Venta', 'Factura #10293', 3, 2, '2021-05-23 15:20:26'),
(1140, 57, 'Venta', 'Factura #10294', 43, 42, '2021-05-23 16:02:15'),
(1141, 118, 'Venta', 'Factura #10295', 22, 21, '2021-05-23 16:04:27'),
(1142, 55, 'Venta', 'Factura #10296', 158, 148, '2021-05-23 16:13:12'),
(1143, 118, 'Venta', 'Factura #10297', 21, 20, '2021-05-23 17:57:44'),
(1144, 53, 'Venta', 'Factura #10298', 30, 23, '2021-05-24 12:15:51'),
(1145, 5, 'Venta', 'Factura #10298', 22, 19, '2021-05-24 12:15:51'),
(1146, 22, 'Venta', 'Factura #10298', 10, 9, '2021-05-24 12:15:51'),
(1147, 9, 'Venta', 'Factura #10298', 8, 2, '2021-05-24 12:15:51'),
(1148, 61, 'Venta', 'Factura #10298', 48, 45, '2021-05-24 12:15:51'),
(1149, 54, 'Venta', 'Factura #10298', 25, 23, '2021-05-24 12:15:51'),
(1150, 121, 'Venta', 'Factura #10298', 21, 18, '2021-05-24 12:15:51'),
(1151, 100, 'Venta', 'Factura #10299', 16, 15, '2021-05-24 12:45:08'),
(1152, 99, 'Venta', 'Factura #10300', 26, 25, '2021-05-24 13:05:58'),
(1153, 57, 'Venta', 'Factura #10301', 42, 41, '2021-05-24 14:09:55'),
(1154, 55, 'Venta', 'Factura #10302', 148, 138, '2021-05-24 14:30:39'),
(1155, 3, 'Entrada', '', 0, 7, '2021-05-24 21:22:43'),
(1156, 3, 'Venta', 'Factura #10303', 7, 1, '2021-05-24 21:23:23'),
(1157, 61, 'Venta', 'Factura #10303', 45, 44, '2021-05-24 21:23:23'),
(1158, 53, 'Venta', 'Factura #10304', 24, 21, '2021-05-24 21:27:01'),
(1159, 55, 'Venta', 'Factura #10304', 138, 128, '2021-05-24 21:27:01'),
(1160, 25, 'Venta', 'Factura #10304', 11, 7, '2021-05-24 21:27:01'),
(1161, 7, 'Venta', 'Factura #10304', 65, 64, '2021-05-24 21:27:01'),
(1162, 61, 'Venta', 'Factura #10304', 44, 42, '2021-05-24 21:27:01'),
(1163, 109, 'Venta', 'Factura #10304', 1, 0, '2021-05-24 21:27:01'),
(1164, 118, 'Venta', 'Factura #10305', 20, 19, '2021-05-24 21:27:30'),
(1165, 4, 'Venta', 'Factura #10306', 29, 26, '2021-05-24 21:28:50'),
(1166, 4, 'Venta', 'Factura #10307', 27, 23, '2021-05-24 21:30:32'),
(1167, 121, 'Venta', 'Factura #10307', 18, 13, '2021-05-24 21:30:32'),
(1168, 61, 'Venta', 'Factura #10307', 42, 41, '2021-05-24 21:30:32'),
(1169, 99, 'Venta', 'Factura #10308', 25, 22, '2021-05-24 21:31:21'),
(1170, 100, 'Venta', 'Factura #10308', 15, 14, '2021-05-24 21:31:21'),
(1171, 57, 'Venta', 'Factura #10309', 41, 39, '2021-05-26 12:22:14'),
(1172, 15, '', 'No apto para la venta', 3, 1, '2021-05-26 12:23:37'),
(1173, 27, '', 'Producto dañado', 2, 0, '2021-05-26 12:24:42'),
(1174, 136, '', 'No apto para la venta', 34, 31, '2021-05-26 12:25:28'),
(1175, 53, '', 'No apto para la venta', 21, 20, '2021-05-26 12:27:38'),
(1176, 12, '', 'Producto dañado', 38, 37, '2021-05-26 12:28:12'),
(1177, 54, '', 'Producto dañado', 23, 22, '2021-05-26 12:28:46'),
(1178, 4, '', 'No apto para la venta', 24, 21, '2021-05-26 12:29:18'),
(1179, 3, '', 'producto dañado', 2, 0, '2021-05-26 12:35:31'),
(1180, 100, 'Venta', 'Factura #10310', 14, 12, '2021-05-26 12:57:39'),
(1181, 20, 'Entrada manual de producto', '', 5, 13, '2021-05-26 12:58:33'),
(1182, 21, 'Entrada manual de producto', '', 16, 21, '2021-05-26 12:59:37'),
(1183, 13, 'Entrada manual de producto', '', 6, 10, '2021-05-26 12:59:57'),
(1184, 14, 'Entrada manual de producto', '', 10, 11, '2021-05-26 13:00:17'),
(1185, 15, 'Entrada manual de producto', '', 2, 5, '2021-05-26 13:00:36'),
(1186, 43, 'Entrada manual de producto', '', 0, 1, '2021-05-26 13:00:58'),
(1187, 44, 'Entrada manual de producto', '', 17, 22, '2021-05-26 13:01:18'),
(1188, 19, 'Entrada manual de producto', '', 3, 4, '2021-05-26 13:01:34'),
(1189, 39, 'Entrada manual de producto', '', 13, 21, '2021-05-26 13:01:55'),
(1190, 16, '', 'Producto dañado', 6, 0, '2021-05-26 13:58:52'),
(1191, 140, 'Entrada manual de producto', '', 1, 2, '2021-05-26 14:50:34'),
(1192, 139, 'Entrada manual de producto', '', 1, 3, '2021-05-26 14:50:44'),
(1193, 139, 'Compra', 'Compra factura #0001', 3, 6, '2021-05-26 14:55:48'),
(1194, 140, 'Compra', 'Compra factura #0001', 2, 4, '2021-05-26 14:55:48'),
(1195, 141, 'Compra', 'Compra factura #0001', 6, 12, '2021-05-26 14:55:48'),
(1196, 142, 'Compra', 'Compra factura #0001', 1, 4, '2021-05-26 14:55:48'),
(1197, 141, 'Venta', 'Factura #10311', 12, 11, '2021-05-26 14:58:21'),
(1198, 141, 'Venta', 'Factura #10312', 11, 10, '2021-05-26 14:59:10'),
(1199, 9, 'Entrada manual de producto', '', 3, 15, '2021-05-26 15:03:52'),
(1200, 141, '', '', 10, 4, '2021-05-26 15:04:35'),
(1201, 140, '', '', 4, 2, '2021-05-26 15:04:48'),
(1202, 139, '', '', 6, 3, '2021-05-26 15:04:59'),
(1203, 142, '', '', 4, 3, '2021-05-26 15:05:11'),
(1204, 71, 'Entrada manual de producto', '', 0, 3, '2021-05-26 15:26:02'),
(1205, 55, 'Venta', 'Factura #10313', 128, 127, '2021-05-26 15:32:25'),
(1206, 53, 'Venta', 'Factura #10314', 21, 20, '2021-05-26 15:34:11'),
(1207, 90, 'Entrada manual de producto', '', 0, 2, '2021-05-26 15:43:59'),
(1208, 118, 'Venta', 'Factura #10315', 19, 18, '2021-05-26 18:28:55'),
(1209, 100, 'Venta', 'Factura #10316', 12, 11, '2021-05-26 19:00:32'),
(1210, 30, 'Venta', 'Factura #10317', 28, 26, '2021-05-26 19:02:44'),
(1211, 57, 'Venta', 'Factura #10318', 39, 38, '2021-05-26 19:15:11'),
(1212, 118, 'Venta', 'Factura #10319', 18, 17, '2021-05-26 20:05:03'),
(1213, 8, '', 'Producto dañado', 92, 91, '2021-05-26 20:08:29'),
(1214, 5, 'Compra', 'Compra factura #00010', 18, 103, '2021-05-26 20:20:22'),
(1215, 130, 'Compra', 'Compra factura #00010', 0, 30, '2021-05-26 20:20:22'),
(1216, 4, 'Compra', 'Compra factura #00010', 21, 76, '2021-05-26 20:20:22'),
(1217, 100, 'Venta', 'Factura #10320', 11, 10, '2021-05-26 21:24:32'),
(1218, 122, '', 'Producto dañado', 4, 3, '2021-05-27 20:29:39'),
(1219, 6, '', 'Producto dañado', 6, 5, '2021-05-27 20:30:14'),
(1220, 133, '', 'Producto dañado', 6, 4, '2021-05-27 20:30:33'),
(1221, 11, '', 'Producto dañado', 44, 43, '2021-05-27 20:30:57'),
(1222, 100, 'Venta', 'Factura #10321', 10, 9, '2021-05-27 20:31:48'),
(1223, 57, 'Venta', 'Factura #10321', 38, 35, '2021-05-27 20:31:48'),
(1224, 58, 'Venta', 'Factura #10322', 9, 6, '2021-05-27 20:33:34'),
(1225, 141, 'Venta', 'Factura #10322', 4, 3, '2021-05-27 20:33:34'),
(1226, 22, 'Venta', 'Factura #10323', 9, 7, '2021-05-27 21:29:13'),
(1227, 9, 'Venta', 'Factura #10323', 15, 5, '2021-05-27 21:29:13'),
(1228, 7, 'Venta', 'Factura #10323', 64, 61, '2021-05-27 21:29:13'),
(1229, 4, 'Venta', 'Factura #10323', 76, 69, '2021-05-27 21:29:13'),
(1230, 19, 'Venta', 'Factura #10323', 4, 3, '2021-05-27 21:29:13'),
(1231, 6, 'Venta', 'Factura #10323', 5, 2, '2021-05-27 21:29:13'),
(1232, 5, 'Venta', 'Factura #10323', 103, 99, '2021-05-27 21:29:13'),
(1233, 30, 'Venta', 'Factura #10323', 26, 22, '2021-05-27 21:29:13'),
(1234, 13, 'Compra', 'Compra factura #00002', 10, 15, '2021-05-27 21:37:04'),
(1235, 20, 'Compra', 'Compra factura #00002', 13, 41, '2021-05-27 21:37:04'),
(1236, 21, 'Compra', 'Compra factura #00002', 21, 57, '2021-05-27 21:37:04'),
(1237, 17, 'Compra', 'Compra factura #00002', 1, 7, '2021-05-27 21:37:04'),
(1238, 51, 'Compra', 'Compra factura #00002', 8, 33, '2021-05-27 21:37:04'),
(1239, 39, 'Compra', 'Compra factura #00002', 21, 31, '2021-05-27 21:37:04'),
(1240, 5, 'Compra', 'Compra factura #0002', 99, 149, '2021-05-27 21:38:20'),
(1241, 4, 'Compra', 'Compra factura #0002', 69, 94, '2021-05-27 21:38:20'),
(1242, 5, 'Venta', 'Factura #10324', 99, 95, '2021-05-27 21:43:53'),
(1243, 13, 'Venta', 'Factura #10324', 10, 8, '2021-05-27 21:43:53'),
(1244, 53, 'Venta', 'Factura #10324', 20, 15, '2021-05-27 21:43:53'),
(1245, 4, 'Venta', 'Factura #10324', 69, 64, '2021-05-27 21:43:53'),
(1246, 41, 'Venta', 'Factura #10324', 5, 4, '2021-05-27 21:43:53'),
(1247, 103, '', 'producto dañado', 5, 0, '2021-05-28 12:56:14'),
(1248, 55, 'Venta', 'Factura #10325', 127, 123, '2021-05-28 12:59:31'),
(1249, 15, '', 'no apto para la venta', 5, 4, '2021-05-28 13:31:58'),
(1250, 118, 'Venta', 'Factura #10326', 17, 16, '2021-05-28 13:36:26'),
(1251, 61, 'Venta', 'Factura #10327', 41, 38, '2021-05-28 14:46:18'),
(1252, 18, '', 'Producto dañado', 13, 12, '2021-05-28 19:57:26'),
(1253, 118, 'Venta', 'Factura #10328', 16, 15, '2021-05-28 19:59:11'),
(1254, 4, 'Venta', 'Factura #10329', 64, 61, '2021-05-29 13:03:30'),
(1255, 22, 'Entrada manual de producto', '', 8, 22, '2021-05-29 13:06:54'),
(1256, 57, 'Venta', 'Factura #10330', 35, 34, '2021-05-29 13:55:27'),
(1257, 27, 'Entrada manual de producto', '', 0, 5, '2021-05-29 14:13:46'),
(1258, 103, 'Entrada manual de producto', '', 0, 4, '2021-05-29 14:14:04'),
(1259, 133, '', 'Producto dañado', 4, 0, '2021-05-29 15:08:12'),
(1260, 41, '', 'Producto dañado', 4, 0, '2021-05-29 15:08:36'),
(1261, 44, '', 'Producto dañado', 22, 21, '2021-05-29 15:09:28'),
(1262, 55, 'Venta', 'Factura #10331', 123, 121, '2021-05-29 15:51:50'),
(1263, 55, 'Venta', 'Factura #10332', 121, 117, '2021-05-29 15:52:53'),
(1264, 27, 'Venta', 'Factura #10332', 5, 4, '2021-05-29 15:52:53'),
(1265, 103, 'Venta', 'Factura #10332', 4, 3, '2021-05-29 15:52:53'),
(1266, 55, 'Venta', 'Factura #10332', 117, 113, '2021-05-29 15:54:38'),
(1267, 27, 'Venta', 'Factura #10332', 4, 3, '2021-05-29 15:54:38'),
(1268, 103, 'Venta', 'Factura #10332', 3, 2, '2021-05-29 15:54:38'),
(1269, 6, 'Entrada manual de producto', '', 2, 7, '2021-05-29 16:04:51'),
(1270, 53, 'Entrada manual de producto', '', 15, 32, '2021-05-29 16:06:13'),
(1271, 55, 'Entrada manual de producto', '', 113, 143, '2021-05-29 16:06:25'),
(1272, 17, 'Compra', 'Compra factura #7776', 7, 10, '2021-05-29 16:11:03'),
(1273, 19, 'Compra', 'Compra factura #7776', 3, 5, '2021-05-29 16:11:03'),
(1274, 43, 'Compra', 'Compra factura #7776', 1, 4, '2021-05-29 16:11:03'),
(1275, 44, 'Compra', 'Compra factura #7776', 21, 23, '2021-05-29 16:11:03'),
(1276, 15, 'Compra', 'Compra factura #7776', 4, 7, '2021-05-29 16:11:03'),
(1277, 57, 'Venta', 'Factura #10333', 34, 32, '2021-05-29 18:29:30'),
(1278, 100, 'Venta', 'Factura #10334', 9, 7, '2021-05-29 18:30:17'),
(1279, 100, 'Venta', 'Factura #10335', 7, 6, '2021-05-29 18:32:57'),
(1280, 100, 'Venta', 'Factura #10336', 6, 5, '2021-05-29 18:34:26'),
(1281, 5, 'Venta', 'Factura #10337', 96, 93, '2021-05-29 18:42:00'),
(1282, 61, 'Venta', 'Factura #10338', 38, 33, '2021-05-29 19:11:47'),
(1283, 92, 'Venta', 'Factura #10339', 4, 3, '2021-05-29 20:22:01'),
(1284, 143, 'Venta', 'Factura #10339', 1, 0, '2021-05-29 20:22:01'),
(1285, 15, 'Venta', 'Factura #10340', 7, 4, '2021-05-29 20:24:01'),
(1286, 5, '', 'Producto dañado\r\n', 94, 92, '2021-05-29 20:37:59'),
(1287, 118, 'Venta', 'Factura #10341', 15, 14, '2021-05-29 20:47:10'),
(1288, 11, '', 'Producto dañado', 43, 42, '2021-05-30 13:29:41'),
(1289, 9, '', 'Producto dañado\r\n', 6, 5, '2021-05-30 13:32:31'),
(1290, 54, '', 'No apto para la venta', 23, 22, '2021-05-30 13:33:21'),
(1291, 25, '', 'Producto dañado', 8, 7, '2021-05-30 13:33:53'),
(1292, 53, '', 'No apto para la venta', 37, 36, '2021-05-30 13:34:18'),
(1293, 7, '', 'Producto dañado', 61, 60, '2021-05-30 13:34:51'),
(1294, 118, 'Venta', 'Factura #10342', 14, 12, '2021-05-30 13:49:53'),
(1295, 57, 'Venta', 'Factura #10342', 32, 31, '2021-05-30 13:49:53'),
(1296, 100, 'Venta', 'Factura #10343', 5, 3, '2021-05-30 13:51:43'),
(1297, 100, 'Entrada manual de producto', '', 3, 9, '2021-05-30 13:53:03'),
(1298, 30, 'Venta', 'Factura #10344', 22, 18, '2021-05-30 15:51:17'),
(1299, 121, '', 'Producto dañado', 13, 12, '2021-05-31 12:15:33'),
(1300, 99, 'Venta', 'Factura #10345', 22, 21, '2021-05-31 12:50:44'),
(1301, 9, '', 'Producto dañado', 5, 2, '2021-05-31 12:53:11'),
(1302, 53, '', 'no apto para la venta', 37, 36, '2021-05-31 12:53:54'),
(1303, 54, '', 'No apto para la venta', 22, 21, '2021-05-31 12:54:40'),
(1304, 100, 'Venta', 'Factura #10346', 9, 8, '2021-05-31 12:58:20'),
(1305, 99, 'Venta', 'Factura #10346', 21, 20, '2021-05-31 12:58:20'),
(1306, 7, '', 'Producto dañado', 60, 57, '2021-05-31 14:21:05'),
(1307, 8, '', 'Producto dañado', 91, 86, '2021-05-31 14:29:16'),
(1308, 141, 'Venta', 'Factura #10347', 3, 2, '2021-05-31 14:49:31'),
(1309, 86, 'Venta', 'Factura #10348', 1, 0, '2021-05-31 14:59:31'),
(1310, 61, 'Venta', 'Factura #10349', 33, 27, '2021-05-31 15:06:02'),
(1311, 55, 'Venta', 'Factura #10350', 143, 103, '2021-05-31 15:23:12'),
(1312, 6, 'Venta', 'Factura #10350', 8, 4, '2021-05-31 15:23:12'),
(1313, 55, '', 'prodeucto dañado', 103, 101, '2021-05-31 15:26:18'),
(1314, 5, '', 'No apto para la venta', 95, 94, '2021-05-31 15:28:00'),
(1315, 6, '', 'Producto dañado', 4, 3, '2021-05-31 15:28:22'),
(1316, 57, 'Venta', 'Factura #10351', 31, 30, '2021-05-31 18:22:46'),
(1317, 57, 'Venta', 'Factura #10351', 31, 30, '2021-05-31 18:25:13'),
(1318, 55, 'Venta', 'Factura #10352', 101, 96, '2021-05-31 21:37:27'),
(1319, 54, 'Venta', 'Factura #10352', 22, 21, '2021-05-31 21:37:27'),
(1320, 157, 'Venta', 'Factura #10353', 2, 0, '2021-06-01 13:22:49'),
(1321, 153, 'Venta', 'Factura #10353', 2, 1, '2021-06-01 13:22:49'),
(1322, 57, 'Venta', 'Factura #10354', 30, 29, '2021-06-02 12:40:03'),
(1323, 9, '', 'Producto dañado', 3, 1, '2021-06-02 12:41:09'),
(1324, 6, '', 'no apto para la venta', 4, 3, '2021-06-02 12:41:54'),
(1325, 86, 'Venta', 'Factura #10355', 1, 0, '2021-06-02 12:45:19'),
(1326, 39, '', 'no apto para la venta', 31, 29, '2021-06-02 12:52:17'),
(1327, 100, 'Venta', 'Factura #10356', 8, 7, '2021-06-02 12:53:34'),
(1328, 55, '', 'Producto dañado', 96, 91, '2021-06-02 13:16:44'),
(1329, 20, '', 'Producto dañado', 41, 37, '2021-06-02 13:35:27'),
(1330, 25, '', 'Producto dañado', 7, 5, '2021-06-02 13:40:22'),
(1331, 55, 'Venta', 'Factura #10357', 91, 90, '2021-06-02 14:48:28'),
(1332, 55, 'Venta', 'Factura #10358', 90, 80, '2021-06-02 15:43:36'),
(1333, 71, 'Venta', 'Factura #10359', 3, 2, '2021-06-02 15:49:15'),
(1334, 55, 'Venta', 'Factura #10359', 80, 76, '2021-06-02 15:49:15'),
(1335, 4, 'Venta', 'Factura #10359', 66, 63, '2021-06-02 15:49:15'),
(1336, 11, 'Compra', 'Compra factura #0003', 43, 59, '2021-06-02 18:14:08'),
(1337, 55, 'Compra', 'Compra factura #0003', 76, 136, '2021-06-02 18:14:08'),
(1338, 55, 'Ajuste de inventario', '', 136, 71, '2021-06-02 18:14:45'),
(1339, 12, 'Ajuste de inventario', '', 38, 38, '2021-06-02 18:14:58'),
(1340, 11, 'Ajuste de inventario', '', 60, 25, '2021-06-02 18:16:00'),
(1341, 31, 'Ajuste de inventario', '', 2, 0, '2021-06-02 18:16:16'),
(1342, 113, 'Entrada manual de producto', '', 3, 11, '2021-06-02 18:20:00'),
(1343, 30, 'Ajuste de inventario', '', 18, 0, '2021-06-02 18:20:12'),
(1344, 57, 'Venta', 'Factura #10360', 29, 28, '2021-06-02 18:50:28'),
(1345, 100, 'Venta', 'Factura #10360', 7, 6, '2021-06-02 18:50:28'),
(1346, 3, 'Entrada manual de producto', '', 0, 1, '2021-06-02 20:19:12'),
(1347, 57, 'Venta', 'Factura #10361', 28, 21, '2021-06-02 21:24:32'),
(1348, 100, 'Venta', 'Factura #10361', 6, 5, '2021-06-02 21:24:32'),
(1349, 145, 'Compra', 'Compra factura #7809', 2, 6, '2021-06-02 21:27:20'),
(1350, 20, 'Compra', 'Compra factura #7809', 37, 42, '2021-06-02 21:27:20'),
(1351, 54, 'Compra', 'Compra factura #7809', 22, 42, '2021-06-02 21:27:20'),
(1352, 51, 'Compra', 'Compra factura #7809', 33, 37, '2021-06-02 21:27:20'),
(1353, 39, 'Compra', 'Compra factura #7809', 30, 45, '2021-06-02 21:27:20'),
(1354, 43, 'Compra', 'Compra factura #7809', 4, 5, '2021-06-02 21:27:20'),
(1355, 30, 'Entrada manual de producto', '', 0, 7, '2021-06-02 21:27:35'),
(1356, 32, 'Ajuste de inventario', '', 7, 4, '2021-06-02 21:27:53'),
(1357, 20, 'Venta', 'Factura #10362', 42, 41, '2021-06-02 21:35:13'),
(1358, 21, 'Venta', 'Factura #10362', 57, 56, '2021-06-02 21:35:13'),
(1359, 3, 'Venta', 'Factura #10362', 2, 1, '2021-06-02 21:35:13'),
(1360, 4, 'Venta', 'Factura #10362', 64, 62, '2021-06-02 21:35:13'),
(1361, 5, 'Venta', 'Factura #10362', 94, 92, '2021-06-02 21:35:13'),
(1362, 22, 'Venta', 'Factura #10362', 22, 21, '2021-06-02 21:35:13'),
(1363, 7, 'Venta', 'Factura #10362', 57, 56, '2021-06-02 21:35:13'),
(1364, 30, 'Venta', 'Factura #10362', 7, 6, '2021-06-02 21:35:13'),
(1365, 11, 'Venta', 'Factura #10362', 26, 24, '2021-06-02 21:35:13'),
(1366, 174, 'Venta', 'Factura #10362', 1, 0, '2021-06-02 21:37:10'),
(1367, 174, 'Entrada manual de producto', '', 0, 1, '2021-06-02 21:37:58'),
(1368, 174, 'Venta', 'Factura #10362', 1, 0, '2021-06-02 21:38:12'),
(1369, 118, 'Venta', 'Factura #10362', 12, 11, '2021-06-02 21:38:47'),
(1370, 5, '', 'producto dañado', 93, 92, '2021-06-03 12:05:48'),
(1371, 54, '', 'No apto para la venta', 42, 41, '2021-06-03 12:55:26'),
(1372, 57, 'Venta', 'Factura #10362', 21, 20, '2021-06-03 13:16:35'),
(1373, 20, '', 'Producto dañado', 41, 39, '2021-06-03 13:21:40'),
(1374, 55, '', 'producto dañado', 71, 69, '2021-06-03 13:24:08'),
(1375, 55, 'Venta', 'Factura #10363', 69, 29, '2021-06-03 15:02:03'),
(1376, 61, '', 'Producto dañado', 27, 26, '2021-06-03 15:12:37'),
(1377, 145, 'Venta', 'Factura #10364', 6, 5, '2021-06-04 03:07:20'),
(1378, 11, '', 'Producto dañado', 24, 23, '2021-06-04 12:41:47'),
(1379, 100, 'Venta', 'Factura #10364', 5, 4, '2021-06-04 12:59:43'),
(1380, 0, '', 'Producto dañado', 0, 0, '2021-06-04 13:29:02'),
(1381, 13, 'Producto averiado', '', 10, 9, '2021-06-04 13:32:04'),
(1382, 17, 'Producto averiado', '', 10, 8, '2021-06-04 13:55:58'),
(1383, 5, 'Venta', 'Factura #10365', 93, 89, '2021-06-04 14:29:12'),
(1384, 53, 'Venta', 'Factura #10365', 37, 32, '2021-06-04 14:29:12'),
(1385, 51, '', 'producto dañado', 37, 36, '2021-06-04 14:46:33'),
(1386, 23, 'Entrada manual de producto', '', 1, 3, '2021-06-04 18:19:32'),
(1387, 9, 'Entrada manual de producto', '', 1, 12, '2021-06-04 18:20:59'),
(1388, 9, 'Venta', 'Factura #10366', 13, 11, '2021-06-04 18:23:45'),
(1389, 51, 'Venta', 'Factura #10366', 37, 35, '2021-06-04 18:23:45'),
(1390, 7, 'Venta', 'Factura #10366', 56, 54, '2021-06-04 18:23:45'),
(1391, 23, 'Venta', 'Factura #10366', 3, 2, '2021-06-04 18:23:45'),
(1392, 4, 'Venta', 'Factura #10366', 63, 61, '2021-06-04 18:23:45'),
(1393, 55, 'Venta', 'Factura #10366', 29, 26, '2021-06-04 18:23:45'),
(1394, 58, 'Venta', 'Factura #10366', 6, 4, '2021-06-04 18:40:00'),
(1395, 118, 'Venta', 'Factura #10367', 11, 10, '2021-06-04 19:48:43'),
(1396, 7, 'Venta', 'Factura #10368', 54, 49, '2021-06-04 21:20:19'),
(1397, 55, 'Venta', 'Factura #10368', 26, 22, '2021-06-04 21:20:19'),
(1398, 4, 'Venta', 'Factura #10369', 61, 59, '2021-06-04 21:22:37'),
(1399, 51, 'Venta', 'Factura #10369', 35, 33, '2021-06-04 21:22:37'),
(1400, 7, 'Venta', 'Factura #10369', 49, 47, '2021-06-04 21:22:37'),
(1401, 9, 'Venta', 'Factura #10369', 11, 9, '2021-06-04 21:22:37'),
(1402, 23, 'Venta', 'Factura #10369', 2, 1, '2021-06-04 21:22:37'),
(1403, 55, 'Venta', 'Factura #10369', 22, 19, '2021-06-04 21:22:37'),
(1404, 51, '', 'Producto dañado', 33, 31, '2021-06-04 22:13:06'),
(1405, 55, 'Venta', 'Factura #10370', 19, 13, '2021-06-04 23:04:39'),
(1406, 21, 'Venta', 'Factura #10371', 56, 54, '2021-06-04 23:17:17'),
(1407, 5, 'Venta', 'Factura #10371', 89, 85, '2021-06-04 23:17:17'),
(1408, 99, 'Venta', 'Factura #10372', 20, 19, '2021-06-05 13:07:13'),
(1409, 100, 'Venta', 'Factura #10372', 4, 1, '2021-06-05 13:07:13'),
(1410, 100, 'Venta', 'Factura #10373', 1, 0, '2021-06-05 13:10:27'),
(1411, 100, 'Entrada manual de producto', '', 0, 4, '2021-06-05 13:11:02'),
(1412, 11, 'Venta', 'Factura #10374', 24, 17, '2021-06-05 16:06:08'),
(1413, 9, 'Venta', 'Factura #10374', 9, 6, '2021-06-05 16:06:08'),
(1414, 19, 'Venta', 'Factura #10374', 5, 4, '2021-06-05 16:06:08'),
(1415, 7, 'Venta', 'Factura #10374', 47, 44, '2021-06-05 16:06:08'),
(1416, 51, 'Producto averiado', '', 32, 31, '2021-06-05 16:22:06'),
(1417, 5, 'Venta', 'Factura #10375', 85, 77, '2021-06-05 17:15:20'),
(1418, 103, 'Venta', 'Factura #10375', 2, 1, '2021-06-05 17:15:20'),
(1419, 46, 'Venta', 'Factura #10375', 2, 1, '2021-06-05 17:15:20'),
(1420, 99, 'Venta', 'Factura #10376', 19, 18, '2021-06-05 17:48:55'),
(1421, 100, 'Venta', 'Factura #10377', 4, 3, '2021-06-05 18:01:49'),
(1422, 99, 'Venta', 'Factura #10378', 18, 17, '2021-06-05 18:42:33'),
(1423, 57, 'Venta', 'Factura #10379', 20, 19, '2021-06-05 19:02:20'),
(1424, 55, '', 'pruducto dañado', 13, 11, '2021-06-05 19:45:21'),
(1425, 61, '', 'No apto para la venta', 27, 25, '2021-06-06 13:32:43'),
(1426, 21, '', 'No apto para la venta', 54, 53, '2021-06-06 13:35:14'),
(1427, 7, '', 'Producto dañado', 44, 43, '2021-06-06 13:58:03'),
(1428, 30, 'Venta', 'Factura #10380', 6, 5, '2021-06-06 14:09:41'),
(1429, 51, 'Producto averiado', '', 31, 30, '2021-06-06 14:16:36'),
(1430, 6, 'Producto averiado', '', 4, 3, '2021-06-06 14:23:34'),
(1431, 15, 'Producto averiado', '', 4, 1, '2021-06-06 14:26:26'),
(1432, 4, 'Producto averiado', '', 59, 58, '2021-06-06 14:29:36'),
(1433, 6, 'Venta', 'Factura #10381', 3, 0, '2021-06-06 14:41:16'),
(1434, 55, 'Venta', 'Factura #10381', 11, 7, '2021-06-06 14:41:16'),
(1435, 55, 'Venta', 'Factura #10382', 7, 4, '2021-06-06 14:47:55'),
(1436, 40, 'Compra', 'Compra factura #7826', 0, 1, '2021-06-06 14:59:05'),
(1437, 20, 'Compra', 'Compra factura #7826', 40, 43, '2021-06-06 14:59:05'),
(1438, 21, 'Compra', 'Compra factura #7826', 53, 56, '2021-06-06 14:59:05'),
(1439, 10, 'Compra', 'Compra factura #7826', 17, 19, '2021-06-06 14:59:05'),
(1440, 13, 'Compra', 'Compra factura #7826', 9, 18, '2021-06-06 14:59:05'),
(1441, 42, 'Compra', 'Compra factura #7826', 0, 1, '2021-06-06 14:59:05'),
(1442, 127, 'Compra', 'Compra factura #7826', 2, 5, '2021-06-06 14:59:05'),
(1443, 44, 'Compra', 'Compra factura #7826', 23, 26, '2021-06-06 14:59:05'),
(1444, 19, 'Compra', 'Compra factura #7826', 4, 5, '2021-06-06 14:59:05'),
(1445, 47, 'Compra', 'Compra factura #7826', 0, 7, '2021-06-06 14:59:05'),
(1446, 49, 'Compra', 'Compra factura #7826', 0, 1, '2021-06-06 14:59:05'),
(1447, 50, 'Compra', 'Compra factura #7826', 1, 2, '2021-06-06 14:59:05'),
(1448, 15, 'Compra', 'Compra factura #7826', 1, 7, '2021-06-06 14:59:05'),
(1449, 4, 'Producto averiado', '', 59, 58, '2021-06-06 15:16:02'),
(1450, 6, 'Entrada manual de producto', '', 0, 50, '2021-06-06 15:32:46'),
(1451, 3, 'Entrada manual de producto', '', 1, 101, '2021-06-06 15:33:14'),
(1452, 6, 'Venta', 'Factura #10383', 50, 48, '2021-06-06 15:35:05'),
(1453, 20, 'Venta', 'Factura #10383', 43, 42, '2021-06-06 15:35:05'),
(1454, 21, 'Venta', 'Factura #10383', 56, 54, '2021-06-06 15:35:05'),
(1455, 175, 'Venta', 'Factura #10383', 2, 1, '2021-06-06 15:35:05'),
(1456, 3, 'Venta', 'Factura #10383', 101, 96, '2021-06-06 15:35:05'),
(1457, 5, 'Venta', 'Factura #10383', 77, 73, '2021-06-06 15:35:05'),
(1458, 54, 'Producto averiado', '', 41, 40, '2021-06-06 15:39:58'),
(1459, 57, 'Venta', 'Factura #10384', 19, 18, '2021-06-06 17:55:21'),
(1460, 118, 'Venta', 'Factura #10385', 10, 9, '2021-06-06 18:05:46'),
(1461, 86, 'Venta', 'Factura #10386', 1, 0, '2021-06-06 18:06:44'),
(1462, 30, 'Producto averiado', '', 5, -2, '2021-06-07 12:12:41'),
(1463, 25, 'Producto averiado', '', 6, 4, '2021-06-07 12:16:57'),
(1464, 54, 'Producto averiado', '', 40, 38, '2021-06-07 12:18:23'),
(1465, 47, 'Producto averiado', '', 7, 5, '2021-06-07 12:21:38'),
(1466, 4, 'Producto averiado', '', 59, 56, '2021-06-07 13:00:06'),
(1467, 8, 'Producto averiado', '', 86, 85, '2021-06-07 13:01:00'),
(1468, 22, 'Venta', 'Factura #10387', 22, 21, '2021-06-07 13:10:24'),
(1469, 13, 'Venta', 'Factura #10388', 18, 16, '2021-06-07 13:16:30'),
(1470, 39, 'Venta', 'Factura #10388', 45, 43, '2021-06-07 13:16:30'),
(1471, 53, 'Producto averiado', '', 32, 31, '2021-06-07 13:46:11'),
(1472, 100, 'Venta', 'Factura #10389', 3, 2, '2021-06-07 14:22:21'),
(1473, 47, 'Venta', 'Factura #10390', 5, 2, '2021-06-07 15:39:04'),
(1474, 61, 'Venta', 'Factura #10390', 26, 25, '2021-06-07 15:39:04'),
(1475, 53, 'Venta', 'Factura #10390', 32, 30, '2021-06-07 15:39:04'),
(1476, 55, 'Venta', 'Factura #10390', 4, 0, '2021-06-07 15:39:04'),
(1477, 25, 'Venta', 'Factura #10390', 5, 3, '2021-06-07 15:39:04'),
(1478, 5, 'Venta', 'Factura #10390', 73, 71, '2021-06-07 15:39:04'),
(1479, 27, 'Venta', 'Factura #10390', 3, 2, '2021-06-07 15:39:04'),
(1480, 109, 'Venta', 'Factura #10391', 1, 0, '2021-06-07 15:42:42'),
(1481, 153, 'Venta', 'Factura #10391', 1, 0, '2021-06-07 15:42:42'),
(1482, 61, 'Producto averiado', '', 25, 23, '2021-06-07 19:12:28'),
(1483, 61, 'Venta', 'Factura #10392', 24, 23, '2021-06-07 19:28:06'),
(1484, 118, 'Venta', 'Factura #10393', 9, 8, '2021-06-07 20:25:13'),
(1485, 18, 'Ajuste de inventario', '', 12, 0, '2021-06-07 20:47:46'),
(1486, 55, 'Entrada manual de producto', '', 0, 60, '2021-06-07 20:48:18'),
(1487, 55, 'Venta', 'Factura #10394', 60, 56, '2021-06-07 20:49:00'),
(1488, 13, 'Venta', 'Factura #10395', 16, 14, '2021-06-07 21:09:16'),
(1489, 55, 'Venta', 'Factura #10395', 56, 54, '2021-06-07 21:09:16'),
(1490, 21, 'Venta', 'Factura #10396', 54, 51, '2021-06-09 13:32:36'),
(1491, 20, 'Venta', 'Factura #10396', 42, 41, '2021-06-09 13:32:36'),
(1492, 55, 'Venta', 'Factura #10396', 54, 51, '2021-06-09 13:32:36'),
(1493, 39, 'Venta', 'Factura #10396', 43, 42, '2021-06-09 13:32:36'),
(1494, 139, 'Venta', 'Factura #10396', 3, 2, '2021-06-09 13:32:36'),
(1495, 54, 'Producto averiado', '', 39, 38, '2021-06-09 13:34:00'),
(1496, 3, 'Producto averiado', '', 96, 88, '2021-06-09 13:34:16'),
(1497, 7, 'Producto averiado', '', 44, 43, '2021-06-09 13:34:43'),
(1498, 4, 'Producto averiado', '', 56, 53, '2021-06-09 13:35:02'),
(1499, 6, 'Producto averiado', '', 48, 47, '2021-06-09 13:35:20'),
(1500, 53, 'Producto averiado', '', 31, 30, '2021-06-09 13:35:35'),
(1501, 6, 'Producto averiado', '', 48, 47, '2021-06-09 13:39:11'),
(1502, 17, 'Producto averiado', '', 9, 6, '2021-06-09 13:43:59'),
(1503, 55, 'Venta', 'Factura #10397', 51, 44, '2021-06-09 21:34:14'),
(1504, 99, 'Venta', 'Factura #10398', 17, 15, '2021-06-10 13:10:53'),
(1505, 20, 'Producto averiado', '', 41, 38, '2021-06-10 13:29:22'),
(1506, 175, 'Venta', 'Factura #10399', 1, 0, '2021-06-10 14:36:26'),
(1507, 122, 'Venta', 'Factura #10399', 3, 2, '2021-06-10 14:36:26'),
(1508, 20, 'Venta', 'Factura #10399', 39, 38, '2021-06-10 14:36:26'),
(1509, 13, 'Venta', 'Factura #10399', 15, 13, '2021-06-10 14:36:26'),
(1510, 11, 'Venta', 'Factura #10399', 17, 10, '2021-06-10 14:36:26'),
(1511, 7, 'Venta', 'Factura #10399', 44, 43, '2021-06-10 14:36:26'),
(1512, 53, 'Venta', 'Factura #10399', 31, 30, '2021-06-10 14:36:26'),
(1513, 118, 'Venta', 'Factura #10399', 8, 7, '2021-06-10 14:36:26'),
(1514, 68, 'Venta', 'Factura #10400', 1, 0, '2021-06-10 15:36:59'),
(1515, 71, 'Venta', 'Factura #10400', 3, 2, '2021-06-10 15:36:59'),
(1516, 136, 'Venta', 'Factura #10400', 31, 26, '2021-06-10 15:36:59'),
(1517, 99, 'Venta', 'Factura #10401', 15, 14, '2021-06-10 18:17:46'),
(1518, 99, 'Venta', 'Factura #10401', 15, 14, '2021-06-10 18:24:10'),
(1519, 118, 'Venta', 'Factura #10402', 7, 5, '2021-06-10 20:35:37'),
(1520, 57, 'Venta', 'Factura #10403', 18, 17, '2021-06-11 12:35:32'),
(1521, 5, 'Producto averiado', '', 72, 68, '2021-06-11 12:46:22'),
(1522, 4, 'Producto averiado', '', 54, 51, '2021-06-11 13:00:13'),
(1523, 3, 'Producto averiado', '', 89, 88, '2021-06-11 13:25:48'),
(1524, 53, 'Producto averiado', '', 30, 28, '2021-06-11 13:26:43'),
(1525, 61, 'Producto averiado', '', 23, 22, '2021-06-11 14:41:01'),
(1526, 79, 'Entrada manual de producto', '', 0, 0, '2021-06-11 15:17:59'),
(1527, 118, 'Venta', 'Factura #10404', 5, 4, '2021-06-11 20:53:36'),
(1528, 30, 'Venta', 'Factura #10405', -2, -3, '2021-06-11 21:42:15'),
(1529, 61, 'Venta', 'Factura #10405', 22, 20, '2021-06-11 21:42:15'),
(1530, 79, 'Entrada manual de producto', '', 0, 1, '2021-06-12 14:36:18'),
(1531, 79, 'Venta', 'Factura #10406', 1, 0, '2021-06-12 14:37:28'),
(1532, 55, 'Venta', 'Factura #10406', 44, 42, '2021-06-12 14:37:28'),
(1533, 99, 'Venta', 'Factura #10406', 14, 13, '2021-06-12 14:37:28'),
(1534, 100, 'Compra', 'Compra factura #0001', 2, 14, '2021-06-12 14:49:03'),
(1535, 99, 'Compra', 'Compra factura #0001', 13, 25, '2021-06-12 14:49:03'),
(1536, 57, 'Compra', 'Compra factura #16569', 17, 37, '2021-06-12 14:49:41'),
(1537, 30, 'Entrada manual de producto', '', -3, 0, '2021-06-12 14:50:15'),
(1538, 4, 'Producto averiado', '', 51, 50, '2021-06-12 14:50:29'),
(1539, 32, 'Producto averiado', 'Producto dañado', 4, 0, '2021-06-12 14:50:45'),
(1540, 3, 'Producto averiado', '', 88, 86, '2021-06-12 14:51:03'),
(1541, 6, 'Producto averiado', '', 48, 47, '2021-06-12 14:51:29'),
(1542, 57, 'Entrada manual de producto', '', 37, 57, '2021-06-12 14:53:57'),
(1543, 57, 'Venta', 'Factura #10407', 57, 53, '2021-06-12 15:22:38'),
(1544, 7, 'Producto averiado', '', 43, 42, '2021-06-12 16:23:47'),
(1545, 57, 'Venta', 'Factura #10408', 53, 48, '2021-06-12 16:51:18'),
(1546, 5, 'Producto averiado', '', 69, 61, '2021-06-12 16:55:29'),
(1547, 15, 'Producto averiado', '', 7, 5, '2021-06-12 17:31:56'),
(1548, 44, 'Producto averiado', '', 26, 23, '2021-06-12 18:32:06'),
(1549, 136, 'Ajuste de inventario', '', 26, 10, '2021-06-12 20:28:05'),
(1550, 158, 'Ajuste de inventario', '', 2, 1, '2021-06-12 20:28:34'),
(1551, 152, 'Ajuste de inventario', '', 3, 2, '2021-06-12 20:29:20'),
(1552, 135, 'Entrada manual de producto', '', 3, 3, '2021-06-12 20:29:48'),
(1553, 130, 'Entrada manual de producto', '', 30, 34, '2021-06-12 20:30:32'),
(1554, 129, 'Entrada manual de producto', '', 0, 23, '2021-06-12 20:30:54'),
(1555, 122, 'Entrada manual de producto', '', 2, 3, '2021-06-12 20:31:55');
INSERT INTO `movimientos` (`id`, `id_producto`, `tipo`, `descripcion_movimiento`, `habia`, `hay`, `fecha`) VALUES
(1556, 121, 'Ajuste de inventario', '', 12, 0, '2021-06-12 20:32:20'),
(1557, 15, 'Ajuste de inventario', '', 6, 2, '2021-06-12 20:34:41'),
(1558, 127, 'Ajuste de inventario', '', 5, 0, '2021-06-12 20:35:36'),
(1559, 0, 'Ajuste de inventario', '', 0, 0, '2021-06-12 20:35:58'),
(1560, 120, 'Ajuste de inventario', '', 4, 0, '2021-06-12 20:36:44'),
(1561, 119, 'Ajuste de inventario', '', 6, 6, '2021-06-12 20:38:11'),
(1562, 117, 'Ajuste de inventario', '', 2, 0, '2021-06-12 20:38:33'),
(1563, 116, '', '', 2, 0, '2021-06-12 20:38:45'),
(1564, 114, 'Ajuste de inventario', '', 8, 0, '2021-06-12 20:43:43'),
(1565, 110, 'Ajuste de inventario', '', 9, 0, '2021-06-12 20:44:06'),
(1566, 104, 'Ajuste de inventario', '', 6, 0, '2021-06-12 20:44:33'),
(1567, 103, 'Ajuste de inventario', '', 1, 0, '2021-06-12 20:44:51'),
(1568, 99, 'Ajuste de inventario', '', 25, 23, '2021-06-12 20:45:12'),
(1569, 95, 'Ajuste de inventario', '', 2, 1, '2021-06-12 20:45:30'),
(1570, 92, 'Ajuste de inventario', '', 4, 2, '2021-06-12 20:47:16'),
(1571, 86, 'Ajuste de inventario', '', 1, 0, '2021-06-12 20:47:37'),
(1572, 74, 'Entrada manual de producto', '', 1, 2, '2021-06-12 20:48:28'),
(1573, 69, 'Ajuste de inventario', '', 5, 3, '2021-06-12 20:49:14'),
(1574, 67, 'Ajuste de inventario', '', 5, 1, '2021-06-12 20:49:46'),
(1575, 65, 'Ajuste de inventario', '', 5, 1, '2021-06-12 20:50:06'),
(1576, 61, 'Entrada manual de producto', '', 20, 32, '2021-06-12 20:50:31'),
(1577, 60, 'Entrada manual de producto', '', 0, 6, '2021-06-12 20:50:54'),
(1578, 173, 'Entrada manual de producto', '', 2, 4, '2021-06-12 20:51:05'),
(1579, 57, '', '', 48, 38, '2021-06-12 20:51:45'),
(1580, 55, 'Entrada manual de producto', '', 42, 48, '2021-06-12 20:52:09'),
(1581, 54, 'Ajuste de inventario', '', 38, 11, '2021-06-12 20:52:37'),
(1582, 53, '', '', 29, 14, '2021-06-12 20:53:05'),
(1583, 51, 'Ajuste de inventario', '', 30, 3, '2021-06-12 20:53:30'),
(1584, 49, 'Ajuste de inventario', '', 1, 0, '2021-06-12 20:53:54'),
(1585, 58, 'Venta', 'Factura #10409', 4, 3, '2021-06-12 20:53:55'),
(1586, 50, 'Ajuste de inventario', '', 2, 0, '2021-06-12 20:54:06'),
(1587, 47, 'Entrada manual de producto', '', 2, 4, '2021-06-12 20:54:28'),
(1588, 46, 'Ajuste de inventario', '', 1, 0, '2021-06-12 20:54:45'),
(1589, 44, 'Ajuste de inventario', '', 24, 3, '2021-06-12 20:55:06'),
(1590, 43, '', '', 5, 1, '2021-06-12 20:55:26'),
(1591, 119, 'Ajuste de inventario', '', 6, 0, '2021-06-12 20:56:00'),
(1592, 41, 'Ajuste de inventario', '', 1, 0, '2021-06-12 20:56:13'),
(1593, 39, 'Ajuste de inventario', '', 42, 6, '2021-06-12 20:56:43'),
(1594, 38, 'Ajuste de inventario', '', 8, 0, '2021-06-12 20:57:02'),
(1595, 36, 'Entrada manual de producto', '', 0, 2, '2021-06-12 20:57:20'),
(1596, 57, 'Venta', 'Factura #10410', 38, 36, '2021-06-12 20:58:11'),
(1597, 35, 'Ajuste de inventario', '', 1, 0, '2021-06-12 20:58:40'),
(1598, 34, 'Ajuste de inventario', '', 14, 0, '2021-06-12 20:59:54'),
(1599, 30, 'Entrada manual de producto', '', 0, 3, '2021-06-12 21:00:24'),
(1600, 29, 'Ajuste de inventario', '', 1, 0, '2021-06-12 21:00:49'),
(1601, 152, '', '', 2, 0, '2021-06-12 21:01:15'),
(1602, 27, 'Ajuste de inventario', '', 2, 0, '2021-06-12 21:01:28'),
(1603, 25, 'Ajuste de inventario', '', 4, 0, '2021-06-12 21:02:12'),
(1604, 23, 'Ajuste de inventario', '', 1, 0, '2021-06-12 21:02:33'),
(1605, 22, 'Ajuste de inventario', '', 22, 17, '2021-06-12 21:03:28'),
(1606, 0, 'Ajuste de inventario', '', 0, -48, '2021-06-12 21:03:53'),
(1607, 21, 'Ajuste de inventario', '', 51, -48, '2021-06-12 21:04:09'),
(1608, 20, 'Ajuste de inventario', '', 38, 1, '2021-06-12 21:04:21'),
(1609, 19, 'Ajuste de inventario', '', 5, 0, '2021-06-12 21:04:41'),
(1610, 17, 'Ajuste de inventario', '', 7, 0, '2021-06-12 21:05:00'),
(1611, 16, 'Entrada manual de producto', '', 0, 4, '2021-06-12 21:05:28'),
(1612, 14, 'Ajuste de inventario', '', 11, 0, '2021-06-12 21:05:52'),
(1613, 13, 'Ajuste de inventario', '', 14, 3, '2021-06-12 21:06:13'),
(1614, 12, 'Entrada manual de producto', '', 38, 108, '2021-06-12 21:06:43'),
(1615, 11, 'Entrada manual de producto', '', 11, 39, '2021-06-12 21:07:06'),
(1616, 9, 'Entrada manual de producto', '', 6, 12, '2021-06-12 21:07:29'),
(1617, 8, 'Ajuste de inventario', '', 86, 20, '2021-06-12 21:07:55'),
(1618, 7, 'Ajuste de inventario', '', 43, 32, '2021-06-12 21:08:19'),
(1619, 6, 'Ajuste de inventario', '', 47, 31, '2021-06-12 21:08:38'),
(1620, 5, 'Ajuste de inventario', '', 62, 3, '2021-06-12 21:09:11'),
(1621, 4, 'Entrada manual de producto', '', 50, 61, '2021-06-12 21:10:53'),
(1622, 3, 'Ajuste de inventario', '', 86, 52, '2021-06-12 21:11:16'),
(1623, 6, 'Producto averiado', '', 31, 30, '2021-06-13 13:38:02'),
(1624, 6, 'Producto averiado', '', 30, 29, '2021-06-13 13:41:22'),
(1625, 53, 'Producto averiado', '', 15, 14, '2021-06-13 13:44:39'),
(1626, 11, 'Venta', 'Factura #10411', 39, 37, '2021-06-13 13:47:30'),
(1627, 13, 'Venta', 'Factura #10411', 4, 1, '2021-06-13 13:47:30'),
(1628, 9, 'Venta', 'Factura #10411', 13, 11, '2021-06-13 13:47:30'),
(1629, 9, 'Entrada manual de producto', '', 11, 13, '2021-06-13 13:50:04'),
(1630, 11, 'Entrada manual de producto', '', 37, 39, '2021-06-13 13:50:14'),
(1631, 13, 'Entrada manual de producto', '', 2, 4, '2021-06-13 13:50:23'),
(1632, 13, 'Venta', 'Factura #10411', 5, 2, '2021-06-13 13:51:11'),
(1633, 11, 'Venta', 'Factura #10411', 39, 37, '2021-06-13 13:51:11'),
(1634, 9, 'Venta', 'Factura #10411', 13, 11, '2021-06-13 13:51:11'),
(1635, 30, 'Producto averiado', '', 3, 2, '2021-06-13 13:53:05'),
(1636, 4, 'Producto averiado', '', 61, 60, '2021-06-13 13:56:00'),
(1637, 54, 'Producto averiado', '', 12, 11, '2021-06-13 13:56:31'),
(1638, 57, 'Venta', 'Factura #10412', 36, 33, '2021-06-13 14:23:08'),
(1639, 3, 'Producto averiado', '', 53, 51, '2021-06-13 14:26:57'),
(1640, 99, 'Venta', 'Factura #10413', 23, 22, '2021-06-13 14:53:32'),
(1641, 58, 'Venta', 'Factura #10414', 3, 2, '2021-06-13 14:56:12'),
(1642, 55, 'Venta', 'Factura #10415', 48, 18, '2021-06-13 15:03:00'),
(1643, 55, 'Producto averiado', '', 18, 17, '2021-06-13 15:03:49'),
(1644, 129, 'Producto averiado', '', 24, 22, '2021-06-13 15:13:19'),
(1645, 61, 'Venta', 'Factura #10416', 32, 31, '2021-06-13 15:40:26'),
(1646, 6, 'Venta', 'Factura #10416', 30, 28, '2021-06-13 15:40:26'),
(1647, 5, 'Venta', 'Factura #10416', 3, 1, '2021-06-13 15:40:26'),
(1648, 12, 'Venta', 'Factura #10416', 108, 107, '2021-06-13 15:40:26'),
(1649, 4, 'Venta', 'Factura #10416', 60, 57, '2021-06-13 15:40:26'),
(1650, 54, 'Venta', 'Factura #10417', 11, 9, '2021-06-13 17:34:12'),
(1651, 30, 'Venta', 'Factura #10417', 2, 1, '2021-06-13 17:34:12'),
(1652, 55, 'Venta', 'Factura #10417', 17, 16, '2021-06-13 17:34:12'),
(1653, 53, 'Venta', 'Factura #10417', 14, 12, '2021-06-13 17:34:12'),
(1654, 54, 'Venta', 'Factura #10418', 10, 8, '2021-06-13 17:40:50'),
(1655, 129, 'Venta', 'Factura #10418', 23, 22, '2021-06-13 17:40:50'),
(1656, 55, 'Venta', 'Factura #10418', 16, 13, '2021-06-13 17:40:50'),
(1657, 89, 'Venta', 'Factura #10418', 1, 0, '2021-06-13 17:40:50'),
(1658, 61, 'Venta', 'Factura #10418', 31, 30, '2021-06-13 17:40:50'),
(1659, 4, 'Venta', 'Factura #10419', 58, 56, '2021-06-13 17:49:14'),
(1660, 11, 'Venta', 'Factura #10419', 37, 33, '2021-06-13 17:49:14'),
(1661, 61, 'Venta', 'Factura #10419', 30, 29, '2021-06-13 17:49:14'),
(1662, 6, 'Venta', 'Factura #10419', 28, 27, '2021-06-13 17:49:14'),
(1663, 8, 'Venta', 'Factura #10419', 20, 19, '2021-06-13 17:49:14'),
(1664, 7, 'Venta', 'Factura #10419', 32, 31, '2021-06-13 17:49:14'),
(1665, 53, 'Venta', 'Factura #10419', 12, 11, '2021-06-13 17:49:14'),
(1666, 54, 'Venta', 'Factura #10419', 9, 8, '2021-06-13 17:49:14'),
(1667, 20, 'Venta', 'Factura #10419', 1, 0, '2021-06-13 17:49:14'),
(1668, 9, 'Venta', 'Factura #10419', 11, 9, '2021-06-13 17:49:14'),
(1669, 36, 'Venta', 'Factura #10419', 2, 1, '2021-06-13 17:49:14'),
(1670, 30, 'Venta', 'Factura #10419', 1, 0, '2021-06-13 17:49:14'),
(1671, 118, 'Venta', 'Factura #10419', 4, 2, '2021-06-13 17:49:14'),
(1672, 58, 'Venta', 'Factura #10419', 2, 1, '2021-06-13 17:49:14'),
(1673, 22, 'Venta', 'Factura #10419', 17, 16, '2021-06-13 17:49:14'),
(1674, 55, 'Venta', 'Factura #10419', 13, 9, '2021-06-13 17:49:14'),
(1675, 39, 'Venta', 'Factura #10419', 7, 6, '2021-06-13 17:49:14'),
(1676, 137, 'Uso personal', 'Para la tienda', 10, 9, '2021-06-13 17:51:33'),
(1677, 60, 'Venta', 'Factura #10420', 6, 4, '2021-06-13 17:55:48'),
(1678, 176, 'Venta', 'Factura #10420', 4, 2, '2021-06-13 17:55:48'),
(1679, 57, 'Venta', 'Factura #10420', 33, 32, '2021-06-13 17:55:48'),
(1680, 39, 'Producto averiado', '', 6, 5, '2021-06-13 18:01:50'),
(1681, 55, 'Compra', 'Compra factura #0006', 9, 110, '2021-06-13 18:03:35'),
(1682, 118, 'Venta', 'Factura #10421', 2, 1, '2021-06-13 18:08:42'),
(1683, 30, 'Entrada manual de producto', '', 0, 4, '2021-06-13 18:24:33'),
(1684, 4, 'Producto averiado', '', 56, 53, '2021-06-14 12:47:15'),
(1685, 3, 'Producto averiado', '', 51, 50, '2021-06-14 12:49:26'),
(1686, 61, 'Venta', 'Factura #10422', 29, 27, '2021-06-14 13:33:39'),
(1687, 8, 'Producto averiado', '', 19, 18, '2021-06-14 14:18:23'),
(1688, 57, 'Venta', 'Factura #10423', 32, 31, '2021-06-14 14:51:06'),
(1689, 53, 'Venta', 'Factura #10423', 11, 8, '2021-06-14 14:51:06'),
(1690, 99, 'Venta', 'Factura #10424', 22, 21, '2021-06-14 14:52:55'),
(1691, 4, 'Venta', 'Factura #10425', 53, 50, '2021-06-14 15:44:26'),
(1692, 99, 'Venta', 'Factura #10426', 21, 20, '2021-06-14 18:08:39'),
(1693, 57, 'Venta', 'Factura #10426', 31, 30, '2021-06-14 18:08:39'),
(1694, 100, 'Venta', 'Factura #10427', 14, 13, '2021-06-14 18:15:43'),
(1695, 4, 'Venta', 'Factura #10428', 50, 31, '2021-06-14 18:43:55'),
(1696, 61, 'Venta', 'Factura #10428', 27, 22, '2021-06-14 18:43:55'),
(1697, 4, 'Producto averiado', '', 32, 24, '2021-06-14 18:55:07'),
(1698, 4, 'Venta', 'Factura #10429', 24, 21, '2021-06-14 19:33:52'),
(1699, 3, 'Venta', 'Factura #10429', 50, 48, '2021-06-14 19:33:52'),
(1700, 5, 'Venta', 'Factura #10429', 0, 0, '2021-06-14 19:33:52'),
(1701, 129, 'Venta', 'Factura #10429', 22, 21, '2021-06-14 19:33:52'),
(1702, 9, 'Venta', 'Factura #10429', 9, 7, '2021-06-14 19:33:52'),
(1703, 30, 'Venta', 'Factura #10429', 4, 3, '2021-06-14 19:33:52'),
(1704, 3, 'Producto averiado', '', 49, 47, '2021-06-14 19:52:09'),
(1705, 100, 'Venta', 'Factura #10430', 13, 12, '2021-06-14 20:40:02'),
(1706, 100, 'Venta', 'Factura #10431', 12, 11, '2021-06-16 12:52:04'),
(1707, 99, 'Venta', 'Factura #10431', 20, 19, '2021-06-16 12:52:04'),
(1708, 100, 'Venta', 'Factura #10432', 11, 10, '2021-06-16 13:04:15'),
(1709, 99, 'Venta', 'Factura #10432', 19, 16, '2021-06-16 13:04:15'),
(1710, 21, 'Entrada manual de producto', '', -49, -46, '2021-06-16 13:23:28'),
(1711, 21, 'Entrada manual de producto', '', -46, 3, '2021-06-16 13:23:45'),
(1712, 21, 'Venta', 'Factura #10433', 3, 0, '2021-06-16 13:27:54'),
(1713, 13, 'Venta', 'Factura #10433', 3, 1, '2021-06-16 13:27:54'),
(1714, 4, 'Venta', 'Factura #10433', 25, 17, '2021-06-16 13:27:54'),
(1715, 39, 'Venta', 'Factura #10433', 5, 2, '2021-06-16 13:27:54'),
(1716, 53, 'Venta', 'Factura #10433', 8, 6, '2021-06-16 13:27:54'),
(1717, 55, 'Venta', 'Factura #10433', 110, 107, '2021-06-16 13:27:54'),
(1718, 47, 'Producto averiado', '', 4, 2, '2021-06-16 13:33:01'),
(1719, 6, 'Producto averiado', '', 27, 25, '2021-06-16 13:33:23'),
(1720, 51, 'Producto averiado', '', 4, 3, '2021-06-16 13:41:08'),
(1721, 129, 'Producto averiado', '', 22, 21, '2021-06-16 13:41:28'),
(1722, 99, 'Venta', 'Factura #10434', 16, 15, '2021-06-16 13:47:06'),
(1723, 55, 'Venta', 'Factura #10435', 107, 103, '2021-06-16 13:58:45'),
(1724, 5, 'Venta', 'Factura #10436', 0, 0, '2021-06-16 18:59:20'),
(1725, 129, 'Venta', 'Factura #10436', 21, 20, '2021-06-16 18:59:20'),
(1726, 3, 'Venta', 'Factura #10436', 49, 48, '2021-06-16 18:59:20'),
(1727, 30, 'Venta', 'Factura #10436', 4, 3, '2021-06-16 18:59:20'),
(1728, 9, 'Venta', 'Factura #10436', 9, 7, '2021-06-16 18:59:20'),
(1729, 4, 'Venta', 'Factura #10436', 17, 14, '2021-06-16 18:59:20'),
(1730, 6, 'Venta', 'Factura #10436', 25, 24, '2021-06-16 18:59:20'),
(1731, 3, 'Producto averiado', '', 48, 46, '2021-06-16 19:18:15'),
(1732, 43, 'Venta', 'Factura #10437', 1, 0, '2021-06-16 20:03:51'),
(1733, 16, 'Venta', 'Factura #10437', 4, 3, '2021-06-16 20:03:51'),
(1734, 4, 'Venta', 'Factura #10437', 14, 12, '2021-06-16 20:03:51'),
(1735, 6, 'Venta', 'Factura #10437', 24, 23, '2021-06-16 20:03:51'),
(1736, 55, 'Venta', 'Factura #10437', 103, 101, '2021-06-16 20:03:51'),
(1737, 53, 'Venta', 'Factura #10437', 6, 6, '2021-06-16 20:03:51'),
(1738, 39, 'Venta', 'Factura #10437', 2, 1, '2021-06-16 20:03:51'),
(1739, 54, 'Venta', 'Factura #10437', 8, 6, '2021-06-16 20:03:51'),
(1740, 42, 'Venta', 'Factura #10438', 1, 0, '2021-06-16 20:30:46'),
(1741, 61, 'Producto averiado', '', 22, 21, '2021-06-16 21:33:24'),
(1742, 99, 'Venta', 'Factura #10439', 15, 14, '2021-06-17 13:19:11'),
(1743, 100, 'Venta', 'Factura #10439', 10, 8, '2021-06-17 13:19:11'),
(1744, 60, 'Venta', 'Factura #10440', 4, 0, '2021-06-17 13:20:13'),
(1745, 176, 'Venta', 'Factura #10440', 2, 0, '2021-06-17 13:20:13'),
(1746, 9, 'Producto averiado', '', 7, 4, '2021-06-17 14:44:47'),
(1747, 6, 'Producto averiado', '', 23, 21, '2021-06-17 14:45:04'),
(1748, 136, 'Producto averiado', '', 10, 8, '2021-06-17 14:45:19'),
(1749, 54, 'Producto averiado', '', 7, 4, '2021-06-17 14:45:39'),
(1750, 55, 'Venta', 'Factura #10441', 101, 71, '2021-06-17 15:07:03'),
(1751, 6, 'Venta', 'Factura #10442', 21, 20, '2021-06-17 15:26:46'),
(1752, 8, 'Venta', 'Factura #10442', 18, 17, '2021-06-17 15:26:46'),
(1753, 4, 'Venta', 'Factura #10442', 12, 11, '2021-06-17 15:26:46'),
(1754, 22, 'Venta', 'Factura #10442', 17, 16, '2021-06-17 15:26:46'),
(1755, 11, 'Venta', 'Factura #10442', 34, 29, '2021-06-17 15:26:46'),
(1756, 100, 'Venta', 'Factura #10443', 8, 7, '2021-06-17 15:37:10'),
(1757, 177, 'Venta', 'Factura #10444', 2, 1, '2021-06-17 18:06:22'),
(1758, 4, 'Venta', 'Factura #10445', 11, 0, '2021-06-17 18:44:22'),
(1759, 61, 'Venta', 'Factura #10445', 21, 16, '2021-06-17 18:44:22'),
(1760, 130, 'Venta', 'Factura #10445', 34, 20, '2021-06-17 18:44:22'),
(1761, 4, 'Producto averiado', '', 1, 0, '2021-06-17 18:45:54'),
(1762, 57, 'Venta', 'Factura #10446', 30, 29, '2021-06-17 18:50:51'),
(1763, 57, 'Venta', 'Factura #10447', 29, 28, '2021-06-17 19:37:21'),
(1764, 53, 'Venta', 'Factura #10448', 6, 5, '2021-06-17 19:48:33'),
(1765, 136, 'Venta', 'Factura #10448', 8, 5, '2021-06-17 19:48:33'),
(1766, 53, 'Venta', 'Factura #10449', 5, 4, '2021-06-17 19:52:35'),
(1767, 136, 'Venta', 'Factura #10449', 5, 2, '2021-06-17 19:52:35'),
(1768, 130, 'Venta', 'Factura #10449', 20, 19, '2021-06-17 19:52:35'),
(1769, 57, 'Venta', 'Factura #10450', 28, 26, '2021-06-17 20:57:43'),
(1770, 61, 'Producto averiado', '', 17, 15, '2021-06-18 13:16:01'),
(1771, 61, 'Producto averiado', '', 15, 14, '2021-06-18 13:16:24'),
(1772, 47, 'Producto averiado', '', 2, 0, '2021-06-18 13:18:08'),
(1773, 100, 'Venta', 'Factura #10451', 7, 5, '2021-06-18 13:31:12'),
(1774, 99, 'Venta', 'Factura #10451', 14, 13, '2021-06-18 13:31:12'),
(1775, 9, 'Compra', 'Compra factura #00063', 4, 23, '2021-06-18 14:09:54'),
(1776, 53, 'Compra', 'Compra factura #00063', 5, 20, '2021-06-18 14:09:54'),
(1777, 42, 'Compra', 'Compra factura #00063', 0, 3, '2021-06-18 14:09:54'),
(1778, 11, 'Compra', 'Compra factura #00063', 29, 49, '2021-06-18 14:09:54'),
(1779, 27, 'Compra', 'Compra factura #00063', 0, 3, '2021-06-18 14:09:54'),
(1780, 3, 'Producto averiado', '', 46, 44, '2021-06-18 14:16:15'),
(1781, 21, 'Compra', 'Compra factura #000618', 0, 3, '2021-06-18 14:54:33'),
(1782, 6, 'Compra', 'Compra factura #000618', 20, 39, '2021-06-18 14:54:33'),
(1783, 5, 'Compra', 'Compra factura #000618', 0, 5, '2021-06-18 14:54:33'),
(1784, 129, 'Compra', 'Compra factura #000618', 20, 46, '2021-06-18 14:54:33'),
(1785, 3, 'Compra', 'Compra factura #000618', 44, 49, '2021-06-18 14:54:33'),
(1786, 130, 'Compra', 'Compra factura #000618', 19, 41, '2021-06-18 14:54:33'),
(1787, 61, 'Compra', 'Compra factura #000617', 14, 62, '2021-06-18 15:00:24'),
(1788, 3, 'Compra', 'Compra factura #000617', 49, 168, '2021-06-18 15:02:01'),
(1789, 39, 'Compra', 'Compra factura #000617', 1, 21, '2021-06-18 15:02:01'),
(1790, 5, 'Compra', 'Compra factura #000617', 5, 75, '2021-06-18 15:02:51'),
(1791, 129, 'Compra', 'Compra factura #000617', 46, 76, '2021-06-18 15:02:51'),
(1792, 4, 'Compra', 'Compra factura #000617', 0, 60, '2021-06-18 15:02:51'),
(1793, 130, 'Compra', 'Compra factura #000617', 41, 71, '2021-06-18 15:02:51'),
(1794, 6, 'Producto averiado', '', 40, 38, '2021-06-18 15:06:34'),
(1795, 15, 'Venta', 'Factura #10452', 2, 1, '2021-06-18 15:09:58'),
(1796, 9, 'Producto averiado', '', 24, 21, '2021-06-18 15:31:38'),
(1797, 4, 'Producto averiado', '', 60, 57, '2021-06-18 15:41:31'),
(1798, 6, 'Producto averiado', '', 38, 36, '2021-06-18 15:43:26'),
(1799, 133, 'Compra', 'Compra factura #000617', 0, 3, '2021-06-18 15:57:18'),
(1800, 41, 'Compra', 'Compra factura #000617', 0, 3, '2021-06-18 15:57:18'),
(1801, 18, 'Compra', 'Compra factura #000617', 0, 9, '2021-06-18 15:57:18'),
(1802, 46, 'Compra', 'Compra factura #000617', 0, 1, '2021-06-18 15:57:18'),
(1803, 41, 'Venta', 'Factura #10453', 3, 2, '2021-06-18 15:58:48'),
(1804, 133, 'Venta', 'Factura #10453', 3, 2, '2021-06-18 15:58:48'),
(1805, 27, 'Venta', 'Factura #10453', 3, 2, '2021-06-18 15:58:48'),
(1806, 136, 'Venta', 'Factura #10453', 5, 1, '2021-06-18 15:58:48'),
(1807, 13, 'Venta', 'Factura #10453', 1, 0, '2021-06-18 15:58:48'),
(1808, 57, 'Venta', 'Factura #10454', 26, 25, '2021-06-18 18:15:13'),
(1809, 61, 'Venta', 'Factura #10455', 62, 42, '2021-06-18 18:17:54'),
(1810, 57, 'Venta', 'Factura #10456', 25, 24, '2021-06-18 19:31:39'),
(1811, 57, 'Venta', 'Factura #10457', 24, 23, '2021-06-18 19:33:00'),
(1812, 57, 'Venta', 'Factura #10458', 23, 22, '2021-06-18 19:33:33'),
(1813, 53, 'Venta', 'Factura #10459', 20, 19, '2021-06-19 13:09:57'),
(1814, 55, 'Venta', 'Factura #10459', 71, 68, '2021-06-19 13:09:57'),
(1815, 7, 'Venta', 'Factura #10459', 31, 27, '2021-06-19 13:09:57'),
(1816, 129, 'Producto averiado', '', 77, 57, '2021-06-19 13:28:25'),
(1817, 129, 'Producto averiado', '', 58, 56, '2021-06-19 13:39:27'),
(1818, 6, 'Producto averiado', '', 36, 34, '2021-06-19 13:39:54'),
(1819, 99, 'Venta', 'Factura #10460', 13, 12, '2021-06-19 13:40:52'),
(1820, 6, 'Producto averiado', '', 34, 29, '2021-06-19 14:02:09'),
(1821, 6, 'Producto averiado', '', 30, 27, '2021-06-19 14:12:17'),
(1822, 129, 'Producto averiado', '', 57, 54, '2021-06-19 14:19:03'),
(1823, 15, 'Producto averiado', '', 1, 0, '2021-06-19 14:53:25'),
(1824, 4, 'Producto averiado', '', 57, 51, '2021-06-19 15:20:15'),
(1825, 36, 'Producto averiado', '', 1, 0, '2021-06-19 15:41:15'),
(1826, 36, '', '', 0, 0, '2021-06-19 15:41:37'),
(1827, 13, 'Entrada manual de producto', '', 1, 0, '2021-06-19 15:47:10'),
(1828, 13, 'Entrada manual de producto', '', 0, 2, '2021-06-19 15:49:02'),
(1829, 13, 'Venta', 'Factura #10461', 2, 0, '2021-06-19 15:51:46'),
(1830, 39, 'Venta', 'Factura #10461', 21, 20, '2021-06-19 15:51:46'),
(1831, 130, 'Venta', 'Factura #10461', 71, 66, '2021-06-19 15:51:46'),
(1832, 55, 'Venta', 'Factura #10461', 68, 65, '2021-06-19 15:51:46'),
(1833, 61, 'Producto averiado', '', 42, 40, '2021-06-19 17:15:13'),
(1834, 10, 'Compra', 'Compra factura #7917', 19, 23, '2021-06-19 18:54:12'),
(1835, 20, 'Compra', 'Compra factura #7917', 0, 4, '2021-06-19 18:54:12'),
(1836, 21, 'Compra', 'Compra factura #7917', 3, 8, '2021-06-19 18:54:12'),
(1837, 145, 'Compra', 'Compra factura #7917', 6, 11, '2021-06-19 18:54:12'),
(1838, 13, 'Compra', 'Compra factura #7917', 0, 7, '2021-06-19 18:54:12'),
(1839, 36, 'Compra', 'Compra factura #7917', 0, 2, '2021-06-19 18:54:12'),
(1840, 14, 'Compra', 'Compra factura #7917', 0, 1, '2021-06-19 18:54:12'),
(1841, 42, 'Compra', 'Compra factura #7917', 3, 5, '2021-06-19 18:54:12'),
(1842, 17, 'Compra', 'Compra factura #7917', 0, 5, '2021-06-19 18:54:12'),
(1843, 19, 'Compra', 'Compra factura #7917', 0, 3, '2021-06-19 18:54:12'),
(1844, 43, 'Compra', 'Compra factura #7917', 0, 3, '2021-06-19 18:54:12'),
(1845, 44, 'Compra', 'Compra factura #7917', 3, 5, '2021-06-19 18:54:12'),
(1846, 50, 'Compra', 'Compra factura #7917', 0, 1, '2021-06-19 18:54:12'),
(1847, 51, 'Compra', 'Compra factura #7917', 3, 5, '2021-06-19 18:54:12'),
(1848, 16, 'Compra', 'Compra factura #7917', 3, 6, '2021-06-19 18:54:12'),
(1849, 47, 'Compra', 'Compra factura #7917', 0, 12, '2021-06-19 18:54:12'),
(1850, 10, 'Compra', 'Compra factura #13714', 23, 24, '2021-06-19 18:58:31'),
(1851, 20, 'Compra', 'Compra factura #13714', 4, 6, '2021-06-19 18:58:31'),
(1852, 21, 'Compra', 'Compra factura #13714', 8, 10, '2021-06-19 18:58:31'),
(1853, 13, 'Compra', 'Compra factura #13714', 7, 11, '2021-06-19 18:58:31'),
(1854, 14, 'Compra', 'Compra factura #13714', 1, 3, '2021-06-19 18:58:31'),
(1855, 49, 'Compra', 'Compra factura #13714', 0, 1, '2021-06-19 18:58:31'),
(1856, 50, 'Compra', 'Compra factura #13714', 1, 3, '2021-06-19 18:58:31'),
(1857, 54, 'Compra', 'Compra factura #13714', 4, 6, '2021-06-19 18:58:31'),
(1858, 15, 'Compra', 'Compra factura #13714', 0, 4, '2021-06-19 18:58:31'),
(1859, 145, 'Ajuste de inventario', '', 11, 2, '2021-06-19 18:59:18'),
(1860, 30, 'Entrada manual de producto', '', 3, 7, '2021-06-19 19:00:26'),
(1861, 31, 'Entrada manual de producto', '', 0, 1, '2021-06-19 19:00:38'),
(1862, 57, 'Venta', 'Factura #10462', 22, 21, '2021-06-19 19:18:32'),
(1863, 57, 'Venta', 'Factura #10463', 21, 20, '2021-06-19 20:00:06'),
(1864, 3, 'Producto averiado', '', 168, 158, '2021-06-20 14:14:39'),
(1865, 7, 'Producto averiado', '', 28, 26, '2021-06-20 14:20:48'),
(1866, 50, 'Producto averiado', '', 3, 0, '2021-06-20 14:31:48'),
(1867, 49, 'Producto averiado', '', 1, 0, '2021-06-20 14:32:12'),
(1868, 122, 'Entrada manual de producto', '', 3, 1, '2021-06-20 14:33:24'),
(1869, 122, 'Entrada manual de producto', '', 1, 4, '2021-06-20 14:33:57'),
(1870, 175, 'Entrada manual de producto', '', 0, 4, '2021-06-20 14:35:20'),
(1871, 3, 'Producto averiado', '', 158, 156, '2021-06-20 14:47:12'),
(1872, 58, 'Venta', 'Factura #10464', 1, 0, '2021-06-20 16:03:31'),
(1873, 118, 'Venta', 'Factura #10464', 1, 0, '2021-06-20 16:03:31'),
(1874, 8, 'Venta', 'Factura #10465', 17, 16, '2021-06-20 17:20:05'),
(1875, 6, 'Venta', 'Factura #10465', 27, 26, '2021-06-20 17:20:05'),
(1876, 5, 'Venta', 'Factura #10465', 75, 74, '2021-06-20 17:20:05'),
(1877, 44, 'Venta', 'Factura #10465', 5, 2, '2021-06-20 17:20:05'),
(1878, 54, 'Venta', 'Factura #10465', 6, 3, '2021-06-20 17:20:05'),
(1879, 55, 'Venta', 'Factura #10465', 65, 59, '2021-06-20 17:20:05'),
(1880, 130, 'Venta', 'Factura #10465', 66, 63, '2021-06-20 17:20:05'),
(1881, 53, 'Venta', 'Factura #10465', 19, 15, '2021-06-20 17:20:05'),
(1882, 22, 'Venta', 'Factura #10465', 16, 16, '2021-06-20 17:20:05'),
(1883, 113, 'Venta', 'Factura #10466', 11, 5, '2021-06-20 18:17:44'),
(1884, 57, 'Venta', 'Factura #10466', 20, 19, '2021-06-20 18:17:44'),
(1885, 57, 'Venta', 'Factura #10467', 19, 18, '2021-06-20 18:46:29'),
(1886, 99, 'Venta', 'Factura #10468', 12, 9, '2021-06-21 14:49:50'),
(1887, 55, 'Venta', 'Factura #10468', 59, 57, '2021-06-21 14:49:50'),
(1888, 57, 'Venta', 'Factura #10468', 18, 17, '2021-06-21 14:49:50'),
(1889, 57, 'Venta', 'Factura #10469', 17, 16, '2021-06-21 14:51:34'),
(1890, 8, 'Venta', 'Factura #10469', 16, 14, '2021-06-21 14:51:34'),
(1891, 129, 'Venta', 'Factura #10469', 54, 54, '2021-06-21 14:51:34'),
(1892, 6, 'Producto averiado', '', 27, 20, '2021-06-21 14:52:20'),
(1893, 20, 'Producto averiado', '', 6, 3, '2021-06-21 14:53:00'),
(1894, 55, 'Venta', 'Factura #10470', 57, 55, '2021-06-21 15:03:36'),
(1895, 130, 'Venta', 'Factura #10470', 63, 62, '2021-06-21 15:03:36'),
(1896, 100, 'Venta', 'Factura #10471', 5, 4, '2021-06-21 15:23:09'),
(1897, 57, 'Venta', 'Factura #10472', 16, 15, '2021-06-21 20:09:38'),
(1898, 55, 'Venta', 'Factura #10472', 55, 54, '2021-06-21 20:09:38'),
(1899, 61, 'Producto averiado', '', 40, 39, '2021-06-21 21:08:18'),
(1900, 57, 'Venta', 'Factura #10473', 15, 8, '2021-06-21 21:20:23'),
(1901, 57, 'Venta', 'Factura #10474', 8, 7, '2021-06-21 21:26:29'),
(1902, 3, 'Producto averiado', '', 156, 150, '2021-06-23 12:12:43'),
(1903, 30, 'Producto averiado', '', 7, 3, '2021-06-23 12:51:05'),
(1904, 30, 'Producto averiado', '', 3, 2, '2021-06-23 12:51:22'),
(1905, 100, 'Venta', 'Factura #10475', 4, 3, '2021-06-23 12:54:31'),
(1906, 54, 'Producto averiado', '', 3, 2, '2021-06-23 12:56:54'),
(1907, 6, 'Producto averiado', '', 20, 19, '2021-06-23 12:57:49'),
(1908, 21, 'Producto averiado', '', 10, 9, '2021-06-23 13:08:15'),
(1909, 20, 'Producto averiado', '', 4, 2, '2021-06-23 13:08:27'),
(1910, 6, 'Producto averiado', '', 19, 16, '2021-06-23 13:31:13'),
(1911, 129, 'Producto averiado', '', 54, 52, '2021-06-23 13:36:50'),
(1912, 39, 'Venta', 'Factura #10476', 20, 18, '2021-06-23 13:46:57'),
(1913, 53, 'Venta', 'Factura #10476', 15, 12, '2021-06-23 13:46:57'),
(1914, 13, 'Venta', 'Factura #10476', 11, 10, '2021-06-23 13:46:57'),
(1915, 4, 'Venta', 'Factura #10476', 51, 46, '2021-06-23 13:46:57'),
(1916, 130, 'Producto averiado', '', 62, 60, '2021-06-23 13:51:49'),
(1917, 3, 'Producto averiado', '', 150, 145, '2021-06-23 13:57:44'),
(1918, 57, 'Venta', 'Factura #10477', 7, 4, '2021-06-23 14:05:46'),
(1919, 100, 'Venta', 'Factura #10477', 3, 1, '2021-06-23 14:05:46'),
(1920, 57, 'Venta', 'Factura #10477', 7, 4, '2021-06-23 14:07:21'),
(1921, 100, 'Venta', 'Factura #10477', 3, 2, '2021-06-23 14:07:21'),
(1922, 57, 'Venta', 'Factura #10478', 4, 3, '2021-06-23 14:22:24'),
(1923, 55, 'Venta', 'Factura #10479', 54, 50, '2021-06-23 14:25:55'),
(1924, 55, 'Venta', 'Factura #10480', 50, 47, '2021-06-23 15:40:42'),
(1925, 21, 'Entrada manual de producto', '', 9, 14, '2021-06-23 15:54:25'),
(1926, 20, 'Entrada manual de producto', '', 3, 7, '2021-06-23 15:54:36'),
(1927, 10, 'Producto averiado', '', 24, 5, '2021-06-23 15:55:09'),
(1928, 3, 'Venta', 'Factura #10481', 145, 140, '2021-06-23 16:06:48'),
(1929, 39, 'Venta', 'Factura #10481', 20, 16, '2021-06-23 16:06:48'),
(1930, 11, 'Venta', 'Factura #10481', 49, 44, '2021-06-23 16:06:48'),
(1931, 10, 'Venta', 'Factura #10481', 5, 0, '2021-06-23 16:06:48'),
(1932, 6, 'Venta', 'Factura #10481', 16, 13, '2021-06-23 16:06:48'),
(1933, 9, 'Venta', 'Factura #10481', 21, 16, '2021-06-23 16:06:48'),
(1934, 20, 'Venta', 'Factura #10481', 7, 2, '2021-06-23 16:06:48'),
(1935, 21, 'Venta', 'Factura #10481', 14, 9, '2021-06-23 16:06:48'),
(1936, 53, 'Entrada manual de producto', '', 15, 17, '2021-06-23 20:44:27'),
(1937, 53, 'Venta', 'Factura #10482', 17, 0, '2021-06-23 20:45:16'),
(1938, 99, 'Venta', 'Factura #10483', 9, 8, '2021-06-23 21:51:02'),
(1939, 54, 'Producto averiado', '', 2, 0, '2021-06-24 12:29:26'),
(1940, 20, 'Ajuste de inventario', '', 3, 1, '2021-06-24 12:57:49'),
(1941, 99, 'Venta', 'Factura #10484', 8, 7, '2021-06-24 13:07:06'),
(1942, 51, 'Producto averiado', '', 5, 4, '2021-06-24 13:19:28'),
(1943, 30, 'Producto averiado', 'al congelador', 2, 0, '2021-06-24 13:21:46'),
(1944, 130, 'Venta', 'Factura #10485', 60, 49, '2021-06-24 13:38:43'),
(1945, 55, 'Venta', 'Factura #10485', 47, 27, '2021-06-24 13:38:43'),
(1946, 61, 'Producto averiado', '', 39, 36, '2021-06-24 14:28:17'),
(1947, 57, 'Venta', 'Factura #10486', 3, 2, '2021-06-24 15:15:49'),
(1948, 57, 'Venta', 'Factura #10487', 2, 1, '2021-06-24 19:26:06'),
(1949, 57, 'Compra', 'Compra factura #15007', 1, 21, '2021-06-24 20:01:34'),
(1950, 100, 'Compra', 'Compra factura #0002406', 2, 22, '2021-06-24 20:02:42'),
(1951, 99, 'Compra', 'Compra factura #0002406', 7, 27, '2021-06-24 20:02:42'),
(1952, 145, 'Venta', 'Factura #10488', 2, 1, '2021-06-25 23:06:23'),
(1953, 146, 'Venta', 'Factura #10488', 2, 1, '2021-06-25 23:06:23'),
(1954, 147, 'Venta', 'Factura #10488', 1, 0, '2021-06-25 23:06:23'),
(1955, 145, 'Venta', 'Factura #10489', 1, 0, '2021-06-25 23:16:38'),
(1956, 146, 'Venta', 'Factura #10489', 1, 0, '2021-06-25 23:16:38'),
(1957, 148, 'Venta', 'Factura #10489', 2, 1, '2021-06-25 23:16:38'),
(1958, 149, 'Venta', 'Factura #10490', 2, 1, '2021-06-25 23:17:59'),
(1959, 150, 'Venta', 'Factura #10490', 2, 1, '2021-06-25 23:17:59'),
(1960, 151, 'Venta', 'Factura #10490', 2, 1, '2021-06-25 23:17:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producciones`
--

CREATE TABLE `producciones` (
  `id` int(11) NOT NULL,
  `descripcion_produccion` varchar(500) COLLATE utf8_spanish_ci NOT NULL,
  `inversion_inicial` double NOT NULL,
  `fecha_inicio` date NOT NULL,
  `estado` varchar(50) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `producciones`
--

INSERT INTO `producciones` (`id`, `descripcion_produccion`, `inversion_inicial`, `fecha_inicio`, `estado`) VALUES
(1, 'Lechuga Romana', 50000, '2021-06-11', 'Activo'),
(2, 'PEPINO MODA', 100000, '2021-05-12', 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `codigo` text COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `imagen` text COLLATE utf8_spanish_ci NOT NULL,
  `stock` double NOT NULL,
  `precio_compra` decimal(10,0) NOT NULL,
  `precio_venta` decimal(10,0) NOT NULL,
  `precio_mayorista` double NOT NULL,
  `total_costo` float NOT NULL,
  `ventas` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `id_categoria`, `codigo`, `descripcion`, `imagen`, `stock`, `precio_compra`, `precio_venta`, `precio_mayorista`, `total_costo`, `ventas`, `fecha`) VALUES
(3, 1, '103', 'Tomate Barcelo', 'vistas/img/productos/default/anonymous.png', 140.2, '14', '22', 16, 0, 94, '2021-06-23 16:06:48'),
(4, 1, '104', 'Tomate de Ensalada', 'vistas/img/productos/default/anonymous.png', 51, '13', '22', 20, 0, 175, '2021-06-23 14:42:31'),
(5, 1, '105', 'Aji Morron', 'vistas/img/productos/default/anonymous.png', 74, '38', '51', 25, 0, 116, '2021-06-23 19:46:40'),
(6, 1, '106', 'Aji Cubanela', 'vistas/img/productos/default/anonymous.png', 13, '15', '29', 26, 0, 80, '2021-06-23 19:45:30'),
(7, 1, '107', 'Cebolla Roja ', 'vistas/img/productos/default/anonymous.png', 26, '20', '30', 25, 0, 123, '2021-06-20 14:20:48'),
(8, 1, '108', 'Cebolla Amarilla', 'vistas/img/productos/default/anonymous.png', 14.099999999999998, '26', '38', 30, 0, 82, '2021-06-21 14:51:34'),
(9, 1, '109', 'Zanahoria', 'vistas/img/productos/default/anonymous.png', 16, '8', '15', 12, 0, 119, '2021-06-23 20:13:19'),
(10, 1, '110', 'Apio', 'vistas/img/productos/default/anonymous.png', 0, '20', '22', 20, 0, 63, '2021-06-23 19:47:39'),
(11, 1, '111', 'Papa', 'vistas/img/productos/default/anonymous.png', 44, '11', '30', 16, 0, 110, '2021-06-23 19:55:01'),
(12, 1, '112', 'Papa Gourmet', 'vistas/img/productos/default/anonymous.png', 107, '7', '20', 8, 0, 105, '2021-06-23 19:55:24'),
(13, 1, '113', 'Lechuga Repollada', 'vistas/img/productos/default/anonymous.png', 11.8, '15', '25', 20, 0, 84, '2021-06-23 14:42:31'),
(14, 1, '114', 'Lechuga Morada', 'vistas/img/productos/default/anonymous.png', 3, '15', '20', 15, 0, 59, '2021-06-19 18:58:31'),
(15, 1, '115', 'Lechuga Romana', 'vistas/img/productos/default/anonymous.png', 4, '15', '25', 20, 0, 64, '2021-06-19 18:58:31'),
(16, 1, '116', 'Rabano', 'vistas/img/productos/default/anonymous.png', 6, '18', '37', 22, 0, 33, '2021-06-23 19:57:32'),
(17, 1, '117', 'Remolacha', 'vistas/img/productos/default/anonymous.png', 5, '10', '15', 22, 0, 68, '2021-06-23 20:08:12'),
(18, 1, '118', 'Espinaca', 'vistas/img/productos/default/anonymous.png', 9, '12', '15', 15, 0, 60, '2021-06-23 19:50:12'),
(19, 1, '119', 'Repollo Verde', 'vistas/img/productos/default/anonymous.png', 3, '60', '80', 60, 0, 61, '2021-06-23 20:08:45'),
(20, 1, '120', 'Brocoli', 'vistas/img/productos/default/anonymous.png', 1.7000000000000002, '20', '37', 26, 0, 70, '2021-06-24 12:57:49'),
(21, 1, '121', 'Coliflor', 'vistas/img/productos/default/anonymous.png', 9, '20', '50', 45, 0, 75, '2021-06-23 19:49:26'),
(22, 1, '122', 'Ajo Importado', 'vistas/img/productos/default/anonymous.png', 16, '75', '100', 80, 0, 67, '2021-06-23 19:46:55'),
(23, 5, '501', 'Albahaca ', 'vistas/img/productos/default/anonymous.png', 0, '10', '25', 18, 0, 65, '2021-06-12 21:02:33'),
(24, 1, '123', 'Berenjena', 'vistas/img/productos/default/anonymous.png', 0, '12', '16', 15, 0, 59, '2021-06-23 19:48:02'),
(25, 1, '124', 'Calabacin', 'vistas/img/productos/default/anonymous.png', 0, '20', '30', 24, 0, 62, '2021-06-23 19:48:45'),
(26, 5, '502', 'Cilantro Ancho', 'vistas/img/productos/default/anonymous.png', 0, '35', '51', 43, 0, 0, '2021-04-11 19:01:01'),
(27, 5, '503', 'Cilantro Fino Paq', 'vistas/img/productos/default/anonymous.png', 2, '8', '25', 45, 0, 68, '2021-06-18 15:58:48'),
(28, 2, '201', 'Coco Seco', 'vistas/img/productos/default/anonymous.png', 2, '50', '75', 62, 0, 0, '2021-05-13 22:14:53'),
(29, 6, '601', 'Curcuma', 'vistas/img/productos/default/anonymous.png', 0, '96', '140', 120, 0, 58, '2021-06-12 21:00:49'),
(30, 2, '202', 'Fresa Fresca Peq', 'vistas/img/productos/default/anonymous.png', 0, '75', '116', 95, 0, 87, '2021-06-24 13:21:46'),
(31, 2, '203', 'Fresa Fresca Grd', 'vistas/img/productos/default/anonymous.png', 1, '110', '150', 125, 0, 7, '2021-06-19 19:00:38'),
(32, 2, '204', 'Frambuesa', 'vistas/img/productos/default/anonymous.png', 0, '130', '150', 150, 0, 64, '2021-06-23 19:50:31'),
(33, 6, '602', 'Jengibre', 'vistas/img/productos/default/anonymous.png', 0, '125', '165', 150, 0, 1, '2021-06-23 19:51:10'),
(34, 5, '504', 'Hierba Buena', 'vistas/img/productos/default/anonymous.png', 0, '30', '40', 38, 0, 59, '2021-06-12 20:59:54'),
(35, 5, '505', 'Hinojo', 'vistas/img/productos/default/anonymous.png', 0, '30', '44', 34, 0, 0, '2021-06-12 20:58:40'),
(36, 1, '125', 'Lechuga Rizada', 'vistas/img/productos/default/anonymous.png', 2.01, '10', '20', 15, 0, 60, '2021-06-19 18:54:12'),
(37, 1, '126', 'Maiz Dulce', 'vistas/img/productos/default/anonymous.png', 1, '50', '75', 80, 0, 61, '2021-06-23 19:53:59'),
(38, 2, '205', 'Naranja Agria', 'vistas/img/productos/default/anonymous.png', 0, '5', '18', 6, 0, 68, '2021-06-23 19:54:36'),
(39, 1, '127', 'Pepino', 'vistas/img/productos/default/anonymous.png', 16, '8', '15', 24, 0, 84, '2021-06-23 19:56:13'),
(40, 5, '506', 'Perejil Liso', 'vistas/img/productos/default/anonymous.png', 1, '35', '52', 44, 0, 58, '2021-06-06 14:59:05'),
(41, 5, '507', 'Perejil Rizado', 'vistas/img/productos/default/anonymous.png', 2, '3', '10', 43, 0, 4, '2021-06-18 15:58:48'),
(42, 5, '508', 'Puerro Grueso', 'vistas/img/productos/default/anonymous.png', 5, '15', '22', 23, 0, 62, '2021-06-23 19:57:01'),
(43, 1, '128', 'Repollo Chino', 'vistas/img/productos/default/anonymous.png', 3, '25', '38', 32, 0, 60, '2021-06-23 20:09:19'),
(44, 1, '129', 'Repollo Morado', 'vistas/img/productos/default/anonymous.png', 2, '20', '24', 44, 0, 66, '2021-06-23 20:10:41'),
(45, 5, '509', 'Romero', 'vistas/img/productos/default/anonymous.png', 0, '50', '73', 63, 0, 0, '2021-04-11 19:19:05'),
(46, 1, '130', 'Rucula', 'vistas/img/productos/default/anonymous.png', 1, '40', '60', 44, 0, 3, '2021-06-18 15:57:18'),
(47, 1, '131', 'Tayota', 'vistas/img/productos/default/anonymous.png', 12, '12', '18', 15, 0, 68, '2021-06-23 20:11:12'),
(48, 5, '510', 'Tomillo', 'vistas/img/productos/default/anonymous.png', 0, '10', '15', 12, 0, 0, '2021-04-11 19:24:11'),
(49, 1, '132', 'Vainitas Chinas', 'vistas/img/productos/default/anonymous.png', 0, '25', '35', 70, 0, 3, '2021-06-23 20:11:53'),
(50, 1, '133', 'Vainitas Española', 'vistas/img/productos/default/anonymous.png', 0, '25', '30', 38, 0, 1, '2021-06-23 20:13:06'),
(51, 1, '134', 'Zucchini', 'vistas/img/productos/default/anonymous.png', 4.2, '15', '30', 25, 0, 68, '2021-06-24 13:19:28'),
(52, 1, '135', 'Aji Gustoso', 'vistas/img/productos/default/anonymous.png', 0, '25', '51', 110, 0, 0, '2021-06-23 19:46:11'),
(53, 2, '206', 'Limón ', 'vistas/img/productos/default/anonymous.png', 0, '20', '26', 60, 0, 118, '2021-06-23 20:45:16'),
(54, 2, '207', 'Granada China', 'vistas/img/productos/default/anonymous.png', 0.19999999999999973, '30', '45', 26, 0, 82, '2021-06-24 12:29:26'),
(55, 2, '208', 'Aguacate Hass', 'vistas/img/productos/default/anonymous.png', 27, '7', '15', 9, 0, 685, '2021-06-24 13:38:43'),
(56, 2, '209', 'Aguacate', 'vistas/img/productos/default/anonymous.png', 0, '10', '12', 14, 0, 365, '2021-05-15 22:18:28'),
(57, 7, '701', 'Agua ', 'vistas/img/productos/default/anonymous.png', 21, '6', '10', 7, 0, 140, '2021-06-24 20:01:34'),
(58, 7, '702', 'Cerveza Modelo', 'vistas/img/productos/default/anonymous.png', 0, '62', '70', 50, 0, 13, '2021-06-20 16:03:31'),
(59, 2, '210', 'Manzana Verde', 'vistas/img/productos/default/anonymous.png', 0, '50', '55', 110, 0, 4, '2021-05-14 20:49:00'),
(60, 2, '211', 'Piña', 'vistas/img/productos/default/anonymous.png', 0, '35', '50', 88, 0, 6, '2021-06-17 13:20:13'),
(61, 1, '136', 'Tomate Cherry Organico', 'vistas/img/productos/default/anonymous.png', 36, '45', '85', 54, 0, 62, '2021-06-24 14:28:17'),
(62, 8, '801', 'Habichuela Blanca', 'vistas/img/productos/default/anonymous.png', 4, '70', '101', 88, 0, 0, '2021-05-13 22:24:02'),
(63, 8, '802', 'Habichuela Roja', 'vistas/img/productos/default/anonymous.png', 1, '75', '105', 90, 0, 0, '2021-04-11 19:48:52'),
(64, 8, '803', 'Habichuela Negra', 'vistas/img/productos/default/anonymous.png', 1, '75', '105', 90, 0, 0, '2021-04-11 19:49:14'),
(65, 8, '804', 'Lentejas', 'vistas/img/productos/default/anonymous.png', 1, '39', '60', 49, 0, 0, '2021-06-12 20:50:06'),
(66, 3, '301', 'Ajo en Polvo', 'vistas/img/productos/default/anonymous.png', 1, '250', '325', 315, 0, 0, '2021-05-26 15:18:43'),
(67, 3, '302', 'Ajonjolí', 'vistas/img/productos/default/anonymous.png', 1, '150', '300', 75, 0, 59, '2021-06-12 20:49:46'),
(68, 3, '303', 'Anís Estrella', 'vistas/img/productos/default/anonymous.png', 1, '400', '490', 500, 0, 59, '2021-06-10 15:36:59'),
(69, 3, '304', 'Bicarbonato de Sodio', 'vistas/img/productos/default/anonymous.png', 4, '850', '950', 1060, 0, 58, '2021-06-12 20:49:14'),
(70, 3, '305', 'Bija Molida', 'vistas/img/productos/default/anonymous.png', 2, '175', '280', 183, 0, 0, '2021-05-26 15:21:01'),
(71, 3, '306', 'Canela entera', 'vistas/img/productos/default/anonymous.png', 3, '200', '300', 250, 0, 59, '2021-06-10 15:36:59'),
(72, 3, '307', 'Canela Molida', 'vistas/img/productos/default/anonymous.png', 2, '260', '350', 285, 0, 0, '2021-05-26 15:21:48'),
(73, 3, '308', 'Clavo Entero', 'vistas/img/productos/default/anonymous.png', 2, '250', '350', 312, 0, 0, '2021-05-26 15:22:47'),
(74, 3, '309', 'Clavo Dulce Molido', 'vistas/img/productos/default/anonymous.png', 2, '300', '450', 750, 0, 0, '2021-06-12 20:48:28'),
(75, 3, '310', 'Comino', 'vistas/img/productos/default/anonymous.png', 1, '200', '300', 250, 0, 0, '2021-05-26 15:23:10'),
(76, 3, '311', 'Curcuma en Polvo', 'vistas/img/productos/default/anonymous.png', 1, '200', '300', 250, 0, 0, '2021-05-26 15:24:07'),
(77, 3, '312', 'Curry en Polvo', 'vistas/img/productos/default/anonymous.png', 1, '200', '300', 250, 0, 0, '2021-05-26 15:24:29'),
(78, 3, '313', 'Enebro', 'vistas/img/productos/default/anonymous.png', 2, '350', '450', 438, 0, 58, '2021-05-26 15:24:47'),
(79, 3, '314', 'Flor de Tilo', 'vistas/img/productos/default/anonymous.png', 1, '650', '680', 720, 0, 1, '2021-06-12 14:36:18'),
(80, 3, '315', 'Flor de Manzanilla', 'vistas/img/productos/default/anonymous.png', 1, '300', '450', 375, 0, 1, '2021-05-26 15:25:57'),
(81, 3, '316', 'Hojas de Laurel', 'vistas/img/productos/default/anonymous.png', 1, '200', '320', 250, 0, 0, '2021-05-26 15:27:15'),
(82, 3, '317', 'Hojas de Eucalipto', 'vistas/img/productos/default/anonymous.png', 2, '150', '350', 188, 0, 0, '2021-05-26 15:26:41'),
(83, 3, '318', 'Hojas de Sen', 'vistas/img/productos/default/anonymous.png', 2, '80', '200', 100, 0, 0, '2021-05-26 15:27:41'),
(84, 3, '319', 'Linaza semilla', 'vistas/img/productos/default/anonymous.png', 1, '45', '180', 75, 0, 0, '2021-05-26 15:28:24'),
(85, 3, '320', 'Malagueta', 'vistas/img/productos/default/anonymous.png', 1, '150', '220', 188, 0, 0, '2021-05-26 15:29:06'),
(86, 3, '321', 'Manzanilla', 'vistas/img/productos/default/anonymous.png', 0, '150', '250', 188, 0, 58, '2021-06-12 20:47:37'),
(87, 3, '322', 'Nuez Moscada', 'vistas/img/productos/default/anonymous.png', 1, '350', '500', 438, 0, 0, '2021-05-26 15:30:33'),
(88, 3, '323', 'Pimentón Dulce', 'vistas/img/productos/default/anonymous.png', 1, '150', '400', 250, 0, 0, '2021-05-26 15:31:19'),
(89, 3, '324', 'Pimienta de Cayena', 'vistas/img/productos/default/anonymous.png', 1, '200', '400', 250, 0, 0, '2021-04-11 20:24:23'),
(90, 3, '325', 'Pimienta Negra Molida', 'vistas/img/productos/default/anonymous.png', 2, '150', '300', 250, 0, 1, '2021-05-26 15:43:59'),
(91, 3, '326', 'Rosa de Jamaica', 'vistas/img/productos/default/anonymous.png', 2, '250', '400', 312, 0, 2, '2021-05-26 15:36:32'),
(92, 3, '327', 'Sal de Ajo', 'vistas/img/productos/default/anonymous.png', 2, '250', '300', 250, 0, 60, '2021-06-12 20:47:16'),
(93, 3, '328', 'sazonador de Carne', 'vistas/img/productos/default/anonymous.png', 2, '450', '600', 562, 0, 0, '2021-05-26 15:37:11'),
(94, 3, '329', 'Tomillo Molido', 'vistas/img/productos/default/anonymous.png', 2, '250', '400', 312, 0, 0, '2021-05-26 15:37:53'),
(95, 3, '330', 'Cardamomo', 'vistas/img/productos/default/anonymous.png', 2, '2500', '3000', 1250, 0, 58, '2021-05-15 22:18:28'),
(96, 1, '137', 'Molondrón', 'vistas/img/productos/default/anonymous.png', 0, '25', '37', 31, 0, 0, '2021-04-11 20:29:05'),
(99, 7, '703', 'Jugo fruta fresca', 'vistas/img/productos/default/anonymous.png', 27, '19', '25', 25, 0, 67, '2021-06-24 20:02:42'),
(100, 7, '704', 'Refresco', 'vistas/img/productos/default/anonymous.png', 22, '19', '20', 20, 0, 101, '2021-06-24 20:02:42'),
(101, 9, '901', 'Mani con Pasas', 'vistas/img/productos/default/anonymous.png', 0, '75', '110', 100, 0, 4, '2021-05-01 14:43:40'),
(102, 9, '902', 'Almendra', 'vistas/img/productos/default/anonymous.png', 0, '20', '40', 40, 0, 6, '2021-04-25 14:30:43'),
(103, 5, '511', 'Hierba buena paq', 'vistas/img/productos/default/anonymous.png', 0, '3', '10', 20, 0, 36, '2021-06-12 20:44:51'),
(104, 5, '512', 'albahaca libra', 'vistas/img/productos/default/anonymous.png', 0, '100', '120', 100, 0, 4, '2021-06-12 20:44:33'),
(105, 6, '603', 'Cepa de apio', 'vistas/img/productos/default/anonymous.png', 0, '20', '40', 32, 0, 43, '2021-05-15 22:45:42'),
(106, 1, '138', 'Rucula Paq', 'vistas/img/productos/default/anonymous.png', 0, '19', '30', 25, 0, 32, '2021-05-07 20:40:26'),
(107, 3, '331', 'Ajonjolí negro', 'vistas/img/productos/default/anonymous.png', 1, '150', '300', 300, 0, 0, '2021-04-21 13:45:49'),
(108, 3, '332', 'Semilla de apio', 'vistas/img/productos/default/anonymous.png', 1, '150', '300', 300, 0, 0, '2021-04-21 13:53:48'),
(109, 3, '333', 'Semilla de cilantro', 'vistas/img/productos/default/anonymous.png', 0, '100', '200', 200, 0, 1, '2021-06-07 15:42:42'),
(110, 6, '604', 'Auyama', 'vistas/img/productos/default/anonymous.png', 0, '25', '30', 26, 0, 0, '2021-06-12 20:44:06'),
(111, 5, '513', 'Cilantro Fino libra', 'vistas/img/productos/default/anonymous.png', 0, '35', '50', 50, 0, 1, '2021-05-15 22:24:21'),
(112, 2, '212', 'Fresa Fresca Libra', 'vistas/img/productos/default/anonymous.png', 0, '80', '112', 85, 0, 74, '2021-05-15 22:18:29'),
(113, 2, '213', 'Fresa Congelada', 'vistas/img/productos/default/anonymous.png', 5, '110', '110', 110, 0, 73, '2021-06-20 18:17:44'),
(114, 2, '214', 'Sandia', 'vistas/img/productos/default/anonymous.png', 0, '20', '32', 26, 0, 0, '2021-06-12 20:43:43'),
(115, 6, '605', 'Yautia Blanca', 'vistas/img/productos/default/anonymous.png', 0, '55', '77', 57, 0, 2, '2021-05-15 22:45:42'),
(116, 6, '606', 'Yuca', 'vistas/img/productos/default/anonymous.png', 0, '18', '26', 20, 0, 0, '2021-06-12 20:38:45'),
(117, 6, '607', 'Yautia Coco', 'vistas/img/productos/default/anonymous.png', 0, '40', '59', 42, 0, 0, '2021-06-12 20:38:33'),
(118, 7, '705', 'Heineken', 'vistas/img/productos/default/anonymous.png', 0, '54', '65', 55, 0, 46, '2021-06-20 16:03:31'),
(119, 1, '139', 'Perejil rizado lib', 'vistas/img/productos/default/anonymous.png', 0, '30', '40', 40, 0, 58, '2021-06-12 20:56:00'),
(120, 5, '514', 'Romero Paq', 'vistas/img/productos/default/anonymous.png', 0, '10', '20', 20, 0, 58, '2021-06-12 20:36:44'),
(121, 2, '215', 'Pepino paq', 'vistas/img/productos/default/anonymous.png', 0, '6', '15', 15, 0, 9, '2021-06-12 20:32:20'),
(122, 8, '805', 'Vainita Esp paq', 'vistas/img/productos/default/anonymous.png', 4, '24', '35', 30, 0, 34, '2021-06-20 14:33:57'),
(127, 6, '608', 'Rabanito libra', 'vistas/img/productos/default/anonymous.png', 0, '25', '50', 50, 0, 59, '2021-06-12 20:35:36'),
(128, 2, '216', 'Naranja dulce', 'vistas/img/productos/default/anonymous.png', 0, '8', '15', 17, 0, 4, '2021-05-05 14:40:05'),
(129, 1, '140', 'Aji Morron 2da', 'vistas/img/productos/default/anonymous.png', 52.099999999999994, '17', '21', 17, 0, 41, '2021-06-23 13:36:50'),
(130, 1, '141', 'Tomate ensalada 2da', 'vistas/img/productos/default/anonymous.png', 49.5, '5', '6', 5, 0, 92, '2021-06-24 13:38:43'),
(131, 1, '142', 'Cebolla Roja Saco', 'vistas/img/productos/default/anonymous.png', 0, '700', '1022', 875, 0, 1, '2021-05-05 22:55:10'),
(132, 1, '143', 'Cebolla Amarilla Saco', 'vistas/img/productos/default/anonymous.png', 0, '1100', '1606', 1375, 0, 1, '2021-05-05 22:55:10'),
(133, 5, '515', 'Perejil liso Paq', 'vistas/img/productos/default/anonymous.png', 2, '11', '20', 10, 0, 1, '2021-06-18 15:58:48'),
(134, 3, '334', 'Anis Dulce', 'vistas/img/productos/default/anonymous.png', 1, '150', '300', 190, 0, 0, '2021-05-13 22:42:07'),
(135, 8, '807', 'Habichuela Pinta', 'vistas/img/productos/default/anonymous.png', 4, '69', '100', 79, 0, 0, '2021-06-12 20:29:48'),
(136, 2, '217', 'Chinola', 'vistas/img/productos/default/anonymous.png', 1, '6', '10', 7.5, 0, 22, '2021-06-18 15:58:48'),
(137, 11, '1101', 'Alcohol 70%', 'vistas/img/productos/default/anonymous.png', 9, '150', '180', 155, 0, 0, '2021-06-13 17:51:33'),
(139, 9, '903', 'Granola Paq', 'vistas/img/productos/default/anonymous.png', 2, '70', '111', 55, 0, 1, '2021-06-09 13:32:36'),
(140, 9, '904', 'Granola Funda', 'vistas/img/productos/default/anonymous.png', 2, '250', '365', 270, 0, 0, '2021-05-26 15:04:48'),
(141, 9, '905', 'Granola sobre', 'vistas/img/productos/default/anonymous.png', 2, '50', '75', 55, 0, 4, '2021-05-31 14:49:31'),
(142, 9, '906', 'Mixto Paq', 'vistas/img/productos/default/anonymous.png', 3, '110', '161', 120, 0, 0, '2021-05-26 15:05:11'),
(143, 3, '335', 'Comino en Polvo', 'vistas/img/productos/default/anonymous.png', 1, '200', '400', 260, 0, 0, '2021-05-26 15:24:51'),
(144, 12, '1201', 'Maravilla de Verano', 'vistas/img/productos/default/anonymous.png', 2, '65', '150', 85, 0, 0, '2021-05-29 15:29:19'),
(145, 12, '0', 'Lechuga Romana', 'vistas/img/productos/default/anonymous.png', 0, '65', '150', 85, 0, 2, '2021-06-25 23:16:37'),
(146, 12, '1', 'Lechuga Lollo Verde', 'vistas/img/productos/default/anonymous.png', 0, '65', '150', 85, 0, 2, '2021-06-25 23:16:38'),
(147, 12, '2', 'Lechuga Mixta', 'vistas/img/productos/default/anonymous.png', 0, '65', '150', 85, 0, 1, '2021-06-25 23:06:23'),
(148, 12, '3', 'Lechuga Roja De Trento', 'vistas/img/productos/default/anonymous.png', 1, '65', '150', 85, 0, 1, '2021-06-25 23:16:38'),
(149, 12, '4', 'Lechuga Rizada Roja', 'vistas/img/productos/default/anonymous.png', 1, '65', '150', 85, 0, 1, '2021-06-25 23:17:59'),
(150, 12, '5', 'Mostaza Verde', 'vistas/img/productos/default/anonymous.png', 1, '65', '150', 85, 0, 1, '2021-06-25 23:17:59'),
(151, 12, '6', 'Mizuna Red', 'vistas/img/productos/default/anonymous.png', 1, '65', '150', 85, 0, 1, '2021-06-25 23:17:59'),
(152, 12, '7', 'Cilantro Fino', 'vistas/img/productos/default/anonymous.png', 0, '65', '150', 85, 0, 0, '2021-06-12 21:01:15'),
(153, 12, '8', 'Perejil Liso S', 'vistas/img/productos/default/anonymous.png', 0, '65', '150', 85, 0, 2, '2021-06-07 15:42:42'),
(154, 12, '9', 'Mostaza Roja', 'vistas/img/productos/default/anonymous.png', 2, '65', '150', 85, 0, 0, '2021-05-29 15:36:58'),
(155, 12, '10', 'Espinaca', 'vistas/img/productos/default/anonymous.png', 2, '65', '150', 85, 0, 0, '2021-05-29 15:37:22'),
(156, 12, '11', 'Alabahaca Verde', 'vistas/img/productos/default/anonymous.png', 2, '65', '150', 85, 0, 0, '2021-05-29 15:37:56'),
(157, 12, '12', 'Albahaca Roja', 'vistas/img/productos/default/anonymous.png', 0, '65', '150', 85, 0, 2, '2021-06-01 13:22:49'),
(158, 12, '13', 'Perejil Rizado S', 'vistas/img/productos/default/anonymous.png', 1, '65', '150', 85, 0, 0, '2021-06-12 20:28:34'),
(159, 12, '14', 'Acelga', 'vistas/img/productos/default/anonymous.png', 2, '65', '150', 85, 0, 0, '2021-05-29 15:39:44'),
(160, 12, '15', 'Apio S', 'vistas/img/productos/default/anonymous.png', 1, '65', '150', 85, 0, 0, '2021-05-29 15:40:47'),
(161, 12, '16', 'Vainita Italiana ', 'vistas/img/productos/default/anonymous.png', 2, '65', '150', 85, 0, 0, '2021-05-29 15:41:30'),
(162, 12, '17', 'Remolacha', 'vistas/img/productos/default/anonymous.png', 2, '65', '150', 85, 0, 0, '2021-05-29 15:42:01'),
(163, 12, '18', 'Cebolla Roja S', 'vistas/img/productos/default/anonymous.png', 2, '65', '150', 85, 0, 0, '2021-05-29 15:42:26'),
(164, 12, '19', 'Rabanito S', 'vistas/img/productos/default/anonymous.png', 1, '65', '150', 85, 0, 0, '2021-05-29 15:43:03'),
(165, 12, '20', 'Tomate Cherry S', 'vistas/img/productos/default/anonymous.png', 2, '150', '250', 195, 0, 0, '2021-05-29 15:43:49'),
(166, 12, '21', 'Tomate Barcelo F1 S', 'vistas/img/productos/default/anonymous.png', 2, '150', '250', 195, 0, 0, '2021-05-29 15:44:18'),
(167, 12, '22', 'Tomate Mesa F1 S', 'vistas/img/productos/default/anonymous.png', 2, '150', '250', 195, 0, 0, '2021-05-29 15:44:45'),
(168, 12, '23', 'Pimiento Morron F1 ', 'vistas/img/productos/default/anonymous.png', 2, '100', '200', 130, 0, 0, '2021-05-29 15:45:36'),
(169, 12, '24', 'Aji Trofeo', 'vistas/img/productos/default/anonymous.png', 2, '100', '200', 130, 0, 0, '2021-05-29 15:46:58'),
(170, 12, '25', 'Zucchini', 'vistas/img/productos/default/anonymous.png', 2, '100', '200', 130, 0, 0, '2021-05-29 15:47:45'),
(171, 12, '26', 'Berenjena Negra', 'vistas/img/productos/default/anonymous.png', 2, '100', '200', 130, 0, 0, '2021-05-29 15:48:29'),
(172, 12, '27', 'Zanahoria S', 'vistas/img/productos/default/anonymous.png', 2, '65', '150', 85, 0, 0, '2021-05-29 15:49:00'),
(173, 12, '28', 'Melon S', 'vistas/img/productos/default/anonymous.png', 4, '65', '150', 85, 0, 0, '2021-06-12 20:51:05'),
(174, 1, '144', 'Combo', 'vistas/img/productos/default/anonymous.png', 0, '210', '350', 300, 0, 2, '2021-06-02 21:38:12'),
(175, 1, '145', 'Vainita China Paq', 'vistas/img/productos/default/anonymous.png', 4, '28', '40', 32, 0, 2, '2021-06-20 14:35:20'),
(176, 2, '218', 'Melon ', 'vistas/img/productos/default/anonymous.png', 0, '60', '88', 88, 0, 4, '2021-06-17 13:20:13'),
(177, 5, '516', 'Cilantro Ancho Paq', 'vistas/img/productos/default/anonymous.png', 1, '25', '35', 30, 0, 1, '2021-06-17 18:06:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `documento` text COLLATE utf8_spanish_ci NOT NULL,
  `direccion` text COLLATE utf8_spanish_ci NOT NULL,
  `telefono` text COLLATE utf8_spanish_ci NOT NULL,
  `email` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `nombre`, `documento`, `direccion`, `telefono`, `email`) VALUES
(2, 'VEGETALES FELNATI SRL', '130-83888-7	', 'AV. DUVERGE No. 37', '', ''),
(3, 'Fresas Franchi', '0000000000', 'Los Cerros, Constanza', '', ''),
(4, 'Vegetales Ramirez', '0000000000', 'C/Jarabacoa, Arroyo Arriba, Constanza', '(829) 576-7948', ''),
(5, 'Felix Jose Batista', '0000000000', 'Constanza', '(829) 281-7810', ''),
(6, 'Caonabo Quezada', '05300137527', 'Constanza', '(809) 519-9161', ''),
(7, 'Randy CarWash', '0000000000', 'Constanza', '', ''),
(8, 'Moreno Reyes', '0000000000', 'Constanza', '(829) 587-9282', ''),
(9, 'RIMINI FARMS SRL', '132-17103-9', 'c/Cinco s/a,La Colonia, Jarabacoa', '(809) 574-6538', 'info@riminifarms.com'),
(10, 'La Montaña de Chenco', '0000000000', 'Constanza', '(809) 669-1090', 'lamontanadechenco@gmail.com'),
(11, 'Eridania Rodriguez', '0000000000', 'Constanza', '(829) 901-7548', ''),
(12, 'Jonny Paez', '0000000000', 'Constanza', '(829) 558-0796', ''),
(13, 'Agua Tome', '0000000000', 'Constanza', '(809) 763-1059', ''),
(14, 'Mario', '000000', 'Constanza', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rnc_fiscal`
--

CREATE TABLE `rnc_fiscal` (
  `id` int(11) NOT NULL,
  `rnc` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `razon_social` varchar(300) COLLATE utf8_spanish_ci NOT NULL,
  `estado` varchar(30) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salida_dinero`
--

CREATE TABLE `salida_dinero` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `descripcion_salida_caja` text COLLATE utf8_spanish_ci NOT NULL,
  `monto` float NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `salida_dinero`
--

INSERT INTO `salida_dinero` (`id`, `id_usuario`, `descripcion_salida_caja`, `monto`, `fecha`) VALUES
(1, 1, 'Para compra agua', 500, '2019-11-17 10:40:09'),
(2, 1, 'Para pagarle taxi a una empleada', 100, '2019-11-17 10:16:30'),
(3, 2, 'Para pasaje de empleados', 200, '2019-12-02 19:05:00'),
(4, 2, 'Compra de agua', 100, '2019-12-02 19:05:25'),
(5, 2, 'Adelanto de empleado', 500, '2019-12-02 19:09:52'),
(6, 1, 'Compra botellon de agua', 100, '2021-02-05 22:34:43'),
(7, 4, 'Compra de 20 libra de Cepa de Apio', 400, '2021-04-18 19:16:31'),
(8, 4, 'Registrado como fondo en caja por error', 2000, '2021-04-18 19:34:43'),
(9, 4, 'Monto real en Caja $6,299', 2020, '2021-04-18 19:38:43'),
(10, 4, 'Se le entregó a Randy, para un saco de arroz, autorizado por Chepe', 1400, '2021-04-30 15:39:58'),
(11, 4, 'Compra de tomate de ensalada, \r\nAutorizado por liliana', 300, '2021-05-03 12:32:15'),
(12, 4, 'Fondo de caja registrado por error', 30, '2021-05-05 18:50:15'),
(13, 4, 'Autorizado por liliana, se le entregó a un trabajador.', 300, '2021-05-06 13:16:42'),
(14, 4, 'Pago en efectivo a Liliana, por compra en VDA BAEZ', 330, '2021-05-14 14:19:48'),
(15, 4, 'compra de chinola', 300, '2021-05-14 21:39:52'),
(16, 4, 'Pago 1ra quincena mes de mayo a Yeissy.', 4000, '2021-05-17 19:49:00'),
(17, 4, 'entrega de dinero para el desayuno, a Jony, autorizado por Liliana', 300, '2021-05-21 13:13:16'),
(18, 4, 'autorizado por Liliana, se repone al dia siguiente ', 370, '2021-05-22 00:23:44'),
(19, 4, 'Compra de mercancias, autorizado por  Liliana', 1000, '2021-05-27 20:34:28'),
(20, 4, 'Pago a Mario por entrega de Productos\r\nAlbahaca\r\nCilantro Fino\r\nEspinaca\r\nHierba Buena\r\n', 235, '2021-05-28 20:55:52'),
(21, 4, 'Desayuno 2 trabajadores', 100, '2021-05-29 14:00:45'),
(22, 4, 'entregado a Liliana Para Compra de Mercancia', 500, '2021-05-29 15:57:01'),
(23, 4, 'Prestado a Liliana 3/6/21\r\n', 100, '2021-06-03 16:06:13'),
(24, 4, 'Pago a fernando, autorizado por liliana', 1000, '2021-06-10 16:06:27'),
(25, 4, 'pago a un trabajador, Liliana estaba presente, entregado a Caimito', 100, '2021-06-10 20:49:06'),
(26, 4, 'se le entregó a Randy,  para comprar unos materiales', 500, '2021-06-16 13:31:11'),
(27, 4, 'dinero entregado a unos trabajadores, Caimito vino a buscarlo', 300, '2021-06-17 13:16:58'),
(28, 4, 'prestado a Liliana\r\n', 1000, '2021-06-17 13:36:44'),
(29, 4, 'prestado a Liliana', 500, '2021-06-17 15:47:14'),
(30, 4, 'dinero retirado de caja por Liliana', 140, '2021-06-18 01:25:45'),
(31, 4, 'prestado a Hancell, autorizado por Liliana', 100, '2021-06-19 19:11:23'),
(32, 4, 'prestado a Randy', 300, '2021-06-21 14:48:26'),
(33, 4, 'pago de jugos y refrescos', 450, '2021-06-23 15:45:21'),
(34, 4, 'Compra de pan, por liliana', 70, '2021-06-23 19:35:07'),
(35, 4, 'Compra de zuchinni', 600, '2021-06-24 19:42:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursales`
--

CREATE TABLE `sucursales` (
  `suc_id` int(11) NOT NULL,
  `suc_nombre` varchar(350) COLLATE utf8_spanish_ci NOT NULL,
  `suc_logo` varchar(550) COLLATE utf8_spanish_ci NOT NULL,
  `suc_direccion` varchar(350) COLLATE utf8_spanish_ci NOT NULL,
  `suc_telefono` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `suc_fiscal` tinyint(1) NOT NULL DEFAULT 1,
  `suc_estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `sucursales`
--

INSERT INTO `sucursales` (`suc_id`, `suc_nombre`, `suc_logo`, `suc_direccion`, `suc_telefono`, `suc_fiscal`, `suc_estado`) VALUES
(1, 'Excoveg', 'vistas/img/plantilla/logo-negro-lineal.png', 'Contanza', '809-000-0000', 1, 1),
(2, 'Vegetales Quezada', 'vistas/img/plantilla/341298669.jpg', 'Constanza', '809-000-0000', 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_comprobante`
--

CREATE TABLE `tipo_comprobante` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `serie` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `inicio_secuencia` int(11) NOT NULL,
  `fin_secuencia` int(11) NOT NULL,
  `ultimo_generado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipo_comprobante`
--

INSERT INTO `tipo_comprobante` (`id`, `descripcion`, `serie`, `inicio_secuencia`, `fin_secuencia`, `ultimo_generado`) VALUES
(1, 'Crédito Fiscal', 'B01', 0, 656585, 657088),
(2, 'Consumidor Final', 'B02', 0, 0, 505),
(3, 'Nota de credito', 'B03', 454, 656765, 505);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `id_sucursal` int(11) NOT NULL,
  `nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `usuario` text COLLATE utf8_spanish_ci NOT NULL,
  `password` text COLLATE utf8_spanish_ci NOT NULL,
  `perfil` text COLLATE utf8_spanish_ci NOT NULL,
  `foto` text COLLATE utf8_spanish_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `ultimo_login` datetime NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `id_sucursal`, `nombre`, `usuario`, `password`, `perfil`, `foto`, `estado`, `ultimo_login`, `fecha`) VALUES
(1, 1, 'Juan Sánchez', 'admin', '$2a$07$asxx54ahjppf45sd87a5auEve3vXIRl.4GYh.JFccDSJJH/hr3irG', 'Administrador', '', 1, '2021-06-25 19:05:53', '2021-06-25 23:05:53'),
(4, 0, 'Liliana Quezada', 'liliana', '$2a$07$asxx54ahjppf45sd87a5auFL5K1.Cmt9ZheoVVuudOi5BCi10qWly', 'Administrador', '', 1, '2021-06-24 17:13:07', '2021-06-24 21:13:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `codigo` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_vendedor` int(11) NOT NULL,
  `productos` text COLLATE utf8_spanish_ci NOT NULL,
  `impuesto` float NOT NULL,
  `neto` float NOT NULL,
  `descuento` float NOT NULL,
  `total` float NOT NULL,
  `metodo_pago` text COLLATE utf8_spanish_ci NOT NULL,
  `pago_con` double NOT NULL,
  `devuelta` double NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `codigo`, `id_cliente`, `id_vendedor`, `productos`, `impuesto`, `neto`, `descuento`, `total`, `metodo_pago`, `pago_con`, `devuelta`, `fecha`) VALUES
(3, 10003, 0, 4, '[{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"2\",\"stock\":\"1\",\"precio\":\"20\",\"total\":\"40\"}]', 0, 40, 0, 40, 'Efectivo', 0, 0, '2021-04-12 12:28:23'),
(4, 10004, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"23\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 0, 0, '2021-04-12 13:29:27'),
(5, 10005, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"2\",\"stock\":\"19\",\"precio\":\"25\",\"total\":\"50\"},{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"2\",\"stock\":\"21\",\"precio\":\"10\",\"total\":\"20\"}]', 0, 70, 0, 70, 'Efectivo', 0, 0, '2021-04-12 18:10:49'),
(6, 10006, 0, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"116\",\"total\":\"116\"}]', 0, 116, 0, 116, 'Efectivo', 0, 0, '2021-04-12 18:39:18'),
(7, 10007, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"20\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 0, 0, '2021-04-12 19:23:43'),
(8, 10008, 0, 4, '[{\"id\":\"43\",\"descripcion\":\"Repollo Chino\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"40\",\"total\":\"40\"},{\"id\":\"10\",\"descripcion\":\"Apio\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"26\",\"total\":\"26\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1.6\",\"stock\":\"6.4\",\"precio\":\"35\",\"total\":\"56\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.5\",\"stock\":\"15.5\",\"precio\":\"22\",\"total\":\"33\"},{\"id\":\"8\",\"descripcion\":\"Cebolla Amarilla\",\"cantidad\":\"0.6\",\"stock\":\"29.4\",\"precio\":\"38\",\"total\":\"22.8\"},{\"id\":\"33\",\"descripcion\":\"Jengibre\",\"cantidad\":\"0.3\",\"stock\":\"3.7\",\"precio\":\"185\",\"total\":\"55.5\"},{\"id\":\"59\",\"descripcion\":\"Manzana Verde\",\"cantidad\":\"2\",\"stock\":\"3\",\"precio\":\"55\",\"total\":\"110\"},{\"id\":\"18\",\"descripcion\":\"Espinaca\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"18\",\"total\":\"18\"}]', 0, 361.3, 0, 361.3, 'Efectivo', 0, 0, '2021-04-12 20:26:06'),
(10, 10009, 0, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"3.3\",\"stock\":\"26.7\",\"precio\":\"66\",\"total\":\"217.8\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"3\",\"stock\":\"6\",\"precio\":\"30\",\"total\":\"90\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"1.2\",\"stock\":\"6.8\",\"precio\":\"32\",\"total\":\"38.4\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"50\",\"total\":\"100\"},{\"id\":\"49\",\"descripcion\":\"Vainitas Chinas\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"91\",\"total\":\"91\"}]', 0, 537.2, 0, 537.2, 'Efectivo', 0, 0, '2021-04-13 21:14:11'),
(11, 10010, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"38\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 0, 0, '2021-04-14 12:23:05'),
(12, 10011, 0, 4, '[{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"1\",\"stock\":\"-5\",\"precio\":\"30\",\"total\":\"30\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"11\",\"stock\":\"9\",\"precio\":\"10\",\"total\":\"110\"}]', 0, 140, 0, 140, 'Efectivo', 0, 0, '2021-04-14 12:48:25'),
(13, 10012, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"2\",\"stock\":\"36\",\"precio\":\"20\",\"total\":\"40\"}]', 0, 40, 0, 40, 'Efectivo', 0, 0, '2021-04-14 13:40:38'),
(14, 10013, 0, 4, '[{\"id\":\"58\",\"descripcion\":\"Cerveza Modelo\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"60\",\"total\":\"60\"}]', 0, 60, 0, 60, 'Efectivo', 0, 0, '2021-04-14 14:22:41'),
(15, 10014, 0, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.57\",\"stock\":\"26.43\",\"precio\":\"66\",\"total\":\"37.62\"}]', 0, 37.62, 0, 37.62, 'Efectivo', 0, 0, '2021-04-14 15:23:19'),
(16, 10015, 0, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"116\",\"total\":\"116\"}]', 0, 116, 0, 116, 'Efectivo', 0, 0, '2021-04-14 15:54:17'),
(17, 10016, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"35\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 0, 0, '2021-04-14 18:48:09'),
(18, 10017, 0, 4, '[{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"0.001\",\"stock\":\"17.999\",\"precio\":\"15\",\"total\":\"0.02\"}]', 0, 0.02, 0, 0.02, 'Efectivo', 0, 0, '2021-04-14 18:51:55'),
(19, 10018, 0, 4, '[{\"id\":\"66\",\"descripcion\":\"Ajo en Polvo\",\"cantidad\":\"0.205\",\"stock\":\"0.795\",\"precio\":\"500\",\"total\":\"102.5\"},{\"id\":\"76\",\"descripcion\":\"Curcuma en Polvo\",\"cantidad\":\"0.130\",\"stock\":\"0.87\",\"precio\":\"400\",\"total\":\"52\"},{\"id\":\"72\",\"descripcion\":\"Canela Molida\",\"cantidad\":\"0.095\",\"stock\":\"0.905\",\"precio\":\"456\",\"total\":\"43.32\"}]', 0, 197.82, 0, 197.82, 'Efectivo', 0, 0, '2021-04-14 19:53:47'),
(20, 10019, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"34\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 0, 0, '2021-04-15 13:14:38'),
(21, 10020, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"1\",\"stock\":\"8\",\"precio\":\"15\",\"total\":\"15\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"1\",\"stock\":\"-6\",\"precio\":\"30\",\"total\":\"30\"}]', 0, 45, 0, 45, 'Efectivo', 0, 0, '2021-04-15 13:22:24'),
(22, 10021, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"33\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 0, 0, '2021-04-15 13:38:19'),
(23, 10022, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 0, 0, '2021-04-15 14:07:01'),
(24, 10023, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"3\",\"stock\":\"17\",\"precio\":\"10\",\"total\":\"30\"}]', 0, 30, 0, 30, 'Efectivo', 0, 0, '2021-04-15 18:05:20'),
(25, 10024, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 0, 0, '2021-04-15 18:23:25'),
(26, 10025, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 0, 0, '2021-04-15 18:30:13'),
(27, 10026, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"32\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 0, 0, '2021-04-15 18:42:17'),
(28, 10027, 0, 4, '[{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"4.7\",\"stock\":\"20.3\",\"precio\":\"30\",\"total\":\"141\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"6.6\",\"stock\":\"8.4\",\"precio\":\"22\",\"total\":\"145.2\"}]', 0, 286.2, 0, 286.2, 'Efectivo', 0, 0, '2021-04-15 19:22:36'),
(29, 10028, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"2\",\"stock\":\"15\",\"precio\":\"25\",\"total\":\"50\"}]', 0, 50, 0, 50, 'Efectivo', 0, 0, '2021-04-16 13:03:26'),
(30, 10029, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"2\",\"stock\":\"30\",\"precio\":\"20\",\"total\":\"40\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"14\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 65, 0, 65, 'Efectivo', 0, 0, '2021-04-16 13:12:14'),
(31, 10030, 0, 4, '[{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"0.8\",\"stock\":\"5.2\",\"precio\":\"31\",\"total\":\"24.8\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1.4\",\"stock\":\"4.6\",\"precio\":\"35\",\"total\":\"49\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.3\",\"stock\":\"4.7\",\"precio\":\"22\",\"total\":\"28.6\"}]', 0, 102.4, 0, 102.4, 'Efectivo', 0, 0, '2021-04-16 16:17:28'),
(32, 10031, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"15\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 0, 0, '2021-04-16 20:21:32'),
(33, 10032, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"14\",\"precio\":\"10\",\"total\":\"10\"},{\"id\":\"102\",\"descripcion\":\"Almendra\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"40\",\"total\":\"40\"}]', 0, 50, 0, 50, 'Efectivo', 0, 0, '2021-04-16 21:45:56'),
(34, 10033, 0, 4, '[{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"2\",\"stock\":\"3\",\"precio\":\"31\",\"total\":\"62\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.5\",\"stock\":\"25.5\",\"precio\":\"66\",\"total\":\"33\"}]', 0, 95, 0, 95, 'Efectivo', 0, 0, '2021-04-17 15:33:53'),
(35, 10034, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"29\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 0, 0, '2021-04-17 17:50:33'),
(36, 10035, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"28\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 0, 0, '2021-04-18 14:51:11'),
(37, 10036, 0, 4, '[{\"id\":\"31\",\"descripcion\":\"Fresa Fresca\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"150\",\"total\":\"150\"}]', 0, 150, 0, 150, 'Credito', 0, 0, '2021-04-18 14:52:51'),
(38, 10037, 0, 4, '[{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"2\",\"stock\":\"1\",\"precio\":\"30\",\"total\":\"60\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.2\",\"stock\":\"40.8\",\"precio\":\"22\",\"total\":\"26.4\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"2\",\"stock\":\"17\",\"precio\":\"30\",\"total\":\"60\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.6\",\"stock\":\"25.4\",\"precio\":\"66\",\"total\":\"39.6\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"0.3\",\"stock\":\"61.7\",\"precio\":\"30\",\"total\":\"9\"}]', 0, 195, 0, 195, 'Efectivo', 0, 0, '2021-04-18 15:33:01'),
(39, 10038, 7, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"25\",\"stock\":\"16\",\"precio\":\"20\",\"total\":\"500\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"50\",\"stock\":\"55\",\"precio\":\"25\",\"total\":\"1250\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"20\",\"stock\":\"42\",\"precio\":\"26\",\"total\":\"520\"},{\"id\":\"10\",\"descripcion\":\"Apio\",\"cantidad\":\"10\",\"stock\":\"2\",\"precio\":\"20\",\"total\":\"200\"},{\"id\":\"14\",\"descripcion\":\"Lechuga Morada\",\"cantidad\":\"15\",\"stock\":\"3\",\"precio\":\"15\",\"total\":\"225\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"35\",\"stock\":\"6\",\"precio\":\"45\",\"total\":\"1575\"},{\"id\":\"46\",\"descripcion\":\"Rucula\",\"cantidad\":\"2\",\"stock\":\"1\",\"precio\":\"44\",\"total\":\"88\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"20\",\"stock\":\"6\",\"precio\":\"24\",\"total\":\"480\"},{\"id\":\"51\",\"descripcion\":\"Zucchini\",\"cantidad\":\"20\",\"stock\":\"10\",\"precio\":\"25\",\"total\":\"500\"},{\"id\":\"104\",\"descripcion\":\"albahaca libra\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"100\",\"total\":\"200\"}]', 0, 5538, 0, 5538, 'Credito', 0, 0, '2021-04-18 19:38:55'),
(40, 10039, 0, 4, '[{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"30\",\"total\":\"30\"},{\"id\":\"41\",\"descripcion\":\"Perejil Rizado\",\"cantidad\":\"1\",\"stock\":\"9\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 65, 0, 65, 'Efectivo', 0, 0, '2021-04-18 16:22:48'),
(41, 10040, 0, 4, '[{\"id\":\"105\",\"descripcion\":\"Cepa de apio\",\"cantidad\":\"15\",\"stock\":\"6\",\"precio\":\"32\",\"total\":\"480\"}]', 0, 480, 0, 480, 'Efectivo', 0, 0, '2021-04-18 18:27:05'),
(42, 10041, 6, 4, '[{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"30\",\"stock\":\"12\",\"precio\":\"26\",\"total\":\"780\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"40\",\"stock\":\"15\",\"precio\":\"25\",\"total\":\"1000\"}]', 0, 1780, 0, 1780, 'Efectivo', 0, 0, '2021-04-18 19:22:06'),
(43, 10042, 0, 4, '[{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"0.5\",\"stock\":\"4.5\",\"precio\":\"30\",\"total\":\"15\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"1.9\",\"stock\":\"5.1\",\"precio\":\"20\",\"total\":\"38\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"6.7\",\"stock\":\"9.3\",\"precio\":\"22\",\"total\":\"147.4\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"1.7\",\"stock\":\"6.3\",\"precio\":\"32\",\"total\":\"54.4\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1.3\",\"stock\":\"13.7\",\"precio\":\"35\",\"total\":\"45.5\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"1.2\",\"stock\":\"4.8\",\"precio\":\"45\",\"total\":\"54\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"43\",\"descripcion\":\"Repollo Chino\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"40\",\"total\":\"40\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"1\",\"stock\":\"11\",\"precio\":\"30\",\"total\":\"30\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"1.7\",\"stock\":\"16.3\",\"precio\":\"15\",\"total\":\"25.5\"},{\"id\":\"59\",\"descripcion\":\"Manzana Verde\",\"cantidad\":\"0.3\",\"stock\":\"2.7\",\"precio\":\"55\",\"total\":\"16.5\"}]', 0, 491.3, 0, 491.3, 'Efectivo', 0, 0, '2021-04-18 19:31:03'),
(44, 10043, 8, 4, '[{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"2\",\"stock\":\"10\",\"precio\":\"30\",\"total\":\"60\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"3\",\"stock\":\"5\",\"precio\":\"22\",\"total\":\"66\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"6\",\"precio\":\"15\",\"total\":\"30\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"1\",\"stock\":\"-7\",\"precio\":\"30\",\"total\":\"30\"},{\"id\":\"27\",\"descripcion\":\"Cilantro Fino\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 211, 30, 181, 'Credito', 0, 0, '2021-04-19 12:59:18'),
(45, 10044, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"13\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 0, 0, '2021-04-19 13:08:14'),
(46, 10045, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"12\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"13\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 35, 0, 35, 'Efectivo', 0, 0, '2021-04-19 13:17:09'),
(47, 10046, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"3\",\"stock\":\"9\",\"precio\":\"25\",\"total\":\"75\"}]', 0, 75, 0, 75, 'Efectivo', 0, 0, '2021-04-19 14:04:32'),
(48, 10047, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"2\",\"stock\":\"7\",\"precio\":\"25\",\"total\":\"50\"}]', 0, 50, 0, 50, 'Efectivo', 0, 0, '2021-04-19 14:07:17'),
(49, 10048, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"3\",\"stock\":\"25\",\"precio\":\"20\",\"total\":\"60\"}]', 0, 60, 0, 60, 'Efectivo', 0, 0, '2021-04-19 14:08:20'),
(50, 10049, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"24\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 0, 0, '2021-04-19 14:08:57'),
(51, 10050, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"12\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 0, 0, '2021-04-19 14:09:49'),
(52, 10051, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"3\",\"stock\":\"2\",\"precio\":\"22\",\"total\":\"66\"}]', 0, 66, 0, 66, 'Efectivo', 0, 0, '2021-04-19 18:20:58'),
(53, 10052, 5, 4, '[{\"id\":\"102\",\"descripcion\":\"Almendra\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"40\",\"total\":\"40\"}]', 0, 40, 0, 40, 'Credito', 0, 0, '2021-04-19 19:56:49'),
(54, 10053, 0, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.4\",\"stock\":\"24.6\",\"precio\":\"66\",\"total\":\"26.4\"},{\"id\":\"38\",\"descripcion\":\"Naranja Agria\",\"cantidad\":\"6\",\"stock\":\"9\",\"precio\":\"8\",\"total\":\"48\"}]', 0, 74.4, 0, 74.4, 'Efectivo', 0, 0, '2021-04-19 20:10:56'),
(55, 10054, 0, 4, '[{\"id\":\"105\",\"descripcion\":\"Cepa de apio\",\"cantidad\":\"1.9\",\"stock\":\"4.1\",\"precio\":\"40\",\"total\":\"76\"}]', 0, 76, 0, 76, 'Efectivo', 0, 0, '2021-04-19 21:23:24'),
(56, 10055, 0, 4, '[{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"1\",\"stock\":\"66\",\"precio\":\"100\",\"total\":\"100\"}]', 0, 100, 0, 100, 'Efectivo', 0, 0, '2021-04-19 21:25:25'),
(57, 10056, 6, 4, '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"40\",\"stock\":\"9\",\"precio\":\"25\",\"total\":\"1000\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"25\",\"stock\":\"4\",\"precio\":\"26\",\"total\":\"650\"},{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"25\",\"stock\":\"2\",\"precio\":\"20\",\"total\":\"500\"}]', 0, 2150, 0, 2150, 'Efectivo', 0, 0, '2021-04-20 22:56:23'),
(58, 10057, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"23\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 0, 0, '2021-04-21 12:02:18'),
(59, 10058, 5, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"2\",\"stock\":\"10\",\"precio\":\"10\",\"total\":\"20\"},{\"id\":\"106\",\"descripcion\":\"Rucula Paq\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"30\",\"total\":\"30\"},{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 75, 0, 75, 'Credito', 0, 0, '2021-04-21 13:35:14'),
(60, 10059, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"32\",\"precio\":\"15\",\"total\":\"60\"},{\"id\":\"12\",\"descripcion\":\"Papa Gourmet\",\"cantidad\":\"1.39\",\"stock\":\"12.61\",\"precio\":\"15\",\"total\":\"20.85\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"2.3\",\"stock\":\"6.7\",\"precio\":\"42\",\"total\":\"96.6\"},{\"id\":\"16\",\"descripcion\":\"Rabano\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"26\",\"total\":\"26\"},{\"id\":\"49\",\"descripcion\":\"Vainitas Chinas\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"45\",\"total\":\"45\"},{\"id\":\"106\",\"descripcion\":\"Rucula Paq\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"30\",\"total\":\"30\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"1.5\",\"stock\":\"8.5\",\"precio\":\"37\",\"total\":\"55.5\"},{\"id\":\"92\",\"descripcion\":\"Sal de Ajo\",\"cantidad\":\"0.4\",\"stock\":\"1.6\",\"precio\":\"300\",\"total\":\"120\"}]', 0, 453.95, 0, 453.95, 'Efectivo', 0, 0, '2021-04-21 15:06:30'),
(61, 10060, 8, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"5\",\"stock\":\"2\",\"precio\":\"22\",\"total\":\"110\"},{\"id\":\"14\",\"descripcion\":\"Lechuga Morada\",\"cantidad\":\"2\",\"stock\":\"1\",\"precio\":\"20\",\"total\":\"40\"},{\"id\":\"103\",\"descripcion\":\"Hierba buena\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 170, 0, 119, 'Efectivo', 0, 0, '2021-04-21 21:32:30'),
(62, 10061, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"9\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 0, 0, '2021-04-21 18:19:54'),
(63, 10062, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"68\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 0, 0, '2021-04-21 20:18:46'),
(64, 10063, 10, 4, '[{\"id\":\"31\",\"descripcion\":\"Fresa Fresca\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"150\",\"total\":\"150\"}]', 0, 150, 0, 150, 'Credito', 0, 0, '2021-04-21 20:37:43'),
(65, 10064, 0, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"1.9\",\"stock\":\"22.1\",\"precio\":\"66\",\"total\":\"125.4\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"3\",\"stock\":\"16\",\"precio\":\"30\",\"total\":\"90\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"2.1\",\"stock\":\"95.9\",\"precio\":\"22\",\"total\":\"46.2\"},{\"id\":\"49\",\"descripcion\":\"Vainitas Chinas\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"45\",\"total\":\"45\"},{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"2.7\",\"stock\":\"7.3\",\"precio\":\"30\",\"total\":\"81\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1.2\",\"stock\":\"108.8\",\"precio\":\"42\",\"total\":\"50.4\"},{\"id\":\"44\",\"descripcion\":\"Repollo Morado\",\"cantidad\":\"1.7\",\"stock\":\"2.3\",\"precio\":\"52\",\"total\":\"88.4\"}]', 0, 551.4, 10.032, 541.368, 'Efectivo', 0, 0, '2021-04-22 13:36:43'),
(66, 10065, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"2\",\"stock\":\"5\",\"precio\":\"25\",\"total\":\"50\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"22\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 70, 0, 70, 'Efectivo', 0, 0, '2021-04-22 13:40:09'),
(67, 10066, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"72\",\"precio\":\"15\",\"total\":\"30\"}]', 0, 30, 0, 30, 'Efectivo', 0, 0, '2021-04-22 15:10:41'),
(68, 10067, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"67\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 0, 0, '2021-04-22 19:48:56'),
(69, 10068, 0, 4, '[{\"id\":\"92\",\"descripcion\":\"Sal de Ajo\",\"cantidad\":\"0.5\",\"stock\":\"1.5\",\"precio\":\"300\",\"total\":\"150\"}]', 0, 150, 0, 150, 'Efectivo', 0, 0, '2021-04-22 21:21:48'),
(70, 10069, 11, 4, '[{\"id\":\"92\",\"descripcion\":\"Sal de Ajo\",\"cantidad\":\"0.5\",\"stock\":\"1.5\",\"precio\":\"300\",\"total\":\"150\"}]', 0, 150, 0, 150, 'Credito', 0, 0, '2021-04-22 21:29:30'),
(71, 10070, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"21\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 0, 0, '2021-04-23 13:35:57'),
(72, 10071, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"3\",\"stock\":\"64\",\"precio\":\"10\",\"total\":\"30\"}]', 0, 55, 0, 55, 'Efectivo', 0, 0, '2021-04-23 13:42:13'),
(73, 10072, 0, 4, '[{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"1\",\"stock\":\"14\",\"precio\":\"30\",\"total\":\"30\"}]', 0, 30, 0, 30, 'Efectivo', 0, 0, '2021-04-23 13:44:27'),
(74, 10073, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"20\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 0, 0, '2021-04-23 13:46:58'),
(75, 10074, 0, 4, '[{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"12\",\"stock\":\"12\",\"precio\":\"20\",\"total\":\"240\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"10\",\"stock\":\"86\",\"precio\":\"22\",\"total\":\"220\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"2.6\",\"stock\":\"63.4\",\"precio\":\"100\",\"total\":\"260\"}]', 0, 720, 0, 720, 'Efectivo', 0, 0, '2021-04-23 18:13:30'),
(76, 10075, 0, 4, '[{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"1.3\",\"stock\":\"61.7\",\"precio\":\"100\",\"total\":\"130\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"8.9\",\"stock\":\"3.0999999999999996\",\"precio\":\"20\",\"total\":\"178\"}]', 0, 308, 0, 308, 'Efectivo', 0, 0, '2021-04-23 18:17:10'),
(77, 10076, 0, 4, '[{\"id\":\"90\",\"descripcion\":\"Pimienta Negra Molida\",\"cantidad\":\"0.13\",\"stock\":\"0.87\",\"precio\":\"400\",\"total\":\"52\"},{\"id\":\"92\",\"descripcion\":\"Sal de Ajo\",\"cantidad\":\"0.16\",\"stock\":\"1.84\",\"precio\":\"300\",\"total\":\"48\"},{\"id\":\"29\",\"descripcion\":\"Curcuma\",\"cantidad\":\"0.38\",\"stock\":\"1.62\",\"precio\":\"140\",\"total\":\"53.2\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 173.2, 0, 173.2, 'Efectivo', 0, 0, '2021-04-23 21:08:48'),
(78, 10077, 0, 4, '[{\"id\":\"102\",\"descripcion\":\"Almendra\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"40\",\"total\":\"40\"}]', 0, 40, 0, 40, 'Efectivo', 0, 0, '2021-04-24 13:36:00'),
(79, 10078, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"1\",\"stock\":\"71\",\"precio\":\"15\",\"total\":\"15\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.33\",\"stock\":\"83.67\",\"precio\":\"22\",\"total\":\"29.26\"}]', 0, 44.26, 0, 44.26, 'Efectivo', 0, 0, '2021-04-24 14:12:20'),
(80, 10079, 0, 4, '[{\"id\":\"102\",\"descripcion\":\"Almendra\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"40\",\"total\":\"40\"}]', 0, 40, 0, 40, 'Efectivo', 0, 0, '2021-04-24 14:13:16'),
(81, 10080, 0, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"2\",\"stock\":\"22\",\"precio\":\"65\",\"total\":\"130\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 155, 0, 155, 'Efectivo', 0, 0, '2021-04-24 15:02:59'),
(82, 10081, 0, 4, '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1.5\",\"stock\":\"107.5\",\"precio\":\"42\",\"total\":\"63\"}]', 0, 63, 0, 63, 'Efectivo', 0, 0, '2021-04-24 15:51:30'),
(83, 10082, 0, 4, '[{\"id\":\"102\",\"descripcion\":\"Almendra\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"40\",\"total\":\"40\"}]', 0, 40, 0, 40, 'Efectivo', 0, 0, '2021-04-24 16:00:37'),
(84, 10083, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"68\",\"precio\":\"15\",\"total\":\"45\"},{\"id\":\"10\",\"descripcion\":\"Apio\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"26\",\"total\":\"26\"}]', 0, 71, 0, 71, 'Efectivo', 0, 0, '2021-04-24 16:08:21'),
(85, 10084, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"21\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 0, 0, '2021-04-24 16:54:36'),
(86, 10085, 0, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"1.2\",\"stock\":\"20.8\",\"precio\":\"65\",\"total\":\"78\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"1\",\"stock\":\"32\",\"precio\":\"37\",\"total\":\"37\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"66\",\"precio\":\"15\",\"total\":\"30\"}]', 0, 145, 0, 145, 'Efectivo', 0, 0, '2021-04-24 20:30:11'),
(87, 10086, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 0, 0, '2021-04-25 13:52:51'),
(88, 10087, 5, 4, '[{\"id\":\"102\",\"descripcion\":\"Almendra\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"40\",\"total\":\"40\"}]', 0, 40, 0, 40, 'Credito', 0, 0, '2021-04-25 14:30:43'),
(89, 10088, 0, 4, '[{\"id\":\"72\",\"descripcion\":\"Canela Molida\",\"cantidad\":\"0.055\",\"stock\":\"1.945\",\"precio\":\"500\",\"total\":\"27.5\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"0.6\",\"stock\":\"107.4\",\"precio\":\"42\",\"total\":\"25.2\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"0.4\",\"stock\":\"2.6\",\"precio\":\"30\",\"total\":\"12\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"2.1\",\"stock\":\"0.8999999999999999\",\"precio\":\"20\",\"total\":\"42\"},{\"id\":\"51\",\"descripcion\":\"Zucchini\",\"cantidad\":\"2\",\"stock\":\"10\",\"precio\":\"32\",\"total\":\"64\"},{\"id\":\"31\",\"descripcion\":\"Fresa Fresca\",\"cantidad\":\"1\",\"stock\":\"7\",\"precio\":\"150\",\"total\":\"150\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"63\",\"precio\":\"15\",\"total\":\"45\"},{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"1\",\"stock\":\"13\",\"precio\":\"30\",\"total\":\"30\"}]', 0, 395.7, 0, 395.7, 'Efectivo', 0, 0, '2021-04-25 14:47:01'),
(90, 10089, 0, 4, '[{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"1.33\",\"stock\":\"30.67\",\"precio\":\"37\",\"total\":\"49.21\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"3.5\",\"stock\":\"57.5\",\"precio\":\"30\",\"total\":\"105\"},{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"2.4\",\"stock\":\"62.6\",\"precio\":\"25\",\"total\":\"60\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"2\",\"stock\":\"57\",\"precio\":\"15\",\"total\":\"30\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"2.12\",\"stock\":\"81.88\",\"precio\":\"22\",\"total\":\"46.64\"},{\"id\":\"44\",\"descripcion\":\"Repollo Morado\",\"cantidad\":\"1.23\",\"stock\":\"10.77\",\"precio\":\"52\",\"total\":\"63.96\"}]', 0, 354.81, 0, 354.81, 'Efectivo', 0, 0, '2021-04-25 15:01:13'),
(91, 10090, 0, 4, '[{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"3.2\",\"stock\":\"54.8\",\"precio\":\"30\",\"total\":\"96\"}]', 0, 96, 0, 96, 'Efectivo', 0, 0, '2021-04-25 15:34:10'),
(92, 10091, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.33\",\"stock\":\"80.67\",\"precio\":\"22\",\"total\":\"29.26\"}]', 0, 29.26, 0, 29.26, 'Efectivo', 0, 0, '2021-04-25 16:00:52'),
(93, 10092, 0, 4, '[{\"id\":\"95\",\"descripcion\":\"Cardamomo\",\"cantidad\":\"0.055\",\"stock\":\"0.945\",\"precio\":\"2000\",\"total\":\"110\"},{\"id\":\"78\",\"descripcion\":\"Enebro\",\"cantidad\":\"0.086\",\"stock\":\"1.914\",\"precio\":\"700\",\"total\":\"60.2\"},{\"id\":\"68\",\"descripcion\":\"Anís Estrella\",\"cantidad\":\"0.075\",\"stock\":\"0.925\",\"precio\":\"800\",\"total\":\"60\"},{\"id\":\"71\",\"descripcion\":\"Canela entera\",\"cantidad\":\"0.091\",\"stock\":\"1.909\",\"precio\":\"360\",\"total\":\"32.76\"},{\"id\":\"91\",\"descripcion\":\"Rosa de Jamaica\",\"cantidad\":\"0.074\",\"stock\":\"1.926\",\"precio\":\"500\",\"total\":\"37\"}]', 0, 299.96, 0, 299.96, 'Efectivo', 0, 0, '2021-04-25 17:48:49'),
(94, 10093, 13, 4, '[{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"1.9\",\"stock\":\"51.1\",\"precio\":\"20\",\"total\":\"38\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"3.39\",\"stock\":\"77.61\",\"precio\":\"22\",\"total\":\"74.58\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"2.6\",\"stock\":\"104.4\",\"precio\":\"42\",\"total\":\"109.2\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"1.3\",\"stock\":\"1.7\",\"precio\":\"30\",\"total\":\"39\"}]', 0, 260.78, 0, 260.78, 'Credito', 0, 0, '2021-04-25 19:16:44'),
(95, 10094, 14, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"6\",\"stock\":\"72\",\"precio\":\"22\",\"total\":\"132\"},{\"id\":\"27\",\"descripcion\":\"Cilantro Fino Paq\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"3\",\"stock\":\"4\",\"precio\":\"30\",\"total\":\"90\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"2\",\"stock\":\"4\",\"precio\":\"25\",\"total\":\"50\"}]', 0, 297, 19.8, 277.2, 'Credito', 0, 0, '2021-04-25 19:24:38'),
(96, 10095, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"20\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 0, 0, '2021-04-25 19:25:45'),
(97, 10096, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"22\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 25, 5, '2021-04-26 14:33:51'),
(98, 10097, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"6\",\"stock\":\"51\",\"precio\":\"15\",\"total\":\"90\"}]', 0, 90, 0, 90, 'Efectivo', 100, 10, '2021-04-26 14:35:27'),
(99, 10098, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"25\",\"stock\":\"26\",\"precio\":\"8\",\"total\":\"200\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"6\",\"stock\":\"168\",\"precio\":\"10\",\"total\":\"60\"}]', 0, 260, 0, 260, 'Efectivo', 300, 40, '2021-04-26 15:31:51'),
(100, 10099, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"21\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-04-26 19:41:29'),
(101, 10100, 0, 4, '[{\"id\":\"32\",\"descripcion\":\"Frambuesa\",\"cantidad\":\"1\",\"stock\":\"8\",\"precio\":\"160\",\"total\":\"160\"}]', 0, 160, 0, 160, 'Efectivo', 160, 0, '2021-04-28 12:52:05'),
(102, 10101, 0, 4, '[{\"id\":\"95\",\"descripcion\":\"Cardamomo\",\"cantidad\":\"0.5\",\"stock\":\"0.5\",\"precio\":\"2000\",\"total\":\"1000\"},{\"id\":\"125\",\"descripcion\":\"Envio\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"100\",\"total\":\"100\"}]', 0, 1100, 0, 1100, 'Efectivo', 1, 0, '2021-04-28 13:51:26'),
(103, 10102, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"2\",\"stock\":\"18\",\"precio\":\"65\",\"total\":\"130\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"116\",\"total\":\"116\"}]', 0, 246, 0, 246, 'Credito', 246, 0, '2021-04-28 14:40:31'),
(104, 10103, 0, 4, '[{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"2\",\"stock\":\"11\",\"precio\":\"30\",\"total\":\"60\"}]', 0, 60, 0, 60, 'Efectivo', 100, 40, '2021-04-28 14:52:09'),
(105, 10104, 0, 4, '[{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"1.16\",\"stock\":\"9.84\",\"precio\":\"30\",\"total\":\"34.8\"}]', 0, 34.8, 0, 34.8, 'Efectivo', 50, 15.2, '2021-04-28 14:57:23'),
(106, 10105, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"22\",\"precio\":\"15\",\"total\":\"60\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"2\",\"stock\":\"166\",\"precio\":\"15\",\"total\":\"30\"}]', 0, 90, 0, 90, 'Efectivo', 100, 10, '2021-04-28 15:01:38'),
(107, 10106, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"20\",\"precio\":\"15\",\"total\":\"30\"}]', 0, 30, 0, 30, 'Efectivo', 30, 0, '2021-04-28 15:03:18'),
(108, 10107, 0, 4, '[{\"id\":\"70\",\"descripcion\":\"Bija Molida\",\"cantidad\":\"0.055\",\"stock\":\"0.945\",\"precio\":\"360\",\"total\":\"19.8\"},{\"id\":\"90\",\"descripcion\":\"Pimienta Negra Molida\",\"cantidad\":\"0.076\",\"stock\":\"0.924\",\"precio\":\"400\",\"total\":\"30.4\"},{\"id\":\"87\",\"descripcion\":\"Nuez Moscada\",\"cantidad\":\"0.06\",\"stock\":\"0.94\",\"precio\":\"700\",\"total\":\"42\"}]', 0, 92.2, 0, 92.2, 'Efectivo', 95, 2.8, '2021-04-28 15:14:25'),
(109, 10108, 14, 4, '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"3.7\",\"stock\":\"100.3\",\"precio\":\"45\",\"total\":\"166.5\"}]', 0, 166.5, 49.95, 116.55, 'Credito', 166.5, 0, '2021-04-28 15:31:43'),
(110, 10109, 0, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Efectivo', 100, 35, '2021-04-28 19:10:48'),
(111, 10110, 8, 4, '[{\"id\":\"8\",\"descripcion\":\"Cebolla Amarilla\",\"cantidad\":\"1.6\",\"stock\":\"32.4\",\"precio\":\"38\",\"total\":\"60.8\"},{\"id\":\"51\",\"descripcion\":\"Zucchini\",\"cantidad\":\"2.6\",\"stock\":\"7.4\",\"precio\":\"32\",\"total\":\"83.2\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"3\",\"stock\":\"47\",\"precio\":\"20\",\"total\":\"60\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1.8\",\"stock\":\"98.2\",\"precio\":\"45\",\"total\":\"81\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"2.5\",\"stock\":\"57.5\",\"precio\":\"30\",\"total\":\"75\"},{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"2\",\"stock\":\"8\",\"precio\":\"30\",\"total\":\"60\"},{\"id\":\"126\",\"descripcion\":\"Vainita esp paq\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"35\",\"total\":\"35\"},{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"6\",\"stock\":\"52\",\"precio\":\"25\",\"total\":\"150\"},{\"id\":\"27\",\"descripcion\":\"Cilantro Fino Paq\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"5\",\"stock\":\"15\",\"precio\":\"15\",\"total\":\"75\"}]', 0, 705, 18.24, 686.76, 'Credito', 705, 0, '2021-04-28 20:06:20'),
(112, 10111, 0, 4, '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"2.3\",\"stock\":\"95.7\",\"precio\":\"45\",\"total\":\"103.5\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"116\",\"total\":\"116\"},{\"id\":\"101\",\"descripcion\":\"Mani con Pasas\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"110\",\"total\":\"110\"}]', 0, 329.5, 31.05, 329.5, 'Efectivo', 200, -129.5, '2021-04-29 13:34:12'),
(113, 10112, 5, 4, '[{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"1.5\",\"stock\":\"80.5\",\"precio\":\"30\",\"total\":\"45\"}]', 0, 45, 13.5, 31.5, 'Credito', 45, 0, '2021-04-29 13:54:01'),
(114, 10113, 14, 4, '[{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"2\",\"stock\":\"3\",\"precio\":\"25\",\"total\":\"50\"},{\"id\":\"41\",\"descripcion\":\"Perejil Rizado\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 60, 15, 60, 'Credito', 60, 0, '2021-04-29 14:05:35'),
(115, 10114, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"15\",\"stock\":\"67\",\"precio\":\"6\",\"total\":\"90\"}]', 0, 90, 0, 90, 'Efectivo', 90, 0, '2021-04-29 14:50:07'),
(116, 10115, 0, 4, '[{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"1.2\",\"stock\":\"6.8\",\"precio\":\"30\",\"total\":\"36\"}]', 0, 36, 0, 36, 'Efectivo', 50, 14, '2021-04-29 14:51:55'),
(117, 10116, 0, 4, '[{\"id\":\"101\",\"descripcion\":\"Mani con Pasas\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"110\",\"total\":\"110\"}]', 0, 110, 0, 110, 'Efectivo', 110, 0, '2021-04-29 14:54:16'),
(118, 10117, 5, 4, '[{\"id\":\"101\",\"descripcion\":\"Mani con Pasas\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"110\",\"total\":\"110\"}]', 0, 110, 0, 110, 'Credito', 110, 0, '2021-04-29 14:56:26'),
(119, 10118, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"33\",\"stock\":\"34\",\"precio\":\"3\",\"total\":\"99\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"2\",\"stock\":\"164\",\"precio\":\"10\",\"total\":\"20\"}]', 0, 119, 0, 119, 'Efectivo', 500, 381, '2021-04-29 15:46:34'),
(120, 10119, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-04-29 18:17:22'),
(121, 10120, 5, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"63\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Credito', 10, 0, '2021-04-29 20:01:19'),
(122, 10121, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"3\",\"stock\":\"18\",\"precio\":\"20\",\"total\":\"60\"}]', 0, 60, 0, 60, 'Efectivo', 60, 0, '2021-04-30 13:23:12'),
(124, 10123, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"62\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 50, 40, '2021-04-30 15:26:01'),
(125, 10124, 0, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"3\",\"stock\":\"1\",\"precio\":\"116\",\"total\":\"348\"}]', 0, 348, 0, 348, 'Efectivo', 350, 2, '2021-04-30 15:43:55'),
(126, 10125, 0, 4, '[{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"1\",\"stock\":\"378\",\"precio\":\"15\",\"total\":\"15\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.57\",\"stock\":\"70.43\",\"precio\":\"22\",\"total\":\"34.54\"}]', 0, 49.54, 0, 49.54, 'Efectivo', 50, 0.46, '2021-04-30 15:49:44'),
(127, 10126, 0, 4, '[{\"id\":\"42\",\"descripcion\":\"Puerro Grueso\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"27\",\"total\":\"54\"},{\"id\":\"10\",\"descripcion\":\"Apio\",\"cantidad\":\"2\",\"stock\":\"20\",\"precio\":\"31\",\"total\":\"62\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"6.7\",\"stock\":\"31.3\",\"precio\":\"30\",\"total\":\"201\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"3.2\",\"stock\":\"92.8\",\"precio\":\"45\",\"total\":\"144\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"4\",\"stock\":\"51\",\"precio\":\"15\",\"total\":\"60\"}]', 0, 521, 0, 521, 'Efectivo', 600, 79, '2021-04-30 16:17:20'),
(128, 10127, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"61\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-04-30 18:24:20'),
(129, 10128, 0, 4, '[{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"4\",\"stock\":\"27\",\"precio\":\"30\",\"total\":\"120\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"67\",\"precio\":\"15\",\"total\":\"45\"}]', 0, 165, 0, 165, 'Efectivo', 165, 0, '2021-04-30 19:30:00'),
(130, 10129, 0, 4, '[{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.6\",\"stock\":\"61.4\",\"precio\":\"100\",\"total\":\"60\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"2\",\"stock\":\"25\",\"precio\":\"30\",\"total\":\"60\"},{\"id\":\"8\",\"descripcion\":\"Cebolla Amarilla\",\"cantidad\":\"1\",\"stock\":\"31\",\"precio\":\"38\",\"total\":\"38\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"64\",\"precio\":\"15\",\"total\":\"45\"}]', 0, 203, 0, 203, 'Efectivo', 500, 297, '2021-04-30 20:34:35'),
(131, 10130, 0, 4, '[{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"6\",\"stock\":\"45\",\"precio\":\"15\",\"total\":\"90\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"1.8\",\"stock\":\"56.2\",\"precio\":\"37\",\"total\":\"66.6\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"4\",\"stock\":\"94\",\"precio\":\"45\",\"total\":\"180\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"5.9\",\"stock\":\"64.1\",\"precio\":\"22\",\"total\":\"129.8\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"3\",\"stock\":\"5\",\"precio\":\"30\",\"total\":\"90\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"1.1\",\"stock\":\"59.9\",\"precio\":\"100\",\"total\":\"110\"},{\"id\":\"19\",\"descripcion\":\"Repollo Verde\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"85\",\"total\":\"85\"}]', 0, 751.4, 4.5, 746.9, 'Efectivo', 750, 3.1, '2021-04-30 20:48:12'),
(132, 10131, 0, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"3\",\"stock\":\"13\",\"precio\":\"65\",\"total\":\"195\"}]', 0, 195, 0, 195, 'Efectivo', 500, 305, '2021-04-30 20:50:04'),
(133, 10132, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"60\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-04-30 20:53:12'),
(134, 10133, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"10\",\"stock\":\"54\",\"precio\":\"15\",\"total\":\"150\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"1\",\"stock\":\"377\",\"precio\":\"15\",\"total\":\"15\"}]', 0, 165, 76.5, 88.5, 'Efectivo', 100, 11.5, '2021-04-30 21:05:09'),
(135, 10134, 0, 4, '[{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"13\",\"stock\":\"364\",\"precio\":\"16\",\"total\":\"208\"}]', 0, 208, 0, 208, 'Efectivo', 500, 292, '2021-04-30 21:10:48'),
(136, 10135, 0, 4, '[{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"14\",\"stock\":\"167\",\"precio\":\"20\",\"total\":\"280\"}]', 0, 280, 140, 140, 'Efectivo', 140, 0, '2021-04-30 21:20:47'),
(137, 10136, 0, 4, '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"3.5\",\"stock\":\"89.5\",\"precio\":\"45\",\"total\":\"157.5\"}]', 0, 157.5, 0, 157.5, 'Efectivo', 200, 42.5, '2021-05-01 13:54:38'),
(138, 10137, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"3\",\"stock\":\"15\",\"precio\":\"20\",\"total\":\"60\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"2\",\"stock\":\"25\",\"precio\":\"25\",\"total\":\"50\"}]', 0, 110, 0, 110, 'Efectivo', 110, 0, '2021-05-01 13:55:37'),
(139, 10138, 0, 4, '[{\"id\":\"101\",\"descripcion\":\"Mani con Pasas\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"110\",\"total\":\"110\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"14\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 130, 0, 130, 'Efectivo', 210, 80, '2021-05-01 14:43:40'),
(140, 10139, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"59\",\"precio\":\"10\",\"total\":\"10\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"13\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 30, 0, 30, 'Efectivo', 30, 0, '2021-05-01 14:53:20'),
(141, 10140, 0, 4, '[{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"2\",\"stock\":\"43\",\"precio\":\"15\",\"total\":\"30\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"116\",\"total\":\"116\"},{\"id\":\"31\",\"descripcion\":\"Fresa Fresca\",\"cantidad\":\"1\",\"stock\":\"6\",\"precio\":\"150\",\"total\":\"150\"},{\"id\":\"121\",\"descripcion\":\"Pepino paq\",\"cantidad\":\"1\",\"stock\":\"6\",\"precio\":\"15\",\"total\":\"15\"},{\"id\":\"19\",\"descripcion\":\"Repollo Verde\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"85\",\"total\":\"85\"}]', 0, 396, 0, 396, 'Efectivo', 500, 104, '2021-05-01 17:03:15'),
(142, 10141, 0, 4, '[{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"4\",\"stock\":\"390\",\"precio\":\"16\",\"total\":\"64\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"8\",\"stock\":\"76\",\"precio\":\"15\",\"total\":\"120\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"3\",\"stock\":\"61\",\"precio\":\"22\",\"total\":\"66\"},{\"id\":\"34\",\"descripcion\":\"Hierba Buena\",\"cantidad\":\"0.3\",\"stock\":\"14.7\",\"precio\":\"40\",\"total\":\"12\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"2.6\",\"stock\":\"91.4\",\"precio\":\"45\",\"total\":\"117\"},{\"id\":\"111\",\"descripcion\":\"Cilantro Fino libra\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"50\",\"total\":\"50\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.5\",\"stock\":\"59.5\",\"precio\":\"100\",\"total\":\"50\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"1.1\",\"stock\":\"23.9\",\"precio\":\"30\",\"total\":\"33\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"0.9\",\"stock\":\"166.1\",\"precio\":\"20\",\"total\":\"18\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"2\",\"stock\":\"41\",\"precio\":\"15\",\"total\":\"30\"},{\"id\":\"38\",\"descripcion\":\"Naranja Agria\",\"cantidad\":\"4\",\"stock\":\"32\",\"precio\":\"8\",\"total\":\"32\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"2.1\",\"stock\":\"14.9\",\"precio\":\"30\",\"total\":\"63\"},{\"id\":\"80\",\"descripcion\":\"Flor de Manzanilla\",\"cantidad\":\"0.19\",\"stock\":\"0.81\",\"precio\":\"600\",\"total\":\"114\"}]', 0, 769, 19.2, 749.8, 'Efectivo', 775, 25.2, '2021-05-01 18:01:20'),
(143, 10142, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"12\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-05-01 18:20:55'),
(144, 10143, 0, 4, '[{\"id\":\"38\",\"descripcion\":\"Naranja Agria\",\"cantidad\":\"5\",\"stock\":\"27\",\"precio\":\"8\",\"total\":\"40\"},{\"id\":\"128\",\"descripcion\":\"Naranja dulce\",\"cantidad\":\"3\",\"stock\":\"0\",\"precio\":\"17\",\"total\":\"51\"}]', 0, 91, 0, 91, 'Efectivo', 100, 9, '2021-05-01 20:04:53'),
(145, 10144, 0, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"12\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Efectivo', 100, 35, '2021-05-01 20:19:42'),
(146, 10145, 0, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"11\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Efectivo', 100, 35, '2021-05-01 20:20:27'),
(147, 10146, 0, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"10\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Efectivo', 100, 35, '2021-05-01 20:25:54'),
(148, 10147, 0, 4, '[{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"10\",\"stock\":\"380\",\"precio\":\"20\",\"total\":\"200\"}]', 0, 200, 0, 200, 'Efectivo', 500, 300, '2021-05-02 15:57:28');
INSERT INTO `ventas` (`id`, `codigo`, `id_cliente`, `id_vendedor`, `productos`, `impuesto`, `neto`, `descuento`, `total`, `metodo_pago`, `pago_con`, `devuelta`, `fecha`) VALUES
(149, 10148, 0, 4, '[{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"3.6\",\"stock\":\"37.4\",\"precio\":\"15\",\"total\":\"54\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"1.3\",\"stock\":\"22.7\",\"precio\":\"30\",\"total\":\"39\"},{\"id\":\"8\",\"descripcion\":\"Cebolla Amarilla\",\"cantidad\":\"1.1\",\"stock\":\"29.9\",\"precio\":\"38\",\"total\":\"41.8\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"1.3\",\"stock\":\"164.7\",\"precio\":\"20\",\"total\":\"26\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.6\",\"stock\":\"59.4\",\"precio\":\"100\",\"total\":\"60\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"2.3\",\"stock\":\"56.7\",\"precio\":\"22\",\"total\":\"50.6\"},{\"id\":\"17\",\"descripcion\":\"Remolacha\",\"cantidad\":\"1.4\",\"stock\":\"0.6000000000000001\",\"precio\":\"26\",\"total\":\"36.4\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"1.9\",\"stock\":\"18.1\",\"precio\":\"30\",\"total\":\"57\"}]', 0, 364.8, 16.2, 348.6, 'Efectivo', 500, 151.4, '2021-05-02 16:24:52'),
(150, 10149, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"11\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 50, 30, '2021-05-03 13:16:28'),
(151, 10150, 0, 4, '[{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"3\",\"stock\":\"377\",\"precio\":\"15\",\"total\":\"45\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.2\",\"stock\":\"55.8\",\"precio\":\"22\",\"total\":\"26.4\"}]', 0, 71.4, 0, 71.4, 'Efectivo', 80, 8.6, '2021-05-03 14:34:10'),
(152, 10151, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"24\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 25, 0, '2021-05-03 15:53:10'),
(153, 10152, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"9\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-05-03 18:41:00'),
(154, 10153, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"58\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-03 18:47:32'),
(155, 10154, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"8\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-05-03 19:11:00'),
(156, 10155, 14, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"5\",\"stock\":\"49\",\"precio\":\"22\",\"total\":\"110\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"2\",\"stock\":\"5\",\"precio\":\"25\",\"total\":\"50\"}]', 0, 160, 0, 160, 'Credito', 160, 0, '2021-05-05 14:30:23'),
(157, 10156, 5, 4, '[{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"1\",\"stock\":\"60\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Credito', 25, 0, '2021-05-05 14:30:57'),
(158, 10157, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"1\",\"stock\":\"75\",\"precio\":\"15\",\"total\":\"15\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"1\",\"stock\":\"376\",\"precio\":\"15\",\"total\":\"15\"},{\"id\":\"128\",\"descripcion\":\"Naranja dulce\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"15\",\"total\":\"15\"}]', 0, 45, 0, 45, 'Efectivo', 45, 0, '2021-05-05 14:40:05'),
(159, 10158, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"4\",\"stock\":\"54\",\"precio\":\"10\",\"total\":\"40\"}]', 0, 40, 0, 40, 'Efectivo', 40, 0, '2021-05-05 14:40:42'),
(160, 10159, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"53\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-05 14:48:07'),
(161, 10160, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"3\",\"stock\":\"50\",\"precio\":\"10\",\"total\":\"30\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"23\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 55, 0, 55, 'Efectivo', 55, 0, '2021-05-05 15:18:48'),
(162, 10161, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"1\",\"stock\":\"74\",\"precio\":\"15\",\"total\":\"15\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"1\",\"stock\":\"375\",\"precio\":\"15\",\"total\":\"15\"}]', 0, 30, 0, 30, 'Efectivo', 30, 0, '2021-05-05 15:23:05'),
(163, 10162, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"49\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-05 18:17:27'),
(164, 10163, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"2\",\"stock\":\"47\",\"precio\":\"10\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-05-05 18:24:07'),
(165, 10164, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"72\",\"precio\":\"15\",\"total\":\"30\"}]', 0, 30, 0, 30, 'Efectivo', 50, 20, '2021-05-05 18:45:04'),
(166, 10165, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"46\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-05 19:44:43'),
(167, 10166, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"2\",\"stock\":\"21\",\"precio\":\"25\",\"total\":\"50\"}]', 0, 50, 0, 50, 'Efectivo', 50, 0, '2021-05-05 19:51:30'),
(168, 10167, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"45\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-05 19:57:23'),
(169, 10168, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"6\",\"stock\":\"39\",\"precio\":\"10\",\"total\":\"60\"}]', 0, 60, 0, 60, 'Efectivo', 100, 40, '2021-05-05 20:00:45'),
(170, 10169, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"20\",\"stock\":\"52\",\"precio\":\"15\",\"total\":\"300\"}]', 0, 300, 141, 159, 'Efectivo', 500, 341, '2021-05-05 21:24:22'),
(171, 10170, 6, 4, '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"70\",\"stock\":\"161\",\"precio\":\"60\",\"total\":\"3150\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"60\",\"stock\":\"191\",\"precio\":\"25\",\"total\":\"1620\"},{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"30\",\"stock\":\"65\",\"precio\":\"25\",\"total\":\"600\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"70\",\"stock\":\"117\",\"precio\":\"20\",\"total\":\"1400\"}]', 0, 6770, 0, 6770, 'TD-01', 5, -70, '2021-05-06 21:58:54'),
(172, 10171, 10, 4, '[{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"68\",\"stock\":\"189\",\"precio\":\"13\",\"total\":\"884\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"50\",\"stock\":\"89\",\"precio\":\"13\",\"total\":\"650\"},{\"id\":\"130\",\"descripcion\":\"Tomate ensalada 2da\",\"cantidad\":\"30\",\"stock\":\"0\",\"precio\":\"5\",\"total\":\"150\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"50\",\"stock\":\"111\",\"precio\":\"35\",\"total\":\"1750\"},{\"id\":\"129\",\"descripcion\":\"Aji Morron 2da\",\"cantidad\":\"30\",\"stock\":\"0\",\"precio\":\"17\",\"total\":\"510\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"45\",\"stock\":\"146\",\"precio\":\"15\",\"total\":\"675\"}]', 0, 4619, 0, 4619, 'Credito', 4619, 0, '2021-05-05 22:43:58'),
(173, 10172, 7, 4, '[{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"20\",\"stock\":\"60\",\"precio\":\"32\",\"total\":\"640\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"35\",\"stock\":\"91\",\"precio\":\"32\",\"total\":\"1120\"},{\"id\":\"131\",\"descripcion\":\"Cebolla Roja Saco\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"875\",\"total\":\"875\"},{\"id\":\"104\",\"descripcion\":\"albahaca libra\",\"cantidad\":\"1\",\"stock\":\"7\",\"precio\":\"100\",\"total\":\"100\"},{\"id\":\"132\",\"descripcion\":\"Cebolla Amarilla Saco\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"1375\",\"total\":\"1375\"},{\"id\":\"34\",\"descripcion\":\"Hierba Buena\",\"cantidad\":\"1\",\"stock\":\"15\",\"precio\":\"40\",\"total\":\"40\"},{\"id\":\"17\",\"descripcion\":\"Remolacha\",\"cantidad\":\"10\",\"stock\":\"0\",\"precio\":\"24\",\"total\":\"240\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"30\",\"stock\":\"159\",\"precio\":\"18\",\"total\":\"540\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"30\",\"stock\":\"59\",\"precio\":\"19\",\"total\":\"570\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"40\",\"stock\":\"71\",\"precio\":\"45\",\"total\":\"1800\"}]', 0, 7300, 0, 7300, 'Credito', 7300, 0, '2021-05-05 22:55:10'),
(174, 10173, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"38\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-06 12:23:36'),
(175, 10174, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"20\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 25, 0, '2021-05-06 13:14:10'),
(176, 10175, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"37\",\"precio\":\"10\",\"total\":\"10\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"10\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 30, 0, 30, 'Efectivo', 30, 0, '2021-05-06 13:26:40'),
(177, 10176, 0, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"2\",\"stock\":\"1\",\"precio\":\"116\",\"total\":\"232\"},{\"id\":\"51\",\"descripcion\":\"Zucchini\",\"cantidad\":\"2.3\",\"stock\":\"9.7\",\"precio\":\"32\",\"total\":\"73.6\"},{\"id\":\"25\",\"descripcion\":\"Calabacin\",\"cantidad\":\"2.9\",\"stock\":\"7.1\",\"precio\":\"32\",\"total\":\"92.8\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"1\",\"stock\":\"59\",\"precio\":\"37\",\"total\":\"37\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"3.8\",\"stock\":\"87.2\",\"precio\":\"45\",\"total\":\"171\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"1.6\",\"stock\":\"157.4\",\"precio\":\"20\",\"total\":\"32\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.4\",\"stock\":\"57.6\",\"precio\":\"22\",\"total\":\"30.8\"}]', 0, 669.2, 69.6, 599.6, 'Efectivo', 1, 400.4, '2021-05-06 15:20:59'),
(178, 10177, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"36\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-06 15:29:08'),
(179, 10178, 7, 4, '[{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"20\",\"stock\":\"147\",\"precio\":\"27\",\"total\":\"540\"}]', 0, 540, 0, 540, 'Credito', 540, 0, '2021-05-06 15:45:10'),
(180, 10179, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"3\",\"stock\":\"33\",\"precio\":\"10\",\"total\":\"30\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"9\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 50, 0, 50, 'Efectivo', 100, 50, '2021-05-06 15:50:15'),
(181, 10180, 0, 4, '[{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"0.9\",\"stock\":\"58.1\",\"precio\":\"37\",\"total\":\"33.3\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"1.8\",\"stock\":\"85.2\",\"precio\":\"45\",\"total\":\"81\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"0.7\",\"stock\":\"116.3\",\"precio\":\"20\",\"total\":\"14\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1\",\"stock\":\"57\",\"precio\":\"22\",\"total\":\"22\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1.1\",\"stock\":\"159.9\",\"precio\":\"60\",\"total\":\"66\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.5\",\"stock\":\"58.5\",\"precio\":\"100\",\"total\":\"50\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"1\",\"stock\":\"22\",\"precio\":\"30\",\"total\":\"30\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"116\",\"total\":\"116\"},{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"1\",\"stock\":\"61\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 437.3, 87.46, 349.84, 'Efectivo', 349, -0.84, '2021-05-06 18:22:34'),
(182, 10181, 5, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"32\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Credito', 10, 0, '2021-05-06 18:37:40'),
(183, 10182, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"2\",\"stock\":\"30\",\"precio\":\"10\",\"total\":\"20\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"8\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 40, 0, 40, 'Efectivo', 40, 0, '2021-05-06 18:51:17'),
(184, 10183, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"29\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-06 20:57:44'),
(185, 10184, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"6\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-05-06 21:15:54'),
(186, 10185, 0, 4, '[{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"1\",\"stock\":\"60\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"0.7\",\"stock\":\"21.3\",\"precio\":\"30\",\"total\":\"21\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.4\",\"stock\":\"58.6\",\"precio\":\"100\",\"total\":\"40\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"1.3\",\"stock\":\"83.7\",\"precio\":\"45\",\"total\":\"58.5\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"1.1\",\"stock\":\"56.9\",\"precio\":\"37\",\"total\":\"40.7\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.2\",\"stock\":\"55.8\",\"precio\":\"22\",\"total\":\"26.4\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"0.7\",\"stock\":\"115.3\",\"precio\":\"20\",\"total\":\"14\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"0.9\",\"stock\":\"159.1\",\"precio\":\"60\",\"total\":\"54\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"116\",\"total\":\"116\"}]', 0, 395.6, 43.516, 352.084, 'TC', 395.6, 0, '2021-05-06 21:55:47'),
(187, 10186, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"1\",\"stock\":\"51\",\"precio\":\"15\",\"total\":\"15\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"1\",\"stock\":\"373\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 40, 0, 40, 'Efectivo', 40, 0, '2021-05-07 15:09:53'),
(188, 10187, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"6\",\"stock\":\"45\",\"precio\":\"15\",\"total\":\"90\"}]', 0, 90, 0, 90, 'Efectivo', 100, 10, '2021-05-07 18:41:35'),
(189, 10188, 12, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"12\",\"stock\":\"58\",\"precio\":\"15\",\"total\":\"108\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"210\",\"stock\":\"163\",\"precio\":\"25\",\"total\":\"3570\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"4\",\"stock\":\"191\",\"precio\":\"25\",\"total\":\"68\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"5\",\"stock\":\"164\",\"precio\":\"60\",\"total\":\"160\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"2\",\"stock\":\"57\",\"precio\":\"100\",\"total\":\"160\"},{\"id\":\"23\",\"descripcion\":\"Albahaca \",\"cantidad\":\"5\",\"stock\":\"0\",\"precio\":\"25\",\"total\":\"90\"},{\"id\":\"10\",\"descripcion\":\"Apio\",\"cantidad\":\"4\",\"stock\":\"16\",\"precio\":\"31\",\"total\":\"96\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"5\",\"stock\":\"56\",\"precio\":\"37\",\"total\":\"135\"},{\"id\":\"25\",\"descripcion\":\"Calabacin\",\"cantidad\":\"1\",\"stock\":\"6\",\"precio\":\"32\",\"total\":\"17\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"12\",\"stock\":\"9\",\"precio\":\"30\",\"total\":\"192\"},{\"id\":\"105\",\"descripcion\":\"Cepa de apio\",\"cantidad\":\"11\",\"stock\":\"2\",\"precio\":\"40\",\"total\":\"242\"},{\"id\":\"27\",\"descripcion\":\"Cilantro Fino Paq\",\"cantidad\":\"5\",\"stock\":\"0\",\"precio\":\"25\",\"total\":\"100\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"1\",\"stock\":\"13\",\"precio\":\"45\",\"total\":\"32\"},{\"id\":\"18\",\"descripcion\":\"Espinaca\",\"cantidad\":\"4\",\"stock\":\"13\",\"precio\":\"18\",\"total\":\"72\"},{\"id\":\"32\",\"descripcion\":\"Frambuesa\",\"cantidad\":\"2\",\"stock\":\"5\",\"precio\":\"160\",\"total\":\"264\"},{\"id\":\"112\",\"descripcion\":\"Fresa Fresca Libra\",\"cantidad\":\"5\",\"stock\":\"0\",\"precio\":\"112\",\"total\":\"425\"},{\"id\":\"113\",\"descripcion\":\"Fresa Congelada\",\"cantidad\":\"15\",\"stock\":\"13\",\"precio\":\"110\",\"total\":\"1200\"},{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"4\",\"stock\":\"3\",\"precio\":\"30\",\"total\":\"96\"},{\"id\":\"103\",\"descripcion\":\"Hierba buena\",\"cantidad\":\"3\",\"stock\":\"0\",\"precio\":\"10\",\"total\":\"60\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"25\",\"total\":\"16\"},{\"id\":\"14\",\"descripcion\":\"Lechuga Morada\",\"cantidad\":\"2\",\"stock\":\"10\",\"precio\":\"20\",\"total\":\"24\"},{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"3\",\"stock\":\"62\",\"precio\":\"25\",\"total\":\"48\"},{\"id\":\"36\",\"descripcion\":\"Lechuga Rizada\",\"cantidad\":\"4\",\"stock\":\"0\",\"precio\":\"20\",\"total\":\"48\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"11\",\"stock\":\"30\",\"precio\":\"65\",\"total\":\"550\"},{\"id\":\"38\",\"descripcion\":\"Naranja Agria\",\"cantidad\":\"6\",\"stock\":\"19\",\"precio\":\"8\",\"total\":\"30\"},{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"25\",\"stock\":\"35\",\"precio\":\"25\",\"total\":\"350\"},{\"id\":\"12\",\"descripcion\":\"Papa Gourmet\",\"cantidad\":\"50\",\"stock\":\"86\",\"precio\":\"15\",\"total\":\"750\"},{\"id\":\"40\",\"descripcion\":\"Perejil Liso\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"52\",\"total\":\"37\"},{\"id\":\"42\",\"descripcion\":\"Puerro Grueso\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"27\",\"total\":\"40\"},{\"id\":\"16\",\"descripcion\":\"Rabano\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"26\",\"total\":\"70\"},{\"id\":\"17\",\"descripcion\":\"Remolacha\",\"cantidad\":\"4\",\"stock\":\"0\",\"precio\":\"26\",\"total\":\"80\"},{\"id\":\"19\",\"descripcion\":\"Repollo Verde\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"85\",\"total\":\"65\"},{\"id\":\"43\",\"descripcion\":\"Repollo Chino\",\"cantidad\":\"2\",\"stock\":\"1\",\"precio\":\"40\",\"total\":\"54\"},{\"id\":\"44\",\"descripcion\":\"Repollo Morado\",\"cantidad\":\"6\",\"stock\":\"12\",\"precio\":\"52\",\"total\":\"222\"},{\"id\":\"106\",\"descripcion\":\"Rucula Paq\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"30\",\"total\":\"56\"},{\"id\":\"47\",\"descripcion\":\"Tayota\",\"cantidad\":\"9\",\"stock\":\"8\",\"precio\":\"20\",\"total\":\"126\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"7\",\"stock\":\"108\",\"precio\":\"20\",\"total\":\"105\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"5\",\"stock\":\"57\",\"precio\":\"22\",\"total\":\"75\"},{\"id\":\"122\",\"descripcion\":\"Vainita paq\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"35\",\"total\":\"36\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"20\",\"stock\":\"77\",\"precio\":\"15\",\"total\":\"240\"},{\"id\":\"51\",\"descripcion\":\"Zucchini\",\"cantidad\":\"3\",\"stock\":\"7\",\"precio\":\"32\",\"total\":\"66\"}]', 0, 10175, 0, 10175, 'TD-98913746', 9434, 0, '2021-05-07 20:40:26'),
(190, 10189, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 30, 5, '2021-05-08 15:41:40'),
(191, 10190, 0, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"3\",\"stock\":\"3\",\"precio\":\"65\",\"total\":\"195\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"7\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 215, 0, 215, 'Efectivo', 215, 0, '2021-05-08 15:42:25'),
(192, 10191, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"55\",\"precio\":\"15\",\"total\":\"45\"}]', 0, 45, 0, 45, 'Efectivo', 50, 5, '2021-05-08 15:44:10'),
(193, 10192, 0, 4, '[{\"id\":\"80\",\"descripcion\":\"Flor de Manzanilla\",\"cantidad\":\"0.7\",\"stock\":\"0.30000000000000004\",\"precio\":\"500\",\"total\":\"350\"},{\"id\":\"37\",\"descripcion\":\"Maiz Dulce\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"100\",\"total\":\"100\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"53\",\"precio\":\"15\",\"total\":\"30\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"1.3\",\"stock\":\"28.7\",\"precio\":\"65\",\"total\":\"84.5\"},{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"62\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 574.5, 0, 574.5, 'Efectivo', 575, 0.5, '2021-05-08 16:53:02'),
(194, 10193, 12, 4, '[{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"308\",\"stock\":\"0\",\"precio\":\"17\",\"total\":\"5236\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"246\",\"precio\":\"9\",\"total\":\"27\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"1\",\"stock\":\"190\",\"precio\":\"25\",\"total\":\"17\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"16\",\"stock\":\"20\",\"precio\":\"630\",\"total\":\"630\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"4\",\"stock\":\"84\",\"precio\":\"280\",\"total\":\"280\"},{\"id\":\"67\",\"descripcion\":\"Ajonjolí\",\"cantidad\":\"2\",\"stock\":\"5\",\"precio\":\"300\",\"total\":\"300\"},{\"id\":\"23\",\"descripcion\":\"Albahaca \",\"cantidad\":\"6\",\"stock\":\"1\",\"precio\":\"72\",\"total\":\"72\"},{\"id\":\"68\",\"descripcion\":\"Anís Estrella\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"50\",\"total\":\"50\"},{\"id\":\"10\",\"descripcion\":\"Apio\",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"31\",\"total\":\"24\"},{\"id\":\"24\",\"descripcion\":\"Berenjena\",\"cantidad\":\"1\",\"stock\":\"-8\",\"precio\":\"18\",\"total\":\"18\"},{\"id\":\"69\",\"descripcion\":\"Bicarbonato de Sodio\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"48\",\"total\":\"48\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"1\",\"stock\":\"-1\",\"precio\":\"108\",\"total\":\"108\"},{\"id\":\"25\",\"descripcion\":\"Calabacin\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"32\",\"total\":\"22\"},{\"id\":\"71\",\"descripcion\":\"Canela entera\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"50\",\"total\":\"50\"},{\"id\":\"95\",\"descripcion\":\"Cardamomo\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"60\",\"total\":\"60\"},{\"id\":\"8\",\"descripcion\":\"Cebolla Amarilla\",\"cantidad\":\"3\",\"stock\":\"59\",\"precio\":\"78\",\"total\":\"78\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"37\",\"stock\":\"73\",\"precio\":\"740\",\"total\":\"740\"},{\"id\":\"27\",\"descripcion\":\"Cilantro Fino Paq\",\"cantidad\":\"5\",\"stock\":\"0\",\"precio\":\"25\",\"total\":\"135\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"3\",\"stock\":\"10\",\"precio\":\"30\",\"total\":\"81\"},{\"id\":\"29\",\"descripcion\":\"Curcuma\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"9\",\"total\":\"9\"},{\"id\":\"123\",\"descripcion\":\"Envio\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"100\",\"total\":\"200\"},{\"id\":\"78\",\"descripcion\":\"Enebro\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"49.5\",\"total\":\"49.5\"},{\"id\":\"18\",\"descripcion\":\"Espinaca\",\"cantidad\":\"3\",\"stock\":\"13\",\"precio\":\"18\",\"total\":\"42\"},{\"id\":\"32\",\"descripcion\":\"Frambuesa\",\"cantidad\":\"7\",\"stock\":\"7\",\"precio\":\"924\",\"total\":\"924\"},{\"id\":\"113\",\"descripcion\":\"Fresa Congelada\",\"cantidad\":\"10\",\"stock\":\"3\",\"precio\":\"110\",\"total\":\"70\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"3\",\"stock\":\"43\",\"precio\":\"240\",\"total\":\"240\"},{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"13\",\"stock\":\"13\",\"precio\":\"45\",\"total\":\"390\"},{\"id\":\"34\",\"descripcion\":\"Hierba Buena\",\"cantidad\":\"2\",\"stock\":\"14\",\"precio\":\"20\",\"total\":\"40\"},{\"id\":\"14\",\"descripcion\":\"Lechuga Morada\",\"cantidad\":\"2\",\"stock\":\"10\",\"precio\":\"20\",\"total\":\"34\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"8\",\"stock\":\"4\",\"precio\":\"25\",\"total\":\"136\"},{\"id\":\"36\",\"descripcion\":\"Lechuga Rizada\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"20\",\"total\":\"28\"},{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"3\",\"stock\":\"61\",\"precio\":\"25\",\"total\":\"51\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"5\",\"stock\":\"39\",\"precio\":\"65\",\"total\":\"250\"},{\"id\":\"37\",\"descripcion\":\"Maiz Dulce\",\"cantidad\":\"4\",\"stock\":\"1\",\"precio\":\"72\",\"total\":\"288\"},{\"id\":\"86\",\"descripcion\":\"Manzanilla\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"100\",\"total\":\"100\"},{\"id\":\"38\",\"descripcion\":\"Naranja Agria\",\"cantidad\":\"11\",\"stock\":\"8\",\"precio\":\"8\",\"total\":\"66\"},{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"16\",\"stock\":\"39\",\"precio\":\"20\",\"total\":\"288\"},{\"id\":\"12\",\"descripcion\":\"Papa Gourmet\",\"cantidad\":\"47\",\"stock\":\"39\",\"precio\":\"15\",\"total\":\"423\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"6\",\"stock\":\"14\",\"precio\":\"30\",\"total\":\"132\"},{\"id\":\"40\",\"descripcion\":\"Perejil Liso\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"52\",\"total\":\"44\"},{\"id\":\"119\",\"descripcion\":\"Perejil rizado lib\",\"cantidad\":\"1\",\"stock\":\"6\",\"precio\":\"40\",\"total\":\"40\"},{\"id\":\"42\",\"descripcion\":\"Puerro Grueso\",\"cantidad\":\"4\",\"stock\":\"0\",\"precio\":\"25\",\"total\":\"80\"},{\"id\":\"127\",\"descripcion\":\"Rabanito libra\",\"cantidad\":\"2\",\"stock\":\"2\",\"precio\":\"50\",\"total\":\"64\"},{\"id\":\"17\",\"descripcion\":\"Remolacha\",\"cantidad\":\"8\",\"stock\":\"1\",\"precio\":\"26\",\"total\":\"208\"},{\"id\":\"43\",\"descripcion\":\"Repollo Chino\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"40\",\"total\":\"54\"},{\"id\":\"44\",\"descripcion\":\"Repollo Morado\",\"cantidad\":\"6\",\"stock\":\"12\",\"precio\":\"38\",\"total\":\"222\"},{\"id\":\"19\",\"descripcion\":\"Repollo Verde\",\"cantidad\":\"2\",\"stock\":\"2\",\"precio\":\"85\",\"total\":\"130\"},{\"id\":\"120\",\"descripcion\":\"Romero Paq\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"20\",\"total\":\"20\"},{\"id\":\"92\",\"descripcion\":\"Sal de Ajo\",\"cantidad\":\"2\",\"stock\":\"4\",\"precio\":\"625\",\"total\":\"1250\"},{\"id\":\"47\",\"descripcion\":\"Tayota\",\"cantidad\":\"6\",\"stock\":\"10\",\"precio\":\"20\",\"total\":\"84\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"9\",\"stock\":\"99\",\"precio\":\"20\",\"total\":\"126\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"14\",\"stock\":\"43\",\"precio\":\"22\",\"total\":\"224\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"20\",\"stock\":\"57\",\"precio\":\"10\",\"total\":\"200\"},{\"id\":\"51\",\"descripcion\":\"Zucchini\",\"cantidad\":\"4\",\"stock\":\"7\",\"precio\":\"32\",\"total\":\"88\"},{\"id\":\"112\",\"descripcion\":\"Fresa Fresca Libra\",\"cantidad\":\"17\",\"stock\":\"0\",\"precio\":\"50\",\"total\":\"850\"}]', 0, 15420.5, 0, 14823.5, 'TC-0002', 14042, 0, '2021-05-15 22:18:29'),
(195, 10194, 14, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"5\",\"stock\":\"38\",\"precio\":\"22\",\"total\":\"110\"},{\"id\":\"27\",\"descripcion\":\"Cilantro Fino Paq\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"41\",\"descripcion\":\"Perejil Rizado\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 145, 0, 145, 'Credito', 145, 0, '2021-05-08 18:06:42'),
(196, 10195, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"6\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 25, 5, '2021-05-08 18:33:55'),
(197, 10196, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"46\",\"precio\":\"15\",\"total\":\"60\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"2\",\"stock\":\"59\",\"precio\":\"20\",\"total\":\"40\"}]', 0, 100, 0, 100, 'Efectivo', 100, 0, '2021-05-08 18:56:11'),
(198, 10197, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"2\",\"stock\":\"60\",\"precio\":\"10\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 50, 30, '2021-05-08 19:00:24'),
(199, 10198, 14, 4, '[{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"2\",\"stock\":\"2\",\"precio\":\"25\",\"total\":\"50\"}]', 0, 50, 0, 50, 'Credito', 50, 0, '2021-05-09 14:43:13'),
(200, 10199, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-05-09 16:34:25'),
(201, 10200, 5, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"116\",\"total\":\"116\"}]', 0, 116, 0, 116, 'Credito', 116, 0, '2021-05-09 16:38:01'),
(202, 10201, 10, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"116\",\"total\":\"116\"}]', 0, 116, 0, 116, 'Credito', 116, 0, '2021-05-09 17:13:15'),
(203, 10202, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-05-10 12:36:21'),
(204, 10203, 0, 4, '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1\",\"stock\":\"161\",\"precio\":\"60\",\"total\":\"60\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.6\",\"stock\":\"55.4\",\"precio\":\"100\",\"total\":\"60\"},{\"id\":\"66\",\"descripcion\":\"Ajo en Polvo\",\"cantidad\":\"0.1\",\"stock\":\"0.9\",\"precio\":\"500\",\"total\":\"50\"},{\"id\":\"92\",\"descripcion\":\"Sal de Ajo\",\"cantidad\":\"0.16\",\"stock\":\"0.84\",\"precio\":\"300\",\"total\":\"48\"}]', 0, 218, 0, 218, 'Efectivo', 300, 82, '2021-05-10 13:57:48'),
(205, 10204, 0, 4, '[{\"id\":\"68\",\"descripcion\":\"Anís Estrella\",\"cantidad\":\"0.062\",\"stock\":\"1.938\",\"precio\":\"800\",\"total\":\"49.6\"}]', 0, 49.6, 0, 49.6, 'Efectivo', 50, 0.4, '2021-05-10 14:12:50'),
(206, 10205, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"44\",\"precio\":\"15\",\"total\":\"30\"}]', 0, 30, 0, 30, 'Efectivo', 30, 0, '2021-05-10 15:35:48'),
(207, 10206, 0, 4, '[{\"id\":\"76\",\"descripcion\":\"Curcuma en Polvo\",\"cantidad\":\"0.12\",\"stock\":\"0.88\",\"precio\":\"400\",\"total\":\"48\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.3\",\"stock\":\"54.7\",\"precio\":\"100\",\"total\":\"30\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"5\",\"stock\":\"39\",\"precio\":\"15\",\"total\":\"75\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.8\",\"stock\":\"38.2\",\"precio\":\"65\",\"total\":\"52\"}]', 0, 205, 20.5, 184.5, 'Efectivo', 500, 315.5, '2021-05-10 15:56:26'),
(208, 10207, 5, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"116\",\"total\":\"116\"}]', 0, 116, 0, 116, 'Credito', 116, 0, '2021-05-10 19:19:20'),
(209, 10208, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"2\",\"stock\":\"3\",\"precio\":\"20\",\"total\":\"40\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"4\",\"stock\":\"15\",\"precio\":\"25\",\"total\":\"100\"}]', 0, 140, 0, 140, 'Efectivo', 150, 10, '2021-05-10 20:46:09'),
(210, 10209, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"59\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-10 21:37:51'),
(211, 10210, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"58\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-12 14:22:17'),
(212, 10211, 10, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"10\",\"stock\":\"1\",\"precio\":\"65\",\"total\":\"650\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"33\",\"stock\":\"161\",\"precio\":\"38\",\"total\":\"1254\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"14\",\"stock\":\"196\",\"precio\":\"15\",\"total\":\"210\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"20\",\"stock\":\"97\",\"precio\":\"13\",\"total\":\"260\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"21\",\"stock\":\"42\",\"precio\":\"14\",\"total\":\"294\"}]', 0, 2668, 0, 2668, 'Credito', 2668, 0, '2021-05-12 14:25:57'),
(213, 10212, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"35\",\"stock\":\"4\",\"precio\":\"15\",\"total\":\"525\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"5\",\"stock\":\"54\",\"precio\":\"12\",\"total\":\"60\"}]', 0, 585, 262.5, 322.5, 'Efectivo', 500, 177.5, '2021-05-12 15:56:28'),
(214, 10213, 16, 4, '[{\"id\":\"71\",\"descripcion\":\"Canela entera\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"360\",\"total\":\"720\"},{\"id\":\"90\",\"descripcion\":\"Pimienta Negra Molida\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"250\",\"total\":\"250\"},{\"id\":\"78\",\"descripcion\":\"Enebro\",\"cantidad\":\"0.5\",\"stock\":\"0.5\",\"precio\":\"450\",\"total\":\"225\"},{\"id\":\"68\",\"descripcion\":\"Anís Estrella\",\"cantidad\":\"0.5\",\"stock\":\"1.5\",\"precio\":\"490\",\"total\":\"245\"},{\"id\":\"91\",\"descripcion\":\"Rosa de Jamaica\",\"cantidad\":\"0.5\",\"stock\":\"1.5\",\"precio\":\"250\",\"total\":\"125\"}]', 0, 1565, 0, 1565, 'Credito', 1565, 0, '2021-05-12 18:22:29'),
(216, 10214, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 25, 5, '2021-05-12 19:45:45'),
(217, 10215, 0, 4, '[{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"7\",\"stock\":\"2\",\"precio\":\"37\",\"total\":\"259\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"9\",\"stock\":\"2\",\"precio\":\"25\",\"total\":\"225\"},{\"id\":\"10\",\"descripcion\":\"Apio\",\"cantidad\":\"7\",\"stock\":\"21\",\"precio\":\"31\",\"total\":\"217\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"6\",\"stock\":\"12\",\"precio\":\"45\",\"total\":\"270\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"3\",\"stock\":\"52\",\"precio\":\"100\",\"total\":\"300\"},{\"id\":\"8\",\"descripcion\":\"Cebolla Amarilla\",\"cantidad\":\"6\",\"stock\":\"71\",\"precio\":\"38\",\"total\":\"228\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"6\",\"stock\":\"288\",\"precio\":\"60\",\"total\":\"360\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"3\",\"stock\":\"193\",\"precio\":\"25\",\"total\":\"75\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"9\",\"stock\":\"41\",\"precio\":\"15\",\"total\":\"135\"},{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"15\",\"stock\":\"34\",\"precio\":\"25\",\"total\":\"375\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"6\",\"stock\":\"7\",\"precio\":\"30\",\"total\":\"180\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"5\",\"stock\":\"92\",\"precio\":\"20\",\"total\":\"100\"}]', 0, 2724, 354.12, 2369.88, 'TC', 2724, 0, '2021-05-12 20:14:56'),
(218, 10216, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"37\",\"precio\":\"15\",\"total\":\"30\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"1\",\"stock\":\"53\",\"precio\":\"12\",\"total\":\"12\"}]', 0, 42, 0, 42, 'Efectivo', 50, 8, '2021-05-12 21:03:59'),
(219, 10217, 0, 4, '[{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"2\",\"stock\":\"51\",\"precio\":\"12\",\"total\":\"24\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"37\",\"total\":\"37\"}]', 0, 61, 7.2, 53.8, 'Efectivo', 55, 1.2, '2021-05-13 13:28:42'),
(220, 10218, 0, 4, '[{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"0.6\",\"stock\":\"7.4\",\"precio\":\"30\",\"total\":\"18\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"1\",\"stock\":\"28\",\"precio\":\"15\",\"total\":\"15\"}]', 0, 33, 0, 33, 'Efectivo', 50, 17, '2021-05-13 14:12:46'),
(221, 10219, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"2\",\"stock\":\"56\",\"precio\":\"10\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 25, 5, '2021-05-13 14:37:54'),
(222, 10220, 0, 4, '[{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"3\",\"stock\":\"48\",\"precio\":\"12\",\"total\":\"36\"}]', 0, 36, 0, 36, 'Efectivo', 50, 14, '2021-05-13 15:24:57'),
(223, 10221, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-05-13 15:49:32'),
(224, 10222, 10, 4, '[{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"80\",\"stock\":\"112\",\"precio\":\"20\",\"total\":\"1120\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"50\",\"stock\":\"49\",\"precio\":\"22\",\"total\":\"700\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"68\",\"stock\":\"353\",\"precio\":\"60\",\"total\":\"2584\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"45\",\"stock\":\"148\",\"precio\":\"25\",\"total\":\"675\"},{\"id\":\"129\",\"descripcion\":\"Aji Morron 2da\",\"cantidad\":\"12\",\"stock\":\"11\",\"precio\":\"21\",\"total\":\"204\"},{\"id\":\"130\",\"descripcion\":\"Tomate ensalada 2da\",\"cantidad\":\"30\",\"stock\":\"0\",\"precio\":\"6\",\"total\":\"150\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"50\",\"stock\":\"1\",\"precio\":\"65\",\"total\":\"3250\"}]', 0, 8683, 0, 8683, 'TC-0001', 5498, 0, '2021-05-13 20:34:51'),
(226, 10224, 0, 4, '[{\"id\":\"91\",\"descripcion\":\"Rosa de Jamaica\",\"cantidad\":\"0.3\",\"stock\":\"2.7\",\"precio\":\"500\",\"total\":\"150\"}]', 0, 150, 0, 150, 'Efectivo', 150, 0, '2021-05-13 21:19:48'),
(227, 10225, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"34\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 25, 0, '2021-05-13 21:32:45'),
(228, 10226, 0, 4, '[{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"20\",\"stock\":\"72\",\"precio\":\"7\",\"total\":\"140\"}]', 0, 140, 0, 140, 'Efectivo', 150, 10, '2021-05-13 21:39:59'),
(229, 10227, 5, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"30\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Credito', 20, 0, '2021-05-14 13:19:57'),
(230, 10228, 14, 4, '[{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"1.83\",\"stock\":\"4.17\",\"precio\":\"25\",\"total\":\"45.75\"},{\"id\":\"33\",\"descripcion\":\"Jengibre\",\"cantidad\":\"0.59\",\"stock\":\"0.41000000000000003\",\"precio\":\"185\",\"total\":\"109.15\"},{\"id\":\"126\",\"descripcion\":\"Vainita esp paq\",\"cantidad\":\"2\",\"stock\":\"2\",\"precio\":\"35\",\"total\":\"70\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"3.9\",\"stock\":\"6.1\",\"precio\":\"60\",\"total\":\"234\"}]', 0, 458.9, 13.725, 445.175, 'Credito', 458.9, 0, '2021-05-14 13:57:32'),
(231, 10229, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"33\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 30, 5, '2021-05-14 14:00:06'),
(232, 10230, 5, 4, '[{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"2.1\",\"stock\":\"7.9\",\"precio\":\"25\",\"total\":\"52.5\"},{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"47\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 62.5, 0, 62.5, 'Credito', 62.5, 0, '2021-05-14 14:01:18'),
(233, 10231, 14, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"5\",\"stock\":\"24\",\"precio\":\"22\",\"total\":\"110\"}]', 0, 110, 0, 110, 'Credito', 110, 0, '2021-05-14 14:20:23'),
(234, 10232, 14, 4, '[{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"6\",\"stock\":\"17\",\"precio\":\"12\",\"total\":\"72\"}]', 0, 72, 0, 72, 'Credito', 72, 0, '2021-05-14 14:41:31'),
(235, 10233, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"29\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 100, 80, '2021-05-14 20:34:21'),
(236, 10234, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"46\",\"precio\":\"10\",\"total\":\"10\"},{\"id\":\"59\",\"descripcion\":\"Manzana Verde\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"50\",\"total\":\"100\"}]', 0, 110, 0, 110, 'Efectivo', 500, 390, '2021-05-14 20:49:00'),
(237, 10235, 7, 4, '[{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"60\",\"stock\":\"6\",\"precio\":\"26\",\"total\":\"1560\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"30\",\"stock\":\"7\",\"precio\":\"32\",\"total\":\"960\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"40\",\"stock\":\"21\",\"precio\":\"56\",\"total\":\"2240\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"30\",\"stock\":\"44\",\"precio\":\"19\",\"total\":\"570\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"30\",\"stock\":\"10\",\"precio\":\"12\",\"total\":\"360\"},{\"id\":\"104\",\"descripcion\":\"albahaca libra\",\"cantidad\":\"1\",\"stock\":\"6\",\"precio\":\"100\",\"total\":\"100\"},{\"id\":\"34\",\"descripcion\":\"Hierba Buena\",\"cantidad\":\"1\",\"stock\":\"15\",\"precio\":\"45\",\"total\":\"45\"},{\"id\":\"51\",\"descripcion\":\"Zucchini\",\"cantidad\":\"20\",\"stock\":\"6\",\"precio\":\"22\",\"total\":\"440\"}]', 0, 6275, 0, 6275, 'Credito', 6275, 0, '2021-05-14 21:03:47'),
(238, 10236, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"32\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"45\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 35, 0, 35, 'Efectivo', 50, 15, '2021-05-14 21:07:20'),
(239, 10237, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"4\",\"stock\":\"25\",\"precio\":\"20\",\"total\":\"80\"}]', 0, 80, 0, 80, 'Efectivo', 100, 20, '2021-05-14 21:24:36'),
(240, 10238, 10, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"45\",\"precio\":\"95\",\"total\":\"95\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-05-14 21:37:58'),
(241, 10239, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"24\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 50, 30, '2021-05-15 14:07:10'),
(242, 10240, 0, 4, '[{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"4\",\"stock\":\"13\",\"precio\":\"12\",\"total\":\"48\"}]', 0, 48, 0, 48, 'Efectivo', 50, 2, '2021-05-15 14:43:21'),
(243, 10241, 14, 4, '[{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"4\",\"stock\":\"3\",\"precio\":\"25\",\"total\":\"100\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"6\",\"stock\":\"7\",\"precio\":\"12\",\"total\":\"72\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"12\",\"stock\":\"32\",\"precio\":\"22\",\"total\":\"264\"},{\"id\":\"44\",\"descripcion\":\"Repollo Morado\",\"cantidad\":\"2\",\"stock\":\"2\",\"precio\":\"38\",\"total\":\"76\"}]', 0, 512, 0, 512, 'Credito', 512, 0, '2021-05-15 14:56:15'),
(244, 10242, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"44\",\"precio\":\"10\",\"total\":\"10\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.2\",\"stock\":\"14.8\",\"precio\":\"65\",\"total\":\"13\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"23\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 43, 0, 43, 'Efectivo', 50, 7, '2021-05-15 15:38:23'),
(245, 10243, 0, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.5\",\"stock\":\"14.5\",\"precio\":\"65\",\"total\":\"32.5\"},{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"2\",\"stock\":\"5\",\"precio\":\"12\",\"total\":\"24\"}]', 0, 56.5, 0, 56.5, 'Efectivo', 100, 43.5, '2021-05-15 15:42:35'),
(246, 10244, 11, 4, '[{\"id\":\"92\",\"descripcion\":\"Sal de Ajo\",\"cantidad\":\"0.3\",\"stock\":\"1.7\",\"precio\":\"500\",\"total\":\"150\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"249\",\"precio\":\"15\",\"total\":\"60\"}]', 0, 210, 0, 210, 'Credito', 210, 0, '2021-05-15 15:46:56'),
(247, 10245, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"43\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-15 15:51:05'),
(248, 10246, 0, 4, '[{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"2.7\",\"stock\":\"4.3\",\"precio\":\"32\",\"total\":\"86.4\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"2.9\",\"stock\":\"3.1\",\"precio\":\"26\",\"total\":\"75.4\"},{\"id\":\"19\",\"descripcion\":\"Repollo Verde\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"85\",\"total\":\"85\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"2.9\",\"stock\":\"18.1\",\"precio\":\"60\",\"total\":\"174\"},{\"id\":\"10\",\"descripcion\":\"Apio\",\"cantidad\":\"2.8\",\"stock\":\"3.2\",\"precio\":\"30\",\"total\":\"84\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"3.5\",\"stock\":\"28.5\",\"precio\":\"22\",\"total\":\"77\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"1.5\",\"stock\":\"86.5\",\"precio\":\"100\",\"total\":\"150\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"2.9\",\"stock\":\"2.1\",\"precio\":\"28\",\"total\":\"81.2\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"2\",\"stock\":\"43\",\"precio\":\"116\",\"total\":\"232\"},{\"id\":\"31\",\"descripcion\":\"Fresa Fresca\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"150\",\"total\":\"150\"}]', 0, 1195, 0, 1195, 'Efectivo', 1, 5, '2021-05-15 16:48:20'),
(249, 10247, 5, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"22\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Credito', 20, 0, '2021-05-15 17:10:33'),
(250, 10248, 17, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.6\",\"stock\":\"14.4\",\"precio\":\"65\",\"total\":\"39\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"0.38\",\"stock\":\"17.62\",\"precio\":\"60\",\"total\":\"22.8\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"0.16\",\"stock\":\"4.84\",\"precio\":\"25\",\"total\":\"4\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"0.22\",\"stock\":\"72.78\",\"precio\":\"30\",\"total\":\"6.6\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"0.8\",\"stock\":\"15.2\",\"precio\":\"20\",\"total\":\"16\"}]', 0, 88.4, 0, 88.4, 'Credito', 88.4, 0, '2021-05-15 19:51:54'),
(251, 10249, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"246\",\"precio\":\"15\",\"total\":\"45\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"42\",\"precio\":\"116\",\"total\":\"116\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"1.6\",\"stock\":\"13.4\",\"precio\":\"20\",\"total\":\"32\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.9\",\"stock\":\"13.1\",\"precio\":\"65\",\"total\":\"58.5\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"1.5\",\"stock\":\"71.5\",\"precio\":\"30\",\"total\":\"45\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.9\",\"stock\":\"27.1\",\"precio\":\"22\",\"total\":\"41.8\"}]', 0, 338.3, 0, 338.3, 'Efectivo', 500, 161.7, '2021-05-15 20:59:35'),
(252, 10250, 0, 4, '[{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.3\",\"stock\":\"86.7\",\"precio\":\"100\",\"total\":\"30\"}]', 0, 30, 0, 30, 'Efectivo', 30, 0, '2021-05-15 21:00:11'),
(253, 10251, 14, 4, '[{\"id\":\"56\",\"descripcion\":\"Aguacate\",\"cantidad\":\"5\",\"stock\":\"0\",\"precio\":\"12\",\"total\":\"60\"}]', 0, 60, 0, 60, 'Credito', 60, 0, '2021-05-15 21:10:11');
INSERT INTO `ventas` (`id`, `codigo`, `id_cliente`, `id_vendedor`, `productos`, `impuesto`, `neto`, `descuento`, `total`, `metodo_pago`, `pago_con`, `devuelta`, `fecha`) VALUES
(254, 10252, 12, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"203\",\"stock\":\"43\",\"precio\":\"9\",\"total\":\"1827\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"40\",\"total\":\"40\"},{\"id\":\"24\",\"descripcion\":\"Berenjena\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"12\",\"total\":\"12\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"27\",\"total\":\"54\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"3\",\"stock\":\"70\",\"precio\":\"22\",\"total\":\"66\"},{\"id\":\"105\",\"descripcion\":\"Cepa de apio\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"25\",\"total\":\"50\"},{\"id\":\"136\",\"descripcion\":\"Chinola\",\"cantidad\":\"10\",\"stock\":\"40\",\"precio\":\"8\",\"total\":\"80\"},{\"id\":\"27\",\"descripcion\":\"Cilantro Fino Paq\",\"cantidad\":\"1\",\"stock\":\"-1\",\"precio\":\"20\",\"total\":\"20\"},{\"id\":\"31\",\"descripcion\":\"Fresa Fresca Grd\",\"cantidad\":\"2\",\"stock\":\"4\",\"precio\":\"120\",\"total\":\"240\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"2\",\"stock\":\"41\",\"precio\":\"80\",\"total\":\"160\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"3\",\"stock\":\"1\",\"precio\":\"17\",\"total\":\"51\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"3\",\"stock\":\"36\",\"precio\":\"50\",\"total\":\"150\"},{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"5\",\"stock\":\"34\",\"precio\":\"14\",\"total\":\"70\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"1\",\"stock\":\"13\",\"precio\":\"22\",\"total\":\"22\"},{\"id\":\"50\",\"descripcion\":\"Vainitas Española\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"32\",\"total\":\"32\"},{\"id\":\"115\",\"descripcion\":\"Yautia Blanca\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"52\",\"total\":\"104\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"4\",\"stock\":\"53\",\"precio\":\"10\",\"total\":\"40\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"7\",\"stock\":\"92\",\"precio\":\"16\",\"total\":\"112\"},{\"id\":\"47\",\"descripcion\":\"Tayota\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"14\",\"total\":\"28\"}]', 0, 3158, 0, 3158, 'Credito', 3158, 0, '2021-05-15 22:45:42'),
(255, 10253, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"31\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"21\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 45, 0, 45, 'Efectivo', 50, 5, '2021-05-16 13:24:09'),
(256, 10254, 7, 4, '[{\"id\":\"8\",\"descripcion\":\"Cebolla Amarilla\",\"cantidad\":\"16\",\"stock\":\"43\",\"precio\":\"32\",\"total\":\"512\"}]', 0, 512, 0, 512, 'Credito', 512, 0, '2021-05-16 14:11:48'),
(257, 10255, 0, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"3\",\"stock\":\"38\",\"precio\":\"116\",\"total\":\"348\"}]', 0, 348, 0, 348, 'Efectivo', 1, 652, '2021-05-16 14:53:01'),
(258, 10256, 5, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"37\",\"precio\":\"116\",\"total\":\"116\"}]', 0, 116, 0, 116, 'Credito', 116, 0, '2021-05-16 14:59:53'),
(259, 10257, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"6\",\"stock\":\"62\",\"precio\":\"15\",\"total\":\"90\"}]', 0, 90, 0, 90, 'Efectivo', 100, 10, '2021-05-16 15:27:35'),
(260, 10258, 0, 4, '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1.9\",\"stock\":\"17.1\",\"precio\":\"60\",\"total\":\"114\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"2.3\",\"stock\":\"40.7\",\"precio\":\"22\",\"total\":\"50.6\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"59\",\"precio\":\"15\",\"total\":\"45\"}]', 0, 209.6, 0, 209.6, 'TC', 209.6, 0, '2021-05-16 15:34:42'),
(261, 10259, 0, 4, '[{\"id\":\"51\",\"descripcion\":\"Zucchini\",\"cantidad\":\"2.7\",\"stock\":\"4.3\",\"precio\":\"32\",\"total\":\"86.4\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"2.9\",\"stock\":\"38.1\",\"precio\":\"22\",\"total\":\"63.8\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"3.1\",\"stock\":\"66.9\",\"precio\":\"30\",\"total\":\"93\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"4.1\",\"stock\":\"12.9\",\"precio\":\"60\",\"total\":\"246\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"1.8\",\"stock\":\"101.2\",\"precio\":\"20\",\"total\":\"36\"}]', 0, 525.2, 0, 525.2, 'TC', 525.2, 0, '2021-05-16 15:39:01'),
(263, 10260, 0, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"2\",\"stock\":\"35\",\"precio\":\"116\",\"total\":\"232\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"56\",\"precio\":\"15\",\"total\":\"45\"}]', 0, 277, 34.8, 242.2, 'Efectivo', 500, 257.8, '2021-05-16 18:03:04'),
(264, 10261, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.8\",\"stock\":\"36.2\",\"precio\":\"22\",\"total\":\"39.6\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1.8\",\"stock\":\"11.2\",\"precio\":\"60\",\"total\":\"108\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"2\",\"stock\":\"11\",\"precio\":\"30\",\"total\":\"60\"},{\"id\":\"8\",\"descripcion\":\"Cebolla Amarilla\",\"cantidad\":\"0.9\",\"stock\":\"42.1\",\"precio\":\"35\",\"total\":\"31.5\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"0.8\",\"stock\":\"66.2\",\"precio\":\"30\",\"total\":\"24\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"1.5\",\"stock\":\"56.5\",\"precio\":\"10\",\"total\":\"15\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.5\",\"stock\":\"83.5\",\"precio\":\"100\",\"total\":\"50\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"30\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"79\",\"descripcion\":\"Flor de Tilo\",\"cantidad\":\"0.55\",\"stock\":\"0.44999999999999996\",\"precio\":\"1000\",\"total\":\"550\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"2\",\"stock\":\"33\",\"precio\":\"116\",\"total\":\"232\"}]', 0, 1135.1, 0, 1135.1, 'Efectivo', 2, 1, '2021-05-16 21:02:57'),
(265, 10262, 0, 4, '[]', 0, 20, 0, 20, 'Efectivo', 50, 30, '2021-05-17 12:29:29'),
(266, 10263, 10, 4, '[]', 0, 270.1, 0, 270.1, 'Credito', 270.1, 0, '2021-05-17 15:41:25'),
(267, 10264, 0, 4, '[]', 0, 400, 0, 400, 'Efectivo', 400, 0, '2021-05-17 16:00:14'),
(268, 10265, 0, 4, '[]', 0, 30, 0, 30, 'Efectivo', 30, 0, '2021-05-17 16:02:10'),
(274, 10267, 0, 4, '[{\"id\":\"58\",\"descripcion\":\"Cerveza Modelo\",\"cantidad\":\"1\",\"stock\":\"11\",\"precio\":\"70\",\"total\":\"70\"}]', 0, 70, 0, 70, 'Efectivo', 100, 30, '2021-05-17 20:27:44'),
(275, 10268, 5, 4, '[{\"id\":\"58\",\"descripcion\":\"Cerveza Modelo\",\"cantidad\":\"1\",\"stock\":\"10\",\"precio\":\"70\",\"total\":\"70\"}]', 0, 70, 0, 70, 'Credito', 70, 0, '2021-05-17 20:28:50'),
(276, 10269, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"20\",\"precio\":\"20\",\"total\":\"20\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"29\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 45, 0, 45, 'Efectivo', 100, 55, '2021-05-17 21:41:40'),
(277, 10270, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"10\",\"stock\":\"26\",\"precio\":\"22\",\"total\":\"220\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"62\",\"precio\":\"15\",\"total\":\"45\"}]', 0, 265, 79.5, 185.5, 'Efectivo', 190, 4.5, '2021-05-19 12:30:45'),
(279, 10272, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-05-19 13:36:21'),
(280, 10273, 8, 4, '[{\"id\":\"93\",\"descripcion\":\"sazonador de Carne\",\"cantidad\":\"0.17\",\"stock\":\"1.83\",\"precio\":\"900\",\"total\":\"153\"}]', 0, 153, 0, 153, 'Credito', 153, 0, '2021-05-19 15:12:14'),
(281, 10274, 8, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"1.8\",\"stock\":\"34.2\",\"precio\":\"65\",\"total\":\"117\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"6.7\",\"stock\":\"45.3\",\"precio\":\"22\",\"total\":\"147.4\"},{\"id\":\"122\",\"descripcion\":\"Vainita Esp paq\",\"cantidad\":\"2\",\"stock\":\"1\",\"precio\":\"35\",\"total\":\"70\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"1.7\",\"stock\":\"3.3\",\"precio\":\"25\",\"total\":\"42.5\"}]', 0, 376.9, 113.07, 263.83, 'Credito', 376.9, 0, '2021-05-19 15:29:08'),
(282, 10275, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"27\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 50, 25, '2021-05-19 16:02:48'),
(283, 10276, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"5\",\"stock\":\"85\",\"precio\":\"15\",\"total\":\"75\"}]', 0, 75, 22.5, 52.5, 'Efectivo', 55, 2.5, '2021-05-19 18:14:36'),
(285, 10278, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"2\",\"stock\":\"22\",\"precio\":\"65\",\"total\":\"130\"}]', 0, 130, 0, 130, 'Credito', 130, 0, '2021-05-19 19:24:45'),
(286, 10279, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"30\",\"stock\":\"55\",\"precio\":\"8\",\"total\":\"240\"}]', 0, 240, 0, 240, 'Efectivo', 300, 60, '2021-05-20 14:40:32'),
(287, 10280, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"9\",\"stock\":\"46\",\"precio\":\"15\",\"total\":\"135\"}]', 0, 135, 40.5, 94.5, 'Efectivo', 100, 5.5, '2021-05-20 15:24:39'),
(288, 10281, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"10\",\"stock\":\"36\",\"precio\":\"15\",\"total\":\"150\"}]', 0, 150, 0, 105, 'Efectivo', 205, 100, '2021-05-20 20:49:14'),
(289, 10282, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"5\",\"stock\":\"40\",\"precio\":\"22\",\"total\":\"110\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"3.8\",\"stock\":\"11.2\",\"precio\":\"30\",\"total\":\"114\"}]', 0, 224, 0, 191, 'Efectivo', 200, 9, '2021-05-20 21:00:33'),
(290, 10283, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"26\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 50, 25, '2021-05-21 12:18:18'),
(291, 10284, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.2\",\"stock\":\"55.8\",\"precio\":\"22\",\"total\":\"26.4\"}]', 0, 26.4, 0, 26.4, 'Efectivo', 30, 3.6, '2021-05-21 15:18:02'),
(292, 10285, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"2\",\"stock\":\"17\",\"precio\":\"20\",\"total\":\"40\"}]', 0, 40, 0, 40, 'Efectivo', 100, 60, '2021-05-21 15:33:31'),
(293, 10286, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 100, 80, '2021-05-21 20:10:31'),
(294, 10287, 0, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.6\",\"stock\":\"66.4\",\"precio\":\"50\",\"total\":\"30\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1\",\"stock\":\"55\",\"precio\":\"22\",\"total\":\"22\"}]', 0, 52, 0, 52, 'Efectivo', 52, 0, '2021-05-22 15:43:56'),
(295, 10288, 0, 4, '[{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"2.2\",\"stock\":\"47.8\",\"precio\":\"45\",\"total\":\"99\"}]', 0, 99, 0, 99, 'Efectivo', 200, 101, '2021-05-22 18:03:08'),
(296, 10289, 0, 4, '[{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"1.9\",\"stock\":\"25.1\",\"precio\":\"45\",\"total\":\"85.5\"}]', 0, 85.5, 0, 85.5, 'Efectivo', 86, 0.5, '2021-05-22 18:54:02'),
(297, 10290, 0, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"2\",\"stock\":\"30\",\"precio\":\"50\",\"total\":\"100\"},{\"id\":\"17\",\"descripcion\":\"Remolacha\",\"cantidad\":\"2.7\",\"stock\":\"1.2999999999999998\",\"precio\":\"26\",\"total\":\"70.2\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"198\",\"precio\":\"15\",\"total\":\"30\"},{\"id\":\"58\",\"descripcion\":\"Cerveza Modelo\",\"cantidad\":\"1\",\"stock\":\"9\",\"precio\":\"70\",\"total\":\"70\"}]', 0, 270.2, 0, 270.2, 'Efectivo', 275, 4.8, '2021-05-22 19:22:32'),
(298, 10291, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"40\",\"stock\":\"158\",\"precio\":\"8\",\"total\":\"320\"}]', 0, 320, 0, 320, 'Efectivo', 320, 0, '2021-05-23 15:14:31'),
(299, 10292, 0, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"31\",\"precio\":\"116\",\"total\":\"116\"}]', 0, 116, 0, 116, 'Efectivo', 150, 34, '2021-05-23 15:15:36'),
(300, 10293, 14, 4, '[{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"0.8\",\"stock\":\"6.2\",\"precio\":\"25\",\"total\":\"20\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"0.7\",\"stock\":\"13.3\",\"precio\":\"30\",\"total\":\"21\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1\",\"stock\":\"29\",\"precio\":\"22\",\"total\":\"22\"},{\"id\":\"27\",\"descripcion\":\"Cilantro Fino Paq\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 83, 0, 83, 'Credito', 83, 0, '2021-05-23 15:20:26'),
(301, 10294, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"42\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-23 16:02:15'),
(302, 10295, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"21\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-05-23 16:04:27'),
(303, 10296, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"10\",\"stock\":\"148\",\"precio\":\"15\",\"total\":\"150\"}]', 0, 150, 0, 150, 'Efectivo', 150, 0, '2021-05-23 16:13:12'),
(304, 10297, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"20\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-05-23 17:57:44'),
(305, 10298, 0, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"6.32\",\"stock\":\"23.68\",\"precio\":\"50\",\"total\":\"316\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"2.25\",\"stock\":\"19.75\",\"precio\":\"45\",\"total\":\"101.25\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.71\",\"stock\":\"9.29\",\"precio\":\"100\",\"total\":\"71\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"5.5\",\"stock\":\"2.5\",\"precio\":\"10\",\"total\":\"55\"},{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"3\",\"stock\":\"45\",\"precio\":\"85\",\"total\":\"255\"},{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"1.87\",\"stock\":\"23.13\",\"precio\":\"45\",\"total\":\"84.15\"},{\"id\":\"121\",\"descripcion\":\"Pepino paq\",\"cantidad\":\"3\",\"stock\":\"18\",\"precio\":\"10\",\"total\":\"30\"}]', 0, 912.4, 0, 912.4, 'Efectivo', 1, 87.6, '2021-05-24 12:15:51'),
(306, 10299, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"15\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-05-24 12:45:08'),
(307, 10300, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"25\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 50, 25, '2021-05-24 13:05:58'),
(308, 10301, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"41\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-24 14:09:55'),
(309, 10302, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"10\",\"stock\":\"138\",\"precio\":\"15\",\"total\":\"150\"}]', 0, 150, 0, 150, 'Efectivo', 200, 50, '2021-05-24 14:30:39'),
(310, 10303, 0, 4, '[{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"5.5\",\"stock\":\"1.5\",\"precio\":\"20\",\"total\":\"110\"},{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"1\",\"stock\":\"44\",\"precio\":\"85\",\"total\":\"85\"}]', 0, 195, 0, 195, 'Efectivo', 200, 5, '2021-05-24 21:23:23'),
(311, 10304, 18, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"2.56\",\"stock\":\"21.44\",\"precio\":\"50\",\"total\":\"128\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"10\",\"stock\":\"128\",\"precio\":\"15\",\"total\":\"150\"},{\"id\":\"25\",\"descripcion\":\"Calabacin\",\"cantidad\":\"3.1\",\"stock\":\"7.9\",\"precio\":\"35\",\"total\":\"108.5\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"1\",\"stock\":\"64\",\"precio\":\"30\",\"total\":\"30\"},{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"2\",\"stock\":\"42\",\"precio\":\"85\",\"total\":\"170\"},{\"id\":\"109\",\"descripcion\":\"Semilla de cilantro\",\"cantidad\":\"0.45\",\"stock\":\"0.55\",\"precio\":\"200\",\"total\":\"90\"}]', 0, 676.5, 0, 676.5, 'Credito', 676.5, 0, '2021-05-24 21:27:01'),
(312, 10305, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-05-24 21:27:30'),
(313, 10306, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"2.01\",\"stock\":\"26.990000000000002\",\"precio\":\"22\",\"total\":\"44.22\"}]', 0, 44.22, 0, 44.22, 'Efectivo', 50, 5.78, '2021-05-24 21:28:50'),
(314, 10307, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"3.2\",\"stock\":\"23.8\",\"precio\":\"22\",\"total\":\"70.4\"},{\"id\":\"121\",\"descripcion\":\"Pepino paq\",\"cantidad\":\"5\",\"stock\":\"13\",\"precio\":\"10\",\"total\":\"50\"},{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"1\",\"stock\":\"41\",\"precio\":\"85\",\"total\":\"85\"}]', 0, 205.4, 0, 205.4, 'Efectivo', 210, 4.6, '2021-05-24 21:30:32'),
(315, 10308, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"3\",\"stock\":\"22\",\"precio\":\"25\",\"total\":\"75\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"14\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 95, 0, 95, 'Efectivo', 100, 5, '2021-05-24 21:31:21'),
(316, 10309, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"2\",\"stock\":\"39\",\"precio\":\"10\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-05-26 12:22:14'),
(317, 10310, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"2\",\"stock\":\"12\",\"precio\":\"20\",\"total\":\"40\"}]', 0, 40, 0, 40, 'Efectivo', 50, 10, '2021-05-26 12:57:39'),
(318, 10311, 0, 4, '[{\"id\":\"141\",\"descripcion\":\"Granola sobre\",\"cantidad\":\"1\",\"stock\":\"11\",\"precio\":\"75\",\"total\":\"75\"}]', 0, 75, 0, 75, 'Efectivo', 100, 25, '2021-05-26 14:58:21'),
(319, 10312, 5, 4, '[{\"id\":\"141\",\"descripcion\":\"Granola sobre\",\"cantidad\":\"1\",\"stock\":\"10\",\"precio\":\"75\",\"total\":\"75\"}]', 0, 75, 0, 75, 'Credito', 75, 0, '2021-05-26 14:59:11'),
(320, 10313, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"1\",\"stock\":\"127\",\"precio\":\"15\",\"total\":\"15\"}]', 0, 15, 0, 15, 'Efectivo', 25, 10, '2021-05-26 15:32:25'),
(321, 10314, 0, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.7\",\"stock\":\"20.3\",\"precio\":\"50\",\"total\":\"35\"}]', 0, 35, 0, 35, 'Efectivo', 35, 0, '2021-05-26 15:34:11'),
(322, 10315, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-05-26 18:28:55'),
(323, 10316, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"11\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 100, 80, '2021-05-26 19:00:32'),
(324, 10317, 10, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"2\",\"stock\":\"26\",\"precio\":\"75\",\"total\":\"150\"}]', 0, 150, 0, 150, 'Credito', 150, 0, '2021-05-26 19:02:44'),
(325, 10318, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"38\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 50, 40, '2021-05-26 19:15:11'),
(326, 10319, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-05-26 20:05:03'),
(327, 10320, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"10\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-05-26 21:24:32'),
(328, 10321, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"9\",\"precio\":\"20\",\"total\":\"20\"},{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"3\",\"stock\":\"35\",\"precio\":\"10\",\"total\":\"30\"}]', 0, 50, 0, 50, 'Efectivo', 50, 0, '2021-05-27 20:31:48'),
(329, 10322, 10, 4, '[{\"id\":\"58\",\"descripcion\":\"Cerveza Modelo\",\"cantidad\":\"3\",\"stock\":\"6\",\"precio\":\"70\",\"total\":\"210\"},{\"id\":\"141\",\"descripcion\":\"Granola sobre\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"75\",\"total\":\"75\"}]', 0, 285, 0, 285, 'Efectivo', 500, 215, '2021-05-27 20:33:34'),
(330, 10323, 0, 4, '[{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"1.13\",\"stock\":\"7.87\",\"precio\":\"100\",\"total\":\"113\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"9.5\",\"stock\":\"5.5\",\"precio\":\"15\",\"total\":\"142.5\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"2.6\",\"stock\":\"61.4\",\"precio\":\"30\",\"total\":\"78\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"6.9\",\"stock\":\"69.1\",\"precio\":\"22\",\"total\":\"151.8\"},{\"id\":\"19\",\"descripcion\":\"Repollo Verde\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"85\",\"total\":\"85\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"2.8\",\"stock\":\"2.2\",\"precio\":\"25\",\"total\":\"70\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"4\",\"stock\":\"99\",\"precio\":\"45\",\"total\":\"180\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"4\",\"stock\":\"22\",\"precio\":\"116\",\"total\":\"464\"}]', 0, 1284.3, 118.156, 1166.14, 'Efectivo', 2, 833.86, '2021-05-27 21:29:13'),
(332, 10325, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"123\",\"precio\":\"15\",\"total\":\"60\"}]', 0, 60, 0, 60, 'Efectivo', 100, 40, '2021-05-28 12:59:31'),
(333, 10326, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-05-28 13:36:26'),
(334, 10327, 10, 4, '[{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"3\",\"stock\":\"38\",\"precio\":\"65\",\"total\":\"195\"}]', 0, 195, 0, 195, 'Efectivo', 200, 5, '2021-05-28 14:46:18'),
(335, 10328, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"15\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-05-28 19:59:11'),
(336, 10329, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"3\",\"stock\":\"61\",\"precio\":\"22\",\"total\":\"66\"}]', 0, 66, 0, 66, 'Efectivo', 100, 34, '2021-05-29 13:03:30'),
(337, 10330, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"34\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-29 13:55:27'),
(338, 10331, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"121\",\"precio\":\"15\",\"total\":\"30\"}]', 0, 25, 0, 25, 'Efectivo', 25, 0, '2021-05-29 15:51:50'),
(339, 10332, 4, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"113\",\"precio\":\"9\",\"total\":\"36\"},{\"id\":\"27\",\"descripcion\":\"Cilantro Fino Paq\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"45\",\"total\":\"45\"},{\"id\":\"103\",\"descripcion\":\"Hierba buena paq\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 105, 0, 105, 'Credito', 105, 0, '2021-05-29 15:54:38'),
(340, 10333, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"2\",\"stock\":\"32\",\"precio\":\"10\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 100, 80, '2021-05-29 18:29:30'),
(341, 10334, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"2\",\"stock\":\"7\",\"precio\":\"20\",\"total\":\"40\"}]', 0, 40, 0, 40, 'Efectivo', 100, 60, '2021-05-29 18:30:17'),
(342, 10335, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"6\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 25, 5, '2021-05-29 18:32:57'),
(343, 10336, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-05-29 18:34:26'),
(344, 10337, 0, 4, '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"2.2\",\"stock\":\"93.8\",\"precio\":\"45\",\"total\":\"99\"}]', 0, 99, 0, 99, 'Efectivo', 100, 1, '2021-05-29 18:42:00'),
(345, 10338, 0, 4, '[{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"5\",\"stock\":\"33\",\"precio\":\"85\",\"total\":\"425\"}]', 0, 425, 0, 425, 'Efectivo', 425, 0, '2021-05-29 19:11:47'),
(346, 10339, 14, 4, '[{\"id\":\"92\",\"descripcion\":\"Sal de Ajo\",\"cantidad\":\"0.5\",\"stock\":\"3.5\",\"precio\":\"300\",\"total\":\"150\"},{\"id\":\"143\",\"descripcion\":\"Comino en Polvo\",\"cantidad\":\"0.12\",\"stock\":\"0.88\",\"precio\":\"400\",\"total\":\"48\"}]', 0, 198, 0, 198, 'Credito', 198, 0, '2021-05-29 20:22:01'),
(347, 10340, 5, 4, '[{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"2.8\",\"stock\":\"4.2\",\"precio\":\"25\",\"total\":\"70\"}]', 0, 70, 0, 70, 'Credito', 70, 0, '2021-05-29 20:24:01'),
(348, 10341, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"14\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 65, 0, '2021-05-29 20:47:10'),
(349, 10342, 19, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"2\",\"stock\":\"12\",\"precio\":\"65\",\"total\":\"130\"},{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"31\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 140, 0, 140, 'Credito', 140, 0, '2021-05-30 13:49:53'),
(350, 10343, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"2\",\"stock\":\"3\",\"precio\":\"20\",\"total\":\"40\"}]', 0, 40, 0, 40, 'Efectivo', 50, 10, '2021-05-30 13:51:43'),
(351, 10344, 0, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"4\",\"stock\":\"18\",\"precio\":\"116\",\"total\":\"464\"}]', 0, 464, 0, 464, 'Efectivo', 500, 36, '2021-05-30 15:51:17'),
(352, 10345, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"21\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 25, 0, '2021-05-31 12:50:44'),
(353, 10346, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"8\",\"precio\":\"20\",\"total\":\"20\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"20\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 45, 0, 45, 'Efectivo', 100, 55, '2021-05-31 12:58:20'),
(354, 10347, 5, 4, '[{\"id\":\"141\",\"descripcion\":\"Granola sobre\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"75\",\"total\":\"75\"}]', 0, 75, 0, 75, 'Credito', 75, 0, '2021-05-31 14:49:31'),
(355, 10348, 0, 4, '[{\"id\":\"86\",\"descripcion\":\"Manzanilla\",\"cantidad\":\"0.095\",\"stock\":\"0.905\",\"precio\":\"250\",\"total\":\"23.75\"}]', 0, 23.75, 0, 23.75, 'Efectivo', 25, 1.25, '2021-05-31 14:59:31'),
(356, 10349, 0, 4, '[{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"6\",\"stock\":\"27\",\"precio\":\"56\",\"total\":\"336\"}]', 0, 336, 0, 336, 'Efectivo', 340, 4, '2021-05-31 15:06:02'),
(357, 10350, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"40\",\"stock\":\"103\",\"precio\":\"8\",\"total\":\"320\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"4\",\"stock\":\"4\",\"precio\":\"17\",\"total\":\"68\"}]', 0, 388, 0, 388, 'Efectivo', 400, 12, '2021-05-31 15:23:12'),
(358, 10351, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"30\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-31 18:22:46'),
(359, 10351, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"30\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-05-31 18:25:13'),
(360, 10352, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"5\",\"stock\":\"96\",\"precio\":\"15\",\"total\":\"75\"},{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"0.48\",\"stock\":\"21.52\",\"precio\":\"45\",\"total\":\"21.6\"}]', 0, 96.6, 0, 96.6, 'Efectivo', 100, 3.4, '2021-05-31 21:37:27'),
(361, 10353, 20, 4, '[{\"id\":\"157\",\"descripcion\":\"Albahaca Roja\",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"100\",\"total\":\"200\"},{\"id\":\"153\",\"descripcion\":\"Perejil Liso S\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"85\",\"total\":\"85\"}]', 0, 300, 0, 300, 'Credito', 300, 0, '2021-06-01 13:22:49'),
(362, 10354, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"29\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-06-02 12:40:03'),
(363, 10355, 0, 4, '[{\"id\":\"86\",\"descripcion\":\"Manzanilla\",\"cantidad\":\"0.4\",\"stock\":\"0.6\",\"precio\":\"250\",\"total\":\"100\"}]', 0, 100, 0, 100, 'Efectivo', 100, 0, '2021-06-02 12:45:19'),
(364, 10356, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"7\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-06-02 12:53:34'),
(365, 10357, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"1\",\"stock\":\"90\",\"precio\":\"15\",\"total\":\"15\"}]', 0, 15, 0, 15, 'Efectivo', 25, 10, '2021-06-02 14:48:28'),
(366, 10358, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"10\",\"stock\":\"80\",\"precio\":\"15\",\"total\":\"150\"}]', 0, 150, 0, 150, 'Efectivo', 150, 0, '2021-06-02 15:43:36'),
(367, 10359, 0, 4, '[{\"id\":\"71\",\"descripcion\":\"Canela entera\",\"cantidad\":\"0.17\",\"stock\":\"2.83\",\"precio\":\"300\",\"total\":\"51\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"76\",\"precio\":\"15\",\"total\":\"60\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"2.2\",\"stock\":\"63.8\",\"precio\":\"22\",\"total\":\"48.4\"}]', 0, 159.4, 0, 144.1, 'Efectivo', 500, 355.9, '2021-06-02 15:49:15'),
(368, 10360, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"28\",\"precio\":\"10\",\"total\":\"10\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"6\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 30, 0, 30, 'Efectivo', 100, 70, '2021-06-02 18:50:28'),
(369, 10361, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"7\",\"stock\":\"21\",\"precio\":\"10\",\"total\":\"70\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 90, 0, 90, 'Efectivo', 200, 110, '2021-06-02 21:24:32'),
(370, 10362, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"20\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-06-03 13:16:35'),
(371, 10363, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"40\",\"stock\":\"29\",\"precio\":\"8\",\"total\":\"320\"}]', 0, 320, 0, 320, 'Efectivo', 500, 180, '2021-06-03 15:02:03'),
(373, 10364, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-06-04 12:59:43'),
(374, 10365, 14, 4, '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"4\",\"stock\":\"89\",\"precio\":\"45\",\"total\":\"180\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"5\",\"stock\":\"32\",\"precio\":\"38\",\"total\":\"190\"}]', 0, 370, 0, 370, 'Credito', 0, 0, '2021-06-04 14:29:12'),
(375, 10366, 10, 4, '[{\"id\":\"58\",\"descripcion\":\"Cerveza Modelo\",\"cantidad\":\"2\",\"stock\":\"4\",\"precio\":\"70\",\"total\":\"140\"}]', 0, 140, 0, 140, 'Credito', 0, 0, '2021-06-04 18:40:01'),
(376, 10367, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"10\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 0, 0, '2021-06-04 19:48:43'),
(377, 10368, 0, 4, '[{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"4.7\",\"stock\":\"49.3\",\"precio\":\"30\",\"total\":\"141\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"22\",\"precio\":\"15\",\"total\":\"60\"}]', 0, 201, 0, 201, 'Efectivo', 200, -1, '2021-06-04 21:20:19'),
(378, 10369, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"2\",\"stock\":\"59\",\"precio\":\"19\",\"total\":\"38\"},{\"id\":\"51\",\"descripcion\":\"Zucchini\",\"cantidad\":\"2\",\"stock\":\"33\",\"precio\":\"20\",\"total\":\"40\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"2\",\"stock\":\"47\",\"precio\":\"20\",\"total\":\"40\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"2\",\"stock\":\"9\",\"precio\":\"10\",\"total\":\"20\"},{\"id\":\"23\",\"descripcion\":\"Albahaca \",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"19\",\"precio\":\"12\",\"total\":\"36\"}]', 0, 199, 0, 199, 'Efectivo', 200, 1, '2021-06-04 21:22:37'),
(379, 10370, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"6\",\"stock\":\"13\",\"precio\":\"15\",\"total\":\"90\"}]', 0, 90, 0, 90, 'Efectivo', 100, 10, '2021-06-04 23:04:39'),
(380, 10371, 10, 4, '[{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"2\",\"stock\":\"54\",\"precio\":\"20\",\"total\":\"40\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"3.7\",\"stock\":\"85.3\",\"precio\":\"27\",\"total\":\"99.9\"}]', 0, 139.9, 0, 139.9, 'Credito', 0, 0, '2021-06-04 23:17:17'),
(381, 10372, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"3\",\"stock\":\"1\",\"precio\":\"20\",\"total\":\"60\"}]', 0, 85, 0, 85, 'Efectivo', 110, 25, '2021-06-05 13:07:13'),
(382, 10373, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-06-05 13:10:27'),
(383, 10374, 0, 4, '[{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"7\",\"stock\":\"17\",\"precio\":\"20\",\"total\":\"140\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"3\",\"stock\":\"6\",\"precio\":\"10\",\"total\":\"30\"},{\"id\":\"19\",\"descripcion\":\"Repollo Verde\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"85\",\"total\":\"85\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"3\",\"stock\":\"44\",\"precio\":\"30\",\"total\":\"90\"}]', 0, 345, 0, 345, 'Efectivo', 500, 155, '2021-06-05 16:06:08'),
(384, 10375, 5, 4, '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"8\",\"stock\":\"77\",\"precio\":\"25\",\"total\":\"200\"},{\"id\":\"103\",\"descripcion\":\"Hierba buena paq\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"10\",\"total\":\"10\"},{\"id\":\"46\",\"descripcion\":\"Rucula\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"60\",\"total\":\"60\"}]', 0, 240, 0, 240, 'Credito', 0, 0, '2021-06-05 17:15:20'),
(385, 10376, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 25, 0, '2021-06-05 17:48:55'),
(386, 10377, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 100, 80, '2021-06-05 18:01:49'),
(387, 10378, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 50, 25, '2021-06-05 18:42:33'),
(388, 10379, 5, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Credito', 0, 0, '2021-06-05 19:02:20'),
(389, 10380, 19, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"5\",\"precio\":\"116\",\"total\":\"116\"}]', 0, 116, 0, 116, 'Credito', 0, 0, '2021-06-06 14:09:41'),
(390, 10381, 0, 4, '[{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"2.7\",\"stock\":\"0.2999999999999998\",\"precio\":\"17\",\"total\":\"45.9\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"7\",\"precio\":\"8\",\"total\":\"32\"}]', 0, 77.9, 0, 77.9, 'Efectivo', 100, 22.1, '2021-06-06 14:41:16'),
(391, 10382, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"4\",\"precio\":\"15\",\"total\":\"45\"}]', 0, 45, 0, 45, 'Efectivo', 100, 55, '2021-06-06 14:47:55'),
(392, 10383, 0, 4, '[{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"2\",\"stock\":\"48\",\"precio\":\"25\",\"total\":\"50\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"0.7\",\"stock\":\"42.3\",\"precio\":\"37\",\"total\":\"25.9\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"2\",\"stock\":\"54\",\"precio\":\"30\",\"total\":\"60\"},{\"id\":\"175\",\"descripcion\":\"Vainita China Paq\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"40\",\"total\":\"40\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"5\",\"stock\":\"96\",\"precio\":\"22\",\"total\":\"110\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"4\",\"stock\":\"73\",\"precio\":\"45\",\"total\":\"180\"}]', 0, 465.9, 0, 465.9, 'Efectivo', 500, 34.1, '2021-06-06 15:35:05'),
(393, 10384, 17, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Credito', 0, 0, '2021-06-06 17:55:22'),
(394, 10385, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"9\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 0, 0, '2021-06-06 18:05:46'),
(395, 10386, 0, 4, '[{\"id\":\"86\",\"descripcion\":\"Manzanilla\",\"cantidad\":\"0.092\",\"stock\":\"0.908\",\"precio\":\"250\",\"total\":\"23\"}]', 0, 23, 0, 23, 'Efectivo', 25, 2, '2021-06-06 18:06:44'),
(396, 10387, 0, 4, '[{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.5\",\"stock\":\"21.5\",\"precio\":\"110\",\"total\":\"55\"}]', 0, 55, 0, 55, 'Efectivo', 100, 45, '2021-06-07 13:10:24'),
(397, 10388, 14, 4, '[{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"1.9\",\"stock\":\"16.1\",\"precio\":\"25\",\"total\":\"47.5\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"1.6\",\"stock\":\"43.4\",\"precio\":\"30\",\"total\":\"48\"}]', 0, 95.5, 0, 95.5, 'Credito', 0, 0, '2021-06-07 13:16:30'),
(398, 10389, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-06-07 14:22:21'),
(399, 10390, 18, 4, '[{\"id\":\"47\",\"descripcion\":\"Tayota\",\"cantidad\":\"3\",\"stock\":\"2\",\"precio\":\"20\",\"total\":\"60\"},{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"1\",\"stock\":\"25\",\"precio\":\"85\",\"total\":\"85\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"1.4\",\"stock\":\"30.6\",\"precio\":\"38\",\"total\":\"53.2\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"0\",\"precio\":\"15\",\"total\":\"60\"},{\"id\":\"25\",\"descripcion\":\"Calabacin\",\"cantidad\":\"1.2\",\"stock\":\"3.8\",\"precio\":\"32\",\"total\":\"38.4\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1.2\",\"stock\":\"71.8\",\"precio\":\"45\",\"total\":\"54\"},{\"id\":\"27\",\"descripcion\":\"Cilantro Fino Paq\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 375.6, 0, 375.6, 'Efectivo', 2, 1, '2021-06-07 15:39:04'),
(400, 10391, 0, 4, '[{\"id\":\"109\",\"descripcion\":\"Semilla de cilantro\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"200\",\"total\":\"200\"},{\"id\":\"153\",\"descripcion\":\"Perejil Liso S\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"150\",\"total\":\"150\"}]', 0, 300, 0, 300, 'Efectivo', 300, 0, '2021-06-07 15:42:42'),
(401, 10392, 10, 4, '[{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"1\",\"stock\":\"23\",\"precio\":\"85\",\"total\":\"85\"}]', 0, 56, 0, 56, 'Efectivo', 100, 44, '2021-06-07 19:28:06'),
(402, 10393, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"8\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 0, 0, '2021-06-07 20:25:13'),
(403, 10394, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"56\",\"precio\":\"15\",\"total\":\"60\"}]', 0, 60, 0, 60, 'Efectivo', 100, 40, '2021-06-07 20:49:00'),
(404, 10395, 0, 4, '[{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"1.39\",\"stock\":\"14.61\",\"precio\":\"25\",\"total\":\"34.75\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"54\",\"precio\":\"15\",\"total\":\"30\"}]', 0, 64.75, 0, 64.75, 'Efectivo', 1, 935.25, '2021-06-07 21:09:16'),
(405, 10396, 0, 4, '[{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"3\",\"stock\":\"51\",\"precio\":\"30\",\"total\":\"90\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"0.8\",\"stock\":\"41.2\",\"precio\":\"37\",\"total\":\"29.6\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"51\",\"precio\":\"15\",\"total\":\"45\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"0.78\",\"stock\":\"42.22\",\"precio\":\"30\",\"total\":\"23.4\"},{\"id\":\"139\",\"descripcion\":\"Granola Paq\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"111\",\"total\":\"111\"}]', 0, 299, 0, 299, 'Efectivo', 315, 16, '2021-06-09 13:32:36'),
(406, 10397, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"7\",\"stock\":\"44\",\"precio\":\"8\",\"total\":\"56\"}]', 0, 56, 0, 56, 'Efectivo', 100, 44, '2021-06-09 21:34:14'),
(407, 10398, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"2\",\"stock\":\"15\",\"precio\":\"25\",\"total\":\"50\"}]', 0, 50, 0, 50, 'Efectivo', 500, 450, '2021-06-10 13:10:53'),
(408, 10399, 0, 4, '[{\"id\":\"175\",\"descripcion\":\"Vainita China Paq\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"40\",\"total\":\"40\"},{\"id\":\"122\",\"descripcion\":\"Vainita Esp paq\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"35\",\"total\":\"35\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"0.7\",\"stock\":\"38.3\",\"precio\":\"37\",\"total\":\"25.9\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"1.2\",\"stock\":\"13.8\",\"precio\":\"25\",\"total\":\"30\"},{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"6.4\",\"stock\":\"10.6\",\"precio\":\"20\",\"total\":\"128\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"0.65\",\"stock\":\"43.35\",\"precio\":\"30\",\"total\":\"19.5\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.7\",\"stock\":\"30.3\",\"precio\":\"38\",\"total\":\"26.6\"},{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"7\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 370, 0, 358, 'Efectivo', 1, 642, '2021-06-10 14:36:26'),
(409, 10400, 14, 4, '[{\"id\":\"68\",\"descripcion\":\"Anís Estrella\",\"cantidad\":\"0.5\",\"stock\":\"0.5\",\"precio\":\"490\",\"total\":\"245\"},{\"id\":\"71\",\"descripcion\":\"Canela entera\",\"cantidad\":\"0.5\",\"stock\":\"2.5\",\"precio\":\"300\",\"total\":\"150\"},{\"id\":\"136\",\"descripcion\":\"Chinola\",\"cantidad\":\"5\",\"stock\":\"26\",\"precio\":\"10\",\"total\":\"50\"}]', 0, 445, 0, 445, 'Credito', 0, 0, '2021-06-10 15:36:59'),
(411, 10401, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"14\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 50, 25, '2021-06-10 18:24:10'),
(412, 10402, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"2\",\"stock\":\"5\",\"precio\":\"65\",\"total\":\"130\"}]', 0, 130, 0, 130, 'Credito', 0, 0, '2021-06-10 20:35:37'),
(413, 10403, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-06-11 12:35:32'),
(414, 10404, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 0, 0, '2021-06-11 20:53:36'),
(415, 10405, 10, 4, '[{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"-3\",\"precio\":\"116\",\"total\":\"116\"},{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"2\",\"stock\":\"20\",\"precio\":\"54\",\"total\":\"108\"}]', 0, 224, 0, 224, 'Efectivo', 500, 276, '2021-06-11 21:42:15'),
(416, 10406, 0, 4, '[{\"id\":\"79\",\"descripcion\":\"Flor de Tilo\",\"cantidad\":\"0.1\",\"stock\":\"0.9\",\"precio\":\"680\",\"total\":\"68\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"42\",\"precio\":\"15\",\"total\":\"30\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"13\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 123, 0, 123, 'Efectivo', 125, 2, '2021-06-12 14:37:28'),
(417, 10407, 21, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"4\",\"stock\":\"53\",\"precio\":\"10\",\"total\":\"40\"}]', 0, 40, 0, 40, 'Credito', 0, 0, '2021-06-12 15:22:38'),
(418, 10408, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"5\",\"stock\":\"48\",\"precio\":\"10\",\"total\":\"50\"}]', 0, 50, 0, 50, 'Efectivo', 50, 0, '2021-06-12 16:51:18'),
(419, 10409, 0, 4, '[{\"id\":\"58\",\"descripcion\":\"Cerveza Modelo\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"70\",\"total\":\"70\"}]', 0, 70, 0, 70, 'Efectivo', 100, 30, '2021-06-12 20:53:55'),
(420, 10410, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"2\",\"stock\":\"36\",\"precio\":\"10\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-06-12 20:58:11'),
(421, 10411, 14, 4, '[{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"2.5\",\"stock\":\"2.5\",\"precio\":\"25\",\"total\":\"62.5\"},{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"2\",\"stock\":\"37\",\"precio\":\"20\",\"total\":\"40\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"2\",\"stock\":\"11\",\"precio\":\"10\",\"total\":\"20\"}]', 0, 122.5, 0, 122.5, 'Efectivo', 123, 0.5, '2021-06-13 13:51:11'),
(422, 10412, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"3\",\"stock\":\"33\",\"precio\":\"10\",\"total\":\"30\"}]', 0, 30, 0, 30, 'Efectivo', 30, 0, '2021-06-13 14:23:08'),
(423, 10413, 5, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"22\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Credito', 0, 0, '2021-06-13 14:53:32'),
(424, 10414, 0, 4, '[{\"id\":\"58\",\"descripcion\":\"Cerveza Modelo\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"70\",\"total\":\"70\"}]', 0, 70, 0, 70, 'Efectivo', 100, 30, '2021-06-13 14:56:12'),
(425, 10415, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"30\",\"stock\":\"18\",\"precio\":\"8\",\"total\":\"240\"}]', 0, 240, 0, 240, 'Efectivo', 500, 260, '2021-06-13 15:03:00'),
(426, 10416, 0, 4, '[{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"1\",\"stock\":\"31\",\"precio\":\"85\",\"total\":\"85\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"1.9\",\"stock\":\"28.1\",\"precio\":\"25\",\"total\":\"47.5\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1.7\",\"stock\":\"1.3\",\"precio\":\"45\",\"total\":\"76.5\"},{\"id\":\"12\",\"descripcion\":\"Papa Gourmet\",\"cantidad\":\"0.9\",\"stock\":\"107.1\",\"precio\":\"15\",\"total\":\"13.5\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"2.3\",\"stock\":\"57.7\",\"precio\":\"22\",\"total\":\"50.6\"}]', 0, 273.1, 0, 273.1, 'Efectivo', 300, 26.9, '2021-06-13 15:40:26'),
(427, 10417, 0, 4, '[{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"1.2\",\"stock\":\"9.8\",\"precio\":\"45\",\"total\":\"54\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"116\",\"total\":\"116\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"15\",\"total\":\"15\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"2\",\"stock\":\"12\",\"precio\":\"38\",\"total\":\"76\"}]', 0, 261, 0, 261, 'Efectivo', 1, 739, '2021-06-13 17:34:12');
INSERT INTO `ventas` (`id`, `codigo`, `id_cliente`, `id_vendedor`, `productos`, `impuesto`, `neto`, `descuento`, `total`, `metodo_pago`, `pago_con`, `devuelta`, `fecha`) VALUES
(428, 10418, 0, 4, '[{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"1.3\",\"stock\":\"8.7\",\"precio\":\"45\",\"total\":\"58.5\"},{\"id\":\"129\",\"descripcion\":\"Aji Morron 2da\",\"cantidad\":\"0.7\",\"stock\":\"22.3\",\"precio\":\"20\",\"total\":\"14\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"13\",\"precio\":\"15\",\"total\":\"45\"},{\"id\":\"89\",\"descripcion\":\"Pimienta de Cayena\",\"cantidad\":\"0.25\",\"stock\":\"0.75\",\"precio\":\"400\",\"total\":\"100\"},{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"1\",\"stock\":\"30\",\"precio\":\"85\",\"total\":\"85\"}]', 0, 302.5, 0, 302.5, 'Efectivo', 500, 197.5, '2021-06-13 17:40:50'),
(429, 10419, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"2\",\"stock\":\"56\",\"precio\":\"22\",\"total\":\"44\"},{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"3.5\",\"stock\":\"33.5\",\"precio\":\"20\",\"total\":\"70\"},{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"1\",\"stock\":\"29\",\"precio\":\"85\",\"total\":\"85\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"1\",\"stock\":\"27\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"8\",\"descripcion\":\"Cebolla Amarilla\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"38\",\"total\":\"38\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"1\",\"stock\":\"31\",\"precio\":\"30\",\"total\":\"30\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"1\",\"stock\":\"11\",\"precio\":\"38\",\"total\":\"38\"},{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"1\",\"stock\":\"8\",\"precio\":\"45\",\"total\":\"45\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"0.8\",\"stock\":\"0.19999999999999996\",\"precio\":\"37\",\"total\":\"29.6\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"1.8\",\"stock\":\"9.2\",\"precio\":\"10\",\"total\":\"18\"},{\"id\":\"36\",\"descripcion\":\"Lechuga Rizada\",\"cantidad\":\"0.6\",\"stock\":\"1.4\",\"precio\":\"20\",\"total\":\"12\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"116\",\"total\":\"116\"},{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"2\",\"stock\":\"2\",\"precio\":\"65\",\"total\":\"130\"},{\"id\":\"58\",\"descripcion\":\"Cerveza Modelo\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"70\",\"total\":\"70\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.5\",\"stock\":\"16.5\",\"precio\":\"110\",\"total\":\"55\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"9\",\"precio\":\"15\",\"total\":\"60\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"1\",\"stock\":\"6\",\"precio\":\"30\",\"total\":\"30\"}]', 0, 895.6, 0, 895.6, 'Efectivo', 1, 104.4, '2021-06-13 17:49:14'),
(430, 10420, 0, 4, '[{\"id\":\"60\",\"descripcion\":\"Piña\",\"cantidad\":\"2\",\"stock\":\"4\",\"precio\":\"50\",\"total\":\"100\"},{\"id\":\"176\",\"descripcion\":\"Melon \",\"cantidad\":\"2\",\"stock\":\"2\",\"precio\":\"88\",\"total\":\"176\"},{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"32\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 286, 0, 286, 'Efectivo', 300, 14, '2021-06-13 17:55:48'),
(431, 10421, 5, 4, '[{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 65, 0, 65, 'Credito', 0, 0, '2021-06-13 18:08:42'),
(432, 10422, 0, 4, '[{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"2\",\"stock\":\"27\",\"precio\":\"56\",\"total\":\"112\"}]', 0, 112, 0, 112, 'Efectivo', 115, 3, '2021-06-14 13:33:39'),
(433, 10423, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"31\",\"precio\":\"10\",\"total\":\"10\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"3\",\"stock\":\"8\",\"precio\":\"38\",\"total\":\"114\"}]', 0, 124, 0, 124, 'Efectivo', 150, 26, '2021-06-14 14:51:06'),
(434, 10424, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"21\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 25, 0, '2021-06-14 14:52:55'),
(435, 10425, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"2.2\",\"stock\":\"50.8\",\"precio\":\"22\",\"total\":\"48.4\"}]', 0, 48.4, 0, 48.4, 'Efectivo', 50, 1.6, '2021-06-14 15:44:26'),
(436, 10426, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"20\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"30\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 35, 0, 35, 'Efectivo', 100, 65, '2021-06-14 18:08:39'),
(437, 10427, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"13\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-06-14 18:15:43'),
(438, 10428, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"19\",\"stock\":\"31.799999999999997\",\"precio\":\"15\",\"total\":\"285\"},{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"5\",\"stock\":\"22\",\"precio\":\"70\",\"total\":\"350\"}]', 0, 635, 0, 635, 'Efectivo', 1, 365, '2021-06-14 18:43:55'),
(440, 10430, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"12\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-06-14 20:40:02'),
(441, 10431, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"11\",\"precio\":\"20\",\"total\":\"20\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 45, 0, 45, 'Efectivo', 100, 55, '2021-06-16 12:52:04'),
(442, 10432, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"10\",\"precio\":\"20\",\"total\":\"20\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"3\",\"stock\":\"16\",\"precio\":\"25\",\"total\":\"75\"}]', 0, 95, 0, 95, 'Efectivo', 100, 5, '2021-06-16 13:04:15'),
(443, 10433, 0, 4, '[{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"2.4\",\"stock\":\"0.6000000000000001\",\"precio\":\"30\",\"total\":\"72\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"1.3\",\"stock\":\"1.7\",\"precio\":\"25\",\"total\":\"32.5\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"7.8\",\"stock\":\"17.2\",\"precio\":\"22\",\"total\":\"171.6\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"2.6\",\"stock\":\"2.4\",\"precio\":\"30\",\"total\":\"78\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"1.4\",\"stock\":\"6.6\",\"precio\":\"38\",\"total\":\"53.2\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"107\",\"precio\":\"15\",\"total\":\"45\"}]', 0, 452.3, 0, 430.7, 'Efectivo', 500, 69.3, '2021-06-16 13:27:54'),
(444, 10434, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"15\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 25, 0, '2021-06-16 13:47:06'),
(445, 10435, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"103\",\"precio\":\"15\",\"total\":\"60\"}]', 0, 60, 0, 42, 'Efectivo', 50, 8, '2021-06-16 13:58:45'),
(446, 10436, 10, 4, '[{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1\",\"stock\":\"-0.09999999999999998\",\"precio\":\"28\",\"total\":\"28\"},{\"id\":\"129\",\"descripcion\":\"Aji Morron 2da\",\"cantidad\":\"0.4\",\"stock\":\"20.6\",\"precio\":\"14\",\"total\":\"5.6\"},{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"1.8\",\"stock\":\"48\",\"precio\":\"16\",\"total\":\"28.8\"},{\"id\":\"30\",\"descripcion\":\"Fresa Fresca Peq\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"75\",\"total\":\"75\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"2\",\"stock\":\"7\",\"precio\":\"8\",\"total\":\"16\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"2.6\",\"stock\":\"14.6\",\"precio\":\"13\",\"total\":\"33.8\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"1\",\"stock\":\"24\",\"precio\":\"15\",\"total\":\"15\"}]', 0, 202.2, 0, 202.2, 'Credito', 0, 0, '2021-06-16 18:59:20'),
(447, 10437, 0, 4, '[{\"id\":\"43\",\"descripcion\":\"Repollo Chino\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"40\",\"total\":\"40\"},{\"id\":\"16\",\"descripcion\":\"Rabano\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"26\",\"total\":\"26\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.9\",\"stock\":\"12.7\",\"precio\":\"22\",\"total\":\"41.8\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"0.9\",\"stock\":\"23.1\",\"precio\":\"25\",\"total\":\"22.5\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"101\",\"precio\":\"15\",\"total\":\"30\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.4\",\"stock\":\"6.199999999999999\",\"precio\":\"38\",\"total\":\"15.2\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"0.8\",\"stock\":\"1.5999999999999999\",\"precio\":\"30\",\"total\":\"24\"},{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"1.4\",\"stock\":\"6.6\",\"precio\":\"45\",\"total\":\"63\"}]', 0, 262.5, 0, 250.5, 'Efectivo', 1, 749.5, '2021-06-16 20:03:51'),
(448, 10438, 10, 4, '[{\"id\":\"42\",\"descripcion\":\"Puerro Grueso\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 12, 0, 12, 'Credito', 0, 0, '2021-06-16 20:30:46'),
(449, 10439, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"14\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"2\",\"stock\":\"8\",\"precio\":\"20\",\"total\":\"40\"}]', 0, 65, 0, 65, 'Efectivo', 100, 35, '2021-06-17 13:19:11'),
(450, 10440, 5, 4, '[{\"id\":\"60\",\"descripcion\":\"Piña\",\"cantidad\":\"4\",\"stock\":\"0\",\"precio\":\"35\",\"total\":\"140\"},{\"id\":\"176\",\"descripcion\":\"Melon \",\"cantidad\":\"2\",\"stock\":\"0\",\"precio\":\"60\",\"total\":\"120\"}]', 0, 260, 0, 260, 'Credito', 0, 0, '2021-06-17 13:20:13'),
(451, 10441, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"30\",\"stock\":\"71\",\"precio\":\"8\",\"total\":\"240\"}]', 0, 240, 0, 240, 'Efectivo', 300, 60, '2021-06-17 15:07:03'),
(452, 10442, 0, 4, '[{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"0.9\",\"stock\":\"20.900000000000002\",\"precio\":\"25\",\"total\":\"22.5\"},{\"id\":\"8\",\"descripcion\":\"Cebolla Amarilla\",\"cantidad\":\"1\",\"stock\":\"17.4\",\"precio\":\"38\",\"total\":\"38\"},{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"1.1\",\"stock\":\"11.6\",\"precio\":\"22\",\"total\":\"24.2\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.1\",\"stock\":\"16.9\",\"precio\":\"110\",\"total\":\"11\"},{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"4.4\",\"stock\":\"29.6\",\"precio\":\"20\",\"total\":\"88\"}]', 0, 183.7, 0, 183.7, 'Efectivo', 200, 16.3, '2021-06-17 15:26:46'),
(453, 10443, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"7\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-06-17 15:37:10'),
(454, 10444, 14, 4, '[{\"id\":\"177\",\"descripcion\":\"Cilantro Ancho Paq\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"35\",\"total\":\"35\"}]', 0, 35, 0, 35, 'Credito', 0, 0, '2021-06-17 18:06:22'),
(455, 10445, 0, 4, '[{\"id\":\"4\",\"descripcion\":\"Tomate de Ensalada\",\"cantidad\":\"11\",\"stock\":\"0.5999999999999996\",\"precio\":\"15\",\"total\":\"165\"},{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"5\",\"stock\":\"16.5\",\"precio\":\"70\",\"total\":\"350\"},{\"id\":\"130\",\"descripcion\":\"Tomate ensalada 2da\",\"cantidad\":\"14\",\"stock\":\"20\",\"precio\":\"15\",\"total\":\"210\"}]', 0, 725, 0, 725, 'Efectivo', 750, 25, '2021-06-17 18:44:22'),
(456, 10446, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"29\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-06-17 18:50:51'),
(457, 10447, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"28\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-06-17 19:37:21'),
(459, 10449, 0, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"0.8\",\"stock\":\"4.6\",\"precio\":\"38\",\"total\":\"30.4\"},{\"id\":\"136\",\"descripcion\":\"Chinola\",\"cantidad\":\"3\",\"stock\":\"2\",\"precio\":\"10\",\"total\":\"30\"},{\"id\":\"130\",\"descripcion\":\"Tomate ensalada 2da\",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"6\",\"total\":\"6\"}]', 0, 66.4, 0, 57.28, 'Efectivo', 60, 2.72, '2021-06-17 19:52:35'),
(460, 10450, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"2\",\"stock\":\"26\",\"precio\":\"10\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 20, 0, '2021-06-17 20:57:43'),
(461, 10451, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"2\",\"stock\":\"5\",\"precio\":\"20\",\"total\":\"40\"},{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"13\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 65, 0, 65, 'Efectivo', 100, 35, '2021-06-18 13:31:12'),
(462, 10452, 5, 4, '[{\"id\":\"15\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"0.7\",\"stock\":\"1.3\",\"precio\":\"15\",\"total\":\"10.5\"}]', 0, 10.5, 0, 10.5, 'Credito', 0, 0, '2021-06-18 15:09:58'),
(463, 10453, 14, 4, '[{\"id\":\"41\",\"descripcion\":\"Perejil Rizado\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"20\",\"total\":\"20\"},{\"id\":\"133\",\"descripcion\":\"Perejil liso Paq\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"20\",\"total\":\"20\"},{\"id\":\"27\",\"descripcion\":\"Cilantro Fino Paq\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"25\",\"total\":\"25\"},{\"id\":\"136\",\"descripcion\":\"Chinola\",\"cantidad\":\"4\",\"stock\":\"1\",\"precio\":\"6\",\"total\":\"24\"},{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"1\",\"stock\":\"0.7\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 114, 0, 114, 'Credito', 0, 0, '2021-06-18 15:58:48'),
(464, 10454, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"25\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-06-18 18:15:13'),
(465, 10455, 0, 4, '[{\"id\":\"61\",\"descripcion\":\"Tomate Cherry Organico\",\"cantidad\":\"20\",\"stock\":\"42\",\"precio\":\"56\",\"total\":\"1120\"}]', 0, 1120, 0, 1120, 'Efectivo', 1, 80, '2021-06-18 18:17:54'),
(466, 10456, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"24\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-06-18 19:31:39'),
(467, 10457, 5, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"23\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Credito', 0, 0, '2021-06-18 19:33:00'),
(468, 10458, 19, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"22\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Credito', 0, 0, '2021-06-18 19:33:33'),
(469, 10459, 0, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"1.4\",\"stock\":\"19\",\"precio\":\"38\",\"total\":\"53.2\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"68\",\"precio\":\"15\",\"total\":\"45\"},{\"id\":\"7\",\"descripcion\":\"Cebolla Roja \",\"cantidad\":\"3.3\",\"stock\":\"27.7\",\"precio\":\"30\",\"total\":\"99\"}]', 0, 197.2, 0, 197.2, 'Efectivo', 200, 2.8, '2021-06-19 13:09:57'),
(470, 10460, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"12\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 50, 25, '2021-06-19 13:40:52'),
(471, 10461, 0, 4, '[{\"id\":\"13\",\"descripcion\":\"Lechuga Repollada\",\"cantidad\":\"1.2\",\"stock\":\"0.8\",\"precio\":\"25\",\"total\":\"30\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"1.3\",\"stock\":\"20.3\",\"precio\":\"30\",\"total\":\"39\"},{\"id\":\"130\",\"descripcion\":\"Tomate ensalada 2da\",\"cantidad\":\"4.5\",\"stock\":\"66.5\",\"precio\":\"10\",\"total\":\"45\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"65\",\"precio\":\"15\",\"total\":\"45\"}]', 0, 159, 0, 159, 'Efectivo', 200, 41, '2021-06-19 15:51:46'),
(472, 10462, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"21\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-06-19 19:18:32'),
(473, 10463, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"20\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-06-19 20:00:06'),
(474, 10464, 21, 4, '[{\"id\":\"58\",\"descripcion\":\"Cerveza Modelo\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"70\",\"total\":\"70\"},{\"id\":\"118\",\"descripcion\":\"Heineken\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"65\",\"total\":\"65\"}]', 0, 135, 0, 135, 'Efectivo', 500, 365, '2021-06-20 16:03:31'),
(475, 10465, 0, 4, '[{\"id\":\"8\",\"descripcion\":\"Cebolla Amarilla\",\"cantidad\":\"1.3\",\"stock\":\"16.099999999999998\",\"precio\":\"38\",\"total\":\"49.4\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"0.9\",\"stock\":\"26.900000000000006\",\"precio\":\"25\",\"total\":\"22.5\"},{\"id\":\"5\",\"descripcion\":\"Aji Morron\",\"cantidad\":\"1.4\",\"stock\":\"74.5\",\"precio\":\"45\",\"total\":\"63\"},{\"id\":\"44\",\"descripcion\":\"Repollo Morado\",\"cantidad\":\"2.6\",\"stock\":\"2.4\",\"precio\":\"38\",\"total\":\"98.8\"},{\"id\":\"54\",\"descripcion\":\"Granada China\",\"cantidad\":\"3.5\",\"stock\":\"3.0999999999999996\",\"precio\":\"45\",\"total\":\"157.5\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"6\",\"stock\":\"59\",\"precio\":\"15\",\"total\":\"90\"},{\"id\":\"130\",\"descripcion\":\"Tomate ensalada 2da\",\"cantidad\":\"3.3\",\"stock\":\"63.2\",\"precio\":\"10\",\"total\":\"33\"},{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"3.6\",\"stock\":\"15.4\",\"precio\":\"38\",\"total\":\"136.8\"},{\"id\":\"22\",\"descripcion\":\"Ajo Importado\",\"cantidad\":\"0.5\",\"stock\":\"16.4\",\"precio\":\"110\",\"total\":\"55\"}]', 0, 706, 0, 706, 'Efectivo', 1, 299, '2021-06-20 17:20:05'),
(476, 10466, 0, 4, '[{\"id\":\"113\",\"descripcion\":\"Fresa Congelada\",\"cantidad\":\"6\",\"stock\":\"5\",\"precio\":\"98\",\"total\":\"588\"},{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"19\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 598, 0, 598, 'Efectivo', 600, 2, '2021-06-20 18:17:44'),
(477, 10467, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"18\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-06-20 18:46:29'),
(478, 10468, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"3\",\"stock\":\"9\",\"precio\":\"25\",\"total\":\"75\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"57\",\"precio\":\"15\",\"total\":\"30\"},{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"17\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 115, 0, 115, 'Efectivo', 125, 10, '2021-06-21 14:49:50'),
(479, 10469, 5, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"16\",\"precio\":\"10\",\"total\":\"10\"},{\"id\":\"8\",\"descripcion\":\"Cebolla Amarilla\",\"cantidad\":\"2\",\"stock\":\"14.099999999999998\",\"precio\":\"38\",\"total\":\"76\"},{\"id\":\"129\",\"descripcion\":\"Aji Morron 2da\",\"cantidad\":\"0.8\",\"stock\":\"54.099999999999994\",\"precio\":\"20\",\"total\":\"16\"}]', 0, 102, 0, 102, 'Credito', 0, 0, '2021-06-21 14:51:34'),
(480, 10470, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"2\",\"stock\":\"55\",\"precio\":\"15\",\"total\":\"30\"},{\"id\":\"130\",\"descripcion\":\"Tomate ensalada 2da\",\"cantidad\":\"1\",\"stock\":\"62.2\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 40, 0, 40, 'Efectivo', 40, 0, '2021-06-21 15:03:36'),
(481, 10471, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"4\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 200, 180, '2021-06-21 15:23:09'),
(482, 10472, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"15\",\"precio\":\"10\",\"total\":\"10\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"1\",\"stock\":\"54\",\"precio\":\"15\",\"total\":\"15\"}]', 0, 25, 0, 25, 'Efectivo', 25, 0, '2021-06-21 20:09:38'),
(483, 10473, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"7\",\"stock\":\"8\",\"precio\":\"10\",\"total\":\"70\"}]', 0, 70, 0, 70, 'Efectivo', 70, 0, '2021-06-21 21:20:23'),
(484, 10474, 5, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"7\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Credito', 0, 0, '2021-06-21 21:26:29'),
(485, 10475, 0, 4, '[{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 20, 0, 20, 'Efectivo', 50, 30, '2021-06-23 12:54:31'),
(488, 10477, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"3\",\"stock\":\"4\",\"precio\":\"10\",\"total\":\"30\"},{\"id\":\"100\",\"descripcion\":\"Refresco\",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"20\",\"total\":\"20\"}]', 0, 50, 0, 50, 'Efectivo', 100, 50, '2021-06-23 14:07:21'),
(489, 10478, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"3\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-06-23 14:22:24'),
(490, 10479, 14, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"4\",\"stock\":\"50\",\"precio\":\"15\",\"total\":\"60\"}]', 0, 60, 0, 60, 'Credito', 0, 0, '2021-06-23 14:25:55'),
(491, 10480, 0, 4, '[{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"3\",\"stock\":\"47\",\"precio\":\"15\",\"total\":\"45\"}]', 0, 45, 0, 45, 'Efectivo', 100, 55, '2021-06-23 15:40:42'),
(492, 10481, 22, 4, '[{\"id\":\"3\",\"descripcion\":\"Tomate Barcelo\",\"cantidad\":\"5\",\"stock\":\"140.2\",\"precio\":\"22\",\"total\":\"110\"},{\"id\":\"39\",\"descripcion\":\"Pepino\",\"cantidad\":\"4\",\"stock\":\"16.3\",\"precio\":\"15\",\"total\":\"60\"},{\"id\":\"11\",\"descripcion\":\"Papa\",\"cantidad\":\"5\",\"stock\":\"44.6\",\"precio\":\"30\",\"total\":\"150\"},{\"id\":\"10\",\"descripcion\":\"Apio\",\"cantidad\":\"5\",\"stock\":\"0\",\"precio\":\"22\",\"total\":\"110\"},{\"id\":\"6\",\"descripcion\":\"Aji Cubanela\",\"cantidad\":\"2.8\",\"stock\":\"13.600000000000005\",\"precio\":\"29\",\"total\":\"81.2\"},{\"id\":\"9\",\"descripcion\":\"Zanahoria\",\"cantidad\":\"5\",\"stock\":\"16\",\"precio\":\"15\",\"total\":\"75\"},{\"id\":\"20\",\"descripcion\":\"Brocoli\",\"cantidad\":\"5\",\"stock\":\"2.7\",\"precio\":\"37\",\"total\":\"185\"},{\"id\":\"21\",\"descripcion\":\"Coliflor\",\"cantidad\":\"5\",\"stock\":\"9\",\"precio\":\"50\",\"total\":\"250\"}]', 0, 1021.2, 51.06, 970.14, 'Efectivo', 1, 29.86, '2021-06-23 16:06:48'),
(493, 10482, 0, 4, '[{\"id\":\"53\",\"descripcion\":\"Limón \",\"cantidad\":\"17.6\",\"stock\":\"0\",\"precio\":\"26\",\"total\":\"457.6\"}]', 0, 457.6, 0, 457.6, 'Efectivo', 500, 42.4, '2021-06-23 20:45:16'),
(494, 10483, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"8\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 25, 0, '2021-06-23 21:51:02'),
(495, 10484, 0, 4, '[{\"id\":\"99\",\"descripcion\":\"Jugo fruta fresca\",\"cantidad\":\"1\",\"stock\":\"7\",\"precio\":\"25\",\"total\":\"25\"}]', 0, 25, 0, 25, 'Efectivo', 25, 0, '2021-06-24 13:07:06'),
(496, 10485, 0, 4, '[{\"id\":\"130\",\"descripcion\":\"Tomate ensalada 2da\",\"cantidad\":\"10.7\",\"stock\":\"49.5\",\"precio\":\"4\",\"total\":\"42.8\"},{\"id\":\"55\",\"descripcion\":\"Aguacate Hass\",\"cantidad\":\"20\",\"stock\":\"27\",\"precio\":\"9\",\"total\":\"180\"}]', 0, 222.8, 0, 222.8, 'Efectivo', 500, 277.2, '2021-06-24 13:38:43'),
(497, 10486, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"2\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-06-24 15:15:49'),
(498, 10487, 0, 4, '[{\"id\":\"57\",\"descripcion\":\"Agua \",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"10\",\"total\":\"10\"}]', 0, 10, 0, 10, 'Efectivo', 10, 0, '2021-06-24 19:26:06'),
(499, 10488, 0, 1, '[{\"id\":\"145\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"150\",\"total\":\"150\"},{\"id\":\"146\",\"descripcion\":\"Lechuga Lollo Verde\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"150\",\"total\":\"150\"},{\"id\":\"147\",\"descripcion\":\"Lechuga Mixta\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"150\",\"total\":\"150\"}]', 0, 450, 15, 393, 'Efectivo', 500, 107, '2021-06-25 23:06:23'),
(500, 10489, 0, 1, '[{\"id\":\"145\",\"descripcion\":\"Lechuga Romana\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"150\",\"total\":\"150\"},{\"id\":\"146\",\"descripcion\":\"Lechuga Lollo Verde\",\"cantidad\":\"1\",\"stock\":\"0\",\"precio\":\"150\",\"total\":\"150\"},{\"id\":\"148\",\"descripcion\":\"Lechuga Roja De Trento\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"150\",\"total\":\"150\"}]', 0, 450, 30, 420, 'Efectivo', 500, 80, '2021-06-25 23:16:38'),
(501, 10490, 0, 1, '[{\"id\":\"149\",\"descripcion\":\"Lechuga Rizada Roja\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"150\",\"total\":\"150\"},{\"id\":\"150\",\"descripcion\":\"Mostaza Verde\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"150\",\"total\":\"150\"},{\"id\":\"151\",\"descripcion\":\"Mizuna Red\",\"cantidad\":\"1\",\"stock\":\"1\",\"precio\":\"150\",\"total\":\"150\"}]', 0, 450, 60, 390, 'Efectivo', 400, 10, '2021-06-25 23:17:59');

--
-- Disparadores `ventas`
--
DELIMITER $$
CREATE TRIGGER `actualizar_comprobante` BEFORE INSERT ON `ventas` FOR EACH ROW UPDATE tipo_comprobante SET ultimo_generado = ultimo_generado + 1
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `acceso_sucursales`
--
ALTER TABLE `acceso_sucursales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `caja`
--
ALTER TABLE `caja`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cobro_creditos`
--
ALTER TABLE `cobro_creditos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  ADD PRIMARY KEY (`id_cotizacion`);

--
-- Indices de la tabla `creditos`
--
ALTER TABLE `creditos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cuentas_por_pagar`
--
ALTER TABLE `cuentas_por_pagar`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`id_det_compra`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `existencias`
--
ALTER TABLE `existencias`
  ADD PRIMARY KEY (`exist_id`);

--
-- Indices de la tabla `gasto_produccion`
--
ALTER TABLE `gasto_produccion`
  ADD PRIMARY KEY (`id_gasto`),
  ADD KEY `id_produccion` (`id_produccion`,`id_usuario`);

--
-- Indices de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `producciones`
--
ALTER TABLE `producciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `rnc_fiscal`
--
ALTER TABLE `rnc_fiscal`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `rnc` (`rnc`);

--
-- Indices de la tabla `salida_dinero`
--
ALTER TABLE `salida_dinero`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sucursales`
--
ALTER TABLE `sucursales`
  ADD PRIMARY KEY (`suc_id`);

--
-- Indices de la tabla `tipo_comprobante`
--
ALTER TABLE `tipo_comprobante`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `codigo` (`codigo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `acceso_sucursales`
--
ALTER TABLE `acceso_sucursales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `caja`
--
ALTER TABLE `caja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `cobro_creditos`
--
ALTER TABLE `cobro_creditos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  MODIFY `id_cotizacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `creditos`
--
ALTER TABLE `creditos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT de la tabla `cuentas_por_pagar`
--
ALTER TABLE `cuentas_por_pagar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `id_det_compra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `existencias`
--
ALTER TABLE `existencias`
  MODIFY `exist_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gasto_produccion`
--
ALTER TABLE `gasto_produccion`
  MODIFY `id_gasto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1961;

--
-- AUTO_INCREMENT de la tabla `producciones`
--
ALTER TABLE `producciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=178;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `rnc_fiscal`
--
ALTER TABLE `rnc_fiscal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `salida_dinero`
--
ALTER TABLE `salida_dinero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `sucursales`
--
ALTER TABLE `sucursales`
  MODIFY `suc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_comprobante`
--
ALTER TABLE `tipo_comprobante`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=502;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
