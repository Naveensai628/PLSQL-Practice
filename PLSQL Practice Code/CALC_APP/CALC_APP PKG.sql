create or replace PACKAGE calc_app AS
    PROCEDURE calculate (
        variable1  IN  NUMBER,
        variable2  IN  NUMBER,
        operation  IN  VARCHAR2
    );

END calc_app;