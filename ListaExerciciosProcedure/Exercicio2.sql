---2.Desenvolva uma fun��o em PL/SQL denominada "BuscarQuantidadeProdutoEmEstoque" que aceita o c�digo de um produto e o c�digo de
---um estoque como argumentos e retorna � quantidade dispon�vel desse produto no estoque especificado.
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