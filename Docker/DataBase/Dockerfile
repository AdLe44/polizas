FROM postgres:16.7

# Establecer variables de entorno para la configuración de PostgreSQL
ENV POSTGRES_USER=SYS_USER_POLICY
ENV POSTGRES_PASSWORD=SYS_PROGS_POLICY
ENV POSTGRES_DB=DB_SYS_POLICY

# Exponer el puerto de PostgreSQL
EXPOSE 5432

# Copiar el script de configuración
COPY setup.sh /docker-entrypoint-initdb.d/

# Comando para iniciar PostgreSQL
CMD ["postgres"]