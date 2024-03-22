---WHILE
--

---FOR


DECLARE
    V_CONTADOR NUMBER(1):= 0;

BEGIN

FOR V_CONTADOR IN 1..20 LOOP
    DBMS_OUTPUT.PUT_LINE(V_CONTADOR);
    
END LOOP;    
END;


---FOR

DECLARE
    V_CONTADOR NUMBER(1):= 0;

BEGIN

FOR V_CONTADOR IN REVERSE 1..20 LOOP
    DBMS_OUTPUT.PUT_LINE(V_CONTADOR);
    
END LOOP;    
END;


--- Montar um bloco de programação que realize o processamento de uma tabuada qualquer, por exemplo a tabuada do numero 150.

DECLARE
    V_CONTAGEM NUMBER(3):= 0;
    V_MULTIPLICADOR NUMBER(5):= &TABUADA;
BEGIN

    WHILE V_CONTAGEM <= 10 LOOP
        DBMS_OUTPUT.PUT_LINE(V_CONTAGEM * V_MULTIPLICADOR);
        V_CONTAGEM := V_CONTAGEM + 1;
    END LOOP;    

END;

--- Em um intevalo numerico inteiro, informar quantos numeros são pares e quantos são impares.

SET SERVEROUTPUT ON
DECLARE
    V_CONTADOR NUMBER(3):= 0;
BEGIN
     WHILE V_CONTADOR < 10 LOOP
        V_CONTADOR := V_CONTADOR + 1;
            IF MOD(V_CONTADOR, 2) = 1 THEN
                DBMS_OUTPUT.PUT_LINE('IMPAR: ' || V_CONTADOR );
            ELSE
                DBMS_OUTPUT.PUT_LINE('PAR: ' || V_CONTADOR );        
            END IF;    
    END LOOP;    
END;


--- Exibir a média dos valores pares em um intervalo numérico e soma dos ímpares.
SET SERVEROUTPUT ON
DECLARE
    V_CONTADOR NUMBER(3):= 0;
    SOMA NUMBER(3):= 0;
    MEDIA NUMBER(3);
    SOMAIMPAR NUMBER(3):=0;
BEGIN
    WHILE V_CONTADOR < 10 LOOP
    V_CONTADOR := V_CONTADOR + 1;
        
        IF MOD(V_CONTADOR, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('IMPAR: ' || V_CONTADOR );

            IF MOD(V_CONTADOR, 2) = 1 THEN  
            SOMAIMPAR := SOMAIMPAR + V_CONTADOR;
            END IF;
            
        ELSE
        DBMS_OUTPUT.PUT_LINE('PAR: ' || V_CONTADOR );
    
            IF MOD(V_CONTADOR, 2) = 0 THEN    
            SOMA := SOMA + V_CONTADOR;
                IF V_CONTADOR = 10 THEN
                MEDIA := (SOMA / V_CONTADOR);
                DBMS_OUTPUT.PUT_LINE('MEDIA DOS VALORES PARES: ' || MEDIA);
                END IF;               
            END IF; 
            
        END IF;
  
    END LOOP;
                DBMS_OUTPUT.PUT_LINE('SOMA DOS VALORES IMPARES: ' || SOMAIMPAR);
END;