import numpy as np
import tensorflow as tf
import cv2

predictor = tf.lite.Interpreter("../FER.tflite")
predictor.allocate_tensors()
input_details = predictor.get_input_details()
output_details = predictor.get_output_details()

gray = cv2.imread("../FER.jpg", cv2.IMREAD_GRAYSCALE)
input_img = np.expand_dims(np.expand_dims(cv2.resize(gray, (48, 48)), -1), 0)

predictor.set_tensor(input_details[0]["index"], input_img.astype("float32"))
predictor.invoke()

output_data = predictor.get_tensor(output_details[0]["index"])
print(output_data)
