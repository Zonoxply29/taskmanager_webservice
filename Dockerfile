# Etapa de construcción
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiar el archivo .csproj directamente desde la raíz
COPY taskmanager_webservice.csproj ./
RUN dotnet restore

# Copiar todos los archivos del proyecto
COPY . ./

# Publicar la aplicación
RUN dotnet publish -c Release -o /app/publish

# Etapa de ejecución
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copiar los archivos publicados desde la etapa de construcción
COPY --from=build /app/publish ./

# Configuración de variables de entorno
ENV ASPNETCORE_ENVIRONMENT=Production
ENV PORT=5000

# Exponer el puerto
EXPOSE 5000

# Comando para ejecutar la aplicación
ENTRYPOINT ["dotnet", "taskmanager_webservice.dll"]



