--CREATE  PKG SPECIFICATION IN ORACLE DATABASE

/*
                   USER DATA EXPORT IN FILE PKG
                   Description: this script includes pkg, pkg body, script to generate sample data
                   V1 --GALI RAVI NAVEEN 16-02-2023


*/

CREATE OR REPLACE PACKAGE file_extract_process AS
    PROCEDURE get_fnd_user_data (
        in_date IN DATE     ----CURRENT DATE TO EXPORT USERS CREATED
    );

END file_extract_process;


--CREATE PKG BODY

CREATE OR REPLACE PACKAGE BODY file_extract_process AS

    PROCEDURE get_fnd_user_data (
        in_date IN DATE
    ) IS
      
        CURSOR get_data_c IS
        SELECT
            *
        FROM
            fnd_user
        WHERE
            TRUNC(creation_date) = TRUNC(in_date);
       

        get_data_r            get_data_c%rowtype;
        fp                    utl_file.file_type; --file pointer
--suffex_name varchar2(20) := substr((REPLACE(trunc(sysdate) ,'-','')),1,8);
                directory_name        VARCHAR2(30) := 'TEST_DIR2';
        file_name_prefix      VARCHAR2(30) := 'FND_USER_EXPORT';
        file_name_date        NUMBER(10) := substr((replace(trunc(sysdate), '-', '')), 1, 8);
        file_name_unique_num  NUMBER(5) := dbms_random.value(1000, 9999);
        file_format_sufix     VARCHAR2(10) := '.csv';
        delimiter             VARCHAR2(3) := ',';
        data_collector        VARCHAR2(32767);
        file_name             VARCHAR2(60) := file_name_prefix
                                  || file_name_date
                                  || file_name_unique_num
                                  || file_format_sufix;  -- how to convert date to string
        BEGIN
        fp := utl_file.fopen(directory_name, file_name, 'w'); --TO OPEN THE FILE IN 'OS'
                utl_file.putf(fp, '%s\n', 'USER_ID,USER_NAME,NAME,EMAIL,MOBILE_NUMBER,JOB_POSITION,CREATION_DATE,LAST_UPDATE_DATE');
        OPEN get_data_c;
        LOOP
            FETCH get_data_c INTO get_data_r;
            data_collector := get_data_r.user_id
                              || delimiter
                              || get_data_r.user_name
                              || delimiter
                              || get_data_r.name
                              || delimiter
                              || get_data_r.email
                              || delimiter
                              || get_data_r.mobile_number
                              || delimiter
                              || get_data_r.job_position
                              || delimiter
                              || get_data_r.creation_date
                              || delimiter
                              || get_data_r.last_update_date;
            EXIT WHEN get_data_c%notfound;

            utl_file.putf(fp, '%s\n', data_collector); --%s\n to start new line when data inserts
        
                    
        END LOOP;

        utl_file.fclose(fp); --TO CLOSE THE FILE
                dbms_output.put_line('a');
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('ERROR IN PKG');
    END get_fnd_user_data;

END file_extract_process;

/*
DECLARE
    -- declare file pointer variable
    fp UTL_FILE.FILE_TYPE;
BEGIN
    -- open file
    fp := UTL_FILE.FOPEN('ABC', 'file1.txt', 'w');
    -- write data into file
    UTL_FILE.PUTF(fp, 'knowprogram.com');
    -- close file
    UTL_FILE.FCLOSE(fp);
END;
*/

--EXECUTION SCRIPT

BEGIN
    file_extract_process.get_fnd_user_data(sysdate - 2);  -- GIVE DATE AS INPUT TO FETCH DATA IN DBA_DIRECTORIES
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR');
END;