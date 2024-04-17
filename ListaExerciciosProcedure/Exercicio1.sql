SET SERVEROUTPUT ON
---1. Escreva uma função em PL/SQL chamada
---"CalcularTotalPedido" que recebe o código de um pedido como parâmetro e retorna o valor total do pedido, calculado somando
---os valores dos itens do pedido.
CREATE OR REPLACE FUNCTION CalcularTotalPedido(VCOD_PEDIDO PEDIDO.COD_PEDIDO%TYPE
) RETURN NUMBER IS
VALOR_TOTAL NUMBER;
BEGIN
    
    VALOR_TOTAL := 0;
    FOR X IN(SELECT * FROM PEDIDO WHERE COD_PEDIDO = VCOD_PEDIDO) LOOP
        DBMS_OUTPUT.PUT_LINE('X.VAL_TOTAL_PEDIDO');
        VALOR_TOTAL := VALOR_TOTAL + X.VAL_TOTAL_PEDIDO;
    END LOOP;        
    DBMS_OUTPUT.PUT_LINE('Valor total do Pedido: ' || VCOD_PEDIDO || CHR(10) || ' ' || VALOR_TOTAL);
    
    RETURN VALOR_TOTAL;
END CalcularTotalPedido;    
