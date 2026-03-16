project(
	'app1',
	'c',
	version : '0.1',
	meson_version : '>= 1.1',
	default_options : [
		'buildtype=release',
		'warning_level=2',
		'c_std=c99',
		'b_ndebug=if-release',
	],
)

plat = get_option('plat')

plat_c = meson.current_source_dir() / 'plat' / plat + '.c'
plat_h = meson.current_source_dir() / 'plat' / plat + '.h'
plat_ld = meson.current_source_dir() / 'plat' / plat + '.ld'

cflags=[]
if get_option('temporal_fence')
	cflags+=['-DTEMPORAL_FENCE']
endif

elf = executable('app1.elf',
	sources : files(
		'head.S',
		'main.c',
		plat_c,
	),
	c_args : [
		'-include', plat_h,
		'-specs=picolibc.specs',
		cflags
	],
	link_args : [
		'-T', plat_ld,
		'-nostartfiles',
		'-specs=picolibc.specs',
	],
	link_depends : [
		plat_ld,
	],
	dependencies : [
		subproject('libs3k').get_variable('dep'),
	],
)
