ABC Classf. = 
IF(
    HASONEVALUE(
        dProdutos[Produto]),
    VAR tVendasProduto = 
    ADDCOLUMNS(
        ALLSELECTED(dProdutos[Produto]), 
        "@VENDAS", [Fat. Bruto])
    VAR vValorAtual = [Fat. Bruto]
    VAR vValorTotal = 
    CALCULATE(
        [Fat. Bruto], 
        ALLSELECTED(dProdutos[Produto]))
    VAR VvENDAS = 
    FILTER(
        tVendasProduto,
        [@VENDAS] >= vValorAtual)
    VAR vVendasACM = 
    SUMX(VvENDAS, [@VENDAS])
    VAR vPercentCumulado = 
    DIVIDE(vVendasACM, vValorTotal, 0)

    VAR Classificacao = 
    SWITCH(
        TRUE(),
        ISBLANK(vPercentCumulado), BLANK(),
        vPercentCumulado <= 0.7, "A",
        vPercentCumulado <= 0.9, "B", "C")
        RETURN Classificacao)