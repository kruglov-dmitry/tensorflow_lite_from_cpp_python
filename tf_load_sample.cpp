#include <iostream>
#include <opencv2/opencv.hpp>

#include <tensorflow/lite/interpreter.h>
#include <tensorflow/lite/kernels/register.h>
#include <tensorflow/lite/model.h>


using namespace std;
using namespace cv;

#define TFLITE_MINIMAL_CHECK(x)                              \
  if (!(x)) {                                                \
    fprintf(stderr, "Error at %s:%d\n", __FILE__, __LINE__); \
    return 1;                                                 \
  }

int main() {

    cv::Mat img = cv::imread("FER.jpg", cv::IMREAD_GRAYSCALE);

    cv::resize(img, img, {48, 48});

    // Segmentator initialization
    std::unique_ptr<tflite::FlatBufferModel> model =
            tflite::FlatBufferModel::BuildFromFile("FER.tflite");
    TFLITE_MINIMAL_CHECK(model != nullptr);
    tflite::ops::builtin::BuiltinOpResolver resolver;


    tflite::InterpreterBuilder builder(*model, resolver);
    std::unique_ptr<tflite::Interpreter> interpreter;
    builder(&interpreter);
    TFLITE_MINIMAL_CHECK(interpreter != nullptr);

    // Allocate tensor buffers.
    TFLITE_MINIMAL_CHECK(interpreter->AllocateTensors() == kTfLiteOk);
    // End of Segmentator Initialization-----------------------------

    int output_idx = interpreter->inputs()[0];
    cout<<interpreter->inputs().size()<<endl;
    //cout<<output_idx<<endl;
    float* input = interpreter->typed_input_tensor<float>(0);

    int bytes =  img.total()*img.elemSize();


    memcpy(input, img.data, bytes);
    TFLITE_MINIMAL_CHECK(interpreter->Invoke() == kTfLiteOk);

    output_idx = interpreter->outputs()[0];
    cout<<output_idx<<endl;
    float* output = interpreter->typed_output_tensor<float>(0);

    std::cout<<"Predictions: "<<std::endl;
    for (int i = 0;i < 4;i++)
        std::cout << output[i] <<", "<< std::endl;
    return 0;
}
