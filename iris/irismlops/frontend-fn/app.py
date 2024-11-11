import streamlit as st
import requests
import os

# Obtener la URL del servidor desde una variable de entorno
server_url = 'https://tom-dev-iris-be-function-app.calmtree-10f13164.eastus.azurecontainerapps.io'

# Definir el título de la aplicación
st.title("Modelo de Predicción de Precio de Viviendas")

# Crear controles para que el usuario seleccione los valores de las variables
crime_rate = st.slider('Tasa de criminalidad', 0.0, 1.0, 0.00632)
residential_land_zone = st.slider('Zonas residenciales (porcentaje)', 0.0, 100.0, 18.0)
non_retail_business_acres = st.slider('Zonas de negocios no minoristas (acres)', 0.0, 30.0, 2.31)
charles_river = st.selectbox('Cerca del río Charles', [0, 1])
nitric_oxide = st.slider('Concentración de óxidos nítricos', 0.0, 1.0, 0.538)
rooms_per_dwelling = st.slider('Número de habitaciones por vivienda', 1.0, 10.0, 6.575)
proportion_of_business_acres = st.slider('Proporción de negocios en la zona (%)', 0.0, 100.0, 65.2)
weight_of_the_house = st.slider('Peso de la casa', 1.0, 10.0, 4.09)
access_to_highways = st.slider('Accesos a carreteras principales', 0, 10, 1)
full_value = st.slider('Valor total de la propiedad (miles)', 50.0, 500.0, 296.0)
pupil_teacher_ratio = st.slider('Proporción alumnos/profesor', 5.0, 30.0, 15.3)
proportion_of_black_people = st.slider('Proporción de personas negras', 0.0, 500.0, 396.9)
lower_status_population = st.slider('Población de bajo estatus (%)', 0.0, 100.0, 4.98)

# Cuando se presiona el botón, enviar la solicitud al endpoint
if st.button('Predecir'):
    # Crear los parámetros para la solicitud
    params = {
        'crime_rate': crime_rate,
        'residential_land_zone': residential_land_zone,
        'non_retail_business_acres': non_retail_business_acres,
        'charles_river': charles_river,
        'nitric_oxide': nitric_oxide,
        'rooms_per_dwelling': rooms_per_dwelling,
        'proportion_of_business_acres': proportion_of_business_acres,
        'weight_of_the_house': weight_of_the_house,
        'access_to_highways': access_to_highways,
        'full_value': full_value,
        'pupil_teacher_ratio': pupil_teacher_ratio,
        'proportion_of_black_people': proportion_of_black_people,
        'lower_status_population': lower_status_population
    }

    # Hacer la llamada al endpoint
    try:
        response = requests.get(f'{server_url}/api/predict', params=params)
        if response.status_code == 200:
            prediction = response.json()
            st.success(f"El valor predicho para la vivienda es: {prediction['predicted_price']}")  
        else:
            st.error(f"Erro r en la predicción: {response.status_code} y: {server_url}/api/predict ")
    except Exception as e:
        st.error(f"No se pudo conectar con el endpoint. Error: {e}")
