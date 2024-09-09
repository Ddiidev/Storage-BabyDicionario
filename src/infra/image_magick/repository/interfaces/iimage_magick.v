module interfaces

import infra.image_magick.entities

pub interface IImageMagick {
	// convert image from path_file_orig to path_file_dest
	convert(arg entities.ArgsConvert) !
}
