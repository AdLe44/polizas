// filepath: /C:/Users/nem.madrian/Documents/DEV/PERSONAL/polizas/Docker/DataBase/test_select.js
const { Client } = require('pg');

const client = new Client({
    host: '127.0.0.1', // o la IP de tu máquina host si es diferente
    port: 9191,
    user: 'POSTGRES',
    password: 'PSTG',
    database: 'DB_SYS_POLICY',
});

client.connect()
    .then(() => {
    console.log('Conectado a PostgreSQL');
    return client.query('SELECT 1 AS TU_MAMA');
})
.then((res) => {
    console.log('Resultado:', res.rows);
})
.catch((err) => {
    console.error('Error ejecutando la consulta', err.stack);
})
.finally(() => {
    client.end();
});