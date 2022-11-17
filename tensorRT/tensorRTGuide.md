
CONTENT
[basic information](#basic-information)
    [Work flow of tensorRT](#work-flow-of-tensorrt)
    [tensorrt in cpp](#tensorrt-in-cpp)
    [latency](#latency)
    [throughput](#throughput)
    [measure model's performance](#measure-models-performance)
    [techniques to increase throughput and reduce latency](#techniques-to-increase-throughput-and-reduce-latency)
[export a model from torch](#export-a-model-from-torch)
    [in C++](#in-cpp)
    [in python](#in-python)
[build engine](#build-engine)
    [build engine in c++](#build-engine-in-cpp)
    [build engine in python](#build-engine-in-python)
[runtime inference](#runtime-inference)
    [runtime in c++](#runtime-in-cpp)
    [runtime in python](#runtime-in-python)

# basic information
## Work flow of tensorRT
trained models from deep learning frameworks -> optimized engines -> deploy
OR
converting a PyTorch model into an ONNX model -> importing it into TensorRT -> applying optimizations, and generating a high-performance runtime engine -> datacenter environment.
OR
1 Convert the pretrained image segmentation PyTorch model into ONNX.
    https://docs.nvidia.com/deeplearning/tensorrt/quick-start-guide/index.html#export-from-pytorch
2 Import the ONNX model into TensorRT.
3 Apply optimizations and generate an engine.
    I. select a batch size 
        we pick a small batch size when we want to prioritize latency and a larger batch size when we want to prioritize throughput.
            A. fixed batch
            B. dynamic batch: https://docs.nvidia.com/deeplearning/tensorrt/developer-guide/index.html#work_dynamic_shapes
    II. select a precision
        https://docs.nvidia.com/deeplearning/tensorrt/developer-guide/index.html#reduced-precision
    III.convert the model
4 Perform inference on the GPU. 
    有两种转换方式：trtexec 和 TenorRT API


## TensorRT in Cpp
work flow:
1 Create the CUDA engine
    Create a network using the parser.
    Build the engine.
2 create an execution context to hold intermediate activation values generated during inference
3 transfer data and perform inference

如果一次性加载多张图片，那么就可以设置batch。命令行中对应的操作就是 给多个命令行参数。

## latency
The time elapsed between an input being presented to the network and an output being returned

## throughput
The maximum number of inferences possible per second, known as throughput, is a valuable metric for applications.


## measure model's performance
1 latency
2 throughput

## techniques to increase throughput and reduce latency
https://developer.nvidia.com/blog/speeding-up-deep-learning-inference-using-tensorrt-updated/

Here are a few common techniques: 

1 Use mixed precision computation —— 混合精度（应该是指变量的精度）
    TensorRT uses FP32 algorithms for performing inference by default.
    You can use FP16 and INT8 precision for inference
    You can also mix computations in FP32 and FP16 precision with TensorRT, referred to as mixed precision
    You can use INT8 quantized precision for weights, activations, and execute layers.
    You can use "config->setFlag(BuilderFlag::kFP16);" to specify percision
2 Change the workspace size
    通过setMaxWorkspaceSize可设置最大内存使用量
    允许的内存越大，能同时跑的 application就越多
    允许的内存太小则可能产生次优的engine
    就算你允许的内存很大，TensorRT也只会申请够用就行的内存量，不会超过允许的内存量
    可通过以下代码来设置：
    "
    // Allow TensorRT to use up to 1 GB of GPU memory for tactic selection
    constexpr size_t MAX_WORKSPACE_SIZE = 1ULL << 30; // 1 GB worked well for this example
    ...
    // Set the builder flag
    config->setMaxWorkspaceSize(MAX_WORKSPACE_SIZE); 
    "
3 Reuse the TensorRT engine
    这一点主要是说，每一次build engine都很耗时间，因此尽量减少build的次数
    engine可以被序列化和反序列化，也就是保存为文件和加载到内存。
    反序列化（加载文件）可以在运行时进行。
    TensorRT 在buil的时候会优先检测该文件是否存在，如果不存在就会build，所以有时候需要强制build
    如何强制build？
    The SimpleOnnx::buildEngine function first tries to load and use an engine if it exists. 
    If the engine is not available, it creates and saves the engine in the current directory 
    with the name unet_batch4.engine. Before this example tries to build a new engine, 
    it picks this engine if it is available in the current directory.

    To force a new engine to be built with updated configuration and parameters, 
    use the make clean_engines command to delete all existing serialized engines 
    stored on disk before re-running the code example.


# export a model from torch
## in cpp
导出模型也是使用的python脚本。


## in python
需要的东西：
训练好的模型参数、模型对象、BATCH_SIZE
使用的函数：
torch.onnx.export(resnet50, dummy_input, "resnet50_pytorch.onnx", verbose=False)
官方参考：
torch.onnx.export函数：https://pytorch.org/docs/stable/onnx.html#torch.onnx.export
案例：https://pytorch.org/docs/stable/onnx.html
最少就指定模型对象、输入、导出的模型名字就可以了。
另外还能指定：
是否打印导出的模型的信息；
导出的模型是用于训练还是推理；
是否导出模型参数；
*模型的输入参数名（仅用于可视化和提升可读性）；
*模型的输出参数名；
*选择ONNX算子版本；
是否实施constant-folding optimization；
*设置输入输出的动态维度；
*指定自定义算子；
导出模型为函数。


# build-engine
## build-engine-in-cpp
需要指定的参数：
onnx文件名、输出文件名、指定输入输出是否支持动态维度(explicitBatch)、输入输出的数据精度、
setMaxBatchSize、setMaxWorkspaceSize、OptimizationProfile

函数：
 // Declare the CUDA engine
 SampleUniquePtr<nvinfer1::ICudaEngine> mEngine{nullptr};
 ...
 // Create the CUDA engine
 mEngine = SampleUniquePtr<nvinfer1::ICudaEngine>   (builder->buildEngineWithConfig(*network, *config));

 有两种编译engine的方法：
 一种是 builder->buildEngineWithConfig(*network, *config)；
另一种是：
SampleUniquePtr<IHostMemory> plan{builder->buildSerializedNetwork(*network, *config)};
SampleUniquePtr<IRuntime> runtime{createInferRuntime(sample::gLogger.getTRTLogger())};
mEngine = std::shared_ptr<nvinfer1::ICudaEngine>(
        runtime->deserializeCudaEngine(plan->data(), plan->size()), samplesCommon::InferDeleter());

两种方式都是可以的，区别在于，第一种编译的结果是engine，第二种编译的结果是序列化的模型和engine，如果要将engine保存到文件中
的话，就需要将模型序列化。第二种方式的话，就可以直接存文件了。


## build-engine-in-python
需要指定的参数：
onnx文件名、输出文件名、指定输入输出是否支持动态维度(explicitBatch)、输入输出的数据精度

用命令行工具build engine for python：
if USE_FP16:
    !trtexec --onnx=resnet50_pytorch.onnx --saveEngine=resnet_engine_pytorch.trt  --explicitBatch --inputIOFormats=fp16:chw --outputIOFormats=fp16:chw --fp16
else:
    !trtexec --onnx=resnet50_pytorch.onnx --saveEngine=resnet_engine_pytorch.trt  --explicitBatch


# runtime-inference 
## runtime-in-cpp
加载模型-》反序列化-》推理
基本的操作：
1 加载模型
2 创建 context，保存推理的中间结果
3 为输入输出申请GPU内存
4 数据转移
5 模型推理 —— enqueueV2()
6 同步线程——等待GPU执行完毕
7 验证模型，对比部署前的推理结果


## runtime-in-python
加载模型-》模型推理-》

加载模型时需要的内容：
engine文件名

推理时需要的操作：
0 数据预处理 —— 通常是BN
1 为输入输出申请GPU内存
2 获取cuda stream
3 数据转移
4 模型推理
5 同步线程——等待GPU执行完毕
6 验证模型，对比部署前的推理结果
需要注意，如果模型的输入维度是固定的，就需要将数据整理成对应的batch size。
如果数据不够，那就复制数据。



加载engine模型的三个步骤：
    f = open("resnet_engine_pytorch.trt", "rb")
加载模型:
    runtime = trt.Runtime(trt.Logger(trt.Logger.WARNING)) 
反序列化模型:
    engine = runtime.deserialize_cuda_engine(f.read())
构建context用于运行文件:
    context = engine.create_execution_context()
注意这里可能会报错：
    Error Code 1: Serialization (Serialization assertion stdVersionRead == 
    serializationVersion failed.Version tag does not match. 
    Note: Current Version: 213, Serialized Engine Version: 205)

这其实就是生成engine的tensorrt版本和反序列化时的tensorrt版本不一致导致的。



# 代码注解


using Dims = Dims32;
//! \class Dims
//! \brief Structure to define the dimensions of a tensor.
//!        结构体，定义了维度信息tensor的维度信息:最大维度、当前tensor的维数、每个维度的长度（范围、元素个数）
class Dims32
{
public:
    //! The maximum rank (number of dimensions) supported for a tensor.
    static constexpr int32_t MAX_DIMS{8};
    //! The rank (number of dimensions).
    int32_t nbDims;
    //! The extent of each dimension.
    int32_t d[MAX_DIMS];
};




