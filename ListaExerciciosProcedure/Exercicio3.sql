---3. Crie uma função em PL/SQL chamada "CalcularValorDescontoPedido" que recebe o código de um
---pedido como entrada e retorna o valor total do desconto aplicado no pedido, somando os descontos de todos os itens do pedido.
CREATE OR REPLACE FUNCTION CalcularValorDescontoPedido(VCOD_PEDIDO PEDIDO.COD_PEDIDO%TYPE)RETURN NUMBER IS
VALOR_TOTAL NUMBER;
VALOR_DESCONTO NUMBER := 0;
BEGIN
    FOR X IN (SELECT VALOR_DESCONTO FROM PEDIDO WHERE COD_PEDIDO = VCOD_PEDIDO) LOOP
        VALOR_DESCONTO := VALOR_DESCONTO + X.VALOR_DESCONTO;
        
    END LOOP;
    VALOR_TOTAL := VALOR_DESCONTO;
    
    RETURN 'Valor Total do Desconto no pedido '|| VCOD_PEDIDO || ': ' || VALOR_TOTAL;
END CalcularValorDescontoPedido;
