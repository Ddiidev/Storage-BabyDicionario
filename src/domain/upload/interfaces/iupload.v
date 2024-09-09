module interfaces

import domain.config.interfaces as config

pub interface IUploadService {
	conf config.IConfig
	upload(user_uuid string, uuid_profile string, data string) !
}
