package os_info

import (
	flutter "github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"

	"os"
)

const (
	CHANNEL_NAME = "github.com/jWinterDay/go_flutter_utils/os_info"
	METHOD       = "get_os_info"
)

type OsInfoFlutterPlugin struct {
	channel *plugin.MethodChannel
}

var _ flutter.Plugin = &OsInfoFlutterPlugin{}

func (p *OsInfoFlutterPlugin) InitPlugin(messenger plugin.BinaryMessenger) error {
	p.channel = plugin.NewMethodChannel(messenger, CHANNEL_NAME, plugin.StandardMethodCodec{})
	p.channel.HandleFunc(METHOD, handleGetOsInfo)

	return nil
}

func handleGetOsInfo(arguments interface{}) (reply interface{}, err error) {
	hostName, err := os.Hostname()
	if err != nil {
		panic(err)
	}

	return map[interface{}]interface{}{
		"hostName": hostName,
	}, nil

	return hostName, nil
}
