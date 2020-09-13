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
	window *glfw.Window
}

var _ flutter.Plugin = &ScreenSizeSettings{}     // compile-time type check
var _ flutter.PluginGLFW = &ScreenSizeSettings{} // compile-time type check

func (p *ScreenSizeSettings) InitPlugin(messenger plugin.BinaryMessenger) error {
	return nil
}

func (p *ScreenSizeSettings) InitPluginGLFW(window *glfw.Window) error {
	window.SetSizeLimits(minW, minH, maxW, maxH)
	return nil
}
