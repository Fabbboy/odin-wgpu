package main

import wgpu "../wgpu"
import "core:fmt"

main :: proc() { 
	instance := wgpu.CreateInstance(nil)
  if instance == nil {
   fmt.println("Failed to create WGPU instance")
    return
  }

  wgpu.InstanceRelease(instance)
}
