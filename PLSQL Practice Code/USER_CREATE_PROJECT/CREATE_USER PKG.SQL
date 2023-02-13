--CREATE  PKG SPECIFICATION

/*
                   USER CREATION PKG
                   V1 --GALI RAVI NAVEEN 13-02-2023


*/
create or replace PACKAGE CREATE_USER  AS 
--USED TO CREATE USER IN FND_USER TABLE 
PROCEDURE USER_CREATE (
UNAME IN VARCHAR2,
MOBILE_NUMBER IN VARCHAR2,
JOB_POSITION IN VARCHAR2
);

END CREATE_USER;

--CREATE PKG BODY
CREATE OR REPLACE PACKAGE BODY create_user AS

FUNCTION generate_user_name RETURN VARCHAR2 IS
        user_name     fnd_user.user_name%TYPE;
        aplha_part    CHAR;
        numeric_part  NUMBER(5);
    BEGIN
        --DBMS_RANDOM INBUILT PKG IS USED TO GENERATE UNIQUE USERNAME 
        aplha_part := dbms_random.string('u', 1);
        numeric_part := trunc(dbms_random.value(10000, 99999));
        user_name := aplha_part || numeric_part;
        dbms_output.put_line('GENERATE_USER_NAME -'|| user_name);
        RETURN user_name;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('ERROR IN GENERATE_USER_NAME');
    END generate_user_name;


FUNCTION get_user_name RETURN VARCHAR2 IS
        user_name_generator        fnd_user.user_name%TYPE;
        check_user_name_generator  fnd_user.user_name%TYPE;
        exist_flag                 NUMBER := 0;
    BEGIN
        user_name_generator := generate_user_name();
        dbms_output.put_line('INSIDE BEGIN GET_USER_NAME -'|| user_name_generator);
        BEGIN
        SELECT
            1
        INTO exist_flag
        FROM
            fnd_user
        WHERE
            user_name = user_name_generator;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No Duplicate data found in fnd_user');
        END;
    
    --WHILE LOOP USED AS VALIDATION CHECK TO AVOID DUPLICATE USERNAME
        WHILE exist_flag =1 LOOP
        dbms_output.put_line('INSIDE WHILE LOOP');
            SELECT
                1
            INTO exist_flag
            FROM
                fnd_user
            WHERE
                user_name = user_name_generator;

            user_name_generator := generate_user_name();
        END LOOP;

        RETURN user_name_generator;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('ERROR IN GET_USER_NAME');
    END get_user_name;
    
--MAIN PROCEDURE
PROCEDURE user_create (
        Uname           IN  VARCHAR2,
        mobile_number  IN  VARCHAR2,
        job_position   IN  VARCHAR2
    ) AS

        userid    fnd_user.user_id%TYPE;
        username  fnd_user.user_name%TYPE;
        emailadd  fnd_user.email%TYPE;
    BEGIN
         dbms_output.put_line('INSIDE MAIN PROCEDURE '|| SYSDATE);
        userid := user_id_s.nextval;
        username := get_user_name();
        
        BEGIN
        INSERT INTO fnd_user (
            user_id,
            user_name,
            name,
            email,
            mobile_number,
            job_position,
            creation_date,
            last_update_date
        ) VALUES (
            userid,
            username,
            upper(Uname),
            ( username
              || '@NAVINTECH.COM' ),
            mobile_number,
            upper(job_position),
            sysdate,
            sysdate
        );
    EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line(SQLERRM());
    END;
        COMMIT;
     dbms_output.put_line('Record inserted succesfuly for user_name- '|| username);
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('ERROR');
    END user_create;

END create_user;

PROCEDURE user_create (
        Uname           IN  VARCHAR2,
        mobile_number  IN  VARCHAR2,
        job_position   IN  VARCHAR2
    ) AS

        userid    fnd_user.user_id%TYPE;
        username  fnd_user.user_name%TYPE;
        emailadd  fnd_user.email%TYPE;
    BEGIN
         dbms_output.put_line('INSIDE MAIN PROCEDURE '|| SYSDATE);
        userid := user_id_s.nextval;
        username := get_user_name();
        
        BEGIN
        INSERT INTO fnd_user (
            user_id,
            user_name,
            name,
            email,
            mobile_number,
            job_position,
            creation_date,
            last_update_date
        ) VALUES (
            userid,
            username,
            upper(Uname),
            ( username
              || '@NAVINTECH.COM' ),
            mobile_number,
            upper(job_position),
            sysdate,
            sysdate
        );
    EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line(SQLERRM());
    END;
        COMMIT;
     dbms_output.put_line('Record inserted succesfuly for user_name- '|| username);
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('ERROR');
    END user_create;

END create_user;