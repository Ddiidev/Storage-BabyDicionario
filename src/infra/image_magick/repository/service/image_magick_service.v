module service

import infra.image_magick.repository.implementations
import infra.image_magick.repository.interfaces

pub fn get() interfaces.IImageMagick {
	return implementations.ImageMagick{}
}
