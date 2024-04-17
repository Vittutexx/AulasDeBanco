---3. Crie uma função em PL/SQL chamada "CalcularValorDescontoPedido" que recebe o código de um
---pedido como entrada e retorna o valor total do desconto aplicado no pedido, somando os descontos de todos os itens do pedido.
CREATE OR REPLACE FUNCTION CalcularValorDescontoPedido(VCOD_PEDIDO PEDIDO.COD_PEDIDO%TYPE)RETURN NUMBER IS
CODIGO_PEDIDO NUMBER;
RAISE EXCP EXCEPTION;
BEGIN
    SELECT VAL_DESCONTO INTO CODIGO_PEDIDO FROM PEDIDO WHERE COD_PEDIDO = VCOD_PEDIDO;
    RETURN CODIGO_PEDIDO;
END CalcularValorDescontoPedido;
