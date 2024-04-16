---1. Construa uma função para validar o CEP na inserção do endereço, deverá conter somente valores numéricos.

CREATE OR REPLACE FUNCTION  VALIDAR_CEP(
    CEP NUMBER)
    RETURN NUMBER IS 
    BEGIN
        IF REGEXP_LIKE(CEP, '[0-9]') THEN
            RETURN CEP;        
        ELSE
            RAISE_APPLICATION_ERROR(-20006, 'DADOS INVÁLIDOS. ESCREVA NUMEROS E NÃO CARACTERES.');
        END IF; 
    END;