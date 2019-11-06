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
    password => 'kHgO<WLw6Pfz0R1:Pvx1'
    ); 
end;
/
select CREDENTIAL_NAME from dba_credentials;
/
SELECT * 
FROM table(dbms_cloud.list_objects(
             credential_name => 'OBJ_STORE_CRED', 
             location_uri => 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/idzo73zlod7f/b/CODE/o/'
           ));
/
SELECT * 
FROM table(dbms_cloud.list_objects(
             credential_name => 'OBJ_STORE_CRED', 
             location_uri => 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/idzo73zlod7f/b/DATA-PUMP/o/'
           ));
/
