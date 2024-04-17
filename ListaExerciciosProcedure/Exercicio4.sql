---4. Escreva um procedimento em PL/SQL denominado "ListarPedidosCliente" que recebe o c�digo de um cliente como par�metro e lista todos os pedidos associados a 
---esse cliente, incluindo detalhes como o n�mero do pedido, a data do pedido e o valor total.
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE ListarPedidosDoCliente(VAL_COD_CLIENTE PEDIDO.COD_CLIENTE%TYPE) IS 
EXCP EXCEPTION;
BEGIN
        IF LENGTH(VAL_COD_CLIENTE) > 10 OR REGEXP_LIKE(VAL_COD_CLIENTE, '[a-zA-z]')THEN
            RAISE EXCP;
        END IF;
        FOR X IN (SELECT * FROM PEDIDO WHERE COD_CLIENTE = VAL_COD_CLIENTE) LOOP
        DBMS_OUTPUT.PUT_LINE(' CODIGO DO PEDIDO: ' || X.COD_PEDIDO || CHR(10) ||
                             ' CODIGO DO PEDIDO RELACIONADO: ' || X.COD_PEDIDO_RELACIONADO || CHR(10) ||
                             ' CODIGO DO CLIENTE: ' || X.COD_CLIENTE || CHR(10) ||
                             ' CODIGO DO USUARIO: ' || X.COD_USUARIO || CHR(10) ||
                             ' CODIGO DO VENDEDOR: ' || X.COD_VENDEDOR || CHR(10) ||
                             ' DATA DO PEDIDO: ' || X.DAT_PEDIDO || CHR(10) ||
                             ' DATA DE CANCELAMENTO: ' || X.DAT_CANCELAMENTO || CHR(10) ||
                             ' DATA DE ENTREGA DO PEDIDO: ' || X.DAT_ENTREGA || CHR(10) ||
                             ' VALOR TOTAL DO PEDIDO: ' || X.VAL_TOTAL_PEDIDO || CHR(10) ||
                             ' VALOR DO DESCONTO: ' || X.VAL_DESCONTO || CHR(10) ||
                             ' SEQUENCIA DO ENDERE�O DO CLIENTE: ' || X.SEQ_ENDERECO_CLIENTE || CHR(10));
        END LOOP;
        EXCEPTION
            WHEN EXCP THEN
                RAISE_APPLICATION_ERROR(-20020, 'O limite de n�meros para o c�digo deve ser de at� 10 e n�o deve conter caracteres');
END;