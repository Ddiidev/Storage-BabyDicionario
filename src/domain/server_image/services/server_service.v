module services

import os
import domain.config.interfaces as conf
import domain.server_image.types
import infra.backend_babydi.repository.service as infra_backend_babydi

pub struct ServerImageService {
pub:
	conf conf.IConfig
}

fn (serv &ServerImageService) get_image_profile(user_uuid string, uuid_profile string) !types.PathImageOnServer {
	work_dir := serv.conf.get_work_dir() or { return error('Falha interna.') }
	mut uuid_profile_ := uuid_profile

	if !os.exists(os.join_path(work_dir, user_uuid)) {
		return error('Usuário não encontrado.')
	}

	if uuid_profile_ == 'default-user' {
		
		backend := infra_backend_babydi.get()

		uuid_profile_ = backend.default_uuid_profile_from_user(user_uuid) or {
			return error('Imagem não encontrada.')	
		}
	} else if !os.exists(os.join_path(work_dir, user_uuid, uuid_profile_)) {
		return error('Imagem não encontrada.')
	}

	return os.join_path(work_dir, user_uuid, uuid_profile_, 'profile.jpg')
}
