-- +goose Up
-- +goose StatementBegin
CREATE TABLE chat_metrics_history (
    id BIGSERIAL PRIMARY KEY,
    session_id VARCHAR(255) NOT NULL,
    telegram_user_id BIGINT NOT NULL,
    interlocutor_id BIGINT NOT NULL,
    role TEXT CHECK (role IN ('user', 'interlocutor')) NOT NULL,

    ts TIMESTAMP NOT NULL DEFAULT now(),

    compliments_delta INT,
    total_compliments INT,
    engagement_score FLOAT CHECK (engagement_score BETWEEN 0 AND 100),
    attachment_type TEXT,
    attachment_confidence FLOAT CHECK (attachment_confidence BETWEEN 0 AND 1)
);

CREATE INDEX idx_chat_metrics_history_session ON chat_metrics_history(session_id, interlocutor_id);
CREATE INDEX idx_chat_metrics_history_ts ON chat_metrics_history(ts DESC);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS chat_metrics_history;
-- +goose StatementEnd
