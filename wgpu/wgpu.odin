package wgpu

import "core:c"

_ :: c

when ODIN_OS == .Linux {
  foreign import lib "/home/fabrice/OdinProjects/odin-wgpu/wgpu-native/target/release/libwgpu_native.a"
} else when ODIN_OS == .Darwin || ODIN_OS == .FreeBSD || ODIN_OS == .OpenBSD {
  foreign import lib "/home/fabrice/OdinProjects/odin-wgpu/wgpu-native/target/release/libwgpu_native.a"
} else when ODIN_OS == .Windows {
  foreign import lib "/home/fabrice/OdinProjects/odin-wgpu/wgpu-native/target/release/libwgpu_native.a"
}

/**
when ODIN_OS == .Linux {
  foreign import lib "wgpu_native.a"
} else when ODIN_OS == .Darwin || ODIN_OS == .FreeBSD || ODIN_OS == .OpenBSD {
  foreign import lib "wgpu_native.a"
} else when ODIN_OS == .Windows {
  foreign import lib "wgpu_native.lib"
}
*/
 

NativeSType :: enum c.int {
	// Start at 0003 since that's allocated range for wgpu-native
	SType_DeviceExtras = 196609,

	// Start at 0003 since that's allocated range for wgpu-native
	SType_NativeLimits = 196610,

	// Start at 0003 since that's allocated range for wgpu-native
	SType_PipelineLayoutExtras = 196611,

	// Start at 0003 since that's allocated range for wgpu-native
	SType_ShaderSourceGLSL = 196612,

	// Start at 0003 since that's allocated range for wgpu-native
	SType_InstanceExtras = 196614,

	// Start at 0003 since that's allocated range for wgpu-native
	SType_BindGroupEntryExtras = 196615,

	// Start at 0003 since that's allocated range for wgpu-native
	SType_BindGroupLayoutEntryExtras = 196616,

	// Start at 0003 since that's allocated range for wgpu-native
	SType_QuerySetDescriptorExtras = 196617,

	// Start at 0003 since that's allocated range for wgpu-native
	SType_SurfaceConfigurationExtras = 196618,

	// Start at 0003 since that's allocated range for wgpu-native
	SType_SurfaceSourceSwapChainPanel = 196619,

	// Start at 0003 since that's allocated range for wgpu-native
	NativeSType_Force32 = 2147483647,
}

NativeFeature :: enum c.int {
	PushConstants                                         = 196609,
	TextureAdapterSpecificFormatFeatures                  = 196610,
	MultiDrawIndirect                                     = 196611,
	MultiDrawIndirectCount                                = 196612,
	VertexWritableStorage                                 = 196613,
	TextureBindingArray                                   = 196614,
	SampledTextureAndStorageBufferArrayNonUniformIndexing = 196615,
	PipelineStatisticsQuery                               = 196616,
	StorageResourceBindingArray                           = 196617,
	PartiallyBoundBindingArray                            = 196618,
	TextureFormat16bitNorm                                = 196619,
	TextureCompressionAstcHdr                             = 196620,
	MappablePrimaryBuffers                                = 196622,
	BufferBindingArray                                    = 196623,
	UniformBufferAndStorageTextureArrayNonUniformIndexing = 196624,

	// TODO: requires wgpu.h api change
	// WGPUNativeFeature_AddressModeClampToZero = 0x00030011,
	// WGPUNativeFeature_AddressModeClampToBorder = 0x00030012,
	// WGPUNativeFeature_PolygonModeLine = 0x00030013,
	// WGPUNativeFeature_PolygonModePoint = 0x00030014,
	// WGPUNativeFeature_ConservativeRasterization = 0x00030015,
	// WGPUNativeFeature_ClearTexture = 0x00030016,
	SpirvShaderPassthrough = 196631,

	// WGPUNativeFeature_Multiview = 0x00030018,
	VertexAttribute64bit = 196633,

	// WGPUNativeFeature_Multiview = 0x00030018,
	TextureFormatNv12 = 196634,

	// WGPUNativeFeature_Multiview = 0x00030018,
	RayTracingAccelerationStructure = 196635,

	// WGPUNativeFeature_Multiview = 0x00030018,
	RayQuery = 196636,

	// WGPUNativeFeature_Multiview = 0x00030018,
	ShaderF64 = 196637,

	// WGPUNativeFeature_Multiview = 0x00030018,
	ShaderI16 = 196638,

	// WGPUNativeFeature_Multiview = 0x00030018,
	ShaderPrimitiveIndex = 196639,

	// WGPUNativeFeature_Multiview = 0x00030018,
	ShaderEarlyDepthTest = 196640,

	// WGPUNativeFeature_Multiview = 0x00030018,
	Subgroup = 196641,

	// WGPUNativeFeature_Multiview = 0x00030018,
	SubgroupVertex = 196642,

	// WGPUNativeFeature_Multiview = 0x00030018,
	SubgroupBarrier = 196643,

	// WGPUNativeFeature_Multiview = 0x00030018,
	TimestampQueryInsideEncoders = 196644,

	// WGPUNativeFeature_Multiview = 0x00030018,
	TimestampQueryInsidePasses = 196645,

	// WGPUNativeFeature_Multiview = 0x00030018,
	Force32 = 2147483647,
}

