module interfaces

import domain.config.interfaces as conf
import domain.server_image.types

pub interface IServerImage {
	conf conf.IConfig
	get_image_profile(user_uuid string, uuid_profile string) !types.PathImageOnServer
}
