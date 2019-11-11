select owner, count(*) from dba_tables where owner like 'ERP%' group by owner;

select owner, table_name, NUM_ROWS from dba_tables where owner like 'ERP%' order by owner;

