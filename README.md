# bp_shoping

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
Uso libre para servidores de FiveM. No eliminar créditos. Ajusta bajo tu responsabilidad.
