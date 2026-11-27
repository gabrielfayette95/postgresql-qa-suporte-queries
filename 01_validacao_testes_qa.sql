-- 1. Validar consistência de datas e status em ocorrências após testes de fluxo
SELECT
    o.id_ocorrencia,
    o.protocolo,
    o.status,
    o.criado_em,
    o.encerrado_em,
    u.nome AS responsavel
FROM ocorrencias o
LEFT JOIN usuarios u ON u.id_usuario = o.id_usuario_responsavel
WHERE (o.status = 'ENCERRADA' AND o.encerrado_em IS NULL)
   OR (o.status = 'ATIVA' AND o.encerrado_em IS NOT NULL)
   OR (o.encerrado_em < o.criado_em)
ORDER BY o.criado_em DESC;

-- 2. Verificar possíveis registros duplicados por chave externa em autuações
SELECT
    chave_externa,
    COUNT(*) AS quantidade_registros,
    MIN(criado_em) AS primeiro_registro,
    MAX(criado_em) AS ultimo_registro
FROM autuacoes
GROUP BY chave_externa
HAVING COUNT(*) > 1
ORDER BY quantidade_registros DESC;

-- 3. Conferir ocorrências encerradas sem vínculo com usuário responsável
SELECT
    o.id_ocorrencia,
    o.protocolo,
    o.status,
    o.encerrado_em
FROM ocorrencias o
WHERE o.status = 'ENCERRADA'
  AND o.id_usuario_responsavel IS NULL;
