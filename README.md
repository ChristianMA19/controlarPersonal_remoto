# Controlar personal Remoto

Proyecto en clase -Programación Movil-
Grupo:
- Christian David Manga Arrázola
- Juan Jose Campanella de Oros

## TODO List
Desarrollar una solución para controlar personal remoto, la misma debe contar con:

1. Dos tipos de usuario, coordinador (UC) y soporte (US).

2. Los usuarios UC deben poder, mediante interfaz web:
· Administrar los US (id, nombre, correo, clave)
· Administrar clientes (id, nombre)
· Evaluar los reportes de trabajo cada uno de los US de 1 a 5.

3. Los usuarios US deben, mediante una aplicación móvil:
· Enviar reportes de trabajo describiendo el problema solucionado y el cliente atendido la hora de inicio y tiempo de duración del trabajo

Notas:
- Trabajo realizado en parejas, mediante un repositorio compartido. El repositorio debe mostrar trabajo de ambos miembros.
- El desarrollo debe estar cubierto por un set completo de pruebas (unitarias, widgets e integración)
- Tanto la aplicación móvil como la web deben venir de un solo proyecto de Flutter · Los UC deben estar hardcoded en el backend (a@a.com y b@a.com) · El backend se debe soportar sobre retool
- La aplicación de los US debe soportar trabajo offline, sincronizando los reportes una vez se tenga acceso a internet
- La aplicación de US debe mostrar cada uno de sus reportes mostrando si ya fue enviado y la calificación que obtuvo (una vez tenga una).
- La web del coordinador debe entregar los siguientes reportes:

1. Soportes realizados a clientes (con filtro de cliente y/o US) mostrando fecha, US y evaluación
2. Listado de US con número de reportes y calificación promedio
