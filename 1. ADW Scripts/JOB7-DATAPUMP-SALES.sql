set scan off
set serveroutput on
set escape off
REM ERPDEMO04 Tables 9

drop table ADMIN."IMP_SALES_DMP-1";

DECLARE
    s varchar2(1000); 
    h1 number;
    errorvarchar varchar2(100):= 'ERROR';
    tryGetStatus number := 0;
begin
    h1 := dbms_datapump.open (operation => 'IMPORT', job_mode => 'FULL', job_name => 'IMP_SALES_DMP-1', version => 'COMPATIBLE'); 
    tryGetStatus := 1;
    dbms_datapump.set_parameter(h1, 'TRACE', 167144-96) ; 
    dbms_datapump.set_parameter (h1, 'PARTITION_OPTIONS', 'MERGE'); 
    dbms_datapump.metadata_transform(h1, 'SEGMENT_ATTRIBUTES', 0); 
    dbms_datapump.metadata_transform(h1, 'DWCS_CVT_IOTS', 1); 
    dbms_datapump.metadata_transform(h1, 'DWCS_CVT_CONSTRAINTS', 1); 
    dbms_datapump.metadata_filter(h1, 'EXCLUDE_PATH_EXPR',         'IN (''INDEX'',''INDEXTYPE'', ''MATERIALIZED_VIEW'',''MATERIALIZED_VIEW_LOG'',         ''MATERIALIZED_ZONEMAP'', ''CLUSTER'', ''CLUSTERING'')'); 
    dbms_datapump.set_parallel(handle => h1, degree => 1); 
    dbms_datapump.add_file(handle => h1, filename => 'IMPORT-'||to_char(sysdate,'hh24_mi_ss')||'.LOG', directory => 'DATA_PUMP_DIR', filetype=>DBMS_DATAPUMP.KU$_FILE_TYPE_LOG_FILE); 
    dbms_datapump.set_parameter(handle => h1, name => 'KEEP_MASTER', value => 1); 
    dbms_datapump.add_file(handle => h1, filename => 'https://objectstorage.ap-sydney-1.oraclecloud.com/n/sde0oema7qtx/b/DATA-PUMP/o/Sales.dmp', directory => 'OBJ_STORE_CRED', filetype => 5); 
    dbms_datapump.set_parameter(handle => h1, name => 'INCLUDE_METADATA', value => 1); 
    dbms_datapump.set_parameter(handle => h1, name => 'DATA_ACCESS_METHOD', value => 'AUTOMATIC'); 
    dbms_datapump.set_parameter(handle => h1, name => 'REUSE_DATAFILES', value => 1); 
    dbms_datapump.set_parameter(handle => h1, name => 'SKIP_UNUSABLE_INDEXES', value => 0);
    dbms_datapump.start_job(handle => h1, skip_current => 0, abort_step => 0); 
    dbms_datapump.detach(handle => h1); 
    errorvarchar := 'NO_ERROR'; 
EXCEPTION
    WHEN OTHERS THEN
    BEGIN 
        IF ((errorvarchar = 'ERROR')AND(tryGetStatus=1)) THEN 
            DBMS_DATAPUMP.DETACH(h1);
        END IF;
    EXCEPTION 
    WHEN OTHERS THEN 
        NULL;
    END;
    RAISE;
END;
/

