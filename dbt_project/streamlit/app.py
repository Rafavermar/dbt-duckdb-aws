import streamlit as st
import duckdb
import pandas as pd
import matplotlib.pyplot as plt

# Conexión a la base de datos
con = duckdb.connect(database='/dbt_project/dev.duckdb', read_only=True)

# Título
st.title("Demo Streamlit - Citi Bike Trips")

# Filtro de fechas
min_date, max_date = con.execute("SELECT MIN(start_date_id), MAX(start_date_id) FROM dbt_green.fact_bike_trips").fetchone()
start_date, end_date = st.sidebar.date_input("Selecciona una fecha", [min_date, max_date])

# Consulta para filtrar los datos
query = """
SELECT 
    start_date_id, 
    COUNT(*) AS total_trips
FROM dbt_green.fact_bike_trips
WHERE start_date_id BETWEEN ? AND ?
GROUP BY start_date_id
ORDER BY start_date_id
"""
df = con.execute(query, (start_date, end_date)).df()

# Viajes totales
total_trips = df['total_trips'].sum()
st.metric("Num total de viajes", "{:,.2f}".format(total_trips))

# Gráfico de líneas con el número de viajes por día
st.subheader("Número de viajes según el día")
st.line_chart(df.set_index('start_date_id'))
