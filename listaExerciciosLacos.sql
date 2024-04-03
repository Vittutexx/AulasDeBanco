SET SERVEROUTPUT ON

--1. Crie um bloco anônimo que calcula o total de movimentações de estoque para um determinado produto.
DECLARE
    CD_PRODUTO NUMBER(1):= &CODIGO_PRODUTO;
BEGIN

    FOR X IN (SELECT * FROM movimento_estoque) LOOP
    IF (X.COD_PRODUTO = CD_PRODUTO) THEN
    DBMS_OUTPUT.PUT_LINE('TOTAL DE MOVIMENTAÇÃO DE ESTOQUE DO PRODUTO: '|| X.QTD_MOVIMENTACAO_ESTOQUE);
    END IF;
    END LOOP;

END;

--2. Utilizando FOR crie um bloco anônimo que calcula a média de valores totais de pedidos para um cliente específico.
SET SERVEROUTPUT ON
DECLARE
CD_CLIENTE NUMBER := &VALOR;
TOTAL_ESTOQUE NUMBER := 0;
QTD_ITEM NUMBER := 0;
MEDIA NUMBER;
BEGIN

    FOR X IN (SELECT VAL_TOTAL_PEDIDO, COD_CLIENTE FROM PEDIDO) LOOP 
        IF (X.COD_CLIENTE) = CD_CLIENTE THEN
           TOTAL_ESTOQUE := TOTAL_ESTOQUE + X.VAL_TOTAL_PEDIDO;
           QTD_ITEM := QTD_ITEM + 1;
        END IF;
    END LOOP;
        MEDIA := (TOTAL_ESTOQUE / QTD_ITEM);
    DBMS_OUTPUT.PUT_LINE('MEDIA DE VALORES TOTAIS DOS PEDIDOS DO CLIENTE: ' || MEDIA);        
END;

--3. Crie um bloco anônimo que exiba os produtos compostos ativos
SET SERVEROUTPUT ON
BEGIN
    FOR X IN (SELECT COD_PRODUTO_RELACIONADO,
                     COD_PRODUTO, QTD_PRODUTO,
                     QTD_PRODUTO_RELACIONADO,
                     STA_ATIVO, 
                     DAT_CADASTRO, 
                     DAT_CANCELAMENTO 
                     FROM 
                     PRODUTO_COMPOSTO 
                     WHERE 
                     STA_ATIVO = 'A') LOOP
                        DBMS_OUTPUT.PUT_LINE(
                        'CODIGO DO PRODUTO RELACIONADO: ' || X.COD_PRODUTO_RELACIONADO ||
                        ' CODIGO DO PRODUTO: ' || X.COD_PRODUTO ||
                        ' QTD DO PRODUTO: ' || X.QTD_PRODUTO ||
                        ' QTD DO PRODUTO RELACIONADO: ' || X.QTD_PRODUTO_RELACIONADO ||
                        ' SITUAÇÃO: '|| '(' || X.STA_ATIVO || ')' ||
                        ' DATA DE CADASTRO: '|| '(' || X.DAT_CADASTRO || ')' || 
                        ' DATA DE CANCELAMENTO: '|| '(' || X.DAT_CANCELAMENTO || ')'); 
    END LOOP;
END;


--4. Crie um bloco anônimo para calcular o total de movimentações de estoque para um determinado produto usando INNER JOIN com a tabela de tipo_movimento_estoque.
SET SERVEROUTPUT ON
DECLARE
CD_PRODUTO NUMBER(3) := &CODIGO_DO_PRODUTO;
TOTAL_MOV NUMBER(2) := 0;
BEGIN
    FOR X IN (SELECT T.COD_TIPO_MOVIMENTO_ESTOQUE
                     FROM TIPO_MOVIMENTO_ESTOQUE T 
                     INNER JOIN
                     MOVIMENTO_ESTOQUE M 
                     ON 
                     (T.COD_TIPO_MOVIMENTO_ESTOQUE = M.COD_TIPO_MOVIMENTO_ESTOQUE))LOOP
        IF (X.COD_TIPO_MOVIMENTO_ESTOQUE = CD_PRODUTO) THEN
        TOTAL_MOV := TOTAL_MOV + 1;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('TOTAL DE MOVIMENTAÇÕES DE ESTOQUE DO PRODUTO: ' || TOTAL_MOV);
END;

--5. Crie um bloco anônimo para exibir os produtos compostos e, se houver, suas informações de estoque, usando LEFT JOIN com a tabela estoque_produto.
SET SERVEROUTPUT ON
BEGIN
    FOR X IN(SELECT PC.COD_PRODUTO,
                    PC.COD_PRODUTO_RELACIONADO,
                    PC.QTD_PRODUTO,
                    PC.QTD_PRODUTO_RELACIONADO,
                    PC.STA_ATIVO,
                    PC.DAT_CADASTRO,
                    PC.DAT_CANCELAMENTO,
                    EP.DAT_ESTOQUE,
                    EP.QTD_PRODUTO AS QUANTIDADE_PRODUTO 
                    FROM 
                    PRODUTO_COMPOSTO PC
                    LEFT JOIN 
                    ESTOQUE_PRODUTO EP ON PC.COD_PRODUTO = EP.COD_PRODUTO
                    WHERE 
                    EP.COD_PRODUTO IS NOT NULL)LOOP
                        DBMS_OUTPUT.PUT_LINE(
                          'CODIGO DO PRODUTO: ' || X.COD_PRODUTO
                          || ' CODIGO DO PRODUTO RELACIONADO: ' || X.COD_PRODUTO_RELACIONADO
                          || ' QTD DO PRODUTO: ' || X.QTD_PRODUTO
                          || ' QTD DO PRODUTO RELACIONADO: ' || X.QTD_PRODUTO_RELACIONADO
                          || ' DATA DO ESTOQUE: ' || X.DAT_ESTOQUE
                          || ' QUANTIDADE DE PRODUTO NO ESTOQUE: ' || X.QUANTIDADE_PRODUTO
                          || ' DATA DE CADASTRO: ' || X.DAT_CADASTRO
                          || ' DATA DE CANCELAMENTO: ' || X.DAT_CANCELAMENTO);
        END LOOP;
END;

--6. Crie um bloco que exiba as informações de pedidos e, se houver, as informações dos clientes relacionados usando RIGHT JOIN com a tabela cliente.
SET SERVEROUTPUT ON
BEGIN
    FOR X IN(SELECT P.COD_PEDIDO,
                    P.COD_CLIENTE,
                    P.COD_USUARIO,
                    P.COD_VENDEDOR,
                    P.DAT_PEDIDO,
                    P.VAL_TOTAL_PEDIDO,
                    P.VAL_DESCONTO,
                    C.NOM_CLIENTE,
                    C.TIP_PESSOA,
                    C.NUM_CPF_CNPJ
                    FROM 
                    PEDIDO P
                    RIGHT JOIN 
                    CLIENTE C ON C.COD_CLIENTE = P.COD_CLIENTE
                    WHERE 
                    C.COD_CLIENTE IS NOT NULL)
                    LOOP
                        DBMS_OUTPUT.PUT_LINE(
                          'CODIGO DO PEDIDO: ' || X.COD_PEDIDO
                          || ' CÓDIGO DO CLIENTE: ' || X.COD_CLIENTE
                          || ' CÓDIGO DO USUÁRIO: ' || X.COD_USUARIO
                          || ' CÓDIGO DO VENDEDOR: ' || X.COD_VENDEDOR
                          || ' DATA DO PEDIDO: ' || X.DAT_PEDIDO
                          || ' VALOR TOTAL DO PEDIDO: ' || X.VAL_TOTAL_PEDIDO
                          || ' VALOR TOTAL DO DESCONTO: ' || X.VAL_DESCONTO
                          || ' NOME DO CLIENTE RELACIONADO AO PEDIDO: ' || X.NOM_CLIENTE
                          || ' NATUREZA JURÍDICA: ' || X.TIP_PESSOA
                          || ' NUMERO DO CNPJ OU CPF: ' || X.NUM_CPF_CNPJ);
    END LOOP;                      
END;

--7. Crie um bloco que calcule a média de valores totais de pedidos para um cliente específico e exibe as informações do cliente usando INNER JOIN com a tabela cliente.
SET SERVEROUTPUT ON
DECLARE
CD_CLIENTE NUMBER := &VALOR;
TOTAL_ESTOQUE NUMBER := 0;
QTD_ITEM NUMBER := 0;
NOME_CLIENTE VARCHAR(30);
MEDIA NUMBER;
BEGIN

    FOR X IN (SELECT P.VAL_TOTAL_PEDIDO,
                     P.COD_CLIENTE,
                     C.NOM_CLIENTE
                     FROM 
                     PEDIDO P
                     INNER JOIN CLIENTE C
                     ON P.COD_CLIENTE = C.COD_CLIENTE) LOOP             
        IF (X.COD_CLIENTE) = CD_CLIENTE THEN
           TOTAL_ESTOQUE := TOTAL_ESTOQUE + X.VAL_TOTAL_PEDIDO;
           QTD_ITEM := QTD_ITEM + 1;
           NOME_CLIENTE := X.NOM_CLIENTE;
        END IF;
    END LOOP;
        MEDIA := (TOTAL_ESTOQUE / QTD_ITEM);
    DBMS_OUTPUT.PUT_LINE('NOME DO CLIENTE: ' || NOME_CLIENTE);
    DBMS_OUTPUT.PUT_LINE('CÓDIGO DO CLIENTE: ' || CD_CLIENTE);    
    DBMS_OUTPUT.PUT_LINE('MEDIA DE VALORES TOTAIS DOS PEDIDOS DO CLIENTE: ' || MEDIA);

END;






