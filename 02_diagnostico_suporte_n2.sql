-- 1. Identificar dispositivos com múltiplas falhas de sincronização nas últimas 24 horas
SELECT
    d.id_dispositivo,
    d.codigo_dispositivo,
    d.ativo,
    d.ultimo_acesso,
    COUNT(l.id_log) AS total_erros_24h
FROM dispositivos d
JOIN logs_sincronizacao l ON l.id_dispositivo = d.id_dispositivo
WHERE l.status_sync = 'ERRO'
  AND l.ocorrido_em >= NOW() - INTERVAL '24 hours'
GROUP BY d.id_dispositivo, d.codigo_dispositivo, d.ativo, d.ultimo_acesso
HAVING COUNT(l.id_log) >= 3
ORDER BY total_erros_24h DESC;

-- 2. Listar últimas mensagens de erro por dispositivo para apoio ao N2/desenvolvimento
SELECT
    d.codigo_dispositivo,
    l.status_sync,
    l.mensagem_erro,
    l.ocorrido_em
FROM logs_sincronizacao l
JOIN dispositivos d ON d.id_dispositivo = l.id_dispositivo
WHERE l.status_sync = 'ERRO'
ORDER BY l.ocorrido_em DESC
LIMIT 50;

-- 3. Contagem de ocorrências por status para visão geral operacional
SELECT
    status,
    COUNT(*) AS total_ocorrencias
FROM ocorrencias
GROUP BY status
ORDER BY total_ocorrencias DESC;
