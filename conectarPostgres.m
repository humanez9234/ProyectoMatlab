function conn = conectarPostgres()
    % CONECTARPOSTGRES Conecta a la base de datos PostgreSQL y devuelve la conexión.
    
    % Configuración de conexión
    dbname = 'Inventario';        
    usuario = 'postgres';        
    contrasena = '12345';
    servidor = 'localhost';      
    puerto = 5432;               

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
