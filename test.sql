from pyspark.sql.functions import col

existing_ids = spark.table("bronze_drj_tenancies").select("id").distinct()

check_df = (
    df_tenancies
    .join(existing_ids, on="id", how="left_semi")
)

print("Rows in today's file:", df_tenancies.count())
print("IDs already present in Bronze:", check_df.count())


display(
    df_tenancies
    .select("id", "clientType", "invoicePrefix")
    .join(
        spark.table("bronze_drj_tenancies")
             .select("id", "clientType")
             .withColumnRenamed("clientType", "existing_clientType"),
        on="id",
        how="left"
    )
    .limit(20)
)