BEGIN
     DBMS_CLOUD.DROP_CREDENTIAL('OBJ_STORE_CRED');
END;
/
select CREDENTIAL_NAME from dba_credentials;
/
set define off
begin
DBMS_CLOUD.create_credential( 
    credential_name => 'OBJ_STORE_CRED', 
    username => 'dataload',
    password => 'OFpN:.6Q{ISz{iK.G-_h'
    ); 
end;
/
select CREDENTIAL_NAME from dba_credentials;
/
SELECT * 
FROM table(dbms_cloud.list_objects(
             credential_name => 'OBJ_STORE_CRED', 
             location_uri => 'https://objectstorage.ap-sydney-1.oraclecloud.com/n/sde0oema7qtx/b/CODE/o/'
           ));
/
SELECT * 
FROM table(dbms_cloud.list_objects(
             credential_name => 'OBJ_STORE_CRED', 
             location_uri => 'https://objectstorage.ap-sydney-1.oraclecloud.com/n/sde0oema7qtx/b/DATA-PUMP/o/'
           ));
/
