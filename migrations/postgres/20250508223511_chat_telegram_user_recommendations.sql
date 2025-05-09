-- +goose Up
-- +goose StatementBegin
CREATE TABLE telegram_user_recommendations (
    id SERIAL PRIMARY KEY,
    session_id VARCHAR(255) NOT NULL,
    telegram_user_id BIGINT NOT NULL,
    interlocutor_id BIGINT NOT NULL,
    recommendation_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_telegram_user_recommendations_session ON telegram_user_recommendations(session_id, interlocutor_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS telegram_user_recommendations;
-- +goose StatementEnd
