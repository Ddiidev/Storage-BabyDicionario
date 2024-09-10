module services

import os
import domain.backend_babydi.interfaces as backend
import domain.config.interfaces as conf

pub struct UserService {
pub:
	conf conf.IConfig
	api  backend.IBackendBabyDi
}

fn (serv &UserService) create(user_uuid string) ! {
	// if serv.api.contain_user(user_uuid) {
		work_dir := serv.conf.get_work_dir() or { return error('Falha interna.') }

		if !os.exists(os.join_path(work_dir, user_uuid)) {
			os.mkdir(os.join_path(work_dir, user_uuid)) or {
				return error('Falha ao criar espaço do usuário.')
			}
		}
	// } else {
	// 	return error('Usuário inválido ou falha interna. Por favor, tente novamente ou reporte o problema.')
	// }
}
