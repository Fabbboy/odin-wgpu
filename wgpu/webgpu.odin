/**
* Copyright 2019-2023 WebGPU-Native developers
*
* SPDX-License-Identifier: BSD-3-Clause
*/
/** @file */
/**
* \mainpage
*
* **Important:** *This documentation is a Work In Progress.*
*
* This is the home of WebGPU C API specification. We define here the standard
* `webgpu.h` header that all implementations should provide.
*/
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
 

/**
 * \defgroup Constants
 * \brief Constants.
 *
 * @{
 */
// WGPU_ARRAY_LAYER_COUNT_UNDEFINED :: UINT32_MAX
// WGPU_COPY_STRIDE_UNDEFINED :: UINT32_MAX
// WGPU_DEPTH_SLICE_UNDEFINED :: UINT32_MAX
// WGPU_LIMIT_U32_UNDEFINED :: UINT32_MAX
// WGPU_LIMIT_U64_UNDEFINED :: UINT64_MAX
// WGPU_MIP_LEVEL_COUNT_UNDEFINED :: UINT32_MAX
// WGPU_QUERY_SET_INDEX_UNDEFINED :: UINT32_MAX
// WGPU_WHOLE_MAP_SIZE :: SIZE_MAX
// WGPU_WHOLE_SIZE :: UINT64_MAX

/**
* \defgroup UtilityTypes Utility Types
*
* @{
*/
Flags :: u64

Bool :: u32

/**
* Nullable value defining a pointer+length view into a UTF-8 encoded string.
*
* Values passed into the API may use the special length value @ref WGPU_STRLEN
* to indicate a null-terminated string.
* Non-null values passed out of the API (for example as callback arguments)
* always provide an explicit length and **may or may not be null-terminated**.
*
* Some inputs to the API accept null values. Those which do not accept null
* values "default" to the empty string when null values are passed.
*
* Values are encoded as follows:
* - `{NULL, WGPU_STRLEN}`: the null value.
* - `{non_null_pointer, WGPU_STRLEN}`: a null-terminated string view.
* - `{any, 0}`: the empty string.
* - `{NULL, non_zero_length}`: not allowed (null dereference).
* - `{non_null_pointer, non_zero_length}`: an explictly-sized string view with
*   size `non_zero_length` (in bytes).
*
* For info on how this is used in various places, see \ref Strings.
*/
StringView :: struct {
	data:   cstring,
	length: c.size_t,
}

/**
 * Sentinel value used in @ref WGPUStringView to indicate that the pointer
 * is to a null-terminated string, rather than an explicitly-sized string.
 */
// WGPU_STRLEN :: SIZE_MAX

// WGPU_STRING_VIEW_INIT :: (WGPUStringView) { NULL wgpu_COMMA STRLEN wgpu_COMMA } /*.data=*/NULL _wgpu_COMMA /*.length=*/WGPU_STRLEN _wgpu_COMMA })

AdapterImpl :: struct {}

/**
* \defgroup Objects
* \brief Opaque, non-dispatchable handles to WebGPU objects.
*
* @{
*/
Adapter :: ^AdapterImpl

BindGroupImpl :: struct {}

BindGroup :: ^BindGroupImpl

BindGroupLayoutImpl :: struct {}

BindGroupLayout :: ^BindGroupLayoutImpl

BufferImpl :: struct {}

Buffer :: ^BufferImpl

CommandBufferImpl :: struct {}

CommandBuffer :: ^CommandBufferImpl

CommandEncoderImpl :: struct {}

CommandEncoder :: ^CommandEncoderImpl

ComputePassEncoderImpl :: struct {}

ComputePassEncoder :: ^ComputePassEncoderImpl

ComputePipelineImpl :: struct {}

ComputePipeline :: ^ComputePipelineImpl

DeviceImpl :: struct {}

Device :: ^DeviceImpl

InstanceImpl :: struct {}

Instance :: ^InstanceImpl

PipelineLayoutImpl :: struct {}

PipelineLayout :: ^PipelineLayoutImpl

QuerySetImpl :: struct {}

QuerySet :: ^QuerySetImpl

QueueImpl :: struct {}

Queue :: ^QueueImpl

RenderBundleImpl :: struct {}

RenderBundle :: ^RenderBundleImpl

RenderBundleEncoderImpl :: struct {}

RenderBundleEncoder :: ^RenderBundleEncoderImpl

RenderPassEncoderImpl :: struct {}

RenderPassEncoder :: ^RenderPassEncoderImpl

RenderPipelineImpl :: struct {}

RenderPipeline :: ^RenderPipelineImpl

SamplerImpl :: struct {}

Sampler :: ^SamplerImpl

ShaderModuleImpl :: struct {}

ShaderModule :: ^ShaderModuleImpl

SurfaceImpl :: struct {}

/**
* An object used to continuously present image data to the user, see @ref Surfaces for more details.
*/
Surface :: ^SurfaceImpl

TextureImpl :: struct {}

Texture :: ^TextureImpl

TextureViewImpl :: struct {}

TextureView :: ^TextureViewImpl

/**
* \defgroup Enumerations
* \brief Enums.
*
* @{
*/
AdapterType :: enum c.int {
	DiscreteGPU   = 1,
	IntegratedGPU = 2,
	CPU           = 3,
	Unknown       = 4,
	Force32       = 2147483647,
}

AddressMode :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ClampToEdge = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Repeat = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	MirrorRepeat = 3,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

BackendType :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Null = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	WebGPU = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	D3D11 = 3,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	D3D12 = 4,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Metal = 5,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Vulkan = 6,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	OpenGL = 7,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	OpenGLES = 8,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

BlendFactor :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Zero = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	One = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Src = 3,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	OneMinusSrc = 4,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	SrcAlpha = 5,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	OneMinusSrcAlpha = 6,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Dst = 7,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	OneMinusDst = 8,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	DstAlpha = 9,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	OneMinusDstAlpha = 10,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	SrcAlphaSaturated = 11,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Constant = 12,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	OneMinusConstant = 13,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Src1 = 14,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	OneMinusSrc1 = 15,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Src1Alpha = 16,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	OneMinusSrc1Alpha = 17,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

BlendOperation :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Add = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Subtract = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ReverseSubtract = 3,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Min = 4,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Max = 5,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

BufferBindingType :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates that this @ref WGPUBufferBindingLayout member of
	* its parent @ref WGPUBindGroupLayoutEntry is not used.
	* (See also @ref SentinelValues.)
	*/
	BindingNotUsed = 0,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 1,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Uniform = 2,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Storage = 3,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ReadOnlyStorage = 4,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

BufferMapState :: enum c.int {
	Unmapped = 1,
	Pending  = 2,
	Mapped   = 3,
	Force32  = 2147483647,
}

/**
* The callback mode controls how a callback for an asynchronous operation may be fired. See @ref Asynchronous-Operations for how these are used.
*/
CallbackMode :: enum c.int {
	/**
	* `0x00000001`.
	* Callbacks created with `WGPUCallbackMode_WaitAnyOnly`:
	* - fire when the asynchronous operation's future is passed to a call to `::wgpuInstanceWaitAny`
	*   AND the operation has already completed or it completes inside the call to `::wgpuInstanceWaitAny`.
	*/
	WaitAnyOnly = 1,

	/**
	* `0x00000002`.
	* Callbacks created with `WGPUCallbackMode_AllowProcessEvents`:
	* - fire for the same reasons as callbacks created with `WGPUCallbackMode_WaitAnyOnly`
	* - fire inside a call to `::wgpuInstanceProcessEvents` if the asynchronous operation is complete.
	*/
	AllowProcessEvents = 2,

	/**
	* `0x00000003`.
	* Callbacks created with `WGPUCallbackMode_AllowSpontaneous`:
	* - fire for the same reasons as callbacks created with `WGPUCallbackMode_AllowProcessEvents`
	* - **may** fire spontaneously on an arbitrary or application thread, when the WebGPU implementations discovers that the asynchronous operation is complete.
	*
	*   Implementations _should_ fire spontaneous callbacks as soon as possible.
	*
	* @note Because spontaneous callbacks may fire at an arbitrary time on an arbitrary thread, applications should take extra care when acquiring locks or mutating state inside the callback. It undefined behavior to re-entrantly call into the webgpu.h API if the callback fires while inside the callstack of another webgpu.h function that is not `wgpuInstanceWaitAny` or `wgpuInstanceProcessEvents`.
	*/
	AllowSpontaneous = 3,

	/**
	* `0x00000003`.
	* Callbacks created with `WGPUCallbackMode_AllowSpontaneous`:
	* - fire for the same reasons as callbacks created with `WGPUCallbackMode_AllowProcessEvents`
	* - **may** fire spontaneously on an arbitrary or application thread, when the WebGPU implementations discovers that the asynchronous operation is complete.
	*
	*   Implementations _should_ fire spontaneous callbacks as soon as possible.
	*
	* @note Because spontaneous callbacks may fire at an arbitrary time on an arbitrary thread, applications should take extra care when acquiring locks or mutating state inside the callback. It undefined behavior to re-entrantly call into the webgpu.h API if the callback fires while inside the callstack of another webgpu.h function that is not `wgpuInstanceWaitAny` or `wgpuInstanceProcessEvents`.
	*/
	Force32 = 2147483647,
}

CompareFunction :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Never = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Less = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Equal = 3,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	LessEqual = 4,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Greater = 5,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	NotEqual = 6,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	GreaterEqual = 7,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Always = 8,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

CompilationInfoRequestStatus :: enum c.int {
	Success         = 1,
	InstanceDropped = 2,
	Error           = 3,
	Unknown         = 4,
	Force32         = 2147483647,
}

CompilationMessageType :: enum c.int {
	Error   = 1,
	Warning = 2,
	Info    = 3,
	Force32 = 2147483647,
}

/**
* Describes how frames are composited with other contents on the screen when `::wgpuSurfacePresent` is called.
*/
CompositeAlphaMode :: enum c.int {
	/**
	* `0x00000000`.
	* Lets the WebGPU implementation choose the best mode (supported, and with the best performance) between @ref WGPUCompositeAlphaMode_Opaque or @ref WGPUCompositeAlphaMode_Inherit.
	*/
	Auto = 0,

	/**
	* `0x00000001`.
	* The alpha component of the image is ignored and teated as if it is always 1.0.
	*/
	Opaque = 1,

	/**
	* `0x00000002`.
	* The alpha component is respected and non-alpha components are assumed to be already multiplied with the alpha component. For example, (0.5, 0, 0, 0.5) is semi-transparent bright red.
	*/
	Premultiplied = 2,

	/**
	* `0x00000003`.
	* The alpha component is respected and non-alpha components are assumed to NOT be already multiplied with the alpha component. For example, (1.0, 0, 0, 0.5) is semi-transparent bright red.
	*/
	Unpremultiplied = 3,

	/**
	* `0x00000004`.
	* The handling of the alpha component is unknown to WebGPU and should be handled by the application using system-specific APIs. This mode may be unavailable (for example on Wasm).
	*/
	Inherit = 4,

	/**
	* `0x00000004`.
	* The handling of the alpha component is unknown to WebGPU and should be handled by the application using system-specific APIs. This mode may be unavailable (for example on Wasm).
	*/
	Force32 = 2147483647,
}

CreatePipelineAsyncStatus :: enum c.int {
	Success         = 1,
	InstanceDropped = 2,
	ValidationError = 3,
	InternalError   = 4,
	Unknown         = 5,
	Force32         = 2147483647,
}

CullMode :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	None = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Front = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Back = 3,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

DeviceLostReason :: enum c.int {
	Unknown         = 1,
	Destroyed       = 2,
	InstanceDropped = 3,
	FailedCreation  = 4,
	Force32         = 2147483647,
}

ErrorFilter :: enum c.int {
	Validation  = 1,
	OutOfMemory = 2,
	Internal    = 3,
	Force32     = 2147483647,
}

ErrorType :: enum c.int {
	NoError     = 1,
	Validation  = 2,
	OutOfMemory = 3,
	Internal    = 4,
	Unknown     = 5,
	Force32     = 2147483647,
}

/**
* See @ref WGPURequestAdapterOptions::featureLevel.
*/
FeatureLevel :: enum c.int {
	/**
	* `0x00000001`.
	* "Compatibility" profile which can be supported on OpenGL ES 3.1.
	*/
	Compatibility = 1,

	/**
	* `0x00000002`.
	* "Core" profile which can be supported on Vulkan/Metal/D3D12.
	*/
	Core = 2,

	/**
	* `0x00000002`.
	* "Core" profile which can be supported on Vulkan/Metal/D3D12.
	*/
	Force32 = 2147483647,
}

FeatureName :: enum c.int {
	Undefined                      = 0,
	DepthClipControl               = 1,
	Depth32FloatStencil8           = 2,
	TimestampQuery                 = 3,
	TextureCompressionBC           = 4,
	TextureCompressionBCSliced3D   = 5,
	TextureCompressionETC2         = 6,
	TextureCompressionASTC         = 7,
	TextureCompressionASTCSliced3D = 8,
	IndirectFirstInstance          = 9,
	ShaderF16                      = 10,
	RG11B10UfloatRenderable        = 11,
	BGRA8UnormStorage              = 12,
	Float32Filterable              = 13,
	Float32Blendable               = 14,
	ClipDistances                  = 15,
	DualSourceBlending             = 16,
	Force32                        = 2147483647,
}

FilterMode :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Nearest = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Linear = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

FrontFace :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	CCW = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	CW = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

IndexFormat :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Uint16 = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Uint32 = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

LoadOp :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Load = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Clear = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

MapAsyncStatus :: enum c.int {
	Success         = 1,
	InstanceDropped = 2,
	Error           = 3,
	Aborted         = 4,
	Unknown         = 5,
	Force32         = 2147483647,
}

MipmapFilterMode :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Nearest = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Linear = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

OptionalBool :: enum c.int {
	False     = 0,
	True      = 1,
	Undefined = 2,
	Force32   = 2147483647,
}

PopErrorScopeStatus :: enum c.int {
	/**
	* `0x00000001`.
	* The error scope stack was successfully popped and a result was reported.
	*/
	Success = 1,

	/**
	* `0x00000001`.
	* The error scope stack was successfully popped and a result was reported.
	*/
	InstanceDropped = 2,

	/**
	* `0x00000003`.
	* The error scope stack could not be popped, because it was empty.
	*/
	EmptyStack = 3,

	/**
	* `0x00000003`.
	* The error scope stack could not be popped, because it was empty.
	*/
	Force32 = 2147483647,
}

PowerPreference :: enum c.int {
	/**
	* `0x00000000`.
	* No preference. (See also @ref SentinelValues.)
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* No preference. (See also @ref SentinelValues.)
	*/
	LowPower = 1,

	/**
	* `0x00000000`.
	* No preference. (See also @ref SentinelValues.)
	*/
	HighPerformance = 2,

	/**
	* `0x00000000`.
	* No preference. (See also @ref SentinelValues.)
	*/
	Force32 = 2147483647,
}

/**
* Describes when and in which order frames are presented on the screen when `::wgpuSurfacePresent` is called.
*/
PresentMode :: enum c.int {
	/**
	* `0x00000000`.
	* Present mode is not specified. Use the default.
	*/
	Undefined = 0,

	/**
	* `0x00000001`.
	* The presentation of the image to the user waits for the next vertical blanking period to update in a first-in, first-out manner.
	* Tearing cannot be observed and frame-loop will be limited to the display's refresh rate.
	* This is the only mode that's always available.
	*/
	Fifo = 1,

	/**
	* `0x00000002`.
	* The presentation of the image to the user tries to wait for the next vertical blanking period but may decide to not wait if a frame is presented late.
	* Tearing can sometimes be observed but late-frame don't produce a full-frame stutter in the presentation.
	* This is still a first-in, first-out mechanism so a frame-loop will be limited to the display's refresh rate.
	*/
	FifoRelaxed = 2,

	/**
	* `0x00000003`.
	* The presentation of the image to the user is updated immediately without waiting for a vertical blank.
	* Tearing can be observed but latency is minimized.
	*/
	Immediate = 3,

	/**
	* `0x00000004`.
	* The presentation of the image to the user waits for the next vertical blanking period to update to the latest provided image.
	* Tearing cannot be observed and a frame-loop is not limited to the display's refresh rate.
	*/
	Mailbox = 4,

	/**
	* `0x00000004`.
	* The presentation of the image to the user waits for the next vertical blanking period to update to the latest provided image.
	* Tearing cannot be observed and a frame-loop is not limited to the display's refresh rate.
	*/
	Force32 = 2147483647,
}

