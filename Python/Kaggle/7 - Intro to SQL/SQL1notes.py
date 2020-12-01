from google.cloud import bigquery

"""
To start BigQuery will work on posts from Hacker News' website to gather a dataset
"""

# # Create a 'Client' object
# client = bigquery.Client()

# """ 
# Each dataset is contained in a corresponding project. The 'hacker_news' dataset is contained in the 'bigquery-public-data' project
# To access the dataset:
# * A reference to the dataset will be constructed with the 'dataset()' method.
# * The 'get_dateset()' method with the constructed reference will fetch the dataset.
# """

# # Construct a reference to the "hacker_news" dataset
# dataset_ref = client.dataset("hacker_news", project="bigquery-public-data")

# # API request - fetch the dataset
# dataset = client.get_dataset(dataset_ref)

# # List all the tables in the "hacker_news" dataset
# tables = list(client.list_tables(dataset))

# # Print names of all tables in the dataset (there are four!)
# for table in tables:  
#     print(table.table_id)

client = bigquery.Client()

# Perform a query.
QUERY = (
    'SELECT name FROM `bigquery-public-data.usa_names.usa_1910_2013` '
    'WHERE state = "TX" '
    'LIMIT 100')
query_job = client.query(QUERY)  # API request
rows = query_job.result()  # Waits for query to finish

for row in rows:
    print(row.name)