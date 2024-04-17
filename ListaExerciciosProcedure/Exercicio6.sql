---6. Crie um procedimento em PL/SQL denominado "ListarMovimentosEstoqueProduto" que recebe o código de um produto como 
--argumento e lista todos os movimentos de estoque associados a esse produto, incluindo detalhes como a data do movimento e o tipo de movimento.
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE ListarMovimentosEstoqueProduto(VCOD_PROD MOVIMENTO_ESTOQUE.COD_PRODUTO%TYPE) IS

EXCP EXCEPTION;
BEGIN

    IF LENGTH(VCOD_PROD) > 10 OR REGEXP_LIKE(VCOD_PROD, '[a-zA-z]') THEN
        RAISE EXCP;
    END IF;
    
    FOR X IN(SELECT 
    TME.DES_TIPO_MOVIMENTO_ESTOQUE,
    ME.DAT_MOVIMENTO_ESTOQUE,
    ME.COD_TIPO_MOVIMENTO_ESTOQUE
    FROM MOVIMENTO_ESTOQUE ME 
    INNER JOIN TIPO_MOVIMENTO_ESTOQUE TME ON ( ME.COD_TIPO_MOVIMENTO_ESTOQUE = TME.COD_TIPO_MOVIMENTO_ESTOQUE )
    WHERE ME.COD_PRODUTO = VCOD_PROD) LOOP
    DBMS_OUTPUT.PUT_LINE(    
                             ' DATA DE MOVIMENTO DO ESTOQUE: ' || X.DAT_MOVIMENTO_ESTOQUE || CHR(10) ||
                             ' TIPO DO MOVIMENTO DE ESTOQUE: ' || X.DES_TIPO_MOVIMENTO_ESTOQUE || CHR(10));
    END LOOP;
    EXCEPTION
        WHEN EXCP THEN
            RAISE_APPLICATION_ERROR(-20022, 'O limite de números para o código deve ser de até 10 e não deve conter caracteres');
END;
