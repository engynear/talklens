-- +goose Up
-- +goose StatementBegin
CREATE TABLE telegram_subscriptions
(
    id BIGSERIAL PRIMARY KEY,
    user_id text NOT NULL,
    session_id VARCHAR(255) NOT NULL,
    telegram_interlocutor_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, session_id, telegram_interlocutor_id)
);

CREATE INDEX idx_telegram_subscriptions_user_session ON telegram_subscriptions(user_id, session_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS telegram_subscriptions;
-- +goose StatementEnd
