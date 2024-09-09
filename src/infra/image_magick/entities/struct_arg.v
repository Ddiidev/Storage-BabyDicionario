module entities

@[params]
pub struct ArgsConvert {
pub:
	path_file_orig string @[required]
	path_file_dest string @[required]
	quality        int    = 75
	resolution     string = '512x512'
}
