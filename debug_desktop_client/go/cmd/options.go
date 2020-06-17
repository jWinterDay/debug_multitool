package main

import (
	"github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/plugins/shared_preferences"
)

const (
	InitW = 1200 // Samsung Nexus S
	InitH = 1000
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(InitW, InitH),

	flutter.AddPlugin(&shared_preferences.SharedPreferencesPlugin{
		VendorName: "redux_desktop_multitool",
		ApplicationName: "redux_desktop_multitool",
	}),
}