PrimitiveTopology :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	PointList = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	LineList = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	LineStrip = 3,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	TriangleList = 4,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	TriangleStrip = 5,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

QueryType :: enum c.int {
	Occlusion = 1,
	Timestamp = 2,
	Force32   = 2147483647,
}

QueueWorkDoneStatus :: enum c.int {
	Success         = 1,
	InstanceDropped = 2,
	Error           = 3,
	Unknown         = 4,
	Force32         = 2147483647,
}

RequestAdapterStatus :: enum c.int {
	Success         = 1,
	InstanceDropped = 2,
	Unavailable     = 3,
	Error           = 4,
	Unknown         = 5,
	Force32         = 2147483647,
}

RequestDeviceStatus :: enum c.int {
	Success         = 1,
	InstanceDropped = 2,
	Error           = 3,
	Unknown         = 4,
	Force32         = 2147483647,
}

SType :: enum c.int {
	ShaderSourceSPIRV                = 1,
	ShaderSourceWGSL                 = 2,
	RenderPassMaxDrawCount           = 3,
	SurfaceSourceMetalLayer          = 4,
	SurfaceSourceWindowsHWND         = 5,
	SurfaceSourceXlibWindow          = 6,
	SurfaceSourceWaylandSurface      = 7,
	SurfaceSourceAndroidNativeWindow = 8,
	SurfaceSourceXCBWindow           = 9,
	Force32                          = 2147483647,
}

SamplerBindingType :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates that this @ref WGPUSamplerBindingLayout member of
	* its parent @ref WGPUBindGroupLayoutEntry is not used.
	* (See also @ref SentinelValues.)
	*/
	BindingNotUsed = 0,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 1,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Filtering = 2,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	NonFiltering = 3,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Comparison = 4,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

/**
* Status code returned (synchronously) from many operations. Generally
* indicates an invalid input like an unknown enum value or @ref OutStructChainError.
* Read the function's documentation for specific error conditions.
*/
Status :: enum c.int {
	Success = 1,
	Error   = 2,
	Force32 = 2147483647,
}

StencilOperation :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Keep = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Zero = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Replace = 3,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Invert = 4,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	IncrementClamp = 5,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	DecrementClamp = 6,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	IncrementWrap = 7,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	DecrementWrap = 8,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

StorageTextureAccess :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates that this @ref WGPUStorageTextureBindingLayout member of
	* its parent @ref WGPUBindGroupLayoutEntry is not used.
	* (See also @ref SentinelValues.)
	*/
	BindingNotUsed = 0,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 1,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	WriteOnly = 2,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ReadOnly = 3,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ReadWrite = 4,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

StoreOp :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Store = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Discard = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

/**
* The status enum for `::wgpuSurfaceGetCurrentTexture`.
*/
SurfaceGetCurrentTextureStatus :: enum c.int {
	/**
	* `0x00000001`.
	* Yay! Everything is good and we can render this frame.
	*/
	SuccessOptimal = 1,

	/**
	* `0x00000002`.
	* Still OK - the surface can present the frame, but in a suboptimal way. The surface may need reconfiguration.
	*/
	SuccessSuboptimal = 2,

	/**
	* `0x00000003`.
	* Some operation timed out while trying to acquire the frame.
	*/
	Timeout = 3,

	/**
	* `0x00000004`.
	* The surface is too different to be used, compared to when it was originally created.
	*/
	Outdated = 4,

	/**
	* `0x00000005`.
	* The connection to whatever owns the surface was lost.
	*/
	Lost = 5,

	/**
	* `0x00000006`.
	* The system ran out of memory.
	*/
	OutOfMemory = 6,

	/**
	* `0x00000007`.
	* The @ref WGPUDevice configured on the @ref WGPUSurface was lost.
	*/
	DeviceLost = 7,

	/**
	* `0x00000008`.
	* The surface is not configured, or there was an @ref OutStructChainError.
	*/
	Error = 8,

	/**
	* `0x00000008`.
	* The surface is not configured, or there was an @ref OutStructChainError.
	*/
	Force32 = 2147483647,
}

TextureAspect :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	All = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	StencilOnly = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	DepthOnly = 3,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

TextureDimension :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	_1D = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	_2D = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	_3D = 3,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

TextureFormat :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	R8Unorm = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	R8Snorm = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	R8Uint = 3,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	R8Sint = 4,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	R16Uint = 5,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	R16Sint = 6,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	R16Float = 7,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RG8Unorm = 8,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RG8Snorm = 9,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RG8Uint = 10,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RG8Sint = 11,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	R32Float = 12,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	R32Uint = 13,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	R32Sint = 14,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RG16Uint = 15,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RG16Sint = 16,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RG16Float = 17,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGBA8Unorm = 18,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGBA8UnormSrgb = 19,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGBA8Snorm = 20,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGBA8Uint = 21,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGBA8Sint = 22,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BGRA8Unorm = 23,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BGRA8UnormSrgb = 24,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGB10A2Uint = 25,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGB10A2Unorm = 26,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RG11B10Ufloat = 27,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGB9E5Ufloat = 28,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RG32Float = 29,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RG32Uint = 30,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RG32Sint = 31,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGBA16Uint = 32,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGBA16Sint = 33,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGBA16Float = 34,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGBA32Float = 35,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGBA32Uint = 36,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	RGBA32Sint = 37,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Stencil8 = 38,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Depth16Unorm = 39,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Depth24Plus = 40,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Depth24PlusStencil8 = 41,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Depth32Float = 42,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Depth32FloatStencil8 = 43,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC1RGBAUnorm = 44,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC1RGBAUnormSrgb = 45,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC2RGBAUnorm = 46,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC2RGBAUnormSrgb = 47,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC3RGBAUnorm = 48,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC3RGBAUnormSrgb = 49,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC4RUnorm = 50,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC4RSnorm = 51,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC5RGUnorm = 52,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC5RGSnorm = 53,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC6HRGBUfloat = 54,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC6HRGBFloat = 55,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC7RGBAUnorm = 56,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	BC7RGBAUnormSrgb = 57,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ETC2RGB8Unorm = 58,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ETC2RGB8UnormSrgb = 59,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ETC2RGB8A1Unorm = 60,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ETC2RGB8A1UnormSrgb = 61,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ETC2RGBA8Unorm = 62,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ETC2RGBA8UnormSrgb = 63,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	EACR11Unorm = 64,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	EACR11Snorm = 65,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	EACRG11Unorm = 66,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	EACRG11Snorm = 67,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC4x4Unorm = 68,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC4x4UnormSrgb = 69,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC5x4Unorm = 70,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC5x4UnormSrgb = 71,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC5x5Unorm = 72,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC5x5UnormSrgb = 73,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC6x5Unorm = 74,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC6x5UnormSrgb = 75,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC6x6Unorm = 76,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC6x6UnormSrgb = 77,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC8x5Unorm = 78,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC8x5UnormSrgb = 79,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC8x6Unorm = 80,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC8x6UnormSrgb = 81,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC8x8Unorm = 82,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC8x8UnormSrgb = 83,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC10x5Unorm = 84,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC10x5UnormSrgb = 85,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC10x6Unorm = 86,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC10x6UnormSrgb = 87,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC10x8Unorm = 88,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC10x8UnormSrgb = 89,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC10x10Unorm = 90,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC10x10UnormSrgb = 91,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC12x10Unorm = 92,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC12x10UnormSrgb = 93,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC12x12Unorm = 94,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	ASTC12x12UnormSrgb = 95,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

TextureSampleType :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates that this @ref WGPUTextureBindingLayout member of
	* its parent @ref WGPUBindGroupLayoutEntry is not used.
	* (See also @ref SentinelValues.)
	*/
	BindingNotUsed = 0,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 1,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Float = 2,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	UnfilterableFloat = 3,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Depth = 4,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Sint = 5,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Uint = 6,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

TextureViewDimension :: enum c.int {
	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 0,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	_1D = 1,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	_2D = 2,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	_2DArray = 3,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Cube = 4,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	CubeArray = 5,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	_3D = 6,

	/**
	* `0x00000000`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

VertexFormat :: enum c.int {
	Uint8           = 1,
	Uint8x2         = 2,
	Uint8x4         = 3,
	Sint8           = 4,
	Sint8x2         = 5,
	Sint8x4         = 6,
	Unorm8          = 7,
	Unorm8x2        = 8,
	Unorm8x4        = 9,
	Snorm8          = 10,
	Snorm8x2        = 11,
	Snorm8x4        = 12,
	Uint16          = 13,
	Uint16x2        = 14,
	Uint16x4        = 15,
	Sint16          = 16,
	Sint16x2        = 17,
	Sint16x4        = 18,
	Unorm16         = 19,
	Unorm16x2       = 20,
	Unorm16x4       = 21,
	Snorm16         = 22,
	Snorm16x2       = 23,
	Snorm16x4       = 24,
	Float16         = 25,
	Float16x2       = 26,
	Float16x4       = 27,
	Float32         = 28,
	Float32x2       = 29,
	Float32x3       = 30,
	Float32x4       = 31,
	Uint32          = 32,
	Uint32x2        = 33,
	Uint32x3        = 34,
	Uint32x4        = 35,
	Sint32          = 36,
	Sint32x2        = 37,
	Sint32x3        = 38,
	Sint32x4        = 39,
	Unorm10_10_10_2 = 40,
	Unorm8x4BGRA    = 41,
	Force32         = 2147483647,
}

VertexStepMode :: enum c.int {
	/**
	* `0x00000000`.
	* This @ref WGPUVertexBufferLayout is a "hole" in the @ref WGPUVertexState `buffers` array.
	* (See also @ref SentinelValues.)
	*/
	VertexBufferNotUsed = 0,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Undefined = 1,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Vertex = 2,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Instance = 3,

	/**
	* `0x00000001`.
	* Indicates no value is passed for this argument. See @ref SentinelValues.
	*/
	Force32 = 2147483647,
}

WGSLLanguageFeatureName :: enum c.int {
	ReadonlyAndReadwriteStorageTextures = 1,
	Packed4x8IntegerDotProduct          = 2,
	UnrestrictedPointerParameters       = 3,
	PointerCompositeAccess              = 4,
	Force32                             = 2147483647,
}

/**
* Status returned from a call to ::wgpuInstanceWaitAny.
*/
WaitStatus :: enum c.int {
	/**
	* `0x00000001`.
	* At least one WGPUFuture completed successfully.
	*/
	Success = 1,

	/**
	* `0x00000002`.
	* No WGPUFutures completed within the timeout.
	*/
	TimedOut = 2,

	/**
	* `0x00000003`.
	* A @ref Timed-Wait was performed when WGPUInstanceFeatures::timedWaitAnyEnable is false.
	*/
	UnsupportedTimeout = 3,

	/**
	* `0x00000004`.
	* The number of futures waited on in a @ref Timed-Wait is greater than the supported WGPUInstanceFeatures::timedWaitAnyMaxCount.
	*/
	UnsupportedCount = 4,

	/**
	* `0x00000005`.
	* An invalid wait was performed with @ref Mixed-Sources.
	*/
	UnsupportedMixedSources = 5,

	/**
	* `0x00000005`.
	* An invalid wait was performed with @ref Mixed-Sources.
	*/
	Force32 = 2147483647,
}

/**
* \defgroup Bitflags
* \brief Type and constant definitions for bitflag types.
*
* @{
*/
BufferUsage :: Flags

ColorWriteMask :: Flags

MapMode :: Flags

ShaderStage :: Flags

TextureUsage :: Flags

/** @} */
Proc :: proc "c" ()

/**
* \defgroup Callbacks
* \brief Callbacks through which asynchronous functions return.
*
* @{
*/
/**
* @param message
* This parameter is @ref PassedWithoutOwnership.
*/
BufferMapCallback :: proc "c" (MapAsyncStatus, StringView, rawptr, rawptr)

/**
* @param compilationInfo
* This parameter is @ref PassedWithoutOwnership.
*/
CompilationInfoCallback :: proc "c" (CompilationInfoRequestStatus, ^CompilationInfo, rawptr, rawptr)

/**
* @param pipeline
* This parameter is @ref PassedWithOwnership.
*/
CreateComputePipelineAsyncCallback :: proc "c" (CreatePipelineAsyncStatus, ComputePipeline, StringView, rawptr, rawptr)

/**
* @param pipeline
* This parameter is @ref PassedWithOwnership.
*/
CreateRenderPipelineAsyncCallback :: proc "c" (CreatePipelineAsyncStatus, RenderPipeline, StringView, rawptr, rawptr)

/**
* @param device
* Reference to the device which was lost. If, and only if, the `reason` is @ref WGPUDeviceLostReason_FailedCreation, this is a non-null pointer to a null @ref WGPUDevice.
* This parameter is @ref PassedWithoutOwnership.
*
* @param message
* This parameter is @ref PassedWithoutOwnership.
*/
DeviceLostCallback :: proc "c" (^Device, DeviceLostReason, StringView, rawptr, rawptr)

/**
* @param status
* See @ref WGPUPopErrorScopeStatus.
*
* @param type
* The type of the error caught by the scope, or @ref WGPUErrorType_NoError if there was none.
* If the `status` is not @ref WGPUPopErrorScopeStatus_Success, this is @ref WGPUErrorType_NoError.
*
* @param message
* If the `type` is not @ref WGPUErrorType_NoError, this is a non-empty @ref LocalizableHumanReadableMessageString;
* otherwise, this is an empty string.
* This parameter is @ref PassedWithoutOwnership.
*/
PopErrorScopeCallback :: proc "c" (PopErrorScopeStatus, ErrorType, StringView, rawptr, rawptr)

QueueWorkDoneCallback :: proc "c" (QueueWorkDoneStatus, rawptr, rawptr)

/**
* @param adapter
* This parameter is @ref PassedWithOwnership.
*
* @param message
* This parameter is @ref PassedWithoutOwnership.
*/
RequestAdapterCallback :: proc "c" (RequestAdapterStatus, Adapter, StringView, rawptr, rawptr)

/**
* @param device
* This parameter is @ref PassedWithOwnership.
*
* @param message
* This parameter is @ref PassedWithoutOwnership.
*/
RequestDeviceCallback :: proc "c" (RequestDeviceStatus, Device, StringView, rawptr, rawptr)

/**
* @param device
* This parameter is @ref PassedWithoutOwnership.
*
* @param message
* This parameter is @ref PassedWithoutOwnership.
*/
UncapturedErrorCallback :: proc "c" (^Device, ErrorType, StringView, rawptr, rawptr)

/** @} */
/**
* \defgroup ChainedStructures Chained Structures
* \brief Structures used to extend descriptors.
*
* @{
*/
ChainedStruct :: struct {
	next:  ^ChainedStruct,
	sType: SType,
}

ChainedStructOut :: struct {
	next:  ^ChainedStructOut,
	sType: SType,
}

/**
* \defgroup WGPUCallbackInfo
* \brief Callback info structures that are used in asynchronous functions.
*
* @{
*/
BufferMapCallbackInfo :: struct {
	nextInChain: ^ChainedStruct,
	mode:        CallbackMode,
	callback:    BufferMapCallback,
	userdata1:   rawptr,
	userdata2:   rawptr,
}

CompilationInfoCallbackInfo :: struct {
	nextInChain: ^ChainedStruct,
	mode:        CallbackMode,
	callback:    CompilationInfoCallback,
	userdata1:   rawptr,
	userdata2:   rawptr,
}

CreateComputePipelineAsyncCallbackInfo :: struct {
	nextInChain: ^ChainedStruct,
	mode:        CallbackMode,
	callback:    CreateComputePipelineAsyncCallback,
	userdata1:   rawptr,
	userdata2:   rawptr,
}

CreateRenderPipelineAsyncCallbackInfo :: struct {
	nextInChain: ^ChainedStruct,
	mode:        CallbackMode,
	callback:    CreateRenderPipelineAsyncCallback,
	userdata1:   rawptr,
	userdata2:   rawptr,
}

DeviceLostCallbackInfo :: struct {
	nextInChain: ^ChainedStruct,
	mode:        CallbackMode,
	callback:    DeviceLostCallback,
	userdata1:   rawptr,
	userdata2:   rawptr,
}

PopErrorScopeCallbackInfo :: struct {
	nextInChain: ^ChainedStruct,
	mode:        CallbackMode,
	callback:    PopErrorScopeCallback,
	userdata1:   rawptr,
	userdata2:   rawptr,
}

QueueWorkDoneCallbackInfo :: struct {
	nextInChain: ^ChainedStruct,
	mode:        CallbackMode,
	callback:    QueueWorkDoneCallback,
	userdata1:   rawptr,
	userdata2:   rawptr,
}

