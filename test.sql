config_df = spark.read.options(header=True, delimiter=",").csv("Files/bronze_Control_file_prod.csv")

display(
    config_df.filter(
        (config_df.sourcesystem == "drj") &
        (config_df.tablename == "tenancies")
    )
)