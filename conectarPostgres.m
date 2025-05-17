function conn = conectarPostgres()
    % CONECTARPOSTGRES Conecta a la base de datos PostgreSQL y devuelve la conexión.
    
    % Configuración de conexión
    dbname = 'Poblacion';        % Nombre de tu base de datos
    usuario = 'Postgres';        % Usuario de PostgreSQL
    contrasena = '12345';% <-- REEMPLAZA esto por tu contraseña
    servidor = 'localhost';      % O IP si es remoto
    puerto = 5432;               % Puerto por defecto de PostgreSQL

    % Crear conexión
    conn = database(dbname, usuario, contrasena, ...
        'Vendor', 'PostgreSQL', ...
        'Server', servidor, ...
        'PortNumber', puerto);

    % Verificar conexión
    if isopen(conn)
        disp('✅ Conexión exitosa a PostgreSQL');
    else
        error('❌ Error al conectar a PostgreSQL: %s', conn.Message);
    end
end
