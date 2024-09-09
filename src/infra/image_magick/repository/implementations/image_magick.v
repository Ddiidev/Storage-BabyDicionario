module implementations

import os
import infra.image_magick.entities

const current_dir = os.abs_path('.')

pub struct ImageMagick {}

pub fn (_ ImageMagick) convert(arg entities.ArgsConvert) ! {
	if !os.exists(os.join_path(implementations.current_dir, name_executable_magick())) {
		return error('imagemagick not installed')
	}

	if !os.exists(arg.path_file_orig) {
		return error('file not found')
	}

	if os.exists(arg.path_file_dest) {
		return error('file already exists')
	}

	result := os.execute('${name_executable_magick()} ${arg.path_file_orig} -quality ${arg.quality} -resize ${arg.resolution} ${arg.path_file_dest}')

	if result.exit_code != 0 {
		return error_with_code(result.output, result.exit_code)
	}
}

fn name_executable_magick() string {
	return $if windows {
		'magick.exe'
	} $else {
		'magick'
	}
}
