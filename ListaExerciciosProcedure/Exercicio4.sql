---4. Escreva um procedimento em PL/SQL denominado "ListarPedidosCliente" que recebe o código de um cliente como parâmetro e lista todos os pedidos associados a 
---esse cliente, incluindo detalhes como o número do pedido, a data do pedido e o valor total.
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE ListarPedidosDoCliente(VAL_COD_CLIENTE PEDIDO.COD_CLIENTE%TYPE) IS 
EXCP EXCEPTION;
BEGIN
        IF LENGTH(VAL_COD_CLIENTE) > 10 OR REGEXP_LIKE(VAL_COD_CLIENTE, '[a-zA-z]')THEN
            RAISE EXCP;
        END IF;
        FOR X IN (SELECT * FROM PEDIDO WHERE COD_CLIENTE = VAL_COD_CLIENTE) LOOP
        DBMS_OUTPUT.PUT_LINE(' CODIGO DO PEDIDO: ' || X.COD_PEDIDO || CHR(10) ||
                             ' DATA DO PEDIDO: ' || X.DAT_PEDIDO || CHR(10) ||
                             ' VALOR TOTAL DO PEDIDO: ' || X.VAL_TOTAL_PEDIDO || CHR(10));
        END LOOP;
        EXCEPTION
            WHEN EXCP THEN
                RAISE_APPLICATION_ERROR(-20020, 'O limite de números para o código deve ser de até 10 e não deve conter caracteres');
END;
