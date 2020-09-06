module debug_desktop_client/go

go 1.13

replace os_info => ./plugins/os_info

require (
	github.com/go-flutter-desktop/go-flutter v0.41.2
	github.com/go-flutter-desktop/plugins/path_provider v0.4.0
	github.com/go-flutter-desktop/plugins/shared_preferences v0.4.3
	github.com/nealwon/go-flutter-plugin-sqlite v0.0.0-20190909095325-db6bdfd6b983
	github.com/pkg/errors v0.9.1
	os_info v0.0.0-00010101000000-000000000000
)
