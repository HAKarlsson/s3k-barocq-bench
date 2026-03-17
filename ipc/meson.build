project(
	'ipc',
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

s3k_barocq=subproject('s3k-barocq').get_variable('elf')
s3k_c=subproject('s3k-c').get_variable('elf')

app0=subproject('app0').get_variable('elf')
app1=subproject('app1').get_variable('elf')

run_script = meson.project_source_root() / 'scripts'/ get_option('plat') + '.sh'
run_target('run-barocq', command : [run_script, app0, app1, s3k_barocq])
run_target('run-c', command : [run_script, app0, app1, s3k_c])