LogLevel :: enum c.int {
	Off     = 0,
	Error   = 1,
	Warn    = 2,
	Info    = 3,
	Debug   = 4,
	Trace   = 5,
	Force32 = 2147483647,
}

InstanceBackend :: Flags

InstanceFlag :: Flags

Dx12Compiler :: enum c.int {
	Undefined = 0,
	Fxc       = 1,
	Dxc       = 2,
	Force32   = 2147483647,
}

Gles3MinorVersion :: enum c.int {
	Automatic = 0,
	Version0  = 1,
	Version1  = 2,
	Version2  = 3,
	Force32   = 2147483647,
}

PipelineStatisticName :: enum c.int {
	VertexShaderInvocations   = 0,
	ClipperInvocations        = 1,
	ClipperPrimitivesOut      = 2,
	FragmentShaderInvocations = 3,
	ComputeShaderInvocations  = 4,
	Force32                   = 2147483647,
}

NativeQueryType :: enum c.int {
	PipelineStatistics = 196608,
	Force32            = 2147483647,
}

DxcMaxShaderModel :: enum c.int {
	V6_0    = 0,
	V6_1    = 1,
	V6_2    = 2,
	V6_3    = 3,
	V6_4    = 4,
	V6_5    = 5,
	V6_6    = 6,
	V6_7    = 7,
	Force32 = 2147483647,
}

GLFenceBehaviour :: enum c.int {
	Normal     = 0,
	AutoFinish = 1,
	Force32    = 2147483647,
}

InstanceExtras :: struct {
	chain:              ChainedStruct,
	backends:           InstanceBackend,
	flags:              InstanceFlag,
	dx12ShaderCompiler: Dx12Compiler,
	gles3MinorVersion:  Gles3MinorVersion,
	glFenceBehaviour:   GLFenceBehaviour,
	dxilPath:           StringView,
	dxcPath:            StringView,
	dxcMaxShaderModel:  DxcMaxShaderModel,
}

DeviceExtras :: struct {
	chain:     ChainedStruct,
	tracePath: StringView,
}

NativeLimits :: struct {
	/** This struct chain is used as mutable in some places and immutable in others. */
	chain: ChainedStructOut,
	maxPushConstantSize:   u32,
	maxNonSamplerBindings: u32,
}

PushConstantRange :: struct {
	stages: ShaderStage,
	start:  u32,
	end:    u32,
}

PipelineLayoutExtras :: struct {
	chain:                  ChainedStruct,
	pushConstantRangeCount: c.size_t,
	pushConstantRanges:     ^PushConstantRange,
}

SubmissionIndex :: u64

ShaderDefine :: struct {
	name:  StringView,
	value: StringView,
}

ShaderSourceGLSL :: struct {
	chain:       ChainedStruct,
	stage:       ShaderStage,
	code:        StringView,
	defineCount: u32,
	defines:     ^ShaderDefine,
}

ShaderModuleDescriptorSpirV :: struct {
	label:      StringView,
	sourceSize: u32,
	source:     ^u32,
}

RegistryReport :: struct {
	numAllocated:        c.size_t,
	numKeptFromUser:     c.size_t,
	numReleasedFromUser: c.size_t,
	elementSize:         c.size_t,
}

HubReport :: struct {
	adapters:         RegistryReport,
	devices:          RegistryReport,
	queues:           RegistryReport,
	pipelineLayouts:  RegistryReport,
	shaderModules:    RegistryReport,
	bindGroupLayouts: RegistryReport,
	bindGroups:       RegistryReport,
	commandBuffers:   RegistryReport,
	renderBundles:    RegistryReport,
	renderPipelines:  RegistryReport,
	computePipelines: RegistryReport,
	pipelineCaches:   RegistryReport,
	querySets:        RegistryReport,
	buffers:          RegistryReport,
	textures:         RegistryReport,
	textureViews:     RegistryReport,
	samplers:         RegistryReport,
}

GlobalReport :: struct {
	surfaces: RegistryReport,
	hub:      HubReport,
}

InstanceEnumerateAdapterOptions :: struct {
	nextInChain: ^ChainedStruct,
	backends:    InstanceBackend,
}

BindGroupEntryExtras :: struct {
	chain:            ChainedStruct,
	buffers:          ^Buffer,
	bufferCount:      c.size_t,
	samplers:         ^Sampler,
	samplerCount:     c.size_t,
	textureViews:     ^TextureView,
	textureViewCount: c.size_t,
}

BindGroupLayoutEntryExtras :: struct {
	chain: ChainedStruct,
	count: u32,
}

