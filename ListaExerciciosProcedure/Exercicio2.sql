---2.Desenvolva uma função em PL/SQL denominada "BuscarQuantidadeProdutoEmEstoque" que aceita o código de um produto e o código de
---um estoque como argumentos e retorna à quantidade disponível desse produto no estoque especificado.
CREATE OR REPLACE FUNCTION BuscarQuantidadeProdutoEmEstoque (
VCOD_PRODUTO ESTOQUE_PRODUTO.COD_PRODUTO%TYPE,
VCOD_ESTOQUE ESTOQUE_PRODUTO.COD_ESTOQUE%TYPE) RETURN NUMBER IS

QUANTIDADE_ESTOQUE ESTOQUE_PRODUTO.QTD_PRODUTO%TYPE;

BEGIN
    SELECT QTD_PRODUTO INTO
    QUANTIDADE_ESTOQUE FROM
    ESTOQUE_PRODUTO WHERE
    VCOD_PRODUTO = COD_PRODUTO AND VCOD_ESTOQUE = COD_ESTOQUE;
    
    RETURN QUANTIDADE_ESTOQUE;
END BuscarQuantidadeProdutoEmEstoque;