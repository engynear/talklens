-- +goose Up
-- +goose StatementBegin
CREATE TABLE telegram_messages
(
    id                      UInt64,
    user_id                 String,
    session_id              String,
    telegram_user_id        UInt64,
    telegram_interlocutor_id UInt64,
    sender_id               UInt64,
    message_time            DateTime
)
ENGINE = MergeTree()
PARTITION BY toYYYYMM(message_time)
ORDER BY (session_id, telegram_interlocutor_id, message_time);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS telegram_messages;
-- +goose StatementEnd
