---2 � Crie uma procedure para inserir novos clientes, todos os valores dever�o ser informados por par�metros e devera ter tratamento de exce��o.
CREATE OR REPLACE PROCEDURE INSERIR_CL(
VCOD_CLIENTE
CLIENTE.COD_CLIENTE%TYPE,

VNOM_CLIENTE
CLIENTE.NOM_CLIENTE%TYPE,

VDES_RAZAO_SOCIAL
CLIENTE.DES_RAZAO_SOCIAL%TYPE,

VTIP_PESSOA
CLIENTE.TIP_PESSOA%TYPE,

VNUM_CPF_CNPJ
CLIENTE.NUM_CPF_CNPJ%TYPE,

VDAT_CADASTRO
CLIENTE.DAT_CADASTRO%TYPE,

VDAT_CANCELAMENTO
CLIENTE.DAT_CANCELAMENTO%TYPE,

VSTA_ATIVO
CLIENTE.STA_ATIVO%TYPE
) IS
EXE1 EXCEPTION;
EXE2 EXCEPTION;
EXE3 EXCEPTION;
EXE4 EXCEPTION;
EXE5 EXCEPTION;
EXE6 EXCEPTION;
EXE7 EXCEPTION;
EXE8 EXCEPTION;

BEGIN
        INSERT INTO CLIENTE (
        COD_CLIENTE,
        NOM_CLIENTE,
        DES_RAZAO_SOCIAL,
        TIP_PESSOA,
        NUM_CPF_CNPJ,
        DAT_CADASTRO,
        DAT_CANCELAMENTO,
        STA_ATIVO
    ) VALUES (
        VCOD_CLIENTE,
        VNOM_CLIENTE,
        VDES_RAZAO_SOCIAL,
        VTIP_PESSOA,
        VNUM_CPF_CNPJ,
        VDAT_CADASTRO,
        VDAT_CANCELAMENTO,
        VSTA_ATIVO
    );
    
    IF LENGTH(VNOM_CLIENTE) <= 3 OR REGEXP_LIKE(VNOM_CLIENTE, '[0-9]') THEN
        RAISE EXE1;
    
    ELSIF LENGTH(VCOD_CLIENTE) > 10 OR REGEXP_LIKE(VCOD_CLIENTE, '[a-zA-z]') THEN
        RAISE EXE2;
       
    ELSIF LENGTH(VDES_RAZAO_SOCIAL) > 80 OR REGEXP_LIKE(VDES_RAZAO_SOCIAL, '[0-9]') OR NOT NULL THEN
        RAISE EXE3;
    
    ELSIF LENGTH(VTIP_PESSOA) > 1 OR REGEXP_LIKE(VTIP_PESSOA, '[0-9]') OR NOT REGEXP_LIKE(VTIP_PESSOA, '^[^FJ]$') THEN
        RAISE EXE4;
    
    ELSIF LENGTH(VNUM_CPF_CNPJ) > 15 OR REGEXP_LIKE(VNUM_CPF_CNPJ, '^[0-9]{15}$')  AND REGEXP_LIKE(VNUM_CPF_CNPJ, '[.-]') THEN
        RAISE EXE5;
        
    ELSIF NOT REGEXP_LIKE(TO_CHAR(VDAT_CADASTRO),'[^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/[0-9]{4}$ ]')THEN
        RAISE EXE6;
        
    ELSIF NOT REGEXP_LIKE(TO_CHAR(VDAT_CANCELAMENTO),'[^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/[0-9]{4}$ ]') OR NOT NULL THEN 
        RAISE EXE7;
    
    ELSIF NOT REGEXP_LIKE(VSTA_ATIVO, '^[^AI]$') THEN
        RAISE EXE8;
    END IF;   

    EXCEPTION
        WHEN EXE1 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Necess�rio que o nome do cliente tenha mais de tr�s numeros e n�o devem ser n�meros');
        WHEN EXE2 THEN
        RAISE_APPLICATION_ERROR(-20011, 'O c�digo do cliente deve conter mais de dez numeros e n�o deve ter caractere inserido');
        WHEN EXE3 THEN
        RAISE_APPLICATION_ERROR(-20012, 'Necess�rio que a raz�o social tenha menos de 80 caracteres n�o numericos ou devem conter valor NULL');
        WHEN EXE4 THEN
        RAISE_APPLICATION_ERROR(-20013, 'O o tipo de pessoa deve ser ||F|| ou ||J||. E n�o deve ser num�rico.');
        WHEN EXE5 THEN
        RAISE_APPLICATION_ERROR(-20014, 'O CPF/CNPJ precisam ser inseridos apenas com numeros e n�o deve conter caracteres especiais, como ||.|| e ||-||.');
        WHEN EXE6 THEN
        RAISE_APPLICATION_ERROR(-20015, 'Deve inserir a data da seguinte forma: DD/MM/YYYY. E deve conter apenas n�meros');
        WHEN EXE7 THEN
        RAISE_APPLICATION_ERROR(-20016, 'Deve inserir a data da seguinte forma: DD/MM/YYYY. E deve conter apenas n�meros ou seja valor NULL');
        WHEN EXE8 THEN
        RAISE_APPLICATION_ERROR(-20017, 'Deve conter appenas caracteres, sendo ele ||I|| OU ||A||.');
    END INSERIR_CL;