RequestAdapterCallbackInfo :: struct {
	nextInChain: ^ChainedStruct,
	mode:        CallbackMode,
	callback:    RequestAdapterCallback,
	userdata1:   rawptr,
	userdata2:   rawptr,
}

RequestDeviceCallbackInfo :: struct {
	nextInChain: ^ChainedStruct,
	mode:        CallbackMode,
	callback:    RequestDeviceCallback,
	userdata1:   rawptr,
	userdata2:   rawptr,
}

UncapturedErrorCallbackInfo :: struct {
	nextInChain: ^ChainedStruct,
	callback:    UncapturedErrorCallback,
	userdata1:   rawptr,
	userdata2:   rawptr,
}

/** @} */
AdapterInfo :: struct {
	nextInChain: ^ChainedStructOut,

	/**
	* This is an \ref OutputString.
	*/
	vendor: StringView,

	/**
	* This is an \ref OutputString.
	*/
	architecture: StringView,

	/**
	* This is an \ref OutputString.
	*/
	device: StringView,

	/**
	* This is an \ref OutputString.
	*/
	description: StringView,
	backendType: BackendType,
	adapterType: AdapterType,
	vendorID:    u32,
	deviceID:    u32,
}

BindGroupEntry :: struct {
	nextInChain: ^ChainedStruct,
	binding:     u32,
	buffer:      Buffer,
	offset:      u64,
	size:        u64,
	sampler:     Sampler,
	textureView: TextureView,
}

BlendComponent :: struct {
	operation: BlendOperation,
	srcFactor: BlendFactor,
	dstFactor: BlendFactor,
}

BufferBindingLayout :: struct {
	nextInChain:      ^ChainedStruct,
	type:             BufferBindingType,
	hasDynamicOffset: Bool,
	minBindingSize:   u64,
}

BufferDescriptor :: struct {
	nextInChain:      ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	usage:            BufferUsage,
	size:             u64,
	mappedAtCreation: Bool,
}

Color :: struct {
	r: f64,
	g: f64,
	b: f64,
	a: f64,
}

CommandBufferDescriptor :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
}

CommandEncoderDescriptor :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
}

CompilationMessage :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* A @ref LocalizableHumanReadableMessageString.
	*
	* This is an \ref OutputString.
	*/
	message: StringView,

	/**
	* Severity level of the message.
	*/
	type: CompilationMessageType,

	/**
	* Line number where the message is attached, starting at 1.
	*/
	lineNum: u64,

	/**
	* Offset in UTF-8 code units (bytes) from the beginning of the line, starting at 1.
	*/
	linePos: u64,

	/**
	* Offset in UTF-8 code units (bytes) from the beginning of the shader code, starting at 0.
	*/
	offset: u64,

	/**
	* Length in UTF-8 code units (bytes) of the span the message corresponds to.
	*/
	length: u64,
}

ComputePassTimestampWrites :: struct {
	querySet:                  QuerySet,
	beginningOfPassWriteIndex: u32,
	endOfPassWriteIndex:       u32,
}

ConstantEntry :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	key: StringView,
	value:       f64,
}

Extent3D :: struct {
	width:              u32,
	height:             u32,
	depthOrArrayLayers: u32,
}

/**
* Opaque handle to an asynchronous operation. See @ref Asynchronous-Operations for more information.
*/
Future :: struct {
	/**
	* Opaque id of the @ref WGPUFuture
	*/
	id: u64,
}

/**
* Features enabled on the WGPUInstance
*/
InstanceCapabilities :: struct {
	/** This struct chain is used as mutable in some places and immutable in others. */
	nextInChain: ^ChainedStructOut,

	/**
	* Enable use of ::wgpuInstanceWaitAny with `timeoutNS > 0`.
	*/
	timedWaitAnyEnable: Bool,

	/**
	* The maximum number @ref WGPUFutureWaitInfo supported in a call to ::wgpuInstanceWaitAny with `timeoutNS > 0`.
	*/
	timedWaitAnyMaxCount: c.size_t,
}

Limits :: struct {
	/** This struct chain is used as mutable in some places and immutable in others. */
	nextInChain: ^ChainedStructOut,
	maxTextureDimension1D:                     u32,
	maxTextureDimension2D:                     u32,
	maxTextureDimension3D:                     u32,
	maxTextureArrayLayers:                     u32,
	maxBindGroups:                             u32,
	maxBindGroupsPlusVertexBuffers:            u32,
	maxBindingsPerBindGroup:                   u32,
	maxDynamicUniformBuffersPerPipelineLayout: u32,
	maxDynamicStorageBuffersPerPipelineLayout: u32,
	maxSampledTexturesPerShaderStage:          u32,
	maxSamplersPerShaderStage:                 u32,
	maxStorageBuffersPerShaderStage:           u32,
	maxStorageTexturesPerShaderStage:          u32,
	maxUniformBuffersPerShaderStage:           u32,
	maxUniformBufferBindingSize:               u64,
	maxStorageBufferBindingSize:               u64,
	minUniformBufferOffsetAlignment:           u32,
	minStorageBufferOffsetAlignment:           u32,
	maxVertexBuffers:                          u32,
	maxBufferSize:                             u64,
	maxVertexAttributes:                       u32,
	maxVertexBufferArrayStride:                u32,
	maxInterStageShaderVariables:              u32,
	maxColorAttachments:                       u32,
	maxColorAttachmentBytesPerSample:          u32,
	maxComputeWorkgroupStorageSize:            u32,
	maxComputeInvocationsPerWorkgroup:         u32,
	maxComputeWorkgroupSizeX:                  u32,
	maxComputeWorkgroupSizeY:                  u32,
	maxComputeWorkgroupSizeZ:                  u32,
	maxComputeWorkgroupsPerDimension:          u32,
}

MultisampleState :: struct {
	nextInChain:            ^ChainedStruct,
	count:                  u32,
	mask:                   u32,
	alphaToCoverageEnabled: Bool,
}

Origin3D :: struct {
	x: u32,
	y: u32,
	z: u32,
}

PipelineLayoutDescriptor :: struct {
	nextInChain:          ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	bindGroupLayoutCount: c.size_t,
	bindGroupLayouts:     ^BindGroupLayout,
}

PrimitiveState :: struct {
	nextInChain:      ^ChainedStruct,
	topology:         PrimitiveTopology,
	stripIndexFormat: IndexFormat,
	frontFace:        FrontFace,
	cullMode:         CullMode,
	unclippedDepth:   Bool,
}

QuerySetDescriptor :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	type:        QueryType,
	count:       u32,
}

QueueDescriptor :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
}

RenderBundleDescriptor :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
}

RenderBundleEncoderDescriptor :: struct {
	nextInChain:        ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	colorFormatCount:   c.size_t,
	colorFormats:       ^TextureFormat,
	depthStencilFormat: TextureFormat,
	sampleCount:        u32,
	depthReadOnly:      Bool,
	stencilReadOnly:    Bool,
}

RenderPassDepthStencilAttachment :: struct {
	view:              TextureView,
	depthLoadOp:       LoadOp,
	depthStoreOp:      StoreOp,
	depthClearValue:   f32,
	depthReadOnly:     Bool,
	stencilLoadOp:     LoadOp,
	stencilStoreOp:    StoreOp,
	stencilClearValue: u32,
	stencilReadOnly:   Bool,
}

RenderPassMaxDrawCount :: struct {
	chain:        ChainedStruct,
	maxDrawCount: u64,
}

RenderPassTimestampWrites :: struct {
	querySet:                  QuerySet,
	beginningOfPassWriteIndex: u32,
	endOfPassWriteIndex:       u32,
}

RequestAdapterOptions :: struct {
	nextInChain:     ^ChainedStruct,

	/**
	* "Feature level" for the adapter request. If an adapter is returned, it must support the features and limits in the requested feature level.
	*
	* Implementations may ignore @ref WGPUFeatureLevel_Compatibility and provide @ref WGPUFeatureLevel_Core instead. @ref WGPUFeatureLevel_Core is the default in the JS API, but in C, this field is **required** (must not be undefined).
	*/
	featureLevel: FeatureLevel,
	powerPreference: PowerPreference,

	/**
	* If true, requires the adapter to be a "fallback" adapter as defined by the JS spec.
	* If this is not possible, the request returns null.
	*/
	forceFallbackAdapter: Bool,

	/**
	* If set, requires the adapter to have a particular backend type.
	* If this is not possible, the request returns null.
	*/
	backendType: BackendType,

	/**
	* If set, requires the adapter to be able to output to a particular surface.
	* If this is not possible, the request returns null.
	*/
	compatibleSurface: Surface,
}

SamplerBindingLayout :: struct {
	nextInChain: ^ChainedStruct,
	type:        SamplerBindingType,
}

SamplerDescriptor :: struct {
	nextInChain:   ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	addressModeU:  AddressMode,
	addressModeV:  AddressMode,
	addressModeW:  AddressMode,
	magFilter:     FilterMode,
	minFilter:     FilterMode,
	mipmapFilter:  MipmapFilterMode,
	lodMinClamp:   f32,
	lodMaxClamp:   f32,
	compare:       CompareFunction,
	maxAnisotropy: u16,
}

ShaderModuleDescriptor :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
}

ShaderSourceSPIRV :: struct {
	chain:    ChainedStruct,
	codeSize: u32,
	code:     ^u32,
}

ShaderSourceWGSL :: struct {
	chain: ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	code: StringView,
}

StencilFaceState :: struct {
	compare:     CompareFunction,
	failOp:      StencilOperation,
	depthFailOp: StencilOperation,
	passOp:      StencilOperation,
}

StorageTextureBindingLayout :: struct {
	nextInChain:   ^ChainedStruct,
	access:        StorageTextureAccess,
	format:        TextureFormat,
	viewDimension: TextureViewDimension,
}

SupportedFeatures :: struct {
	featureCount: c.size_t,
	features:     ^FeatureName,
}

SupportedWGSLLanguageFeatures :: struct {
	featureCount: c.size_t,
	features:     ^WGSLLanguageFeatureName,
}

/**
* Filled by `::wgpuSurfaceGetCapabilities` with what's supported for `::wgpuSurfaceConfigure` for a pair of @ref WGPUSurface and @ref WGPUAdapter.
*/
SurfaceCapabilities :: struct {
	nextInChain:  ^ChainedStructOut,

	/**
	* The bit set of supported @ref WGPUTextureUsage bits.
	* Guaranteed to contain @ref WGPUTextureUsage_RenderAttachment.
	*/
	usages: TextureUsage,

	/**
	* A list of supported @ref WGPUTextureFormat values, in order of preference.
	*/
	formatCount: c.size_t,
	formats:      ^TextureFormat,

	/**
	* A list of supported @ref WGPUPresentMode values.
	* Guaranteed to contain @ref WGPUPresentMode_Fifo.
	*/
	presentModeCount: c.size_t,
	presentModes: ^PresentMode,

	/**
	* A list of supported @ref WGPUCompositeAlphaMode values.
	* @ref WGPUCompositeAlphaMode_Auto will be an alias for the first element and will never be present in this array.
	*/
	alphaModeCount: c.size_t,
	alphaModes:   ^CompositeAlphaMode,
}

/**
* Options to `::wgpuSurfaceConfigure` for defining how a @ref WGPUSurface will be rendered to and presented to the user.
* See @ref Surface-Configuration for more details.
*/
SurfaceConfiguration :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* The @ref WGPUDevice to use to render to surface's textures.
	*/
	device: Device,

	/**
	* The @ref WGPUTextureFormat of the surface's textures.
	*/
	format: TextureFormat,

	/**
	* The @ref WGPUTextureUsage of the surface's textures.
	*/
	usage: TextureUsage,

	/**
	* The width of the surface's textures.
	*/
	width: u32,

	/**
	* The height of the surface's textures.
	*/
	height: u32,

	/**
	* The additional @ref WGPUTextureFormat for @ref WGPUTextureView format reinterpretation of the surface's textures.
	*/
	viewFormatCount: c.size_t,
	viewFormats: ^TextureFormat,

	/**
	* How the surface's frames will be composited on the screen.
	*/
	alphaMode: CompositeAlphaMode,

	/**
	* When and in which order the surface's frames will be shown on the screen. Defaults to @ref WGPUPresentMode_Fifo.
	*/
	presentMode: PresentMode,
}

