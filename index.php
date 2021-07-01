<?php 

require_once "controladores/plantilla.controlador.php";
require_once "controladores/usuarios.controlador.php";
require_once "controladores/categorias.controlador.php";
require_once "controladores/productos.controlador.php";
require_once "controladores/clientes.controlador.php";
require_once "controladores/ventas.controlador.php";
require_once "controladores/proveedores.controlador.php";
require_once "controladores/compras.controlador.php";
require_once "controladores/creditos.controlador.php";
require_once "controladores/caja.controlador.php";
require_once "controladores/administracion.controlador.php";
require_once "controladores/CotizacionesController.php";
require_once "controladores/SucursalesController.php";
require_once "controladores/producciones.controlador.php";

require_once "modelos/usuarios.modelo.php";
require_once "modelos/categorias.modelo.php";
require_once "modelos/productos.modelo.php";
require_once "modelos/clientes.modelo.php";
require_once "modelos/ventas.modelo.php";
require_once "modelos/proveedores.modelo.php";
require_once "modelos/compras.modelo.php";
require_once "modelos/creditos.modelo.php";
require_once "modelos/caja.modelo.php";
require_once "modelos/administracion.modelo.php";
require_once "modelos/CotizacionesModels.php";
require_once "modelos/SucursalesModels.php";
require_once "modelos/producciones.modelo.php";


$plantilla = new ControladorPlantilla();
$plantilla -> ctrPlantilla();