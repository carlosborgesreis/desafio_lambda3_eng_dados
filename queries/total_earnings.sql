SELECT cliente_nome, CAST(SUM(ganhos) - SUM(descontos) AS DECIMAL(18,2)) AS valor
FROM (
  SELECT 
    nome AS cliente_nome, 
    (t.valor_total * (ctr.percentual / 100)) AS ganhos,
    ((t.valor_total * (ctr.percentual / 100)) * (t.percentual_desconto / 100)) AS descontos
  FROM transacao t
  INNER JOIN contrato ctr ON t.contrato_id = ctr.contrato_id
  INNER JOIN cliente clt ON ctr.cliente_id = clt.cliente_id
  WHERE ctr.ativo = 1
) AS earnings
GROUP BY cliente_nome;