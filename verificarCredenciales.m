function esValido = verificarCredenciales(usuario, contrasena)
    conn = conectarPostgres();

    % Verificar la conexión
    if isempty(conn) || ~isopen(conn)
        error("No fue posible conectarse a la base de datos");
    end

    % Consulta SQL para validar las credenciales
    query = sprintf("SELECT * FROM usuario WHERE username = '%s' AND password = '%s' AND estado = TRUE", usuario, contrasena);

    try
        data = fetch(conn, query);
        esValido = ~isempty(data);
    catch
        esValido = false;
    end

    close(conn);
end