---5. Desenvolva um procedimento em PL/SQL chamado "ListarItensPedido" que aceita o código de um pedido como entrada e lista
---todos os itens incluídos nesse pedido, fornecendo informações como o código do item, o nome do produto e a quantidade.
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE ListarItensPedido(VCOD_PEDIDO ITEM_PEDIDO.COD_PRODUTO%TYPE) IS
EXCP EXCEPTION;
BEGIN
                
        IF LENGTH(VCOD_PEDIDO) > 10 OR REGEXP_LIKE(VCOD_PEDIDO, '[a-zA-z]') THEN
            RAISE EXCP;
        END IF;
        
        FOR X IN(SELECT 
            P.COD_PRODUTO,
            P.COD_ITEM_PEDIDO,
            P.QTD_ITEM,
            PP.NOM_PRODUTO
            FROM ITEM_PEDIDO P INNER JOIN PRODUTO PP ON P.COD_PRODUTO = PP.COD_PRODUTO
            WHERE COD_PEDIDO = VCOD_PEDIDO) LOOP    
        
            DBMS_OUTPUT.PUT_LINE('NOME DO PRODUTO: ' || X.NOM_PRODUTO || CHR(10) ||
                             ' CODIGO DO ITEM PEDIDO: ' || X.COD_ITEM_PEDIDO|| CHR(10) ||
                             ' QUANTIDADE DO ITEM: ' || X.QTD_ITEM || CHR(10));
        END LOOP;

        EXCEPTION
        WHEN EXCP THEN
            RAISE_APPLICATION_ERROR(-20021, 'O limite de números para o código deve ser de até 10 e não deve conter caracteres');
END;
