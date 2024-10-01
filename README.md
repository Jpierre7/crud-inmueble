# CRUD INMUEBLE 

Esta aplicación es un crud completo de Inmuebles, implementado con minimal api con .NET 8 y base de datos sql server.

## CARACTERÍSTICAS

- CRUD completo de Inmuebles.
- Uso ADO.NET para la conexion a la Base de datos y procedimientos almacenados.
- Respuestas en formato JSON.
- Fácil en desplegar. 

## REQUISITOS 
- [.NET 8 SDK](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
- [Visual Studio Code o Visual Studio 2022](https://code.visualstudio.com/)
- Postman para probar la api
- SQLSERVER como gestor de base de datos
- GIT como gestor para control de versiones

## INSTALACIÓN 
1. Clonar el proyecto. 
    - git clone https://github.com/Jpierre7/crud-inmueble.git

2. Restaurar las dependencias una vez abierto el proyecto en visual studio code.
    - dotnet restore

3. En la carpeta mssql se encuentra el script completo de la base de datos y debe ejecutarla en una query de sqlserver.

4. Actualizar la cadena de conexion segun las credenciales de su gestor de base de datos en sql server. La cadena de conexión se encuentra en el archivo. 
    - appsettings.Development.json

4. Ejecutar la aplicacion con el comando 
    - dotnet run

5. La aplicacion estará disponible en este puerto
    - http://localhost:5128/

6. Probar en postman los endpoint, agregar una variable de entorno con nombre API_URL con el valor http://localhost:5128

## ENDPOINTS
- GET: http://localhost:5128/inmuebles
- POST: http://localhost:5128/inmuebles
- UPDATE: http://localhost:5128/inmuebles/{id}
- DELETE: http://localhost:5128/inmuebles/{id}
