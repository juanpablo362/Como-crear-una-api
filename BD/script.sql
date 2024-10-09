-- Active: 1728422868640@@127.0.0.1@5432@capacitacion4b_juan
CREATE TABLE usuario (
    idUsuario SERIAL NOT NULL PRIMARY KEY,
    nombres VARCHAR not NULL,
    usuarios VARCHAR not NULL,
    contrasena VARCHAR not NULL
);

CREATE or REPLACE VIEW view_usuario AS SELECT * FROM usuario;

CREATE or REPLACE FUNCTION fun_user_create (
    in p_nombres VARCHAR,
    in p_usuario VARCHAR,
    in p_contrasena VARCHAR
)
RETURNS setof view_usuario
LANGUAGE plpgsql AS
$FUNCTION$
DECLARE
    newUserId int;
BEGIN
    INSERT INTO usuario(nombres, usuario, contrasena)
        VALUES(p_nombres, p_usuario, p_contrasena)
    RETURNING idUsuario into newUserId;
    
    RETURN QUERY SELECT * FROM view_usuario WHERE idUsuario=newUserId;
END
$FUNCTION$