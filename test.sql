SELECT
    u.id,
    COUNT(DISTINCT CONCAT(u.referral_id,'-',u.episode_number)) AS episode_count
FROM silver_drj_users u
WHERE profile_type = 'user'
GROUP BY u.id
HAVING COUNT(DISTINCT CONCAT(u.referral_id,'-',u.episode_number)) > 1;