/**
* The root descriptor for the creation of an @ref WGPUSurface with `::wgpuInstanceCreateSurface`.
* It isn't sufficient by itself and must have one of the `WGPUSurfaceSource*` in its chain.
* See @ref Surface-Creation for more details.
*/
SurfaceDescriptor :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* Label used to refer to the object.
	*
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping an Android [`ANativeWindow`](https://developer.android.com/ndk/reference/group/a-native-window).
*/
SurfaceSourceAndroidNativeWindow :: struct {
	chain: ChainedStruct,

	/**
	* The pointer to the [`ANativeWindow`](https://developer.android.com/ndk/reference/group/a-native-window) that will be wrapped by the @ref WGPUSurface.
	*/
	window: rawptr,
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping a [`CAMetalLayer`](https://developer.apple.com/documentation/quartzcore/cametallayer?language=objc).
*/
SurfaceSourceMetalLayer :: struct {
	chain: ChainedStruct,

	/**
	* The pointer to the [`CAMetalLayer`](https://developer.apple.com/documentation/quartzcore/cametallayer?language=objc) that will be wrapped by the @ref WGPUSurface.
	*/
	layer: rawptr,
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping a [Wayland](https://wayland.freedesktop.org/) [`wl_surface`](https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_surface).
*/
SurfaceSourceWaylandSurface :: struct {
	chain: ChainedStruct,

	/**
	* A [`wl_display`](https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_display) for this Wayland instance.
	*/
	display: rawptr,

	/**
	* A [`wl_surface`](https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_surface) that will be wrapped by the @ref WGPUSurface
	*/
	surface: rawptr,
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping a Windows [`HWND`](https://learn.microsoft.com/en-us/windows/apps/develop/ui-input/retrieve-hwnd).
*/
SurfaceSourceWindowsHWND :: struct {
	chain: ChainedStruct,

	/**
	* The [`HINSTANCE`](https://learn.microsoft.com/en-us/windows/win32/learnwin32/winmain--the-application-entry-point) for this application.
	* Most commonly `GetModuleHandle(nullptr)`.
	*/
	hinstance: rawptr,

	/**
	* The [`HWND`](https://learn.microsoft.com/en-us/windows/apps/develop/ui-input/retrieve-hwnd) that will be wrapped by the @ref WGPUSurface.
	*/
	hwnd: rawptr,
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping an [XCB](https://xcb.freedesktop.org/) `xcb_window_t`.
*/
SurfaceSourceXCBWindow :: struct {
	chain: ChainedStruct,

	/**
	* The `xcb_connection_t` for the connection to the X server.
	*/
	connection: rawptr,

	/**
	* The `xcb_window_t` for the window that will be wrapped by the @ref WGPUSurface.
	*/
	window: u32,
}

/**
* Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping an [Xlib](https://www.x.org/releases/current/doc/libX11/libX11/libX11.html) `Window`.
*/
SurfaceSourceXlibWindow :: struct {
	chain: ChainedStruct,

	/**
	* A pointer to the [`Display`](https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Opening_the_Display) connected to the X server.
	*/
	display: rawptr,

	/**
	* The [`Window`](https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Creating_Windows) that will be wrapped by the @ref WGPUSurface.
	*/
	window: u64,
}

/**
* Queried each frame from a @ref WGPUSurface to get a @ref WGPUTexture to render to along with some metadata.
* See @ref Surface-Presenting for more details.
*/
SurfaceTexture :: struct {
	nextInChain: ^ChainedStructOut,

	/**
	* The @ref WGPUTexture representing the frame that will be shown on the surface.
	* It is @ref ReturnedWithOwnership from @ref wgpuSurfaceGetCurrentTexture.
	*/
	texture: Texture,

	/**
	* Whether the call to `::wgpuSurfaceGetCurrentTexture` succeeded and a hint as to why it might not have.
	*/
	status: SurfaceGetCurrentTextureStatus,
}

TexelCopyBufferLayout :: struct {
	offset:       u64,
	bytesPerRow:  u32,
	rowsPerImage: u32,
}

TextureBindingLayout :: struct {
	nextInChain:   ^ChainedStruct,
	sampleType:    TextureSampleType,
	viewDimension: TextureViewDimension,
	multisampled:  Bool,
}

TextureViewDescriptor :: struct {
	nextInChain:     ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	format:          TextureFormat,
	dimension:       TextureViewDimension,
	baseMipLevel:    u32,
	mipLevelCount:   u32,
	baseArrayLayer:  u32,
	arrayLayerCount: u32,
	aspect:          TextureAspect,
	usage:           TextureUsage,
}

VertexAttribute :: struct {
	format:         VertexFormat,
	offset:         u64,
	shaderLocation: u32,
}

BindGroupDescriptor :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	layout:      BindGroupLayout,
	entryCount:  c.size_t,
	entries:     ^BindGroupEntry,
}

BindGroupLayoutEntry :: struct {
	nextInChain:    ^ChainedStruct,
	binding:        u32,
	visibility:     ShaderStage,
	buffer:         BufferBindingLayout,
	sampler:        SamplerBindingLayout,
	texture:        TextureBindingLayout,
	storageTexture: StorageTextureBindingLayout,
}

BlendState :: struct {
	color: BlendComponent,
	alpha: BlendComponent,
}

CompilationInfo :: struct {
	nextInChain:  ^ChainedStruct,
	messageCount: c.size_t,
	messages:     ^CompilationMessage,
}

ComputePassDescriptor :: struct {
	nextInChain:     ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	timestampWrites: ^ComputePassTimestampWrites,
}

DepthStencilState :: struct {
	nextInChain:         ^ChainedStruct,
	format:              TextureFormat,
	depthWriteEnabled:   OptionalBool,
	depthCompare:        CompareFunction,
	stencilFront:        StencilFaceState,
	stencilBack:         StencilFaceState,
	stencilReadMask:     u32,
	stencilWriteMask:    u32,
	depthBias:           i32,
	depthBiasSlopeScale: f32,
	depthBiasClamp:      f32,
}

DeviceDescriptor :: struct {
	nextInChain:                 ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	requiredFeatureCount:        c.size_t,
	requiredFeatures:            ^FeatureName,
	requiredLimits:              ^Limits,
	defaultQueue:                QueueDescriptor,
	deviceLostCallbackInfo:      DeviceLostCallbackInfo,
	uncapturedErrorCallbackInfo: UncapturedErrorCallbackInfo,
}

/**
* Struct holding a future to wait on, and a `completed` boolean flag.
*/
FutureWaitInfo :: struct {
	/**
	* The future to wait on.
	*/
	future: Future,

	/**
	* Whether or not the future completed.
	*/
	completed: Bool,
}

InstanceDescriptor :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* Instance features to enable
	*/
	features: InstanceCapabilities,
}

ProgrammableStageDescriptor :: struct {
	nextInChain:   ^ChainedStruct,
	module:        ShaderModule,

	/**
	* This is a \ref NullableInputString.
	*/
	entryPoint: StringView,
	constantCount: c.size_t,
	constants:     ^ConstantEntry,
}

RenderPassColorAttachment :: struct {
	nextInChain:   ^ChainedStruct,
	view:          TextureView,
	depthSlice:    u32,
	resolveTarget: TextureView,
	loadOp:        LoadOp,
	storeOp:       StoreOp,
	clearValue:    Color,
}

TexelCopyBufferInfo :: struct {
	layout: TexelCopyBufferLayout,
	buffer: Buffer,
}

TexelCopyTextureInfo :: struct {
	texture:  Texture,
	mipLevel: u32,
	origin:   Origin3D,
	aspect:   TextureAspect,
}

TextureDescriptor :: struct {
	nextInChain:     ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	usage:           TextureUsage,
	dimension:       TextureDimension,
	size:            Extent3D,
	format:          TextureFormat,
	mipLevelCount:   u32,
	sampleCount:     u32,
	viewFormatCount: c.size_t,
	viewFormats:     ^TextureFormat,
}

VertexBufferLayout :: struct {
	/**
	* The step mode for the vertex buffer. If @ref WGPUVertexStepMode_VertexBufferNotUsed,
	* indicates a "hole" in the parent @ref WGPUVertexState `buffers` array:
	* the pipeline does not use a vertex buffer at this `location`.
	*/
	stepMode: VertexStepMode,
	arrayStride:    u64,
	attributeCount: c.size_t,
	attributes:     ^VertexAttribute,
}

BindGroupLayoutDescriptor :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	entryCount:  c.size_t,
	entries:     ^BindGroupLayoutEntry,
}

ColorTargetState :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* The texture format of the target. If @ref WGPUTextureFormat_Undefined,
	* indicates a "hole" in the parent @ref WGPUFragmentState `targets` array:
	* the pipeline does not output a value at this `location`.
	*/
	format: TextureFormat,
	blend:       ^BlendState,
	writeMask:   ColorWriteMask,
}

ComputePipelineDescriptor :: struct {
	nextInChain: ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	layout:      PipelineLayout,
	compute:     ProgrammableStageDescriptor,
}

RenderPassDescriptor :: struct {
	nextInChain:            ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	colorAttachmentCount:   c.size_t,
	colorAttachments:       ^RenderPassColorAttachment,
	depthStencilAttachment: ^RenderPassDepthStencilAttachment,
	occlusionQuerySet:      QuerySet,
	timestampWrites:        ^RenderPassTimestampWrites,
}

VertexState :: struct {
	nextInChain:   ^ChainedStruct,
	module:        ShaderModule,

	/**
	* This is a \ref NullableInputString.
	*/
	entryPoint: StringView,
	constantCount: c.size_t,
	constants:     ^ConstantEntry,
	bufferCount:   c.size_t,
	buffers:       ^VertexBufferLayout,
}

FragmentState :: struct {
	nextInChain:   ^ChainedStruct,
	module:        ShaderModule,

	/**
	* This is a \ref NullableInputString.
	*/
	entryPoint: StringView,
	constantCount: c.size_t,
	constants:     ^ConstantEntry,
	targetCount:   c.size_t,
	targets:       ^ColorTargetState,
}

RenderPipelineDescriptor :: struct {
	nextInChain:  ^ChainedStruct,

	/**
	* This is a \ref NonNullInputString.
	*/
	label: StringView,
	layout:       PipelineLayout,
	vertex:       VertexState,
	primitive:    PrimitiveState,
	depthStencil: ^DepthStencilState,
	multisample:  MultisampleState,
	fragment:     ^FragmentState,
}

/**
* Proc pointer type for @ref wgpuCreateInstance:
* > @copydoc wgpuCreateInstance
*/
ProcCreateInstance :: proc "c" (^InstanceDescriptor) -> Instance

/**
* Proc pointer type for @ref wgpuGetInstanceCapabilities:
* > @copydoc wgpuGetInstanceCapabilities
*/
ProcGetInstanceCapabilities :: proc "c" (^InstanceCapabilities) -> Status

/**
* Proc pointer type for @ref wgpuGetProcAddress:
* > @copydoc wgpuGetProcAddress
*/
ProcGetProcAddress :: proc "c" (StringView) -> Proc

// Procs of Adapter
/**
* Proc pointer type for @ref wgpuAdapterGetFeatures:
* > @copydoc wgpuAdapterGetFeatures
*/
ProcAdapterGetFeatures :: proc "c" (Adapter, ^SupportedFeatures)

/**
* Proc pointer type for @ref wgpuAdapterGetInfo:
* > @copydoc wgpuAdapterGetInfo
*/
ProcAdapterGetInfo :: proc "c" (Adapter, ^AdapterInfo) -> Status

/**
* Proc pointer type for @ref wgpuAdapterGetLimits:
* > @copydoc wgpuAdapterGetLimits
*/
ProcAdapterGetLimits :: proc "c" (Adapter, ^Limits) -> Status

/**
* Proc pointer type for @ref wgpuAdapterHasFeature:
* > @copydoc wgpuAdapterHasFeature
*/
ProcAdapterHasFeature :: proc "c" (Adapter, FeatureName) -> Bool

/**
* Proc pointer type for @ref wgpuAdapterRequestDevice:
* > @copydoc wgpuAdapterRequestDevice
*/
ProcAdapterRequestDevice :: proc "c" (Adapter, ^DeviceDescriptor, RequestDeviceCallbackInfo) -> Future

/**
* Proc pointer type for @ref wgpuAdapterAddRef.
* > @copydoc wgpuAdapterAddRef
*/
ProcAdapterAddRef :: proc "c" (Adapter)

/**
* Proc pointer type for @ref wgpuAdapterRelease.
* > @copydoc wgpuAdapterRelease
*/
ProcAdapterRelease :: proc "c" (Adapter)

// Procs of AdapterInfo
/**
* Proc pointer type for @ref wgpuAdapterInfoFreeMembers:
* > @copydoc wgpuAdapterInfoFreeMembers
*/
ProcAdapterInfoFreeMembers :: proc "c" (AdapterInfo)

// Procs of BindGroup
/**
* Proc pointer type for @ref wgpuBindGroupSetLabel:
* > @copydoc wgpuBindGroupSetLabel
*/
ProcBindGroupSetLabel :: proc "c" (BindGroup, StringView)

/**
* Proc pointer type for @ref wgpuBindGroupAddRef.
* > @copydoc wgpuBindGroupAddRef
*/
ProcBindGroupAddRef :: proc "c" (BindGroup)

/**
* Proc pointer type for @ref wgpuBindGroupRelease.
* > @copydoc wgpuBindGroupRelease
*/
ProcBindGroupRelease :: proc "c" (BindGroup)

// Procs of BindGroupLayout
/**
* Proc pointer type for @ref wgpuBindGroupLayoutSetLabel:
* > @copydoc wgpuBindGroupLayoutSetLabel
*/
ProcBindGroupLayoutSetLabel :: proc "c" (BindGroupLayout, StringView)

/**
* Proc pointer type for @ref wgpuBindGroupLayoutAddRef.
* > @copydoc wgpuBindGroupLayoutAddRef
*/
ProcBindGroupLayoutAddRef :: proc "c" (BindGroupLayout)

/**
* Proc pointer type for @ref wgpuBindGroupLayoutRelease.
* > @copydoc wgpuBindGroupLayoutRelease
*/
ProcBindGroupLayoutRelease :: proc "c" (BindGroupLayout)

// Procs of Buffer
/**
* Proc pointer type for @ref wgpuBufferDestroy:
* > @copydoc wgpuBufferDestroy
*/
ProcBufferDestroy :: proc "c" (Buffer)

/**
* Proc pointer type for @ref wgpuBufferGetConstMappedRange:
* > @copydoc wgpuBufferGetConstMappedRange
*/
ProcBufferGetConstMappedRange :: proc "c" (Buffer, c.size_t, c.size_t) -> rawptr

/**
* Proc pointer type for @ref wgpuBufferGetMapState:
* > @copydoc wgpuBufferGetMapState
*/
ProcBufferGetMapState :: proc "c" (Buffer) -> BufferMapState

/**
* Proc pointer type for @ref wgpuBufferGetMappedRange:
* > @copydoc wgpuBufferGetMappedRange
*/
ProcBufferGetMappedRange :: proc "c" (Buffer, c.size_t, c.size_t) -> rawptr

/**
* Proc pointer type for @ref wgpuBufferGetSize:
* > @copydoc wgpuBufferGetSize
*/
ProcBufferGetSize :: proc "c" (Buffer) -> u64

/**
* Proc pointer type for @ref wgpuBufferGetUsage:
* > @copydoc wgpuBufferGetUsage
*/
ProcBufferGetUsage :: proc "c" (Buffer) -> BufferUsage

/**
* Proc pointer type for @ref wgpuBufferMapAsync:
* > @copydoc wgpuBufferMapAsync
*/
ProcBufferMapAsync :: proc "c" (Buffer, MapMode, c.size_t, c.size_t, BufferMapCallbackInfo) -> Future

/**
* Proc pointer type for @ref wgpuBufferSetLabel:
* > @copydoc wgpuBufferSetLabel
*/
ProcBufferSetLabel :: proc "c" (Buffer, StringView)

/**
* Proc pointer type for @ref wgpuBufferUnmap:
* > @copydoc wgpuBufferUnmap
*/
ProcBufferUnmap :: proc "c" (Buffer)

/**
* Proc pointer type for @ref wgpuBufferAddRef.
* > @copydoc wgpuBufferAddRef
*/
ProcBufferAddRef :: proc "c" (Buffer)

/**
* Proc pointer type for @ref wgpuBufferRelease.
* > @copydoc wgpuBufferRelease
*/
ProcBufferRelease :: proc "c" (Buffer)

// Procs of CommandBuffer
/**
* Proc pointer type for @ref wgpuCommandBufferSetLabel:
* > @copydoc wgpuCommandBufferSetLabel
*/
ProcCommandBufferSetLabel :: proc "c" (CommandBuffer, StringView)

/**
* Proc pointer type for @ref wgpuCommandBufferAddRef.
* > @copydoc wgpuCommandBufferAddRef
*/
ProcCommandBufferAddRef :: proc "c" (CommandBuffer)

/**
* Proc pointer type for @ref wgpuCommandBufferRelease.
* > @copydoc wgpuCommandBufferRelease
*/
ProcCommandBufferRelease :: proc "c" (CommandBuffer)

// Procs of CommandEncoder
/**
* Proc pointer type for @ref wgpuCommandEncoderBeginComputePass:
* > @copydoc wgpuCommandEncoderBeginComputePass
*/
ProcCommandEncoderBeginComputePass :: proc "c" (CommandEncoder, ^ComputePassDescriptor) -> ComputePassEncoder

/**
* Proc pointer type for @ref wgpuCommandEncoderBeginRenderPass:
* > @copydoc wgpuCommandEncoderBeginRenderPass
*/
ProcCommandEncoderBeginRenderPass :: proc "c" (CommandEncoder, ^RenderPassDescriptor) -> RenderPassEncoder

/**
* Proc pointer type for @ref wgpuCommandEncoderClearBuffer:
* > @copydoc wgpuCommandEncoderClearBuffer
*/
ProcCommandEncoderClearBuffer :: proc "c" (CommandEncoder, Buffer, u64, u64)

/**
* Proc pointer type for @ref wgpuCommandEncoderCopyBufferToBuffer:
* > @copydoc wgpuCommandEncoderCopyBufferToBuffer
*/
ProcCommandEncoderCopyBufferToBuffer :: proc "c" (CommandEncoder, Buffer, u64, Buffer, u64, u64)

/**
* Proc pointer type for @ref wgpuCommandEncoderCopyBufferToTexture:
* > @copydoc wgpuCommandEncoderCopyBufferToTexture
*/
ProcCommandEncoderCopyBufferToTexture :: proc "c" (CommandEncoder, ^TexelCopyBufferInfo, ^TexelCopyTextureInfo, ^Extent3D)

/**
* Proc pointer type for @ref wgpuCommandEncoderCopyTextureToBuffer:
* > @copydoc wgpuCommandEncoderCopyTextureToBuffer
*/
ProcCommandEncoderCopyTextureToBuffer :: proc "c" (CommandEncoder, ^TexelCopyTextureInfo, ^TexelCopyBufferInfo, ^Extent3D)

/**
* Proc pointer type for @ref wgpuCommandEncoderCopyTextureToTexture:
* > @copydoc wgpuCommandEncoderCopyTextureToTexture
*/
ProcCommandEncoderCopyTextureToTexture :: proc "c" (CommandEncoder, ^TexelCopyTextureInfo, ^TexelCopyTextureInfo, ^Extent3D)

/**
* Proc pointer type for @ref wgpuCommandEncoderFinish:
* > @copydoc wgpuCommandEncoderFinish
*/
ProcCommandEncoderFinish :: proc "c" (CommandEncoder, ^CommandBufferDescriptor) -> CommandBuffer

/**
* Proc pointer type for @ref wgpuCommandEncoderInsertDebugMarker:
* > @copydoc wgpuCommandEncoderInsertDebugMarker
*/
ProcCommandEncoderInsertDebugMarker :: proc "c" (CommandEncoder, StringView)

/**
* Proc pointer type for @ref wgpuCommandEncoderPopDebugGroup:
* > @copydoc wgpuCommandEncoderPopDebugGroup
*/
ProcCommandEncoderPopDebugGroup :: proc "c" (CommandEncoder)

/**
* Proc pointer type for @ref wgpuCommandEncoderPushDebugGroup:
* > @copydoc wgpuCommandEncoderPushDebugGroup
*/
ProcCommandEncoderPushDebugGroup :: proc "c" (CommandEncoder, StringView)

/**
* Proc pointer type for @ref wgpuCommandEncoderResolveQuerySet:
* > @copydoc wgpuCommandEncoderResolveQuerySet
*/
ProcCommandEncoderResolveQuerySet :: proc "c" (CommandEncoder, QuerySet, u32, u32, Buffer, u64)

/**
* Proc pointer type for @ref wgpuCommandEncoderSetLabel:
* > @copydoc wgpuCommandEncoderSetLabel
*/
ProcCommandEncoderSetLabel :: proc "c" (CommandEncoder, StringView)

/**
* Proc pointer type for @ref wgpuCommandEncoderWriteTimestamp:
* > @copydoc wgpuCommandEncoderWriteTimestamp
*/
ProcCommandEncoderWriteTimestamp :: proc "c" (CommandEncoder, QuerySet, u32)

/**
* Proc pointer type for @ref wgpuCommandEncoderAddRef.
* > @copydoc wgpuCommandEncoderAddRef
*/
ProcCommandEncoderAddRef :: proc "c" (CommandEncoder)

/**
* Proc pointer type for @ref wgpuCommandEncoderRelease.
* > @copydoc wgpuCommandEncoderRelease
*/
ProcCommandEncoderRelease :: proc "c" (CommandEncoder)

// Procs of ComputePassEncoder
/**
* Proc pointer type for @ref wgpuComputePassEncoderDispatchWorkgroups:
* > @copydoc wgpuComputePassEncoderDispatchWorkgroups
*/
ProcComputePassEncoderDispatchWorkgroups :: proc "c" (ComputePassEncoder, u32, u32, u32)

/**
* Proc pointer type for @ref wgpuComputePassEncoderDispatchWorkgroupsIndirect:
* > @copydoc wgpuComputePassEncoderDispatchWorkgroupsIndirect
*/
ProcComputePassEncoderDispatchWorkgroupsIndirect :: proc "c" (ComputePassEncoder, Buffer, u64)

/**
* Proc pointer type for @ref wgpuComputePassEncoderEnd:
* > @copydoc wgpuComputePassEncoderEnd
*/
ProcComputePassEncoderEnd :: proc "c" (ComputePassEncoder)

/**
* Proc pointer type for @ref wgpuComputePassEncoderInsertDebugMarker:
* > @copydoc wgpuComputePassEncoderInsertDebugMarker
*/
ProcComputePassEncoderInsertDebugMarker :: proc "c" (ComputePassEncoder, StringView)

/**
* Proc pointer type for @ref wgpuComputePassEncoderPopDebugGroup:
* > @copydoc wgpuComputePassEncoderPopDebugGroup
*/
ProcComputePassEncoderPopDebugGroup :: proc "c" (ComputePassEncoder)

/**
* Proc pointer type for @ref wgpuComputePassEncoderPushDebugGroup:
* > @copydoc wgpuComputePassEncoderPushDebugGroup
*/
ProcComputePassEncoderPushDebugGroup :: proc "c" (ComputePassEncoder, StringView)

/**
* Proc pointer type for @ref wgpuComputePassEncoderSetBindGroup:
* > @copydoc wgpuComputePassEncoderSetBindGroup
*/
ProcComputePassEncoderSetBindGroup :: proc "c" (ComputePassEncoder, u32, BindGroup, c.size_t, ^u32)

/**
* Proc pointer type for @ref wgpuComputePassEncoderSetLabel:
* > @copydoc wgpuComputePassEncoderSetLabel
*/
ProcComputePassEncoderSetLabel :: proc "c" (ComputePassEncoder, StringView)

/**
* Proc pointer type for @ref wgpuComputePassEncoderSetPipeline:
* > @copydoc wgpuComputePassEncoderSetPipeline
*/
ProcComputePassEncoderSetPipeline :: proc "c" (ComputePassEncoder, ComputePipeline)

/**
* Proc pointer type for @ref wgpuComputePassEncoderAddRef.
* > @copydoc wgpuComputePassEncoderAddRef
*/
ProcComputePassEncoderAddRef :: proc "c" (ComputePassEncoder)

/**
* Proc pointer type for @ref wgpuComputePassEncoderRelease.
* > @copydoc wgpuComputePassEncoderRelease
*/
ProcComputePassEncoderRelease :: proc "c" (ComputePassEncoder)

// Procs of ComputePipeline
/**
* Proc pointer type for @ref wgpuComputePipelineGetBindGroupLayout:
* > @copydoc wgpuComputePipelineGetBindGroupLayout
*/
ProcComputePipelineGetBindGroupLayout :: proc "c" (ComputePipeline, u32) -> BindGroupLayout

/**
* Proc pointer type for @ref wgpuComputePipelineSetLabel:
* > @copydoc wgpuComputePipelineSetLabel
*/
ProcComputePipelineSetLabel :: proc "c" (ComputePipeline, StringView)

/**
* Proc pointer type for @ref wgpuComputePipelineAddRef.
* > @copydoc wgpuComputePipelineAddRef
*/
ProcComputePipelineAddRef :: proc "c" (ComputePipeline)

/**
* Proc pointer type for @ref wgpuComputePipelineRelease.
* > @copydoc wgpuComputePipelineRelease
*/
ProcComputePipelineRelease :: proc "c" (ComputePipeline)

// Procs of Device
/**
* Proc pointer type for @ref wgpuDeviceCreateBindGroup:
* > @copydoc wgpuDeviceCreateBindGroup
*/
ProcDeviceCreateBindGroup :: proc "c" (Device, ^BindGroupDescriptor) -> BindGroup

/**
* Proc pointer type for @ref wgpuDeviceCreateBindGroupLayout:
* > @copydoc wgpuDeviceCreateBindGroupLayout
*/
ProcDeviceCreateBindGroupLayout :: proc "c" (Device, ^BindGroupLayoutDescriptor) -> BindGroupLayout

/**
* Proc pointer type for @ref wgpuDeviceCreateBuffer:
* > @copydoc wgpuDeviceCreateBuffer
*/
ProcDeviceCreateBuffer :: proc "c" (Device, ^BufferDescriptor) -> Buffer

/**
* Proc pointer type for @ref wgpuDeviceCreateCommandEncoder:
* > @copydoc wgpuDeviceCreateCommandEncoder
*/
ProcDeviceCreateCommandEncoder :: proc "c" (Device, ^CommandEncoderDescriptor) -> CommandEncoder

/**
* Proc pointer type for @ref wgpuDeviceCreateComputePipeline:
* > @copydoc wgpuDeviceCreateComputePipeline
*/
ProcDeviceCreateComputePipeline :: proc "c" (Device, ^ComputePipelineDescriptor) -> ComputePipeline

/**
* Proc pointer type for @ref wgpuDeviceCreateComputePipelineAsync:
* > @copydoc wgpuDeviceCreateComputePipelineAsync
*/
ProcDeviceCreateComputePipelineAsync :: proc "c" (Device, ^ComputePipelineDescriptor, CreateComputePipelineAsyncCallbackInfo) -> Future

/**
* Proc pointer type for @ref wgpuDeviceCreatePipelineLayout:
* > @copydoc wgpuDeviceCreatePipelineLayout
*/
ProcDeviceCreatePipelineLayout :: proc "c" (Device, ^PipelineLayoutDescriptor) -> PipelineLayout

/**
* Proc pointer type for @ref wgpuDeviceCreateQuerySet:
* > @copydoc wgpuDeviceCreateQuerySet
*/
ProcDeviceCreateQuerySet :: proc "c" (Device, ^QuerySetDescriptor) -> QuerySet

/**
* Proc pointer type for @ref wgpuDeviceCreateRenderBundleEncoder:
* > @copydoc wgpuDeviceCreateRenderBundleEncoder
*/
ProcDeviceCreateRenderBundleEncoder :: proc "c" (Device, ^RenderBundleEncoderDescriptor) -> RenderBundleEncoder

/**
* Proc pointer type for @ref wgpuDeviceCreateRenderPipeline:
* > @copydoc wgpuDeviceCreateRenderPipeline
*/
ProcDeviceCreateRenderPipeline :: proc "c" (Device, ^RenderPipelineDescriptor) -> RenderPipeline

/**
* Proc pointer type for @ref wgpuDeviceCreateRenderPipelineAsync:
* > @copydoc wgpuDeviceCreateRenderPipelineAsync
*/
ProcDeviceCreateRenderPipelineAsync :: proc "c" (Device, ^RenderPipelineDescriptor, CreateRenderPipelineAsyncCallbackInfo) -> Future

/**
* Proc pointer type for @ref wgpuDeviceCreateSampler:
* > @copydoc wgpuDeviceCreateSampler
*/
ProcDeviceCreateSampler :: proc "c" (Device, ^SamplerDescriptor) -> Sampler

/**
* Proc pointer type for @ref wgpuDeviceCreateShaderModule:
* > @copydoc wgpuDeviceCreateShaderModule
*/
ProcDeviceCreateShaderModule :: proc "c" (Device, ^ShaderModuleDescriptor) -> ShaderModule

/**
* Proc pointer type for @ref wgpuDeviceCreateTexture:
* > @copydoc wgpuDeviceCreateTexture
*/
ProcDeviceCreateTexture :: proc "c" (Device, ^TextureDescriptor) -> Texture

/**
* Proc pointer type for @ref wgpuDeviceDestroy:
* > @copydoc wgpuDeviceDestroy
*/
ProcDeviceDestroy :: proc "c" (Device)

/**
* Proc pointer type for @ref wgpuDeviceGetAdapterInfo:
* > @copydoc wgpuDeviceGetAdapterInfo
*/
ProcDeviceGetAdapterInfo :: proc "c" (Device) -> AdapterInfo

/**
* Proc pointer type for @ref wgpuDeviceGetFeatures:
* > @copydoc wgpuDeviceGetFeatures
*/
ProcDeviceGetFeatures :: proc "c" (Device, ^SupportedFeatures)

/**
* Proc pointer type for @ref wgpuDeviceGetLimits:
* > @copydoc wgpuDeviceGetLimits
*/
ProcDeviceGetLimits :: proc "c" (Device, ^Limits) -> Status

/**
* Proc pointer type for @ref wgpuDeviceGetLostFuture:
* > @copydoc wgpuDeviceGetLostFuture
*/
ProcDeviceGetLostFuture :: proc "c" (Device) -> Future

/**
* Proc pointer type for @ref wgpuDeviceGetQueue:
* > @copydoc wgpuDeviceGetQueue
*/
ProcDeviceGetQueue :: proc "c" (Device) -> Queue

/**
* Proc pointer type for @ref wgpuDeviceHasFeature:
* > @copydoc wgpuDeviceHasFeature
*/
ProcDeviceHasFeature :: proc "c" (Device, FeatureName) -> Bool

/**
* Proc pointer type for @ref wgpuDevicePopErrorScope:
* > @copydoc wgpuDevicePopErrorScope
*/
ProcDevicePopErrorScope :: proc "c" (Device, PopErrorScopeCallbackInfo) -> Future

/**
* Proc pointer type for @ref wgpuDevicePushErrorScope:
* > @copydoc wgpuDevicePushErrorScope
*/
ProcDevicePushErrorScope :: proc "c" (Device, ErrorFilter)

/**
* Proc pointer type for @ref wgpuDeviceSetLabel:
* > @copydoc wgpuDeviceSetLabel
*/
ProcDeviceSetLabel :: proc "c" (Device, StringView)

/**
* Proc pointer type for @ref wgpuDeviceAddRef.
* > @copydoc wgpuDeviceAddRef
*/
ProcDeviceAddRef :: proc "c" (Device)

/**
* Proc pointer type for @ref wgpuDeviceRelease.
* > @copydoc wgpuDeviceRelease
*/
ProcDeviceRelease :: proc "c" (Device)

// Procs of Instance
/**
* Proc pointer type for @ref wgpuInstanceCreateSurface:
* > @copydoc wgpuInstanceCreateSurface
*/
ProcInstanceCreateSurface :: proc "c" (Instance, ^SurfaceDescriptor) -> Surface

/**
* Proc pointer type for @ref wgpuInstanceGetWGSLLanguageFeatures:
* > @copydoc wgpuInstanceGetWGSLLanguageFeatures
*/
ProcInstanceGetWGSLLanguageFeatures :: proc "c" (Instance, ^SupportedWGSLLanguageFeatures) -> Status

/**
* Proc pointer type for @ref wgpuInstanceHasWGSLLanguageFeature:
* > @copydoc wgpuInstanceHasWGSLLanguageFeature
*/
ProcInstanceHasWGSLLanguageFeature :: proc "c" (Instance, WGSLLanguageFeatureName) -> Bool

/**
* Proc pointer type for @ref wgpuInstanceProcessEvents:
* > @copydoc wgpuInstanceProcessEvents
*/
ProcInstanceProcessEvents :: proc "c" (Instance)

/**
* Proc pointer type for @ref wgpuInstanceRequestAdapter:
* > @copydoc wgpuInstanceRequestAdapter
*/
ProcInstanceRequestAdapter :: proc "c" (Instance, ^RequestAdapterOptions, RequestAdapterCallbackInfo) -> Future

/**
* Proc pointer type for @ref wgpuInstanceWaitAny:
* > @copydoc wgpuInstanceWaitAny
*/
ProcInstanceWaitAny :: proc "c" (Instance, c.size_t, ^FutureWaitInfo, u64) -> WaitStatus

/**
* Proc pointer type for @ref wgpuInstanceAddRef.
* > @copydoc wgpuInstanceAddRef
*/
ProcInstanceAddRef :: proc "c" (Instance)

/**
* Proc pointer type for @ref wgpuInstanceRelease.
* > @copydoc wgpuInstanceRelease
*/
ProcInstanceRelease :: proc "c" (Instance)

// Procs of PipelineLayout
/**
* Proc pointer type for @ref wgpuPipelineLayoutSetLabel:
* > @copydoc wgpuPipelineLayoutSetLabel
*/
ProcPipelineLayoutSetLabel :: proc "c" (PipelineLayout, StringView)

/**
* Proc pointer type for @ref wgpuPipelineLayoutAddRef.
* > @copydoc wgpuPipelineLayoutAddRef
*/
ProcPipelineLayoutAddRef :: proc "c" (PipelineLayout)

/**
* Proc pointer type for @ref wgpuPipelineLayoutRelease.
* > @copydoc wgpuPipelineLayoutRelease
*/
ProcPipelineLayoutRelease :: proc "c" (PipelineLayout)

// Procs of QuerySet
/**
* Proc pointer type for @ref wgpuQuerySetDestroy:
* > @copydoc wgpuQuerySetDestroy
*/
ProcQuerySetDestroy :: proc "c" (QuerySet)

/**
* Proc pointer type for @ref wgpuQuerySetGetCount:
* > @copydoc wgpuQuerySetGetCount
*/
ProcQuerySetGetCount :: proc "c" (QuerySet) -> u32

/**
* Proc pointer type for @ref wgpuQuerySetGetType:
* > @copydoc wgpuQuerySetGetType
*/
ProcQuerySetGetType :: proc "c" (QuerySet) -> QueryType

/**
* Proc pointer type for @ref wgpuQuerySetSetLabel:
* > @copydoc wgpuQuerySetSetLabel
*/
ProcQuerySetSetLabel :: proc "c" (QuerySet, StringView)

/**
* Proc pointer type for @ref wgpuQuerySetAddRef.
* > @copydoc wgpuQuerySetAddRef
*/
ProcQuerySetAddRef :: proc "c" (QuerySet)

/**
* Proc pointer type for @ref wgpuQuerySetRelease.
* > @copydoc wgpuQuerySetRelease
*/
ProcQuerySetRelease :: proc "c" (QuerySet)

// Procs of Queue
/**
* Proc pointer type for @ref wgpuQueueOnSubmittedWorkDone:
* > @copydoc wgpuQueueOnSubmittedWorkDone
*/
ProcQueueOnSubmittedWorkDone :: proc "c" (Queue, QueueWorkDoneCallbackInfo) -> Future

/**
* Proc pointer type for @ref wgpuQueueSetLabel:
* > @copydoc wgpuQueueSetLabel
*/
ProcQueueSetLabel :: proc "c" (Queue, StringView)

/**
* Proc pointer type for @ref wgpuQueueSubmit:
* > @copydoc wgpuQueueSubmit
*/
ProcQueueSubmit :: proc "c" (Queue, c.size_t, ^CommandBuffer)

/**
* Proc pointer type for @ref wgpuQueueWriteBuffer:
* > @copydoc wgpuQueueWriteBuffer
*/
ProcQueueWriteBuffer :: proc "c" (Queue, Buffer, u64, rawptr, c.size_t)

/**
* Proc pointer type for @ref wgpuQueueWriteTexture:
* > @copydoc wgpuQueueWriteTexture
*/
ProcQueueWriteTexture :: proc "c" (Queue, ^TexelCopyTextureInfo, rawptr, c.size_t, ^TexelCopyBufferLayout, ^Extent3D)

/**
* Proc pointer type for @ref wgpuQueueAddRef.
* > @copydoc wgpuQueueAddRef
*/
ProcQueueAddRef :: proc "c" (Queue)

/**
* Proc pointer type for @ref wgpuQueueRelease.
* > @copydoc wgpuQueueRelease
*/
ProcQueueRelease :: proc "c" (Queue)

// Procs of RenderBundle
/**
* Proc pointer type for @ref wgpuRenderBundleSetLabel:
* > @copydoc wgpuRenderBundleSetLabel
*/
ProcRenderBundleSetLabel :: proc "c" (RenderBundle, StringView)

/**
* Proc pointer type for @ref wgpuRenderBundleAddRef.
* > @copydoc wgpuRenderBundleAddRef
*/
ProcRenderBundleAddRef :: proc "c" (RenderBundle)

/**
* Proc pointer type for @ref wgpuRenderBundleRelease.
* > @copydoc wgpuRenderBundleRelease
*/
ProcRenderBundleRelease :: proc "c" (RenderBundle)

// Procs of RenderBundleEncoder
/**
* Proc pointer type for @ref wgpuRenderBundleEncoderDraw:
* > @copydoc wgpuRenderBundleEncoderDraw
*/
ProcRenderBundleEncoderDraw :: proc "c" (RenderBundleEncoder, u32, u32, u32, u32)

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderDrawIndexed:
* > @copydoc wgpuRenderBundleEncoderDrawIndexed
*/
ProcRenderBundleEncoderDrawIndexed :: proc "c" (RenderBundleEncoder, u32, u32, u32, i32, u32)

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderDrawIndexedIndirect:
* > @copydoc wgpuRenderBundleEncoderDrawIndexedIndirect
*/
ProcRenderBundleEncoderDrawIndexedIndirect :: proc "c" (RenderBundleEncoder, Buffer, u64)

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderDrawIndirect:
* > @copydoc wgpuRenderBundleEncoderDrawIndirect
*/
ProcRenderBundleEncoderDrawIndirect :: proc "c" (RenderBundleEncoder, Buffer, u64)

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderFinish:
* > @copydoc wgpuRenderBundleEncoderFinish
*/
ProcRenderBundleEncoderFinish :: proc "c" (RenderBundleEncoder, ^RenderBundleDescriptor) -> RenderBundle

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderInsertDebugMarker:
* > @copydoc wgpuRenderBundleEncoderInsertDebugMarker
*/
ProcRenderBundleEncoderInsertDebugMarker :: proc "c" (RenderBundleEncoder, StringView)

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderPopDebugGroup:
* > @copydoc wgpuRenderBundleEncoderPopDebugGroup
*/
ProcRenderBundleEncoderPopDebugGroup :: proc "c" (RenderBundleEncoder)

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderPushDebugGroup:
* > @copydoc wgpuRenderBundleEncoderPushDebugGroup
*/
ProcRenderBundleEncoderPushDebugGroup :: proc "c" (RenderBundleEncoder, StringView)

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderSetBindGroup:
* > @copydoc wgpuRenderBundleEncoderSetBindGroup
*/
ProcRenderBundleEncoderSetBindGroup :: proc "c" (RenderBundleEncoder, u32, BindGroup, c.size_t, ^u32)

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderSetIndexBuffer:
* > @copydoc wgpuRenderBundleEncoderSetIndexBuffer
*/
ProcRenderBundleEncoderSetIndexBuffer :: proc "c" (RenderBundleEncoder, Buffer, IndexFormat, u64, u64)

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderSetLabel:
* > @copydoc wgpuRenderBundleEncoderSetLabel
*/
ProcRenderBundleEncoderSetLabel :: proc "c" (RenderBundleEncoder, StringView)

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderSetPipeline:
* > @copydoc wgpuRenderBundleEncoderSetPipeline
*/
ProcRenderBundleEncoderSetPipeline :: proc "c" (RenderBundleEncoder, RenderPipeline)

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderSetVertexBuffer:
* > @copydoc wgpuRenderBundleEncoderSetVertexBuffer
*/
ProcRenderBundleEncoderSetVertexBuffer :: proc "c" (RenderBundleEncoder, u32, Buffer, u64, u64)

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderAddRef.
* > @copydoc wgpuRenderBundleEncoderAddRef
*/
ProcRenderBundleEncoderAddRef :: proc "c" (RenderBundleEncoder)

/**
* Proc pointer type for @ref wgpuRenderBundleEncoderRelease.
* > @copydoc wgpuRenderBundleEncoderRelease
*/
ProcRenderBundleEncoderRelease :: proc "c" (RenderBundleEncoder)

// Procs of RenderPassEncoder
/**
* Proc pointer type for @ref wgpuRenderPassEncoderBeginOcclusionQuery:
* > @copydoc wgpuRenderPassEncoderBeginOcclusionQuery
*/
ProcRenderPassEncoderBeginOcclusionQuery :: proc "c" (RenderPassEncoder, u32)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderDraw:
* > @copydoc wgpuRenderPassEncoderDraw
*/
ProcRenderPassEncoderDraw :: proc "c" (RenderPassEncoder, u32, u32, u32, u32)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderDrawIndexed:
* > @copydoc wgpuRenderPassEncoderDrawIndexed
*/
ProcRenderPassEncoderDrawIndexed :: proc "c" (RenderPassEncoder, u32, u32, u32, i32, u32)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderDrawIndexedIndirect:
* > @copydoc wgpuRenderPassEncoderDrawIndexedIndirect
*/
ProcRenderPassEncoderDrawIndexedIndirect :: proc "c" (RenderPassEncoder, Buffer, u64)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderDrawIndirect:
* > @copydoc wgpuRenderPassEncoderDrawIndirect
*/
ProcRenderPassEncoderDrawIndirect :: proc "c" (RenderPassEncoder, Buffer, u64)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderEnd:
* > @copydoc wgpuRenderPassEncoderEnd
*/
ProcRenderPassEncoderEnd :: proc "c" (RenderPassEncoder)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderEndOcclusionQuery:
* > @copydoc wgpuRenderPassEncoderEndOcclusionQuery
*/
ProcRenderPassEncoderEndOcclusionQuery :: proc "c" (RenderPassEncoder)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderExecuteBundles:
* > @copydoc wgpuRenderPassEncoderExecuteBundles
*/
ProcRenderPassEncoderExecuteBundles :: proc "c" (RenderPassEncoder, c.size_t, ^RenderBundle)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderInsertDebugMarker:
* > @copydoc wgpuRenderPassEncoderInsertDebugMarker
*/
ProcRenderPassEncoderInsertDebugMarker :: proc "c" (RenderPassEncoder, StringView)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderPopDebugGroup:
* > @copydoc wgpuRenderPassEncoderPopDebugGroup
*/
ProcRenderPassEncoderPopDebugGroup :: proc "c" (RenderPassEncoder)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderPushDebugGroup:
* > @copydoc wgpuRenderPassEncoderPushDebugGroup
*/
ProcRenderPassEncoderPushDebugGroup :: proc "c" (RenderPassEncoder, StringView)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetBindGroup:
* > @copydoc wgpuRenderPassEncoderSetBindGroup
*/
ProcRenderPassEncoderSetBindGroup :: proc "c" (RenderPassEncoder, u32, BindGroup, c.size_t, ^u32)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetBlendConstant:
* > @copydoc wgpuRenderPassEncoderSetBlendConstant
*/
ProcRenderPassEncoderSetBlendConstant :: proc "c" (RenderPassEncoder, ^Color)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetIndexBuffer:
* > @copydoc wgpuRenderPassEncoderSetIndexBuffer
*/
ProcRenderPassEncoderSetIndexBuffer :: proc "c" (RenderPassEncoder, Buffer, IndexFormat, u64, u64)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetLabel:
* > @copydoc wgpuRenderPassEncoderSetLabel
*/
ProcRenderPassEncoderSetLabel :: proc "c" (RenderPassEncoder, StringView)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetPipeline:
* > @copydoc wgpuRenderPassEncoderSetPipeline
*/
ProcRenderPassEncoderSetPipeline :: proc "c" (RenderPassEncoder, RenderPipeline)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetScissorRect:
* > @copydoc wgpuRenderPassEncoderSetScissorRect
*/
ProcRenderPassEncoderSetScissorRect :: proc "c" (RenderPassEncoder, u32, u32, u32, u32)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetStencilReference:
* > @copydoc wgpuRenderPassEncoderSetStencilReference
*/
ProcRenderPassEncoderSetStencilReference :: proc "c" (RenderPassEncoder, u32)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetVertexBuffer:
* > @copydoc wgpuRenderPassEncoderSetVertexBuffer
*/
ProcRenderPassEncoderSetVertexBuffer :: proc "c" (RenderPassEncoder, u32, Buffer, u64, u64)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderSetViewport:
* > @copydoc wgpuRenderPassEncoderSetViewport
*/
ProcRenderPassEncoderSetViewport :: proc "c" (RenderPassEncoder, f32, f32, f32, f32, f32, f32)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderAddRef.
* > @copydoc wgpuRenderPassEncoderAddRef
*/
ProcRenderPassEncoderAddRef :: proc "c" (RenderPassEncoder)

/**
* Proc pointer type for @ref wgpuRenderPassEncoderRelease.
* > @copydoc wgpuRenderPassEncoderRelease
*/
ProcRenderPassEncoderRelease :: proc "c" (RenderPassEncoder)

// Procs of RenderPipeline
/**
* Proc pointer type for @ref wgpuRenderPipelineGetBindGroupLayout:
* > @copydoc wgpuRenderPipelineGetBindGroupLayout
*/
ProcRenderPipelineGetBindGroupLayout :: proc "c" (RenderPipeline, u32) -> BindGroupLayout

/**
* Proc pointer type for @ref wgpuRenderPipelineSetLabel:
* > @copydoc wgpuRenderPipelineSetLabel
*/
ProcRenderPipelineSetLabel :: proc "c" (RenderPipeline, StringView)

/**
* Proc pointer type for @ref wgpuRenderPipelineAddRef.
* > @copydoc wgpuRenderPipelineAddRef
*/
ProcRenderPipelineAddRef :: proc "c" (RenderPipeline)

/**
* Proc pointer type for @ref wgpuRenderPipelineRelease.
* > @copydoc wgpuRenderPipelineRelease
*/
ProcRenderPipelineRelease :: proc "c" (RenderPipeline)

// Procs of Sampler
/**
* Proc pointer type for @ref wgpuSamplerSetLabel:
* > @copydoc wgpuSamplerSetLabel
*/
ProcSamplerSetLabel :: proc "c" (Sampler, StringView)

/**
* Proc pointer type for @ref wgpuSamplerAddRef.
* > @copydoc wgpuSamplerAddRef
*/
ProcSamplerAddRef :: proc "c" (Sampler)

/**
* Proc pointer type for @ref wgpuSamplerRelease.
* > @copydoc wgpuSamplerRelease
*/
ProcSamplerRelease :: proc "c" (Sampler)

// Procs of ShaderModule
/**
* Proc pointer type for @ref wgpuShaderModuleGetCompilationInfo:
* > @copydoc wgpuShaderModuleGetCompilationInfo
*/
ProcShaderModuleGetCompilationInfo :: proc "c" (ShaderModule, CompilationInfoCallbackInfo) -> Future

/**
* Proc pointer type for @ref wgpuShaderModuleSetLabel:
* > @copydoc wgpuShaderModuleSetLabel
*/
ProcShaderModuleSetLabel :: proc "c" (ShaderModule, StringView)

/**
* Proc pointer type for @ref wgpuShaderModuleAddRef.
* > @copydoc wgpuShaderModuleAddRef
*/
ProcShaderModuleAddRef :: proc "c" (ShaderModule)

/**
* Proc pointer type for @ref wgpuShaderModuleRelease.
* > @copydoc wgpuShaderModuleRelease
*/
ProcShaderModuleRelease :: proc "c" (ShaderModule)

// Procs of SupportedFeatures
/**
* Proc pointer type for @ref wgpuSupportedFeaturesFreeMembers:
* > @copydoc wgpuSupportedFeaturesFreeMembers
*/
ProcSupportedFeaturesFreeMembers :: proc "c" (SupportedFeatures)

// Procs of SupportedWGSLLanguageFeatures
/**
* Proc pointer type for @ref wgpuSupportedWGSLLanguageFeaturesFreeMembers:
* > @copydoc wgpuSupportedWGSLLanguageFeaturesFreeMembers
*/
ProcSupportedWGSLLanguageFeaturesFreeMembers :: proc "c" (SupportedWGSLLanguageFeatures)

// Procs of Surface
/**
* Proc pointer type for @ref wgpuSurfaceConfigure:
* > @copydoc wgpuSurfaceConfigure
*/
ProcSurfaceConfigure :: proc "c" (Surface, ^SurfaceConfiguration)

/**
* Proc pointer type for @ref wgpuSurfaceGetCapabilities:
* > @copydoc wgpuSurfaceGetCapabilities
*/
ProcSurfaceGetCapabilities :: proc "c" (Surface, Adapter, ^SurfaceCapabilities) -> Status

/**
* Proc pointer type for @ref wgpuSurfaceGetCurrentTexture:
* > @copydoc wgpuSurfaceGetCurrentTexture
*/
ProcSurfaceGetCurrentTexture :: proc "c" (Surface, ^SurfaceTexture)

/**
* Proc pointer type for @ref wgpuSurfacePresent:
* > @copydoc wgpuSurfacePresent
*/
ProcSurfacePresent :: proc "c" (Surface) -> Status

/**
* Proc pointer type for @ref wgpuSurfaceSetLabel:
* > @copydoc wgpuSurfaceSetLabel
*/
ProcSurfaceSetLabel :: proc "c" (Surface, StringView)

/**
* Proc pointer type for @ref wgpuSurfaceUnconfigure:
* > @copydoc wgpuSurfaceUnconfigure
*/
ProcSurfaceUnconfigure :: proc "c" (Surface)

/**
* Proc pointer type for @ref wgpuSurfaceAddRef.
* > @copydoc wgpuSurfaceAddRef
*/
ProcSurfaceAddRef :: proc "c" (Surface)

/**
* Proc pointer type for @ref wgpuSurfaceRelease.
* > @copydoc wgpuSurfaceRelease
*/
ProcSurfaceRelease :: proc "c" (Surface)

// Procs of SurfaceCapabilities
/**
* Proc pointer type for @ref wgpuSurfaceCapabilitiesFreeMembers:
* > @copydoc wgpuSurfaceCapabilitiesFreeMembers
*/
ProcSurfaceCapabilitiesFreeMembers :: proc "c" (SurfaceCapabilities)

// Procs of Texture
/**
* Proc pointer type for @ref wgpuTextureCreateView:
* > @copydoc wgpuTextureCreateView
*/
ProcTextureCreateView :: proc "c" (Texture, ^TextureViewDescriptor) -> TextureView

/**
* Proc pointer type for @ref wgpuTextureDestroy:
* > @copydoc wgpuTextureDestroy
*/
ProcTextureDestroy :: proc "c" (Texture)

/**
* Proc pointer type for @ref wgpuTextureGetDepthOrArrayLayers:
* > @copydoc wgpuTextureGetDepthOrArrayLayers
*/
ProcTextureGetDepthOrArrayLayers :: proc "c" (Texture) -> u32

/**
* Proc pointer type for @ref wgpuTextureGetDimension:
* > @copydoc wgpuTextureGetDimension
*/
ProcTextureGetDimension :: proc "c" (Texture) -> TextureDimension

/**
* Proc pointer type for @ref wgpuTextureGetFormat:
* > @copydoc wgpuTextureGetFormat
*/
ProcTextureGetFormat :: proc "c" (Texture) -> TextureFormat

/**
* Proc pointer type for @ref wgpuTextureGetHeight:
* > @copydoc wgpuTextureGetHeight
*/
ProcTextureGetHeight :: proc "c" (Texture) -> u32

/**
* Proc pointer type for @ref wgpuTextureGetMipLevelCount:
* > @copydoc wgpuTextureGetMipLevelCount
*/
ProcTextureGetMipLevelCount :: proc "c" (Texture) -> u32

/**
* Proc pointer type for @ref wgpuTextureGetSampleCount:
* > @copydoc wgpuTextureGetSampleCount
*/
ProcTextureGetSampleCount :: proc "c" (Texture) -> u32

/**
* Proc pointer type for @ref wgpuTextureGetUsage:
* > @copydoc wgpuTextureGetUsage
*/
ProcTextureGetUsage :: proc "c" (Texture) -> TextureUsage

/**
* Proc pointer type for @ref wgpuTextureGetWidth:
* > @copydoc wgpuTextureGetWidth
*/
ProcTextureGetWidth :: proc "c" (Texture) -> u32

/**
* Proc pointer type for @ref wgpuTextureSetLabel:
* > @copydoc wgpuTextureSetLabel
*/
ProcTextureSetLabel :: proc "c" (Texture, StringView)

/**
* Proc pointer type for @ref wgpuTextureAddRef.
* > @copydoc wgpuTextureAddRef
*/
ProcTextureAddRef :: proc "c" (Texture)

/**
* Proc pointer type for @ref wgpuTextureRelease.
* > @copydoc wgpuTextureRelease
*/
ProcTextureRelease :: proc "c" (Texture)

// Procs of TextureView
/**
* Proc pointer type for @ref wgpuTextureViewSetLabel:
* > @copydoc wgpuTextureViewSetLabel
*/
ProcTextureViewSetLabel :: proc "c" (TextureView, StringView)

/**
* Proc pointer type for @ref wgpuTextureViewAddRef.
* > @copydoc wgpuTextureViewAddRef
*/
ProcTextureViewAddRef :: proc "c" (TextureView)

/**
* Proc pointer type for @ref wgpuTextureViewRelease.
* > @copydoc wgpuTextureViewRelease
*/
ProcTextureViewRelease :: proc "c" (TextureView)

@(default_calling_convention="c", link_prefix="wgpu")
foreign lib {
	/**
	* \defgroup GlobalFunctions Global Functions
	* \brief Functions that are not specific to an object.
	*
	* @{
	*/
	/**
	* Create a WGPUInstance
	*/
	CreateInstance :: proc(descriptor: ^InstanceDescriptor) -> Instance ---

	/**
	* Query the supported instance capabilities.
	*
	* @param capabilities
	* The supported instance capabilities
	*
	* @returns
	* Indicates if there was an @ref OutStructChainError.
	*/
	GetInstanceCapabilities :: proc(capabilities: ^InstanceCapabilities) -> Status ---

	/**
	* Returns the "procedure address" (function pointer) of the named function.
	* The result must be cast to the appropriate proc pointer type.
	*/
	GetProcAddress :: proc(procName: StringView) -> Proc ---

	/**
	* \defgroup WGPUAdapterMethods WGPUAdapter methods
	* \brief Functions whose first argument has type WGPUAdapter.
	*
	* @{
	*/
	/**
	* Get the list of @ref WGPUFeatureName values supported by the adapter.
	*
	* @param features
	* This parameter is @ref ReturnedWithOwnership.
	*/
	AdapterGetFeatures :: proc(adapter: Adapter, features: ^SupportedFeatures) ---

	/**
	* @param info
	* This parameter is @ref ReturnedWithOwnership.
	*
	* @returns
	* Indicates if there was an @ref OutStructChainError.
	*/
	AdapterGetInfo :: proc(adapter: Adapter, info: ^AdapterInfo) -> Status ---

	/**
	* @returns
	* Indicates if there was an @ref OutStructChainError.
	*/
	AdapterGetLimits     :: proc(adapter: Adapter, limits: ^Limits) -> Status ---
	AdapterHasFeature    :: proc(adapter: Adapter, feature: FeatureName) -> Bool ---
	AdapterRequestDevice :: proc(adapter: Adapter, descriptor: ^DeviceDescriptor, callbackInfo: RequestDeviceCallbackInfo) -> Future ---
	AdapterAddRef        :: proc(adapter: Adapter) ---
	AdapterRelease       :: proc(adapter: Adapter) ---

	/**
	* \defgroup WGPUAdapterInfoMethods WGPUAdapterInfo methods
	* \brief Functions whose first argument has type WGPUAdapterInfo.
	*
	* @{
	*/
	/**
	* Frees array members of WGPUAdapterInfo which were allocated by the API.
	*/
	AdapterInfoFreeMembers :: proc(adapterInfo: AdapterInfo) ---

	/**
	* \defgroup WGPUBindGroupMethods WGPUBindGroup methods
	* \brief Functions whose first argument has type WGPUBindGroup.
	*
	* @{
	*/
	BindGroupSetLabel :: proc(bindGroup: BindGroup, label: StringView) ---
	BindGroupAddRef   :: proc(bindGroup: BindGroup) ---
	BindGroupRelease  :: proc(bindGroup: BindGroup) ---

	/**
	* \defgroup WGPUBindGroupLayoutMethods WGPUBindGroupLayout methods
	* \brief Functions whose first argument has type WGPUBindGroupLayout.
	*
	* @{
	*/
	BindGroupLayoutSetLabel :: proc(bindGroupLayout: BindGroupLayout, label: StringView) ---
	BindGroupLayoutAddRef   :: proc(bindGroupLayout: BindGroupLayout) ---
	BindGroupLayoutRelease  :: proc(bindGroupLayout: BindGroupLayout) ---

	/**
	* \defgroup WGPUBufferMethods WGPUBuffer methods
	* \brief Functions whose first argument has type WGPUBuffer.
	*
	* @{
	*/
	BufferDestroy :: proc(buffer: Buffer) ---

	/**
	* @param offset
	* Byte offset relative to the beginning of the buffer.
	*
	* @param size
	* Byte size of the range to get. The returned pointer is valid for exactly this many bytes.
	*
	* @returns
	* Returns a const pointer to beginning of the mapped range.
	* It must not be written; writing to this range causes undefined behavior.
	* Returns `NULL` with @ref ImplementationDefinedLogging if:
	*
	* - There is any content-timeline error as defined in the WebGPU specification for `getMappedRange()` (alignments, overlaps, etc.)
	*   **except** for overlaps with other *const* ranges, which are allowed in C.
	*   (JS does not allow this because const ranges do not exist.)
	*/
	BufferGetConstMappedRange :: proc(buffer: Buffer, offset: c.size_t, size: c.size_t) -> rawptr ---
	BufferGetMapState         :: proc(buffer: Buffer) -> BufferMapState ---

	/**
	* @param offset
	* Byte offset relative to the beginning of the buffer.
	*
	* @param size
	* Byte size of the range to get. The returned pointer is valid for exactly this many bytes.
	*
	* @returns
	* Returns a mutable pointer to beginning of the mapped range.
	* Returns `NULL` with @ref ImplementationDefinedLogging if:
	*
	* - There is any content-timeline error as defined in the WebGPU specification for `getMappedRange()` (alignments, overlaps, etc.)
	* - The buffer is not mapped with @ref WGPUMapMode_Write.
	*/
	BufferGetMappedRange :: proc(buffer: Buffer, offset: c.size_t, size: c.size_t) -> rawptr ---
	BufferGetSize        :: proc(buffer: Buffer) -> u64 ---
	BufferGetUsage       :: proc(buffer: Buffer) -> BufferUsage ---
	BufferMapAsync       :: proc(buffer: Buffer, mode: MapMode, offset: c.size_t, size: c.size_t, callbackInfo: BufferMapCallbackInfo) -> Future ---
	BufferSetLabel       :: proc(buffer: Buffer, label: StringView) ---
	BufferUnmap          :: proc(buffer: Buffer) ---
	BufferAddRef         :: proc(buffer: Buffer) ---
	BufferRelease        :: proc(buffer: Buffer) ---

	/**
	* \defgroup WGPUCommandBufferMethods WGPUCommandBuffer methods
	* \brief Functions whose first argument has type WGPUCommandBuffer.
	*
	* @{
	*/
	CommandBufferSetLabel :: proc(commandBuffer: CommandBuffer, label: StringView) ---
	CommandBufferAddRef   :: proc(commandBuffer: CommandBuffer) ---
	CommandBufferRelease  :: proc(commandBuffer: CommandBuffer) ---

	/**
	* \defgroup WGPUCommandEncoderMethods WGPUCommandEncoder methods
	* \brief Functions whose first argument has type WGPUCommandEncoder.
	*
	* @{
	*/
	CommandEncoderBeginComputePass     :: proc(commandEncoder: CommandEncoder, descriptor: ^ComputePassDescriptor) -> ComputePassEncoder ---
	CommandEncoderBeginRenderPass      :: proc(commandEncoder: CommandEncoder, descriptor: ^RenderPassDescriptor) -> RenderPassEncoder ---
	CommandEncoderClearBuffer          :: proc(commandEncoder: CommandEncoder, buffer: Buffer, offset: u64, size: u64) ---
	CommandEncoderCopyBufferToBuffer   :: proc(commandEncoder: CommandEncoder, source: Buffer, sourceOffset: u64, destination: Buffer, destinationOffset: u64, size: u64) ---
	CommandEncoderCopyBufferToTexture  :: proc(commandEncoder: CommandEncoder, source: ^TexelCopyBufferInfo, destination: ^TexelCopyTextureInfo, copySize: ^Extent3D) ---
	CommandEncoderCopyTextureToBuffer  :: proc(commandEncoder: CommandEncoder, source: ^TexelCopyTextureInfo, destination: ^TexelCopyBufferInfo, copySize: ^Extent3D) ---
	CommandEncoderCopyTextureToTexture :: proc(commandEncoder: CommandEncoder, source: ^TexelCopyTextureInfo, destination: ^TexelCopyTextureInfo, copySize: ^Extent3D) ---
	CommandEncoderFinish               :: proc(commandEncoder: CommandEncoder, descriptor: ^CommandBufferDescriptor) -> CommandBuffer ---
	CommandEncoderInsertDebugMarker    :: proc(commandEncoder: CommandEncoder, markerLabel: StringView) ---
	CommandEncoderPopDebugGroup        :: proc(commandEncoder: CommandEncoder) ---
	CommandEncoderPushDebugGroup       :: proc(commandEncoder: CommandEncoder, groupLabel: StringView) ---
	CommandEncoderResolveQuerySet      :: proc(commandEncoder: CommandEncoder, querySet: QuerySet, firstQuery: u32, queryCount: u32, destination: Buffer, destinationOffset: u64) ---
	CommandEncoderSetLabel             :: proc(commandEncoder: CommandEncoder, label: StringView) ---
	CommandEncoderWriteTimestamp       :: proc(commandEncoder: CommandEncoder, querySet: QuerySet, queryIndex: u32) ---
	CommandEncoderAddRef               :: proc(commandEncoder: CommandEncoder) ---
	CommandEncoderRelease              :: proc(commandEncoder: CommandEncoder) ---

	/**
	* \defgroup WGPUComputePassEncoderMethods WGPUComputePassEncoder methods
	* \brief Functions whose first argument has type WGPUComputePassEncoder.
	*
	* @{
	*/
	ComputePassEncoderDispatchWorkgroups         :: proc(computePassEncoder: ComputePassEncoder, workgroupCountX: u32, workgroupCountY: u32, workgroupCountZ: u32) ---
	ComputePassEncoderDispatchWorkgroupsIndirect :: proc(computePassEncoder: ComputePassEncoder, indirectBuffer: Buffer, indirectOffset: u64) ---
	ComputePassEncoderEnd                        :: proc(computePassEncoder: ComputePassEncoder) ---
	ComputePassEncoderInsertDebugMarker          :: proc(computePassEncoder: ComputePassEncoder, markerLabel: StringView) ---
	ComputePassEncoderPopDebugGroup              :: proc(computePassEncoder: ComputePassEncoder) ---
	ComputePassEncoderPushDebugGroup             :: proc(computePassEncoder: ComputePassEncoder, groupLabel: StringView) ---
	ComputePassEncoderSetBindGroup               :: proc(computePassEncoder: ComputePassEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: c.size_t, dynamicOffsets: ^u32) ---
	ComputePassEncoderSetLabel                   :: proc(computePassEncoder: ComputePassEncoder, label: StringView) ---
	ComputePassEncoderSetPipeline                :: proc(computePassEncoder: ComputePassEncoder, pipeline: ComputePipeline) ---
	ComputePassEncoderAddRef                     :: proc(computePassEncoder: ComputePassEncoder) ---
	ComputePassEncoderRelease                    :: proc(computePassEncoder: ComputePassEncoder) ---

	/**
	* \defgroup WGPUComputePipelineMethods WGPUComputePipeline methods
	* \brief Functions whose first argument has type WGPUComputePipeline.
	*
	* @{
	*/
	ComputePipelineGetBindGroupLayout :: proc(computePipeline: ComputePipeline, groupIndex: u32) -> BindGroupLayout ---
	ComputePipelineSetLabel           :: proc(computePipeline: ComputePipeline, label: StringView) ---
	ComputePipelineAddRef             :: proc(computePipeline: ComputePipeline) ---
	ComputePipelineRelease            :: proc(computePipeline: ComputePipeline) ---

	/**
	* \defgroup WGPUDeviceMethods WGPUDevice methods
	* \brief Functions whose first argument has type WGPUDevice.
	*
	* @{
	*/
	DeviceCreateBindGroup            :: proc(device: Device, descriptor: ^BindGroupDescriptor) -> BindGroup ---
	DeviceCreateBindGroupLayout      :: proc(device: Device, descriptor: ^BindGroupLayoutDescriptor) -> BindGroupLayout ---
	DeviceCreateBuffer               :: proc(device: Device, descriptor: ^BufferDescriptor) -> Buffer ---
	DeviceCreateCommandEncoder       :: proc(device: Device, descriptor: ^CommandEncoderDescriptor) -> CommandEncoder ---
	DeviceCreateComputePipeline      :: proc(device: Device, descriptor: ^ComputePipelineDescriptor) -> ComputePipeline ---
	DeviceCreateComputePipelineAsync :: proc(device: Device, descriptor: ^ComputePipelineDescriptor, callbackInfo: CreateComputePipelineAsyncCallbackInfo) -> Future ---
	DeviceCreatePipelineLayout       :: proc(device: Device, descriptor: ^PipelineLayoutDescriptor) -> PipelineLayout ---
	DeviceCreateQuerySet             :: proc(device: Device, descriptor: ^QuerySetDescriptor) -> QuerySet ---
	DeviceCreateRenderBundleEncoder  :: proc(device: Device, descriptor: ^RenderBundleEncoderDescriptor) -> RenderBundleEncoder ---
	DeviceCreateRenderPipeline       :: proc(device: Device, descriptor: ^RenderPipelineDescriptor) -> RenderPipeline ---
	DeviceCreateRenderPipelineAsync  :: proc(device: Device, descriptor: ^RenderPipelineDescriptor, callbackInfo: CreateRenderPipelineAsyncCallbackInfo) -> Future ---
	DeviceCreateSampler              :: proc(device: Device, descriptor: ^SamplerDescriptor) -> Sampler ---
	DeviceCreateShaderModule         :: proc(device: Device, descriptor: ^ShaderModuleDescriptor) -> ShaderModule ---
	DeviceCreateTexture              :: proc(device: Device, descriptor: ^TextureDescriptor) -> Texture ---
	DeviceDestroy                    :: proc(device: Device) ---
	DeviceGetAdapterInfo             :: proc(device: Device) -> AdapterInfo ---

	/**
	* Get the list of @ref WGPUFeatureName values supported by the device.
	*
	* @param features
	* This parameter is @ref ReturnedWithOwnership.
	*/
	DeviceGetFeatures :: proc(device: Device, features: ^SupportedFeatures) ---

	/**
	* @returns
	* Indicates if there was an @ref OutStructChainError.
	*/
	DeviceGetLimits :: proc(device: Device, limits: ^Limits) -> Status ---

	/**
	* @returns
	* The @ref WGPUFuture for the device-lost event of the device.
	*/
	DeviceGetLostFuture  :: proc(device: Device) -> Future ---
	DeviceGetQueue       :: proc(device: Device) -> Queue ---
	DeviceHasFeature     :: proc(device: Device, feature: FeatureName) -> Bool ---
	DevicePopErrorScope  :: proc(device: Device, callbackInfo: PopErrorScopeCallbackInfo) -> Future ---
	DevicePushErrorScope :: proc(device: Device, filter: ErrorFilter) ---
	DeviceSetLabel       :: proc(device: Device, label: StringView) ---
	DeviceAddRef         :: proc(device: Device) ---
	DeviceRelease        :: proc(device: Device) ---

	/**
	* \defgroup WGPUInstanceMethods WGPUInstance methods
	* \brief Functions whose first argument has type WGPUInstance.
	*
	* @{
	*/
	/**
	* Creates a @ref WGPUSurface, see @ref Surface-Creation for more details.
	*
	* @param descriptor
	* The description of the @ref WGPUSurface to create.
	*
	* @returns
	* A new @ref WGPUSurface for this descriptor (or an error @ref WGPUSurface).
	*/
	InstanceCreateSurface :: proc(instance: Instance, descriptor: ^SurfaceDescriptor) -> Surface ---

	/**
	* Get the list of @ref WGPUWGSLLanguageFeatureName values supported by the instance.
	*/
	InstanceGetWGSLLanguageFeatures :: proc(instance: Instance, features: ^SupportedWGSLLanguageFeatures) -> Status ---
	InstanceHasWGSLLanguageFeature  :: proc(instance: Instance, feature: WGSLLanguageFeatureName) -> Bool ---

	/**
	* Processes asynchronous events on this `WGPUInstance`, calling any callbacks for asynchronous operations created with `::WGPUCallbackMode_AllowProcessEvents`.
	*
	* See @ref Process-Events for more information.
	*/
	InstanceProcessEvents  :: proc(instance: Instance) ---
	InstanceRequestAdapter :: proc(instance: Instance, options: ^RequestAdapterOptions, callbackInfo: RequestAdapterCallbackInfo) -> Future ---

	/**
	* Wait for at least one WGPUFuture in `futures` to complete, and call callbacks of the respective completed asynchronous operations.
	*
	* See @ref Wait-Any for more information.
	*/
	InstanceWaitAny :: proc(instance: Instance, futureCount: c.size_t, futures: ^FutureWaitInfo, timeoutNS: u64) -> WaitStatus ---
	InstanceAddRef  :: proc(instance: Instance) ---
	InstanceRelease :: proc(instance: Instance) ---

	/**
	* \defgroup WGPUPipelineLayoutMethods WGPUPipelineLayout methods
	* \brief Functions whose first argument has type WGPUPipelineLayout.
	*
	* @{
	*/
	PipelineLayoutSetLabel :: proc(pipelineLayout: PipelineLayout, label: StringView) ---
	PipelineLayoutAddRef   :: proc(pipelineLayout: PipelineLayout) ---
	PipelineLayoutRelease  :: proc(pipelineLayout: PipelineLayout) ---

	/**
	* \defgroup WGPUQuerySetMethods WGPUQuerySet methods
	* \brief Functions whose first argument has type WGPUQuerySet.
	*
	* @{
	*/
	QuerySetDestroy  :: proc(querySet: QuerySet) ---
	QuerySetGetCount :: proc(querySet: QuerySet) -> u32 ---
	QuerySetGetType  :: proc(querySet: QuerySet) -> QueryType ---
	QuerySetSetLabel :: proc(querySet: QuerySet, label: StringView) ---
	QuerySetAddRef   :: proc(querySet: QuerySet) ---
	QuerySetRelease  :: proc(querySet: QuerySet) ---

	/**
	* \defgroup WGPUQueueMethods WGPUQueue methods
	* \brief Functions whose first argument has type WGPUQueue.
	*
	* @{
	*/
	QueueOnSubmittedWorkDone :: proc(queue: Queue, callbackInfo: QueueWorkDoneCallbackInfo) -> Future ---
	QueueSetLabel            :: proc(queue: Queue, label: StringView) ---
	QueueSubmit              :: proc(queue: Queue, commandCount: c.size_t, commands: ^CommandBuffer) ---

	/**
	* Produces a @ref DeviceError both content-timeline (`size` alignment) and device-timeline
	* errors defined by the WebGPU specification.
	*/
	QueueWriteBuffer  :: proc(queue: Queue, buffer: Buffer, bufferOffset: u64, data: rawptr, size: c.size_t) ---
	QueueWriteTexture :: proc(queue: Queue, destination: ^TexelCopyTextureInfo, data: rawptr, dataSize: c.size_t, dataLayout: ^TexelCopyBufferLayout, writeSize: ^Extent3D) ---
	QueueAddRef       :: proc(queue: Queue) ---
	QueueRelease      :: proc(queue: Queue) ---

	/**
	* \defgroup WGPURenderBundleMethods WGPURenderBundle methods
	* \brief Functions whose first argument has type WGPURenderBundle.
	*
	* @{
	*/
	RenderBundleSetLabel :: proc(renderBundle: RenderBundle, label: StringView) ---
	RenderBundleAddRef   :: proc(renderBundle: RenderBundle) ---
	RenderBundleRelease  :: proc(renderBundle: RenderBundle) ---

	/**
	* \defgroup WGPURenderBundleEncoderMethods WGPURenderBundleEncoder methods
	* \brief Functions whose first argument has type WGPURenderBundleEncoder.
	*
	* @{
	*/
	RenderBundleEncoderDraw                :: proc(renderBundleEncoder: RenderBundleEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) ---
	RenderBundleEncoderDrawIndexed         :: proc(renderBundleEncoder: RenderBundleEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) ---
	RenderBundleEncoderDrawIndexedIndirect :: proc(renderBundleEncoder: RenderBundleEncoder, indirectBuffer: Buffer, indirectOffset: u64) ---
	RenderBundleEncoderDrawIndirect        :: proc(renderBundleEncoder: RenderBundleEncoder, indirectBuffer: Buffer, indirectOffset: u64) ---
	RenderBundleEncoderFinish              :: proc(renderBundleEncoder: RenderBundleEncoder, descriptor: ^RenderBundleDescriptor) -> RenderBundle ---
	RenderBundleEncoderInsertDebugMarker   :: proc(renderBundleEncoder: RenderBundleEncoder, markerLabel: StringView) ---
	RenderBundleEncoderPopDebugGroup       :: proc(renderBundleEncoder: RenderBundleEncoder) ---
	RenderBundleEncoderPushDebugGroup      :: proc(renderBundleEncoder: RenderBundleEncoder, groupLabel: StringView) ---
	RenderBundleEncoderSetBindGroup        :: proc(renderBundleEncoder: RenderBundleEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: c.size_t, dynamicOffsets: ^u32) ---
	RenderBundleEncoderSetIndexBuffer      :: proc(renderBundleEncoder: RenderBundleEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) ---
	RenderBundleEncoderSetLabel            :: proc(renderBundleEncoder: RenderBundleEncoder, label: StringView) ---
	RenderBundleEncoderSetPipeline         :: proc(renderBundleEncoder: RenderBundleEncoder, pipeline: RenderPipeline) ---
	RenderBundleEncoderSetVertexBuffer     :: proc(renderBundleEncoder: RenderBundleEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) ---
	RenderBundleEncoderAddRef              :: proc(renderBundleEncoder: RenderBundleEncoder) ---
	RenderBundleEncoderRelease             :: proc(renderBundleEncoder: RenderBundleEncoder) ---

	/**
	* \defgroup WGPURenderPassEncoderMethods WGPURenderPassEncoder methods
	* \brief Functions whose first argument has type WGPURenderPassEncoder.
	*
	* @{
	*/
	RenderPassEncoderBeginOcclusionQuery :: proc(renderPassEncoder: RenderPassEncoder, queryIndex: u32) ---
	RenderPassEncoderDraw                :: proc(renderPassEncoder: RenderPassEncoder, vertexCount: u32, instanceCount: u32, firstVertex: u32, firstInstance: u32) ---
	RenderPassEncoderDrawIndexed         :: proc(renderPassEncoder: RenderPassEncoder, indexCount: u32, instanceCount: u32, firstIndex: u32, baseVertex: i32, firstInstance: u32) ---
	RenderPassEncoderDrawIndexedIndirect :: proc(renderPassEncoder: RenderPassEncoder, indirectBuffer: Buffer, indirectOffset: u64) ---
	RenderPassEncoderDrawIndirect        :: proc(renderPassEncoder: RenderPassEncoder, indirectBuffer: Buffer, indirectOffset: u64) ---
	RenderPassEncoderEnd                 :: proc(renderPassEncoder: RenderPassEncoder) ---
	RenderPassEncoderEndOcclusionQuery   :: proc(renderPassEncoder: RenderPassEncoder) ---
	RenderPassEncoderExecuteBundles      :: proc(renderPassEncoder: RenderPassEncoder, bundleCount: c.size_t, bundles: ^RenderBundle) ---
	RenderPassEncoderInsertDebugMarker   :: proc(renderPassEncoder: RenderPassEncoder, markerLabel: StringView) ---
	RenderPassEncoderPopDebugGroup       :: proc(renderPassEncoder: RenderPassEncoder) ---
	RenderPassEncoderPushDebugGroup      :: proc(renderPassEncoder: RenderPassEncoder, groupLabel: StringView) ---
	RenderPassEncoderSetBindGroup        :: proc(renderPassEncoder: RenderPassEncoder, groupIndex: u32, group: BindGroup, dynamicOffsetCount: c.size_t, dynamicOffsets: ^u32) ---
	RenderPassEncoderSetBlendConstant    :: proc(renderPassEncoder: RenderPassEncoder, color: ^Color) ---
	RenderPassEncoderSetIndexBuffer      :: proc(renderPassEncoder: RenderPassEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) ---
	RenderPassEncoderSetLabel            :: proc(renderPassEncoder: RenderPassEncoder, label: StringView) ---
	RenderPassEncoderSetPipeline         :: proc(renderPassEncoder: RenderPassEncoder, pipeline: RenderPipeline) ---
	RenderPassEncoderSetScissorRect      :: proc(renderPassEncoder: RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) ---
	RenderPassEncoderSetStencilReference :: proc(renderPassEncoder: RenderPassEncoder, reference: u32) ---
	RenderPassEncoderSetVertexBuffer     :: proc(renderPassEncoder: RenderPassEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) ---
	RenderPassEncoderSetViewport         :: proc(renderPassEncoder: RenderPassEncoder, x: f32, y: f32, width: f32, height: f32, minDepth: f32, maxDepth: f32) ---
	RenderPassEncoderAddRef              :: proc(renderPassEncoder: RenderPassEncoder) ---
	RenderPassEncoderRelease             :: proc(renderPassEncoder: RenderPassEncoder) ---

	/**
	* \defgroup WGPURenderPipelineMethods WGPURenderPipeline methods
	* \brief Functions whose first argument has type WGPURenderPipeline.
	*
	* @{
	*/
	RenderPipelineGetBindGroupLayout :: proc(renderPipeline: RenderPipeline, groupIndex: u32) -> BindGroupLayout ---
	RenderPipelineSetLabel           :: proc(renderPipeline: RenderPipeline, label: StringView) ---
	RenderPipelineAddRef             :: proc(renderPipeline: RenderPipeline) ---
	RenderPipelineRelease            :: proc(renderPipeline: RenderPipeline) ---

	/**
	* \defgroup WGPUSamplerMethods WGPUSampler methods
	* \brief Functions whose first argument has type WGPUSampler.
	*
	* @{
	*/
	SamplerSetLabel :: proc(sampler: Sampler, label: StringView) ---
	SamplerAddRef   :: proc(sampler: Sampler) ---
	SamplerRelease  :: proc(sampler: Sampler) ---

	/**
	* \defgroup WGPUShaderModuleMethods WGPUShaderModule methods
	* \brief Functions whose first argument has type WGPUShaderModule.
	*
	* @{
	*/
	ShaderModuleGetCompilationInfo :: proc(shaderModule: ShaderModule, callbackInfo: CompilationInfoCallbackInfo) -> Future ---
	ShaderModuleSetLabel           :: proc(shaderModule: ShaderModule, label: StringView) ---
	ShaderModuleAddRef             :: proc(shaderModule: ShaderModule) ---
	ShaderModuleRelease            :: proc(shaderModule: ShaderModule) ---

	/**
	* \defgroup WGPUSupportedFeaturesMethods WGPUSupportedFeatures methods
	* \brief Functions whose first argument has type WGPUSupportedFeatures.
	*
	* @{
	*/
	/**
	* Frees array members of WGPUSupportedFeatures which were allocated by the API.
	*/
	SupportedFeaturesFreeMembers :: proc(supportedFeatures: SupportedFeatures) ---

	/**
	* \defgroup WGPUSupportedWGSLLanguageFeaturesMethods WGPUSupportedWGSLLanguageFeatures methods
	* \brief Functions whose first argument has type WGPUSupportedWGSLLanguageFeatures.
	*
	* @{
	*/
	/**
	* Frees array members of WGPUSupportedWGSLLanguageFeatures which were allocated by the API.
	*/
	SupportedWGSLLanguageFeaturesFreeMembers :: proc(supportedWGSLLanguageFeatures: SupportedWGSLLanguageFeatures) ---

	/**
	* \defgroup WGPUSurfaceMethods WGPUSurface methods
	* \brief Functions whose first argument has type WGPUSurface.
	*
	* @{
	*/
	/**
	* Configures parameters for rendering to `surface`.
	* Produces a @ref DeviceError for all content-timeline errors defined by the WebGPU specification.
	*
	* See @ref Surface-Configuration for more details.
	*
	* @param config
	* The new configuration to use.
	*/
	SurfaceConfigure :: proc(surface: Surface, config: ^SurfaceConfiguration) ---

	/**
	* Provides information on how `adapter` is able to use `surface`.
	* See @ref Surface-Capabilities for more details.
	*
	* @param adapter
	* The @ref WGPUAdapter to get capabilities for presenting to this @ref WGPUSurface.
	*
	* @param capabilities
	* The structure to fill capabilities in.
	* It may contain memory allocations so `::wgpuSurfaceCapabilitiesFreeMembers` must be called to avoid memory leaks.
	* This parameter is @ref ReturnedWithOwnership.
	*
	* @returns
	* Indicates if there was an @ref OutStructChainError.
	*/
	SurfaceGetCapabilities :: proc(surface: Surface, adapter: Adapter, capabilities: ^SurfaceCapabilities) -> Status ---

	/**
	* Returns the @ref WGPUTexture to render to `surface` this frame along with metadata on the frame.
	* Returns `NULL` and @ref WGPUSurfaceGetCurrentTextureStatus_Error if the surface is not configured.
	*
	* See @ref Surface-Presenting for more details.
	*
	* @param surfaceTexture
	* The structure to fill the @ref WGPUTexture and metadata in.
	*/
	SurfaceGetCurrentTexture :: proc(surface: Surface, surfaceTexture: ^SurfaceTexture) ---

	/**
	* Shows `surface`'s current texture to the user.
	* See @ref Surface-Presenting for more details.
	*
	* @returns
	* Returns @ref WGPUStatus_Error if the surface doesn't have a current texture.
	*/
	SurfacePresent :: proc(surface: Surface) -> Status ---

	/**
	* Modifies the label used to refer to `surface`.
	*
	* @param label
	* The new label.
	*/
	SurfaceSetLabel :: proc(surface: Surface, label: StringView) ---

	/**
	* Removes the configuration for `surface`.
	* See @ref Surface-Configuration for more details.
	*/
	SurfaceUnconfigure :: proc(surface: Surface) ---
	SurfaceAddRef      :: proc(surface: Surface) ---
	SurfaceRelease     :: proc(surface: Surface) ---

	/**
	* \defgroup WGPUSurfaceCapabilitiesMethods WGPUSurfaceCapabilities methods
	* \brief Functions whose first argument has type WGPUSurfaceCapabilities.
	*
	* @{
	*/
	/**
	* Frees array members of WGPUSurfaceCapabilities which were allocated by the API.
	*/
	SurfaceCapabilitiesFreeMembers :: proc(surfaceCapabilities: SurfaceCapabilities) ---

	/**
	* \defgroup WGPUTextureMethods WGPUTexture methods
	* \brief Functions whose first argument has type WGPUTexture.
	*
	* @{
	*/
	TextureCreateView            :: proc(texture: Texture, descriptor: ^TextureViewDescriptor) -> TextureView ---
	TextureDestroy               :: proc(texture: Texture) ---
	TextureGetDepthOrArrayLayers :: proc(texture: Texture) -> u32 ---
	TextureGetDimension          :: proc(texture: Texture) -> TextureDimension ---
	TextureGetFormat             :: proc(texture: Texture) -> TextureFormat ---
	TextureGetHeight             :: proc(texture: Texture) -> u32 ---
	TextureGetMipLevelCount      :: proc(texture: Texture) -> u32 ---
	TextureGetSampleCount        :: proc(texture: Texture) -> u32 ---
	TextureGetUsage              :: proc(texture: Texture) -> TextureUsage ---
	TextureGetWidth              :: proc(texture: Texture) -> u32 ---
	TextureSetLabel              :: proc(texture: Texture, label: StringView) ---
	TextureAddRef                :: proc(texture: Texture) ---
	TextureRelease               :: proc(texture: Texture) ---

	/**
	* \defgroup WGPUTextureViewMethods WGPUTextureView methods
	* \brief Functions whose first argument has type WGPUTextureView.
	*
	* @{
	*/
	TextureViewSetLabel :: proc(textureView: TextureView, label: StringView) ---
	TextureViewAddRef   :: proc(textureView: TextureView) ---
	TextureViewRelease  :: proc(textureView: TextureView) ---
}
