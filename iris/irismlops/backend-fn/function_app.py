import azure.functions as func
import json
import logging
from keras.models import model_from_json
import streamlit as st
import numpy as np
import requests


app = func.FunctionApp()

model = None

# Cargar el modelo
def load_trained_model():
    with open('price-house-v1.json') as json_file:
        load_model_json = json_file.read()
    model = model_from_json(load_model_json)
    model.compile(optimizer='rmsprop', metrics=['mae'])
    return model

# Cargar el modelo al inicio
model = load_trained_model()

@app.route(route="predict", auth_level=func.AuthLevel.ANONYMOUS)
def predict(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    # Obtener los parámetros de la solicitud
    try:
        crime_rate = float(req.params.get('crime_rate'))
        residential_land_zone = float(req.params.get('residential_land_zone'))
        non_retail_business_acres = float(req.params.get('non_retail_business_acres'))
        charles_river = float(req.params.get('charles_river'))
        nitric_oxide = float(req.params.get('nitric_oxide'))
        rooms_per_dwelling = float(req.params.get('rooms_per_dwelling'))
        proportion_of_business_acres = float(req.params.get('proportion_of_business_acres'))
        weight_of_the_house = float(req.params.get('weight_of_the_house'))
        access_to_highways = float(req.params.get('access_to_highways'))
        full_value = float(req.params.get('full_value'))
        pupil_teacher_ratio = float(req.params.get('pupil_teacher_ratio'))
        proportion_of_black_people = float(req.params.get('proportion_of_black_people'))
        lower_status_population = float(req.params.get('lower_status_population'))
    except ValueError:
        return func.HttpResponse(
            "Invalid input data. Please check the values provided.",
            status_code=400
        )

    # Crear el array de entrada para la predicción
    input_data = np.array([crime_rate, residential_land_zone, non_retail_business_acres, 
                           charles_river, nitric_oxide, rooms_per_dwelling, 
                           proportion_of_business_acres, weight_of_the_house, 
                           access_to_highways, full_value, pupil_teacher_ratio, 
                           proportion_of_black_people, lower_status_population]).reshape(1, 13)

    # Obtener la predicción del modelo
    price = model.predict(input_data)

    # Devolver la respuesta en formato JSON
    return func.HttpResponse(
        json.dumps({"predicted_price": str(price[0][0])}),
        mimetype="application/json",
        status_code=200
    )


    
    

    

   
