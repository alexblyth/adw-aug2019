SELECT * 
FROM table(dbms_cloud.list_objects(
             credential_name => 'OBJ_STORE_CRED', 
             location_uri => 'https://objectstorage.ap-sydney-1.oraclecloud.com/n/sde0oema7qtx/b/CODE/o/'
           ));