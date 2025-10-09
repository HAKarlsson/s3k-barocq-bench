project(
	'hello',
	'c',
	version : '0.1',
	meson_version : '>= 1.1',
	default_options : [
		'buildtype=debug',
		'warning_level=2',
		'c_std=c99',
		'b_ndebug=if-release',
	],
)

subproject('app0')
subproject('app1')
