---1. Construa uma fun��o para validar o CEP na inser��o do endere�o, dever� conter somente valores num�ricos.

CREATE OR REPLACE FUNCTION  VALIDAR_CEP(
    CEP NUMBER)
    RETURN NUMBER IS 
    BEGIN
        IF REGEXP_LIKE(CEP, '[0-9]') THEN
            RETURN CEP;        
        ELSE
            RAISE_APPLICATION_ERROR(-20006, 'DADOS INV�LIDOS. ESCREVA NUMEROS E N�O CARACTERES.');
        END IF; 
    END;