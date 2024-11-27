SELECT funcionario.nome_funcionario, funcionario_mesa.idmesa, SUM(financeiro.valor_total) AS total_vendas
FROM 
    mesa 
JOIN 
    funcionario_mesa ON mesa.idmesa = funcionario_mesa.idmesa
JOIN 
    funcionario ON funcionario_mesa.idfuncionario = funcionario.idfuncionario
JOIN 
    pedido ON mesa.idmesa = pedido.idmesa
JOIN 
    pedido_financeiro ON pedido.idpedido = pedido_financeiro.idpedido
JOIN 
    financeiro ON pedido_financeiro.idfinanceiro = financeiro.idfinanceiro
GROUP BY 
    funcionario.nome_funcionario, 
    funcionario_mesa.idmesa;
    
SELECT mesa.idmesa, SUM(financeiro.valor_total) AS valor_por_mesa
FROM 
    mesa
JOIN 
    pedido ON mesa.idmesa = pedido.idmesa
JOIN 
    pedido_financeiro ON pedido.idpedido = pedido_financeiro.idpedido
JOIN 
    financeiro ON pedido_financeiro.idfinanceiro = financeiro.idfinanceiro
GROUP BY 
    mesa.idmesa;
    

    
   

