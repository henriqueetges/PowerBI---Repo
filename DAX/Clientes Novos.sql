Clientes Novos = 
VAR tClientesComPrimeiraCompra = 
/* CRIA UMA TABELA COM O MÊS QUE CADA CLIENTE É CONSIDERADO NOVO INDEPENDENTE DOS FILTROS DE CLIENTE, TEMPO DE VENDA E DE REPRESENTANTES */
CALCULATETABLE(                            
    ADDCOLUMNS(                            
        FILTER(
            VALUES(dCliente[COD_CLIENTE]),
            EOMONTH([Data Ref. Novo], 0) >= EOMONTH([Data Ref Cadastro], 0)),   
        "DataCliNovo", [Data Ref. Novo]),
        ALLSELECTED(dCliente),           
        ALLSELECTED(dTempo),
        ALL(dRepresentantes)
)

VAR tClientesComLinhagem =                 
/* AQUI É CRIADO RELACIONAMENTO PARA POSSIBILIAR FILTRAR CLIENTE E DATA */                                
    TREATAS(                                
        tClientesComPrimeiraCompra,
        Faturamento[COD_CLIENTE],
        dTempo[DATA])

VAR vResultado = 
/* -- AQUI SÃO CONTADOS OS CLIENTES QUE SE ENCAIXAM NA DATA DE PRIMEIRA COMPRA  = DATA */
CALCULATE(                                  
    DISTINCTCOUNT(Faturamento[COD_CLIENTE])   
    , KEEPFILTERS(tClientesComLinhagem))

RETURN vResultado
