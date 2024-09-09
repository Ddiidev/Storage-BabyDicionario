module services

import os
import domain.config.interfaces as conf
import domain.server_image.types

pub struct ServerImageService {
pub:
	conf conf.IConfig
}

fn (serv &ServerImageService) get_image_profile(user_uuid string, uuid_profile string) !types.PathImageOnServer {
	work_dir := serv.conf.get_work_dir() or { return error('Falha interna.') }

	if !os.exists(os.join_path(work_dir, user_uuid)) {
		return error('Usuário não encontrado.')
	}

	if !os.exists(os.join_path(work_dir, user_uuid, uuid_profile)) {
		return error('Imagem não encontrada.')
	}

	return os.join_path(work_dir, user_uuid, uuid_profile, 'profile.jpg')
}
