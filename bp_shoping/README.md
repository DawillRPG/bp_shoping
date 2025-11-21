# bp_shoping

Tienda con NPC para comprar equipos (paracaídas y buceo) integrada con QBCore y ox_lib/ox_target. El jugador interactúa con un NPC para abrir un menú contextual y comprar items pagando en efectivo.

## Características
- **NPC persistente** configurable (modelo y coordenadas).
- **Menú con ox_lib** para listar artículos y precios.
- **Interacción con ox_target** (icono y etiqueta personalizable).
- **Cobro en efectivo** y entrega de items usando QBCore.
- **Items y precios configurables** desde `config.lua`.

## Requisitos
- **FiveM** (fxserver) con `fx_version 'cerulean'`.
- **QBCore** (`qb-core`).
- **ox_lib** (para context menu y notificaciones).
- **ox_target** (para la interacción con el NPC).
- Un inventario compatible con QBCore. Recomendado: **ox_inventory**. Asegúrate de que los items configurados existan en tu inventario (por ejemplo: `parachute`, `diving_gear`).

## Instalación
1. Copia la carpeta `bp_shoping` dentro de tu directorio `resources/`.
2. En tu `server.cfg`, asegura el orden de arranque (ejemplo):
   ```cfg
   ensure qb-core
   ensure ox_lib
   ensure ox_target
   ensure ox_inventory
   ensure bp_shoping
   ```
3. Verifica que los items del shop existan en tu inventario. Si usas `ox_inventory`, añade/valida las definiciones correspondientes a los nombres configurados.

## Configuración
Toda la configuración está en `config.lua`:
- **`Config.NPC`**: modelo y coordenadas del NPC.
  - `model`: nombre del ped, por ejemplo `a_m_y_runner_02`.
  - `coords`: `vector4(x, y, z, heading)` donde aparecerá el NPC.
- **`Config.ShopItems`**: lista de artículos a vender.
  - `name`: nombre interno del item (debe existir en el inventario).
  - `label`: cómo se muestra en el menú.
  - `price`: precio en efectivo.

Ejemplo incluido:
```lua
Config.NPC = {
    model = 'a_m_y_runner_02',
    coords = vector4(-1504.06, 1512.26, 115.29, 259.7)
}

Config.ShopItems = {
    { name = 'parachute',   label = 'Paracaídas',  price = 2500 },
    { name = 'diving_gear', label = 'Equipo de buceo', price = 5000 }
}
```

## Uso en el juego
- Dirígete a la ubicación configurada; verás al NPC.
- Apunta/aceŕcate para que `ox_target` muestre la opción con icono de carrito.
- Selecciona “Comprar Equipos” para abrir el menú de `ox_lib`.
- Elige un artículo. Si tienes suficiente efectivo, se te descontará y recibirás el item.
- Se muestran notificaciones de éxito/error mediante `ox_lib`.

## Eventos y lógica
- **Cliente**: al seleccionar un artículo, se dispara `TriggerServerEvent('bp_shoping:buyItem', itemName)`.
- **Servidor**: maneja `bp_shoping:buyItem`.
  - Verifica el precio a partir de `Config.ShopItems`.
  - Intenta `RemoveMoney('cash', price)`.
  - Si procede, `AddItem(itemName, 1)` y notifica con `ox_lib`.

No hay comandos de chat/administración expuestos por este recurso.

## Estructura de archivos
- `fxmanifest.lua`: metadatos del recurso y carga de scripts.
- `config.lua`: configuración del NPC y artículos.
- `client.lua`: spawn del NPC, target y menú.
- `server.lua`: compra, cobro y entrega de items.

## Consejos y solución de problemas
- **El menú no aparece**: verifica que `ox_target` esté iniciado antes que `bp_shoping` y que no haya errores de consola. Acércate lo suficiente al NPC.
- **No descuenta dinero / no agrega items**: confirma que el jugador tenga efectivo, que el item exista en tu inventario y que `qb-core` esté funcionando. Revisa permisos en `ox_inventory` si aplica.
- **NPC no spawnea**: comprueba el `model` y las `coords` en `config.lua`. Revisa el client console por errores.
- **Items no existen**: crea los items en tu inventario con el mismo `name` definido en `Config.ShopItems`.


## Soporte
- **Discord (byp4ss.net):** https://discord.gg/ECXdrQ6GUN
Únete para soporte, reportes de errores y sugerencias.


## Créditos
- Autor: DawilLRPG
- Descripción: NPC Shop for Diving and Parachute Gear (ox_inventory + QBCore)

## Licencia
Uso libre para servidores de FiveM. No eliminar créditos. Ajusta y forkea bajo tu responsabilidad.