QuerySetDescriptorExtras :: struct {
	chain:                  ChainedStruct,
	pipelineStatistics:     ^PipelineStatisticName,
	pipelineStatisticCount: c.size_t,
}

SurfaceConfigurationExtras :: struct {
	chain:                      ChainedStruct,
	desiredMaximumFrameLatency: u32,
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make a @ref WGPUSurface wrapping a WinUI [`SwapChainPanel`](https://learn.microsoft.com/en-us/windows/windows-app-sdk/api/winrt/microsoft.ui.xaml.controls.swapchainpanel).
*/
SurfaceSourceSwapChainPanel :: struct {
	chain: ChainedStruct,

	/**
	* A pointer to the [`ISwapChainPanelNative`](https://learn.microsoft.com/en-us/windows/windows-app-sdk/api/win32/microsoft.ui.xaml.media.dxinterop/nn-microsoft-ui-xaml-media-dxinterop-iswapchainpanelnative)
	* interface of the SwapChainPanel that will be wrapped by the @ref WGPUSurface.
	*/
	panelNative: rawptr,
}

LogCallback :: proc "c" (LogLevel, StringView, rawptr)

NativeTextureFormat :: enum c.int {
	// From Features::TEXTURE_FORMAT_16BIT_NORM
	R16Unorm = 196609,

	// From Features::TEXTURE_FORMAT_16BIT_NORM
	R16Snorm = 196610,

	// From Features::TEXTURE_FORMAT_16BIT_NORM
	Rg16Unorm = 196611,

	// From Features::TEXTURE_FORMAT_16BIT_NORM
	Rg16Snorm = 196612,

	// From Features::TEXTURE_FORMAT_16BIT_NORM
	Rgba16Unorm = 196613,

	// From Features::TEXTURE_FORMAT_16BIT_NORM
	Rgba16Snorm = 196614,

	// From Features::TEXTURE_FORMAT_NV12
	NV12 = 196615,
}

@(default_calling_convention="c", link_prefix="wgpu")
foreign lib {
	GenerateReport            :: proc(instance: Instance, report: ^GlobalReport) ---
	InstanceEnumerateAdapters :: proc(instance: Instance, options: ^InstanceEnumerateAdapterOptions, adapters: ^Adapter) -> c.size_t ---
	QueueSubmitForIndex       :: proc(queue: Queue, commandCount: c.size_t, commands: ^CommandBuffer) -> SubmissionIndex ---

	// Returns true if the queue is empty, or false if there are more queue submissions still in flight.
	DevicePoll                                     :: proc(device: Device, wait: Bool, submissionIndex: ^SubmissionIndex) -> Bool ---
	DeviceCreateShaderModuleSpirV                  :: proc(device: Device, descriptor: ^ShaderModuleDescriptorSpirV) -> ShaderModule ---
	SetLogCallback                                 :: proc(callback: LogCallback, userdata: rawptr) ---
	SetLogLevel                                    :: proc(level: LogLevel) ---
	GetVersion                                     :: proc() -> u32 ---
	RenderPassEncoderSetPushConstants              :: proc(encoder: RenderPassEncoder, stages: ShaderStage, offset: u32, sizeBytes: u32, data: rawptr) ---
	ComputePassEncoderSetPushConstants             :: proc(encoder: ComputePassEncoder, offset: u32, sizeBytes: u32, data: rawptr) ---
	RenderBundleEncoderSetPushConstants            :: proc(encoder: RenderBundleEncoder, stages: ShaderStage, offset: u32, sizeBytes: u32, data: rawptr) ---
	RenderPassEncoderMultiDrawIndirect             :: proc(encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count: u32) ---
	RenderPassEncoderMultiDrawIndexedIndirect      :: proc(encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count: u32) ---
	RenderPassEncoderMultiDrawIndirectCount        :: proc(encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count_buffer: Buffer, count_buffer_offset: u64, max_count: u32) ---
	RenderPassEncoderMultiDrawIndexedIndirectCount :: proc(encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count_buffer: Buffer, count_buffer_offset: u64, max_count: u32) ---
	ComputePassEncoderBeginPipelineStatisticsQuery :: proc(computePassEncoder: ComputePassEncoder, querySet: QuerySet, queryIndex: u32) ---
	ComputePassEncoderEndPipelineStatisticsQuery   :: proc(computePassEncoder: ComputePassEncoder) ---
	RenderPassEncoderBeginPipelineStatisticsQuery  :: proc(renderPassEncoder: RenderPassEncoder, querySet: QuerySet, queryIndex: u32) ---
	RenderPassEncoderEndPipelineStatisticsQuery    :: proc(renderPassEncoder: RenderPassEncoder) ---
	ComputePassEncoderWriteTimestamp               :: proc(computePassEncoder: ComputePassEncoder, querySet: QuerySet, queryIndex: u32) ---
	RenderPassEncoderWriteTimestamp                :: proc(renderPassEncoder: RenderPassEncoder, querySet: QuerySet, queryIndex: u32) ---
}
