import pandas as pd
from sqlalchemy import create_engine
from urllib.parse import quote_plus

password = input("MySQL password: ")

engine = create_engine(
    "mysql+pymysql://root:" + quote_plus(password) +
    "@localhost/Hospital_analytics"
)

df = pd.read_sql("SELECT * FROM admissions", engine)

print("MYSQL CONNECTION SUCCESSFUL")
print("Rows:", len(df))
print("Columns:", len(df.columns))
print(df.head())