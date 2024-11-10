from flask import Flask
from keras.models import load_model
from keras.models import model_from_json
from flask import request
import numpy as np

app = Flask(__name__)
model = None
 #lets change
def load_trained_model():
    with open('price-house-v1.json') as json_file:
        load_model_json = json_file.read()
    model = model_from_json(load_model_json)
    model.compile(optimizer='rmsprop', metrics=['mae'])
    return model
#get endpoint for predict the house price
@app.route('/predict', methods=['GET'])
def predict():
    # get the data from the request reading from the URL variables
    crime_rate = float(request.args.get('crime_rate'))
    residential_land_zone = float(request.args.get('residential_land_zone'))
    non_retail_business_acres = float(request.args.get('non_retail_business_acres'))
    charles_river = float(request.args.get('charles_river'))
    nitric_oxide = float(request.args.get('nitric_oxide'))
    rooms_per_dwelling = float(request.args.get('rooms_per_dwelling'))
    proportion_of_business_acres = float(request.args.get('proportion_of_business_acres'))
    weight_of_the_house = float(request.args.get('weight_of_the_house'))
    access_to_highways = float(request.args.get('access_to_highways'))
    full_value = float(request.args.get('full_value'))
    pupil_teacher_ratio = float(request.args.get('pupil_teacher_ratio'))
    proportion_of_black_people = float(request.args.get('proportion_of_black_people'))
    lower_status_population = float(request.args.get('lower_status_population'))
 
    keras_model = load_trained_model()
    # Reshape the input and predict
    input_data = np.array([crime_rate, residential_land_zone, non_retail_business_acres, 
                           charles_river, nitric_oxide, rooms_per_dwelling, 
                           proportion_of_business_acres, weight_of_the_house, 
                           access_to_highways, full_value, pupil_teacher_ratio, 
                           proportion_of_black_people, lower_status_population]).reshape(1, 13)
    # Get the predicted price
    price = keras_model.predict(input_data)
 
    # Return the price as a string
    return str(price[0][0])
 
if __name__ == "__main__":
    load_trained_model()
    app.run(host='0.0.0.0', port=8080)
