module interfaces

import os
import domain.config.interfaces as conf

pub struct UserService {
pub:
	conf conf.IConfig
}

fn (serv &UserService) create_user(user_uuid string) ! {
	work_dir := serv.conf.get_work_dir() or { return error('Falha interna.') }

	if !os.exists(os.join_path(work_dir, user_uuid)) {
		os.mkdir(os.join_path(work_dir, user_uuid)) or {
			return error('Falha ao criar espaço do usuário.')
		}
	}
}
