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
    in p_usuarios VARCHAR,
    in p_contrasena VARCHAR
)
RETURNS setof view_usuario
LANGUAGE plpgsql AS
$FUNCTION$
DECLARE
    newUserId int;
BEGIN
    INSERT INTO usuario(nombres, usuarios, contrasena)
        VALUES(p_nombres, p_usuarios, p_contrasena)
    RETURNING idUsuario into newUserId;
    
    RETURN QUERY SELECT * FROM view_usuario WHERE idUsuario=newUserId;
END
$FUNCTION$
;

Create or REPLACE FUNCTION fun_user_update(
    in p_idUsuario int,
    in p_nombres VARCHAR DEFAULT NULL,
    in p_usuarios VARCHAR DEFAULT NULL,
    in p_contrasena VARCHAR DEFAULT NULL
)
RETURNS SETOF view_usuario
LANGUAGE plpgsql AS
$FUNCTION$
BEGIN
    UPDATE usuario SET 
    nombres = COALESCE(p_nombres, nombres),
    usuarios = COALESCE(p_usuarios, usuarios),
    contrasena = COALESCE(p_contrasena, contrasena)
    WHERE idUsuario = p_idUsuario;

    RETURN query SELECT * FROM view_usuario WHERE idUsuario = p_idUsuario;
END
$FUNCTION$

CREATE or REPLACE FUNCTION fun_user_remove(
    in p_idUsuario int
) RETURNS SETOF view_usuario
LANGUAGE plpgsql as
$FUNCTION$
BEGIN
CREATE TEMP TABLE usuarioEliminadoTabla on COMMIT DROP
    as SELECT * FROM view_usuario WHERE idUsuario=p_idUsuario;

    DELETE FROM usuario WHERE idUsuario = p_idUsuario;
    
    RETURN query SELECT * FROM usuarioEliminadoTabla;
END
$FUNCTION$


-- Prueba de las funciones

SELECT * FROM fun_user_create (
    p_nombres:='pepe',
    p_usuarios:='pep3',
    p_contrasena:='1234'
);

-- Me equivoque y modifique la funcion
drop Function if EXISTS fun_user_create

SELECT * FROM fun_user_update(
    p_idUsuario:=1,
    p_nombres:='Pepe',
    p_usuarios:='hola',
    p_contrasena:='123'
)

DROP Function if EXISTS fun_user_update

SELECT * FROM fun_user_remove(
    p_idUsuario:=1
)

SELECT * FROM view_usuario