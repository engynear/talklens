-- +goose Up
-- +goose StatementBegin
-- VIEW для подсчёта среднего времени ответа
CREATE VIEW telegram_avg_response_time AS
WITH diffs AS (
  SELECT
    session_id,
    telegram_interlocutor_id,
    message_time,
    sender_id,
    -- предыдущая запись в рамках той же пары (user, interlocutor)
    lag(message_time) OVER (
      PARTITION BY session_id, telegram_interlocutor_id
      ORDER BY message_time
    ) AS prev_time,
    lag(sender_id) OVER (
      PARTITION BY session_id, telegram_interlocutor_id
      ORDER BY message_time
    ) AS prev_sender
  FROM telegram_messages
)
SELECT
  session_id,
  telegram_interlocutor_id,
  -- среднее время между сменой отправителя: 
  -- если prev_sender != sender_id, считаем diff, иначе игнорируем
  AVG(
    dateDiff('second', prev_time, message_time)
  ) AS avg_response_time_seconds
FROM diffs
WHERE prev_time IS NOT NULL
  AND prev_sender != sender_id
GROUP BY
  session_id,
  telegram_interlocutor_id;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP VIEW IF EXISTS telegram_avg_response_time;
-- +goose StatementEnd
