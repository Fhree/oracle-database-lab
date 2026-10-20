-- scripts/deployment/env/10-crear-usuario-alumno.sql
WHENEVER SQLERROR EXIT SQL.SQLCODE
ALTER SESSION SET CONTAINER = FREEPDB1;

-- Crear el usuario alumno con cuota en el tablespace de usuarios
CREATE USER alumno IDENTIFIED BY "Alumno_2026_*"
  DEFAULT TABLESPACE USERS
  QUOTA UNLIMITED ON USERS;

GRANT DB_DEVELOPER_ROLE, CREATE SESSION TO alumno;

-- Habilitar el esquema para Oracle REST Data Services (Database Actions)
BEGIN
  ords_admin.enable_schema(
    p_enabled             => TRUE,
    p_schema              => 'ALUMNO',
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'alumno',
    p_auto_rest_auth      => TRUE
  );
  COMMIT;
END;
/

PROMPT == Verificacion usuario ALUMNO ==
SELECT username, account_status FROM dba_users WHERE username = 'ALUMNO';

EXIT
