from notebookutils import mssparkutils

mssparkutils.fs.cp(
    "Files/bronze_Control_file_lakshmi.csv",
    "Files/bronze_Control_file_veri.csv"
)