Carteira Ativa Histórica = 
VAR _minData = MIN(dTempo[DATA])
VAR _hoje = TODAY()
VAR _resultado = 

CALCULATE(
    DISTINCTCOUNTNOBLANK(dCliente[COD_CLIENTE]),
    USERELATIONSHIP(dCliente[DATA_CADASTRO], dTempo[DATA]),
    USERELATIONSHIP(dCliente[COD_REPRE], dRepresentantes[COD_ESTRUTURA]),
    dCliente[STATUS_ATIVIDADE] = "Ativo"
    , Filter(
        ALL( dTempo[DATA] ),
        dTempo[DATA] <= max(Faturamento[PERIODO]) 
        )
)
RETURN 
SWITCH(
    TRUE(),
    _minData < _hoje && or(ISFILTERED(dRepresentantes), ISINSCOPE(dRepresentantes[NOME_ESTRUTURA])), _resultado
    _minData >= _hoje, BLANK(), _resultado)