-- +goose Up
-- +goose StatementBegin
-- Materialized View: накапливаем count-состояния
CREATE MATERIALIZED VIEW telegram_messages_count_mv
ENGINE = AggregatingMergeTree()
PARTITION BY toYYYYMM(message_time)
ORDER BY (session_id, telegram_interlocutor_id)
POPULATE AS
SELECT
    session_id,
    telegram_interlocutor_id,
    message_time, -- добавлено!
    countStateIf(1, sender_id = telegram_interlocutor_id) AS interlocutor_msg_count_state,
    countStateIf(1, sender_id = telegram_user_id)         AS user_msg_count_state
FROM telegram_messages
GROUP BY
    session_id,
    telegram_interlocutor_id,
    message_time;
-- +goose StatementEnd

-- +goose StatementBegin
-- VIEW: разворачиваем агрегаты в числа
CREATE VIEW telegram_messages_count AS
SELECT
    session_id,
    telegram_interlocutor_id,
    countMerge(interlocutor_msg_count_state) AS interlocutor_messages,
    countMerge(user_msg_count_state)         AS user_messages
FROM telegram_messages_count_mv
GROUP BY
    session_id,
    telegram_interlocutor_id;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP VIEW IF EXISTS telegram_messages_count;
DROP MATERIALIZED VIEW IF EXISTS telegram_messages_count_mv;
-- +goose StatementEnd
