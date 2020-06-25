package main

import (
	"github.com/go-flutter-desktop/go-flutter"
	// "github.com/go-flutter-desktop/plugins/shared_preferences"
	"github.com/go-flutter-desktop/plugins/path_provider"
	sqflite "github.com/nealwon/go-flutter-plugin-sqlite"
	"os_info"
)

const (
	InitW = 1200 // Samsung Nexus S
	InitH = 1000
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(InitW, InitH),

	// os info
	flutter.AddPlugin(&os_info.OsInfoFlutterPlugin{}),

	// path provider
	flutter.AddPlugin(&path_provider.PathProviderPlugin{
		VendorName:      "debug_desktop_multitool",
		ApplicationName: "debug_desktop_multitool",
	}),

	// sqlite
	flutter.AddPlugin(sqflite.NewSqflitePlugin("debug_desktop_multitool", "debug_desktop_multitool")),
}
