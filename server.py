from flask import Flask, request, Response
#from mushroom.model.tools.predict import predict
#import jsonpickle
import numpy as np
import cv2
import datetime
import base64
import json
import sys
sys.path.append('/root/mushroom/tf-faster-rcnn/tools')
print(sys.path)
from predict import predict

# Initialize the Flask application
app = Flask(__name__)

@app.route('/')
def connect():
    response = {'from':'35.201.9.84','connection':'true','timestamp':str(datetime.datetime.now())}
    response_json = json.dumps(response)
    return response_json



@app.route('/hello')
def hello():
    return 'Hello World!'


# route http posts to this method
@app.route('/api/test', methods=['POST'])
def test():
    r = request
    received_data = base64.b64decode(r.data)
    image = 'data/' + str(datetime.datetime.now())+'.jpg'
    f = open(image,'wb')
    f.write(received_data)
    f.close()
    # Predict the image
    boxes = []
    className, classProb, boxes = predict(image)
    print(boxes)
 
    response = {'timestamp':str(datetime.datetime.now()),'className': className, 'classProb':classProb, 'boxes':str(boxes)}
    response_json = json.dumps(response)
    return response_json   
   
# start flask app
app.run(host='0.0.0.0',port=80)
