### What is this about
Minimum example to reproduce issue when the same network at the same input produce different result
using different kind of tensorflow lite library - build with and without XNNPACK support:

```bash
cd <tensorflow_source_tree>/tensorflow/lite/
```

Case 1: build without xnnpack support
```bash
mkdir tf_build_no_xnnpack/
cd tf_build_no_xnnpack/
cmake -D TFLITE_ENABLE_XNNPACK=OFF ..
make -j 8
```

Case 2: build with xnnpack support
```bash
mkdir tf_build/
cd tf_build/
cmake ..
make -j 8
```


### Cpp
1. Edit Makefile to specify include and lib paths to include for opencv and tensorflow:
- TF_SRC_PATH
- TF_LITE_BUILD_FOLDER
- OPENCV_INCLUDE_PATH
- OPENCV_LIB_PATH

**NOTE:** list of libs for linking is different for convinience in Makefile present commented version for list of libs without XNNPACK

2. build
```bash
make tf_load_sample
```
3. run
```bash
tf_load_sample
```

### Python
1. create venv:
```bash
make venv
```
2. run python script
```bash
source VENV/bin/activate && cd python &&
python tf_load_sample.py
```

### Network and conversion
Original keras network definition in python/network.py

for conversion python interface was used:
```python
md.load_weights("FER.h5")
converter = tf.lite.TFLiteConverter.from_keras_model(md)
converter.experimental_new_converter = True
onverter.optimizations = [tf.lite.Optimize.DEFAULT]

converter.target_spec.supported_types = [tf.float32]
quantized_tflite_model = converter.convert()
open("FER.tflite", "wb").write(quantized_tflite_model)
```
