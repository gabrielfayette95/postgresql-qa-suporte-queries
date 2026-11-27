# PostgreSQL para QA e Suporte Técnico (N1/N2)

Coleção de consultas SQL em **PostgreSQL** voltadas para validação de dados em testes de software (QA) e diagnóstico de incidentes/inconsistências no suporte técnico (N1/N2).

> **Observação:** O esquema de tabelas abaixo é ilustrativo/simulado para demonstrar raciocínio de consulta, validação de integridade e investigação operacional.

## Tabelas Consideradas nos Exemplos

- `usuarios` (`id_usuario`, `nome`, `perfil`, `ativo`)
- `dispositivos` (`id_dispositivo`, `codigo_dispositivo`, `ativo`, `ultimo_acesso`)
- `ocorrencias` (`id_ocorrencia`, `protocolo`, `status`, `id_usuario_responsavel`, `criado_em`, `encerrado_em`)
- `autuacoes` (`id_autuacao`, `chave_externa`, `id_ocorrencia`, `status`, `criado_em`)
- `logs_sincronizacao` (`id_log`, `id_dispositivo`, `status_sync`, `mensagem_erro`, `ocorrido_em`)

## Arquivos

- `01_validacao_testes_qa.sql`: Consultas para apoiar testes funcionais, conferência de status e detecção de duplicidades.
- `02_diagnostico_suporte_n2.sql`: Consultas para investigar falhas de sincronização, dispositivos com erro e pendências operacionais.
