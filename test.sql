WITH src AS
(
    SELECT
        *,
        to_date(
            reverse(substring(reverse(FILEDATE), 5, 8)),
            'yyyyMMdd'
        ) AS file_date,

        CASE
            WHEN LEFT(FILEDATE, 5) = 'Y0600'
                THEN LEFT(FILEDATE, 6)

            WHEN LEFT(FILEDATE, 5) NOT IN ('G489E', '00D1Z', 'T7L2F', 'U1V5S')
                 AND to_date(
                        reverse(substring(reverse(FILEDATE), 5, 8)),
                        'yyyyMMdd'
                     ) < '2023-12-01'
                THEN '00D1Z'

            ELSE LEFT(FILEDATE, 5)
        END AS id_organisation_source

    FROM bronze_sone_YOUR_NEW_TABLE
)

SELECT *
FROM src
WHERE RowIdentifier IN
(
    SELECT RowIdentifier
    FROM src
    GROUP BY RowIdentifier
    HAVING COUNT(DISTINCT id_organisation_source) > 1
)
ORDER BY RowIdentifier, file_date DESC;