package main

import (
	"github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
	"github.com/go-gl/glfw/v3.3/glfw"
	
	"github.com/go-flutter-desktop/plugins/path_provider"
	"github.com/go-flutter-desktop/plugins/package_info"
	"github.com/go-flutter-desktop/plugins/url_launcher"
)

const (
	InitW = 1200
	InitH = 800

	MinW = 800 // iPhone 5
	MinH = 600


	MaxW = 5120 // 5K monitor
	MaxH = 4096
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(InitW, InitH),

	flutter.AddPlugin(&ScreenSizeSettings{}),

	flutter.AddPlugin(&url_launcher.UrlLauncherPlugin{}),
	flutter.AddPlugin(&package_info.PackageInfoPlugin{}),
	flutter.AddPlugin(&path_provider.PathProviderPlugin{
		VendorName:      "ligastavok",
		ApplicationName: "ligastavok",
	}),
}


type ScreenSizeSettings struct {
	window *glfw.Window
}

var _ flutter.Plugin = &ScreenSizeSettings{} // compile-time type check
var _ flutter.PluginGLFW = &ScreenSizeSettings{} // compile-time type check

func (p *ScreenSizeSettings) InitPlugin(messenger plugin.BinaryMessenger) error {
	return nil
}

func (p *ScreenSizeSettings) InitPluginGLFW(window *glfw.Window) error {
	window.SetSizeLimits(MinW, MinH, MaxW, MaxH);
	return nil
}