function conn = conectarPostgres()
    % Conecta a la base de datos PostgreSQL y devuelve la conexión.
    jdbcDriverPath = 'C:\Users\alexa\Documents\Métodos numéricos\Proyecto Final\ProyectoMatlab\postgresql-42.7.6.jar';

    % Agrega el driver al classpath de Java
    javaaddpath(jdbcDriverPath);
    % Configuración de conexión
    dbname = 'gestion_inventario';        
    username = 'postgres';        
    password = 'alpha$25';
    server = '34.46.26.173';      
    port = 5432;               

     % Intentar conexión
    try
        conn = database(dbname, username, password, ...
            'Vendor', 'PostgreSQL', ...
            'Server', server, ...
            'PortNumber', port);
        
        if isopen(conn)
            fprintf('Se conectó correctamente "%s"\n', dbname);
            close(conn);  % Cerramos la conexión
        else
            fprintf('Falló al conectar por: %s\n', conn.Message);
        end

    catch ME
        fprintf('Excepción: %s\n', ME.message);
    end
end


