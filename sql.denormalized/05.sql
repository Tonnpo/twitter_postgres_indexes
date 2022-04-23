SELECT
    t1.tag,
    count(*) AS count
FROM (
    SELECT DISTINCT
        id_tweets,
        '#' || (jsonb->>'text') AS tag
    FROM (
        SELECT
            data->'id' AS id_tweets,
            jsonb_array_elements(
                COALESCE(data->'entities'->'hashtags', '[]') ||
                COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]')
            ) AS jsonb
        FROM tweets_jsonb
        WHERE
            to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text'))@@to_tsquery('english', 'coronavirus')
        AND 
            data->>'lang' = 'en'
    ) t
) t1
GROUP BY t1.tag
ORDER BY count DESC, t1.tag
LIMIT 1000;
