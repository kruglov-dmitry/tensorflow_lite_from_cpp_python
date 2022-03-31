TF_SRC_PATH = $(HOME)/work/tensorflow_280/tensorflow/
#TF_LITE_BUILD_FOLDER = $(TF_SRC_PATH)/tensorflow/lite/tf_build_no_xnnpack/
TF_LITE_BUILD_FOLDER = $(TF_SRC_PATH)/tensorflow/lite/tf_build/
OPENCV_INCLUDE_PATH = $(HOME)/work/opencv_45_install/usr/local/include/opencv4/
OPENCV_LIB_PATH = $(HOME)/work/opencv_45_install/usr/local/lib/

INCLUDES = -I$(TF_SRC_PATH) \
	   -I$(TF_LITE_BUILD_FOLDER)/flatbuffers/include/ \
	   -I$(OPENCV_INCLUDE_PATH) 

LINKER_FLAGS = -L$(OPENCV_LIB_PATH) \
	       -L$(TF_LITE_BUILD_FOLDER) \
	       -L$(TF_LITE_BUILD_FOLDER)/pthreadpool/ \
	       -L$(TF_LITE_BUILD_FOLDER)_deps/flatbuffers-build/ \
	       -L$(TF_LITE_BUILD_FOLDER)_deps/ruy-build/ruy/ \
	       -L$(TF_LITE_BUILD_FOLDER)_deps/xnnpack-build/ \
	       -L$(TF_LITE_BUILD_FOLDER)_deps/cpuinfo-build/ \
	       -L$(TF_LITE_BUILD_FOLDER)_deps/clog-build/ \
	       -L$(TF_LITE_BUILD_FOLDER)_deps/farmhash-build/ \
	       -L$(TF_LITE_BUILD_FOLDER)_deps/fft2d-build/
LIBS_TO_LINK = -ldl -lpthread -ltensorflow-lite -lflatbuffers -lXNNPACK -lpthreadpool -lopencv_core -lopencv_imgproc -lopencv_imgcodecs -lruy_ctx -lruy_allocator -lruy_prepacked_cache -lruy_system_aligned_alloc -lruy_trmul -lruy_tune -lruy_cpuinfo -lcpuinfo -lclog -lruy_context_get_ctx -lruy_context -lruy_thread_pool -lruy_denormal -lruy_blocking_counter -lruy_wait -lruy_kernel_avx2_fma -lruy_have_built_path_for_avx512 -lruy_have_built_path_for_avx2_fma -lruy_have_built_path_for_avx2_fma  -lruy_frontend -lruy_trmul -lruy_prepare_packed_matrices -lruy_block_map -lruy_apply_multiplier -lruy_pack_avx512 -lruy_pack_avx2_fma -lruy_kernel_avx -lruy_kernel_avx512 -lruy_pack_avx -lruy_pack_avx2_fma -lruy_pack_avx512 -lruy_have_built_path_for_avx -lfft2d_fftsg -lfft2d_fftsg2d -lfarmhash
#LIBS_TO_LINK = -ldl -lpthread -ltensorflow-lite -lflatbuffers -lopencv_core -lopencv_imgproc -lopencv_imgcodecs -lruy_ctx -lruy_allocator -lruy_prepacked_cache -lruy_system_aligned_alloc -lruy_trmul -lruy_tune -lruy_cpuinfo -lcpuinfo -lclog -lruy_context_get_ctx -lruy_context -lruy_thread_pool -lruy_denormal -lruy_blocking_counter -lruy_wait -lruy_kernel_avx2_fma -lruy_have_built_path_for_avx512 -lruy_have_built_path_for_avx2_fma -lruy_have_built_path_for_avx2_fma  -lruy_frontend -lruy_trmul -lruy_prepare_packed_matrices -lruy_block_map -lruy_apply_multiplier -lruy_pack_avx512 -lruy_pack_avx2_fma -lruy_kernel_avx -lruy_kernel_avx512 -lruy_pack_avx -lruy_pack_avx2_fma -lruy_pack_avx512 -lruy_have_built_path_for_avx -lfft2d_fftsg -lfft2d_fftsg2d -lfarmhash

tf_load_sample: tf_load_sample.cpp
	g++ tf_load_sample.cpp -o tf_load_sample $(INCLUDES) $(LINKER_FLAGS) $(LIBS_TO_LINK)

venv:
	python3 -m venv VENV && \
	. VENV/bin/activate && \
	pip install --upgrade pip && \
	pip install wheel && \
	pip install -r requirements.txt

all: tf_load_sample
