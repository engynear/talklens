-- +goose Up
-- +goose StatementBegin
CREATE TABLE historical_summaries (
    id BIGSERIAL PRIMARY KEY,
    session_id VARCHAR(255) NOT NULL,
    interlocutor_id BIGINT NOT NULL,
    summary TEXT NOT NULL,
    ts TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX idx_historical_summaries_session ON historical_summaries(session_id, interlocutor_id);
CREATE INDEX idx_historical_summaries_ts ON historical_summaries(ts DESC);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS historical_summaries;
-- +goose StatementEnd
