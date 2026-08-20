df_test = (
    spark.read
    .option("header", True)
    .option("delimiter", "|")
    .csv("Files/landing/DRJ/Tenancies_20260820/2026/08/20/Tenancies_202608200205.csv")
    .limit(20)
)

df_test.write \
    .format("delta") \
    .mode("overwrite") \
    .option("overwriteSchema", "true") \
    .saveAsTable("zz_test_bronze_drj_tenancies")



    SELECT
    id,
    clientType,
    invoicePrefix
FROM zz_test_bronze_drj_tenancies;