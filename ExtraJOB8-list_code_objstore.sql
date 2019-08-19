SELECT * 
FROM table(dbms_cloud.list_objects(
             credential_name => 'OBJ_STORE_CRED', 
             location_uri => 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/idzo73zlod7f/b/CODE/o/'
           ));