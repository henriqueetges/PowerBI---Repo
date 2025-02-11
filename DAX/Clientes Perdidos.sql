Clientes Perdidos = 
VAR _UltimaDataPerda = 
CALCULATE(
    MAX (dTempo[DATA] ), 
    ALLSELECTED( dTempo[DATA]),
    ALLSELECTED( dRepresentantes)
)

VAR _ClientesComDataPerda = 
CALCULATETABLE(
    ADDCOLUMNS(
        VALUES( Faturamento[COD_CLIENTE] ), 
        "UltimaData", [Data Ref. Perdidos]), 
        dTempo[DATA] <= _UltimaDataPerda
        )
        
VAR _ClientesPerdidos = 
FILTER(
    _ClientesComDataPerda,
    [UltimaData] IN VALUES(dTempo[DATA])
)

VAR _Resultado = 
COUNTROWS( _ClientesPerdidos )

RETURN _Resultado