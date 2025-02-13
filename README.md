# Sales App

Este proyecto es una aplicación móvil construida con Flutter cuyo objetivo principal es gestionar e informar sobre ventas y clientes. La aplicación ofrece un **Dashboard** para visualizar estadísticas generales y secciones para la administración de clientes, además de una barra de navegación inferior para cambiar entre pantallas.

## Características principales

- **Visualización de estadísticas**: Muestra datos relacionados con las ventas, ingresos totales, productos y clientes activos.
- **Gestión de clientes**: Permite crear y visualizar información de cada cliente (funcionalidades ampliables).
- **Diseño responsivo**: Se adapta a diferentes tamaños de pantalla.
- **Estilos personalizables**: Utiliza temas y colorimetría ajustable para una interfaz limpia y moderna.

## Requisitos previos

- [Flutter](https://docs.flutter.dev/get-started/install) en su versión estable (2.0 en adelante).
- [Dart](https://dart.dev/get-dart) en la versión adecuada incluida con Flutter.
- Preferiblemente un editor con soporte para Flutter (por ejemplo, intellij Idea, Android Studio o Visual Studio Code).

## Instalación y ejecución

1. **Clonar el repositorio**:
   ```
   git clone https://github.com/DanildZambrana/sales_app
   ```
2. **Navegar a la carpeta del proyecto**:
   ```
   cd sales_app
   ```

3. **Instalar dependencias**:
   ```
   flutter pub get
   ```
4. **Ejecutar la aplicación**:
   ```
   flutter run
   ```
   Asegúrate de tener un emulador o dispositivo físico conectado y reconocido por Flutter.

## Estructura del proyecto (Ejemplo resumido)
```
lib/
 ┣ screens/
 ┃ ┣ dashboard.dart
 ┃ ┗ customers.dart
 ┣ components/
 ┃ ┗ ... (componentes de UI y widgets reutilizables)
 ┣ structure/
 ┃ ┗ navbar.dart
 ┗ main.dart
```

## Contribución

1. Haz un fork del repositorio.
2. Crea una rama con la nueva característica o solución de error:
   ```
   git checkout -b feature/nueva-funcionalidad
   ```
3. Haz commit de tus cambios:
   ```
   git commit -m "Agrega nueva funcionalidad"
   ```
4. Sube tus cambios al repositorio remoto:
   ```
   git push origin feature/nueva-funcionalidad
   ```
5. Crea un Pull Request describiendo tus aportes y motivaciones.

---

¡Gracias por utilizar **Sales App**! Si tienes preguntas o sugerencias, no dudes en crear un issue o contribuir con mejoras. ¡Disfruta desarrollando y usando la aplicación!



- `main.dart`: Punto de entrada de la aplicación.
- `screens/`: Contiene las diferentes pantallas (Dashboard, Clientes, etc.).
- `components/`: Widgets y componentes reutilizables.
- `structure/`: Elementos estructurales como la barra de navegación.
