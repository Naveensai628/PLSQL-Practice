create or replace PACKAGE BODY calc_app AS

    result_v NUMBER(10, 2);

    FUNCTION add (
        variable1  IN  NUMBER,
        variable2  IN  NUMBER
    ) RETURN NUMBER AS
        variable3 NUMBER(10, 2) := 0;
    BEGIN
        dbms_output.put_line('INSIDE ADD FUNCTION');
        RETURN variable1 + variable2;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('error');
            RETURN NULL;
    END add;

    FUNCTION sub (
        variable1  IN  NUMBER,
        variable2  IN  NUMBER
    ) RETURN NUMBER AS
        variable3 NUMBER(10, 2) := 0;
    BEGIN
        dbms_output.put_line('INSIDE SUB FUNCTION');
        IF variable1 > variable2 THEN
            return(variable1 - variable2);
        ELSE
            RETURN variable2 - variable1;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('error');
            RETURN NULL;
    END sub;

    FUNCTION mul (
        variable1  IN  NUMBER,
        variable2  IN  NUMBER
    ) RETURN NUMBER AS
        variable3 NUMBER(10, 2) := 0;
    BEGIN
        dbms_output.put_line('INSIDE MUL FUNCTION');
        RETURN variable1 * variable2;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('error');
            RETURN NULL;
    END mul;

    FUNCTION div (
        variable1  IN  NUMBER,
        variable2  IN  NUMBER
    ) RETURN NUMBER AS
        variable3 NUMBER(10, 2) := 0;
    BEGIN
        dbms_output.put_line('INSIDE DIV FUNCTION');
        IF variable1 > variable2 THEN
            RETURN variable1 / variable2;
        ELSE
            RETURN variable2 / variable1;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('error');
            RETURN NULL;
    END div;

    PROCEDURE calculate (
        variable1  IN  NUMBER,
        variable2  IN  NUMBER,
        operation  IN  VARCHAR2
    ) IS
    BEGIN
        result_v := 0;
        CASE upper(operation)
            WHEN 'ADD' THEN
                result_v := add(variable1, variable2);
                dbms_output.put_line('SUM OF NUMBERS : ' || result_v);
            WHEN 'SUB' THEN
                result_v := sub(variable1, variable2);
                dbms_output.put_line('SUM OF NUMBERS : ' || result_v);
            WHEN 'MUL' THEN
                result_v := mul(variable1, variable2);
                dbms_output.put_line('SUM OF NUMBERS : ' || result_v);
            WHEN 'DIV' THEN
                result_v := div(variable1, variable2);
                dbms_output.put_line('SUM OF NUMBERS : ' || result_v);
            ELSE
                dbms_output.put_line('Please provide proper details...');
        END CASE;

    END calculate;

END calc_app;