BEGIN;
CREATE INDEX ON tweet_tags (tag, id_tweets);
CREATE INDEX ON tweet_tags (id_tweets, tag);
CREATE INDEX ON tweets (id_tweets, lang);
CREATE INDEX ON tweets USING gin(to_tsvector('english', text));
COMMIT;
