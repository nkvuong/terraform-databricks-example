# Databricks notebook source
# created from terraform-databricks-example/aws
display(spark.range(10))

# COMMAND ----------

dbutils.fs.ls("/databricks-datasets")

# COMMAND ----------

df = spark.read.load("dbfs:/databricks-datasets/learning-spark-v2/people/people-10m.delta")
display(df)
