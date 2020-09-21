package main

import (
	"github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
	"github.com/go-gl/glfw/v3.3/glfw"

	"github.com/go-flutter-desktop/plugins/package_info"
	"github.com/go-flutter-desktop/plugins/path_provider"
	"github.com/go-flutter-desktop/plugins/url_launcher"

	"os_info"
)

const (
	initW = 850
	initH = 600

	minW = 850
	minH = 600

	maxW = 5120
	maxH = 4096
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(initW, initH),

	flutter.AddPlugin(&ScreenSizeSettings{}),

	flutter.AddPlugin(&url_launcher.UrlLauncherPlugin{}),
	flutter.AddPlugin(&package_info.PackageInfoPlugin{}),
	flutter.AddPlugin(&path_provider.PathProviderPlugin{
		VendorName:      "multi_debugger",
		ApplicationName: "multi_debugger",
	}),

	// os info
	flutter.AddPlugin(&os_info.OsInfoFlutterPlugin{}),
}

type ScreenSizeSettings struct {
	// stop      chan bool
	window    *glfw.Window
	widthChan chan int
}

var _ flutter.Plugin = &ScreenSizeSettings{}     // compile-time type check
var _ flutter.PluginGLFW = &ScreenSizeSettings{} // compile-time type check

func (p *ScreenSizeSettings) InitPlugin(messenger plugin.BinaryMessenger) error {
	// p.stop = make(chan bool)

	channel := plugin.NewEventChannel(messenger, "github.com/jWinterDay/platform_messages", plugin.StandardMethodCodec{})
	channel.Handle(p)

	return nil
}

func (p *ScreenSizeSettings) InitPluginGLFW(window *glfw.Window) error {
	p.window = window

	return nil
}

func (p *ScreenSizeSettings) OnListen(arguments interface{}, sink *plugin.EventSink) {
	// size callback
	onSetSizeCallback := glfw.SizeCallback(func(w *glfw.Window, width int, height int) {
		sink.Success(map[interface{}]interface{}{
			"type":   "resize",
			"width":  int64(width),
			"height": int64(height),
		})
	})
	// close callback
	onCloseCallback := glfw.CloseCallback(func(window *glfw.Window) {
		sink.Success(map[interface{}]interface{}{
			"type": "close",
		})

		sink.EndOfStream()
	})

	p.window.SetSizeCallback(onSetSizeCallback)
	p.window.SetCloseCallback(onCloseCallback)
}

func (p *ScreenSizeSettings) OnCancel(arguments interface{}) {
}
