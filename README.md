# Esportify
==========Instalación Repo======================================================

Paso 1: Descargar archivos
Primero debemos de clonar el repositorio o descargar el .zip

Paso 2: Desplegar Mongodb
Entrar mediante la terminal a la carpeta de backend y correr el siguiente script

-- node app.js

paso 3: Instalar dependecias de flutter
Debemos entrar a la carpeta del Fronted mediante la terminal, despues corremos el script "flutter doctor". Esto nos permitira validar si tenemos todo lo necesario instalado(Flutter SDK, Android Studio, VS Code, emuladores, etc.)

ya validado, que esta instalado lo necesario para ejecutar flutter , instalamos las dependencias con el siguiente script 

--flutter pub get

============Configuración variables de entorno=================================

Para configurar las variables de entorno de nuestro proyecto primero debemos de hacer el cambio de nombre del archivo .env.example a .env, La misma esta en la raiz de la carpeta Backend del proyecto, ya habiendo configurada esta, procedemos a configurar en la carpeta FrontEnd, en esta dirección FrontEnd\lib\data\connect_to_backend.dart, la variable baseUrl, la configuramos de la siguiente manera http://NUESTRADIRECCIONIP/api/users.