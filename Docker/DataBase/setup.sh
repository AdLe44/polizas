#!/bin/bash
set -e

# Configurar PostgreSQL para aceptar conexiones desde cualquier IP
echo "listen_addresses='*'" >> /var/lib/postgresql/data/postgresql.conf

# Permitir conexiones desde cualquier IP
echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf