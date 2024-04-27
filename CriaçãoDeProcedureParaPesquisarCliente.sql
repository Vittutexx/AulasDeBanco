SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE ENDERECO_CLIENTE_COMPLETO(CODCLI CLIENTE.COD_CLIENTE%TYPE) IS
CONTAGEM NUMBER := 0;
BEGIN
    FOR X IN (SELECT EC.SEQ_ENDERECO_CLIENTE,
    EC.COD_TIPO_ENDERECO,
    EC.COD_CLIENTE,
    EC.DES_ENDERECO,
    EC.NUM_ENDERECO,
    EC.DES_COMPLEMENTO,
    EC.NUM_CEP,
    EC.DES_BAIRRO,
    EC.COD_CIDADE,
    EC.STA_ATIVO,
    EC.DAT_CADASTRO,
    EC.DAT_CANCELAMENTO,
    P.COD_PAIS,
    ES.COD_ESTADO,
    P.NOM_PAIS,
    ES.NOM_ESTADO 
FROM ENDERECO_CLIENTE EC INNER JOIN CIDADE CI ON EC.COD_CIDADE = CI.COD_CIDADE
                         INNER JOIN ESTADO ES ON CI.COD_ESTADO = ES.COD_ESTADO 
                         INNER JOIN PAIS P ON ES.COD_PAIS = P.COD_PAIS
                         WHERE COD_CLIENTE = CODCLI) LOOP
                         CONTAGEM := CONTAGEM + 1;
                         
    DBMS_OUTPUT.PUT_LINE(' SEQUENCIA DE ENDEREÇO DO CLIENTE: ' || X.SEQ_ENDERECO_CLIENTE || CHR(10)
                        || ' CODIGO DO TIPO DE ENDEREÇO: ' || X.COD_TIPO_ENDERECO || CHR(10)
                        || ' DESCRIÇÃO DO ENDEREÇO DO CLIENTE: ' || X.COD_CLIENTE || CHR(10)
                        || ' NUMERO DO ENDEREÇO: ' || X.NUM_ENDERECO || CHR(10)
                        || ' DESCRIÇÃO DO COMPLEMENTO: ' || X.DES_COMPLEMENTO || CHR(10)
                        || ' NUMERO DO CEP: ' || X.NUM_CEP || CHR(10)
                        || ' DESCRIÇÃO DO BAIRRO: ' || X.DES_BAIRRO || CHR(10)
                        || ' CODIGO DA CIDADE: ' || X.COD_CIDADE || CHR(10)
                        || ' CODIGO DO ESTADO: ' || X.COD_ESTADO || CHR(10)
                        || ' CODIGO DO PAIS: ' || X.COD_PAIS || CHR(10)
                        || ' NOME DO ESTADO: ' || X.NOM_ESTADO || CHR(10)
                        || ' NOME DO PAÍS: ' || X.NOM_PAIS || CHR(10) || CHR(10)
                        || ' ------ FIM DA TABELA DE ENDEREÇO: ' || CONTAGEM ||  ' ------' || CHR(10));
    END LOOP;                    
END;           

CALL ENDERECO_CLIENTE_COMPLETO(1);

                        